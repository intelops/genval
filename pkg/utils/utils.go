package utils

import (
	"bufio"
	"bytes"
	"context"
	"encoding/json"
	"errors"
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
	"gopkg.in/yaml.v3"
)

var token = os.Getenv("GITHUB_TOKEN")

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
	for _, policy := range policies {
		policyBytes, err := os.ReadFile(policy)
		if err != nil {
			log.Errorf("Error reading schema:%v", err)
			return nil, err
		}
		overlay[filepath.Join(td, filepath.Base(policy))] = load.FromBytes(policyBytes)
	}

	return overlay, nil
}

// compileFromURL parses the Github URL, reads the contents and compiles it to Cue Value
func CompileFromURL(client *github.Client, u *url.URL) (map[string]cue.Value, error) {
	dataMap := make(map[string]cue.Value)
	ctx := cuecontext.New()

	// Use fetchFromGitHub to get the file or directory content
	fileCon, dirCon, err := fetchFromGitHub(u.String())
	if err != nil {
		return nil, err
	}

	// Check if it's a directory or a single file
	if len(dirCon) == 0 {
		// If single file
		fileContent, err := fileCon.GetContent()
		if err != nil {
			return nil, err
		}
		compiledData := ctx.CompileBytes([]byte(fileContent))
		if compiledData.Err() != nil {
			return nil, compiledData.Err()
		}
		dataMap[fileCon.GetName()] = compiledData
	} else {
		// If directory
		for _, content := range dirCon {
			if content.GetType() == "file" {
				fileCon, _, err := fetchFromGitHub(content.GetDownloadURL())
				if err != nil {
					log.Errorf("Error reading file from GitHub Directory: %v", err)
					continue
				}
				fileContent, err := fileCon.GetContent()
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

// compileFromLocal processes either a single file or all files in a directory.
func CompileFromLocal(path string) (map[string]cue.Value, error) {
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

// compileAndAddFile reads, compiles a file, and appends it to the dataMap.
func compileAndAddFile(filePath string, dataMap map[string]cue.Value) error {
	fileContent, err := os.ReadFile(filePath)
	if err != nil {
		return err
	}

	ctx := cuecontext.New()

	// Check if the file has a YAML extension
	if isYAMLFile(filePath) {
		// Convert YAML to JSON
		jsonContent, err := yamlToJSON(fileContent)
		if err != nil {
			return err
		}
		compiledData := ctx.CompileString(string(jsonContent))
		if compiledData.Err() != nil {
			return compiledData.Err()
		}
		dataMap[filepath.Base(filePath)] = compiledData
	} else {
		// For other extensions, directly compile the content
		compiledData := ctx.CompileBytes(fileContent)
		if compiledData.Err() != nil {
			return compiledData.Err()
		}
		dataMap[filepath.Base(filePath)] = compiledData
	}

	return nil
}

// isYAMLFile checks if the file extension is either yaml or yml
func isYAMLFile(filePath string) bool {
	ext := strings.ToLower(filepath.Ext(filePath))
	return ext == ".yaml" || ext == ".yml"
}

// yamlToJSON converts YAML to JSON
func yamlToJSON(yamlContent []byte) ([]byte, error) {
	var yamlMap interface{}
	err := yaml.Unmarshal(yamlContent, &yamlMap)
	if err != nil {
		return nil, err
	}

	jsonContent, err := json.Marshal(yamlMap)
	if err != nil {
		return nil, err
	}

	return jsonContent, nil
}

// isURL checks if the given string is a valid URL.
func isURL(s string) bool {
	u, err := url.Parse(s)
	return err == nil && u.Scheme != "" && u.Host != ""
}

func fetchFromGitHub(urlStr string) (*github.RepositoryContent, []*github.RepositoryContent, error) {
	// Use environment variable for GitHub token
	client := CreateGitHubClient(token)
	// Parse the URL
	u, err := url.Parse(urlStr)
	if err != nil {
		log.Errorf("error processing the provided URL '%s'. Please ensure it is a valid URL: %v", urlStr, err)
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
	log.Errorf("unsupported URL: %s", urlStr)
	return nil, nil, err
}

// fetchFilenames fetches the content of a given URL and saves it to a temporary file and returns file names.
func fetchFilenames(urlStr string, client *github.Client) (string, error) {
	// Use the fetchFromGitHub function to get the file content
	fileCon, _, err := fetchFromGitHub(urlStr)
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
			log.Errorf("Failed to create directory: %v", err)
		}
	} else if err != nil {
		log.Errorf("Error checking directory: %v", err)
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

// ReadFile reads the files provided from cli args and returns []byte and an error if any
func ReadFile(content string) ([]byte, error) {
	var policyContent []byte
	var err error

	// Attempt to parse the content as a URL
	u, err := url.ParseRequestURI(content)
	if err == nil && strings.HasPrefix(u.Hostname(), "github.com") && strings.HasPrefix(u.Hostname(), "raw.githubusercontent.com") {
		fileCon, dirCon, err := fetchFromGitHub(u.String())
		if err != nil {
			return nil, err
		}
		// Check if it's a directory or a single file
		if len(dirCon) == 0 {
			// If single file
			policyContent, err := fileCon.GetContent()
			if err != nil {
				return nil, err
			}
			return []byte(policyContent), nil
		}
		// If directory
		for _, content := range dirCon {
			if content.GetType() == "file" {
				fileCon, _, err := fetchFromGitHub(content.GetDownloadURL())
				if err != nil {
					log.Errorf("Error reading file from GitHub Directory: %v", err)
					continue
				}
				policyContent, err := fileCon.GetContent()
				if err != nil {
					return nil, err
				}
				return []byte(policyContent), nil
			}
		}
	} else {
		if err == nil && u.Scheme != "" && u.Host != "" {
			policyContent, err = readData(content)
			if err != nil {
				return nil, err
			}
			return policyContent, nil
		} else {
			// Handle local file
			policyContent, err = os.ReadFile(content)
			if err != nil {
				return nil, err
			}
			return policyContent, nil
		}
	}
	return nil, errors.New("unsupported file source. Please provide a valid URL or a local file path")

}

// readData reads data from a URL or a local file.
func readData(input string) ([]byte, error) {
	if IsURL(input) {
		resp, err := http.Get(input)
		if err != nil {
			return nil, err
		}
		defer resp.Body.Close()
		return io.ReadAll(resp.Body)
	}
	return os.ReadFile(input)
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
