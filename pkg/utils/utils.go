package utils

import (
	"bufio"
	"bytes"
	"context"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"regexp"
	"strings"

	"github.com/google/go-github/v57/github"
	log "github.com/sirupsen/logrus"
	"golang.org/x/oauth2"
)

// TempDirWithCleanup creates a temporary directory and returns its path along with a cleanup function.
func TempDirWithCleanup() (dirPath string, cleanupFunc func(), err error) {
	td, err := os.MkdirTemp("", "")
	if err != nil {
		log.Fatal(err)
		return "", nil, err
	}
	return td, func() {
		os.RemoveAll(td)
	}, nil
}

// GetDefinitions reads the policies/definitions passed in as CLI arg and returns filenames
func GetDefinitions(dirPath string) ([]string, error) {
	var filenames []string

	entries, err := os.ReadDir(dirPath)
	if err != nil {
		return nil, err
	}
	// Skip directories
	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}
		fileName := entry.Name()
		filenames = append(filenames, fileName)
	}

	return filenames, nil
}

// isURL checks if the given string is a valid URL.
func isURL(s string) bool {
	u, err := url.Parse(s)
	return err == nil && u.Scheme != "" && u.Host != ""
}

func FetchFromGitHub(urlStr string, client *github.Client) (*github.RepositoryContent, []*github.RepositoryContent, error) {
	// Parse the URL
	u, err := url.Parse(urlStr)
	if err != nil {
		log.Errorf("cannot parse URL '%s': %v", urlStr, err)
		return nil, nil, err
	}

	if strings.HasPrefix(u.Hostname(), "github.com") || strings.HasPrefix(u.Hostname(), "raw.githubusercontent.com") {
		// Extract owner, repo, branch/commit, and path from the URL
		splitPath := strings.Split(strings.TrimPrefix(u.Path, "/"), "/")

		owner := splitPath[0]
		repo := splitPath[1]
		var branch string
		var filePath string
		if strings.HasPrefix(u.Hostname(), "github.com") {
			branch = splitPath[3]
			filePath = strings.Join(splitPath[4:], "/")
		}
		if strings.HasPrefix(u.Hostname(), "raw.githubusercontent.com") {
			branch = splitPath[2]
			filePath = strings.Join(splitPath[3:], "/")
		}

		// Get the file content from GitHub API
		fileCon, dirCon, _, err := client.Repositories.GetContents(context.Background(), owner, repo, filePath, &github.RepositoryContentGetOptions{
			Ref: branch,
		})
		if err != nil {
			log.Errorf("failed fetching content from GitHub: %v", err)
			return nil, nil, err
		}
		return fileCon, dirCon, nil
	}
	// If it's not a GitHub URL, return an error
	return nil, nil, fmt.Errorf("unsupported URL: %s", urlStr)
}

// fetchFilenames fetches the content of a given URL and saves it to a temporary file and returns file names.
func fetchFilenames(urlStr string, client *github.Client) (string, error) {
	// Use the fetchFromGitHub function to get the file content
	fileCon, _, err := FetchFromGitHub(urlStr, client)
	if err != nil {
		log.Errorf("failed fetching content from GitHub: %v", err)
		return "", err
	}

	// Read the content of the file
	fileContent, err := fileCon.GetContent()
	if err != nil {
		log.Errorf("failed fetching content from GitHub: %v", err)
		return "", err
	}

	// Extract the filename from GitHub API
	filename := fileCon.GetName()

	// Create a cue_downloads directory in /tmp to store the files
	dir := filepath.Join(os.TempDir(), "cue_downloads")
	if _, err := os.Stat(dir); os.IsNotExist(err) {
		if err := os.Mkdir(dir, 0777); err != nil {
			// Handle error here
			log.Println("Failed to create directory:", err)
		}
	} else if err != nil {
		// Handle other potential errors from os.Stat
		log.Println("Error checking directory:", err)
	}

	// Write the content to a file with the original filename
	filePath := filepath.Join(dir, filename)
	if err := os.WriteFile(filePath, []byte(fileContent), 0644); err != nil {
		log.Errorf("failed to write content to file: %v", err)
		return "", err
	}

	// Return the path to the downloaded file
	return filePath, nil
}

