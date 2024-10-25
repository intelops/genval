package llm

import (
	"bufio"
	"context"
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/google/go-github/v55/github"
)

// DownloadLLMResources downloads files from multiple directories in a GitHub repository
// and stores them locally in the same directory hierarchy.
func DownloadLLMResources() error {
	owner := "intelops"
	repo := "genval-prompts"
	baseDir := filepath.Join(os.Getenv("HOME"), ".genval/")

	directories := []string{
		"genai/system_prompts",
		"genai/supported_tools",
	}

	client := github.NewClient(nil)

	for _, dir := range directories {
		localDir := filepath.Join(baseDir, dir)

		if err := os.MkdirAll(localDir, 0o755); err != nil {
			return fmt.Errorf("failed to create local directory %s: %v", localDir, err)
		}

		if err := downloadDirectoryContents(client, owner, repo, dir, localDir); err != nil {
			return fmt.Errorf("failed to download from directory %s: %v", dir, err)
		}
	}

	fmt.Println("All files downloaded successfully with directory hierarchy.")
	return nil
}

// downloadDirectoryContents handles downloading all files from a specific GitHub directory.
func downloadDirectoryContents(client *github.Client, owner, repo, dir, destDir string) error {
	_, contents, _, err := client.Repositories.GetContents(context.Background(), owner, repo, dir, nil)
	if err != nil {
		return fmt.Errorf("failed to get contents for %s: %v", dir, err)
	}

	for _, content := range contents {
		if content.GetType() == "file" {
			err = downloadFile(content.GetDownloadURL(), destDir, content.GetName())
			if err != nil {
				return fmt.Errorf("failed to download file %s: %v", content.GetName(), err)
			}
		}
	}

	return nil
}

// downloadFile downloads a file from a URL and saves it to the specified directory.
func downloadFile(url string, destDir, fileName string) error {
	resp, err := http.Get(url)
	if err != nil {
		return fmt.Errorf("failed to download file: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("failed to download file: %v", resp.Status)
	}

	filePath := filepath.Join(destDir, fileName)
	out, err := os.Create(filePath)
	if err != nil {
		return fmt.Errorf("failed to create file: %v", err)
	}
	defer out.Close()

	if _, err = io.Copy(out, resp.Body); err != nil {
		return fmt.Errorf("failed to copy file contents: %v", err)
	}

	fmt.Printf("%s downloaded successfully.\n", fileName)
	return nil
}

// readMarkdownFile reads the content of the specified Markdown file.
func readMarkdownFile(filePath string) (string, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return "", err
	}
	defer file.Close()

	var content strings.Builder
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		content.WriteString(scanner.Text() + "\n")
	}

	if err := scanner.Err(); err != nil {
		return "", err
	}

	return content.String(), nil
}

// ExtractSupportedTools takes the content of a Markdown file and extracts supported_tools into a slice.
func ExtractSupportedTools() ([]string, error) {
	filePath := filepath.Join(os.Getenv("HOME"), SupportedTools)
	content, err := readMarkdownFile(filePath)
	if err != nil {
		return nil, fmt.Errorf("error reading list of supported tools: %v", err)
	}
	var keywords []string
	lines := strings.Split(content, "\n")

	for _, line := range lines {
		// Check if the line starts with a dash indicating a keyword
		if strings.HasPrefix(strings.TrimSpace(line), "-") {
			keyword := strings.TrimSpace(strings.TrimPrefix(line, "-"))
			keywords = append(keywords, keyword)
		}
	}

	return keywords, nil
}
