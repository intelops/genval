package utils

import (
	"bufio"
	"bytes"
	"context"
	"fmt"
	"io"
	"io/fs"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
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

// GenerateOverlay creates an overlay to store cue schemas
func GenerateOverlay(staticFS fs.FS, td string, policies []string) (map[string]load.Source, error) {
	overlay := make(map[string]load.Source)

	// Walk through and add files from the embedded fs
	err := fs.WalkDir(staticFS, ".", func(p string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if !d.Type().IsRegular() {
			return nil
		}
		f, err := staticFS.Open(p)
		if err != nil {
			return err
		}
		byts, err := io.ReadAll(f)
		if err != nil {
			return err
		}
		op := filepath.Join(td, p)
		overlay[op] = load.FromBytes(byts)
		return nil
	})
	if err != nil {
		return nil, err
	}

	// Add files from policies
	for _, filePath := range policies {
		fileBytes, err := os.ReadFile(filePath)
		if err != nil {
			log.Errorf("Error reading schema:%v", err)
			return nil, err
		}
		overlay[filepath.Join(td, filepath.Base(filePath))] = load.FromBytes(fileBytes)
	}

	return overlay, nil
}

// ReadAndCompileData reads the content from the given file path or GitHub URL and compiles it into cue.Value.
func ReadAndCompileData(dataPath string) (map[string]cue.Value, error) {
	token := os.Getenv("GITHUB_TOKEN") // Use environment variable for GitHub token
	client := CreateGitHubClient(token)

	// Check if dataPath is a URL
	if u, err := url.ParseRequestURI(dataPath); err == nil && u.Scheme != "" && u.Host != "" {
		return handleGitHubURL(client, u)
	}
	// Handle local file or directory
	return handleLocalPath(dataPath)
}

// handleGitHubURL parses the Github URL, reads the contents and compiles it to Cue Value
func handleGitHubURL(client *github.Client, u *url.URL) (map[string]cue.Value, error) {
	dataMap := make(map[string]cue.Value)
	ctx := cuecontext.New()

	splitPath := strings.Split(strings.TrimPrefix(u.Path, "/"), "/")

	owner := splitPath[0]
	repo := splitPath[1]
	var branch string
	var path string
	if strings.HasPrefix(u.Hostname(), "github.com") {
		branch = splitPath[3]
		path = strings.Join(splitPath[4:], "/")
	}
	if strings.HasPrefix(u.Hostname(), "raw.githubusercontent.com") {
		branch = splitPath[2]
		path = strings.Join(splitPath[3:], "/")
	}
	// Get repository contents
	fc, dc, _, err := client.Repositories.GetContents(context.Background(), owner, repo, path, &github.RepositoryContentGetOptions{Ref: branch})
	if err != nil {
		return nil, err
	}
	// Check if it's a directory or a single file
	if len(dc) == 0 {
		// If single file
		fileContent, err := fc.GetContent()
		if err != nil {
			return nil, err
		}
		compiledData := ctx.CompileBytes([]byte(fileContent))
		if compiledData.Err() != nil {
			return nil, compiledData.Err()
		}
		dataMap[fc.GetName()] = compiledData
	} else {
		// IF directory
		for _, content := range dc {
			if content.GetType() == "file" {
				file, _, _, err := client.Repositories.GetContents(context.Background(), owner, repo, *content.Path, &github.RepositoryContentGetOptions{Ref: branch})
				if err != nil {
					log.Errorf("Error reading file from Github Directory: %v", err)
				}
				fileContent, err := file.GetContent()
				if err != nil {
					return nil, err
				}
				compiledData := ctx.CompileBytes([]byte(fileContent))
				if compiledData.Err() != nil {
					return nil, compiledData.Err()
				}
				dataMap[content.GetName()] = compiledData
			}
		}
	}
	return dataMap, nil
}

// handleLocalPath processes either a single file or all files in a directory.
func handleLocalPath(path string) (map[string]cue.Value, error) {
	dataMap := make(map[string]cue.Value)
	// Check if the path is a directory or a single file.
	fileInfo, err := os.Stat(path)
	if err != nil {
		return nil, err
	}

	if fileInfo.IsDir() {
		// Handle directory.
		files, err := os.ReadDir(path)
		if err != nil {
			return nil, err
		}

		for _, file := range files {
			if !file.IsDir() {
				filePath := filepath.Join(path, file.Name())
				err := compileAndAddFile(filePath, dataMap)
				if err != nil {
					return nil, err
				}
			}
		}
	} else {
		// Handle single file.
		err := compileAndAddFile(path, dataMap)
		if err != nil {
			return nil, err
		}
	}

	return dataMap, nil
}

// compileAndAddFile reads, compiles a file, and adds it to the dataMap.
func compileAndAddFile(filePath string, dataMap map[string]cue.Value) error {
	fileContent, err := os.ReadFile(filePath)
	if err != nil {
		return err
	}
	ctx := cuecontext.New()
	compiledData := ctx.CompileBytes(fileContent)
	if compiledData.Err() != nil {
		return compiledData.Err()
	}
	dataMap[filepath.Base(filePath)] = compiledData
	return nil
}

// isURL checks if the given string is a valid URL.
func isURL(s string) bool {
	u, err := url.Parse(s)
	return err == nil && u.Scheme != "" && u.Host != ""
}

// fetchFileWithCURL fetches the content of a given URL using curl and saves it to a temporary file.
// It returns the name of the temporary file.
func fetchFileFromURL(urlStr string, client *github.Client) (string, error) {
	// Parse the URL
	u, err := url.Parse(urlStr)
	if err != nil {
		log.Errorf("cannot parse URL '%s': %v", urlStr, err)
		return "", err
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
		fileCon, _, _, err := client.Repositories.GetContents(context.Background(), owner, repo, filePath, &github.RepositoryContentGetOptions{
			Ref: branch,
		})
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
		filePath = filepath.Join(dir, filename)
		if err := os.WriteFile(filePath, []byte(fileContent), 0644); err != nil {
			log.Errorf("failed to write content to file: %v", err)
			return "", err
		}

		// Return the path to the downloaded file
		return filePath, nil
	}

	// If it's not a GitHub URL, return an error or handle it as needed
	return "", fmt.Errorf("unsupported URL: %s", urlStr)
}

// ProcessInputs processes the CLI args, fetches content from URLs if needed, and returns a slice of filenames.
func ProcessInputs(inputs []string) ([]string, error) {
	token := os.Getenv("GITHUB_TOKEN") // Use environment variable for GitHub token
	client := CreateGitHubClient(token)
	var filenames []string
	for _, input := range inputs {
		if isURL(input) {
			filename, err := fetchFileFromURL(input, client)
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