// ProcessInputs processes the CLI args, fetches content from URLs if needed, and returns a slice of filenames.
func ProcessInputs(inputs []string) ([]string, error) {
	token := os.Getenv("GITHUB_TOKEN") // Use environment variable for GitHub token
	client := CreateGitHubClient(token)
	var filenames []string
	for _, input := range inputs {
		if isURL(input) {
			filename, err := fetchFilenames(input, client)
			if err != nil {
				return nil, err
			}
			filenames = append(filenames, filename)
		} else if _, err := os.Stat(input); os.IsNotExist(err) {
			log.Errorf("local file '%s' does not exist", input)
			return nil, err
		} else {
			// local file exists, so simply append its absolute path
			absPath, err := filepath.Abs(input)
			if err != nil {
				log.Errorf("failed to get absolute path for '%s': %v", input, err)
				return nil, err
			}
			filenames = append(filenames, absPath)
		}
	}
	return filenames, nil
}

func CleanupDownloadedDir() error {
	dir := filepath.Join(os.TempDir(), "cue_downloads")
	return os.RemoveAll(dir)
}

func IsURL(s string) bool {
	u, err := url.Parse(s)
	return err == nil && u.Scheme != "" && u.Host != ""
}

// ReadPolicyFile read the policy provided from cli args, accepts polices from a remote URL or local file
func ReadPolicyFile(policyFile string) ([]byte, error) {
	var policyContent []byte
	var err error

	// Attempt to parse the policyFile as a URL
	u, err := url.ParseRequestURI(policyFile)
	if err == nil && u.Scheme != "" && u.Host != "" {
		// It's a URL, fetch content
		resp, err := http.Get(u.String())
		if err != nil {
			log.Printf("error fetching policy from URL: %v", err)
			return nil, err
		}
		defer resp.Body.Close()

		if resp.StatusCode != http.StatusOK {
			log.Printf("error fetching policy from URL: status code %d", resp.StatusCode)
			return nil, fmt.Errorf("failed to fetch policy from URL with status code %d", resp.StatusCode)
		}
		policyContent, err = io.ReadAll(resp.Body)
		if err != nil {
			log.Printf("error reading policy from URL: %v", err)
			return nil, err
		}
	} else {
		// If not a URL, treat it as a local file path
		policyContent, err = os.ReadFile(policyFile)
		if err != nil {
			log.Printf("error reading policy from file: %v", err)
			return nil, err
		}
	}

	return policyContent, nil
}
func ExtractPackageName(content []byte) (string, error) {
	scanner := bufio.NewScanner(bytes.NewReader(content))
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "package ") {
			parts := strings.Fields(line)
			if len(parts) >= 2 {
				return parts[1], nil
			}
			break
		}
	}

	if err := scanner.Err(); err != nil {
		return "", err
	}

	return "", io.EOF
}

func CreateGitHubClient(token string) *github.Client {
	ctx := context.Background()
	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
	tc := oauth2.NewClient(ctx, ts)
	client := github.NewClient(tc)
	return client
}

func ExtractModule(dirPath string) (string, error) {
	moduleFilePath := filepath.Join(dirPath, "cue.mod", "module.cue")
	// Read the module.cue file
	content, err := os.ReadFile(moduleFilePath)
	if err != nil {
		return "", err
	}
	// Regular expression to find the module string
	re := regexp.MustCompile(`module:\s*"(.*?)"`)
	log.Infof("REGEX: %v", re)
	matches := re.FindStringSubmatch(string(content))
	if len(matches) < 2 {
		return "", errors.New("module not found in module.cue")
	}

	// Return the extracted module string
	return matches[1], nil
}
