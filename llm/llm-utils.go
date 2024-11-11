package llm

import (
	"bufio"
	"context"
	"errors"
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

// WriteOutput takes content from LLM backend and writes it to a specified file.
// It creates the file if it does not exist.
// TODO: Extract any codeblocks in the LLM response and save it in a var
// will be used for providing for further analysys to LLM
func WriteOutput(filename string, resp string) error {
	if filename == "" {
		return fmt.Errorf("filename cannot be empty")
	}

	// Ensure the directory exists before creating the file
	dir := filepath.Dir(filename)
	if dir != "" { // Check if there's a directory part in the path
		if err := os.MkdirAll(dir, os.ModePerm); err != nil {
			return fmt.Errorf("error creating directory for output file: %w", err)
		}
	}

	// Create the file with write-only permissions, setting permissions to 0644
	file, err := os.Create(filename)
	if err != nil {
		return fmt.Errorf("error opening/creating file: %w", err)
	}
	defer file.Close()

	// Write content to file after converting it to a string
	_, err = fmt.Fprint(file, resp)
	if err != nil {
		return fmt.Errorf("error writing to file: %w", err)
	}
	return nil
}

// SelectActiveAssistant selects provided assistant and prioritizes Assistant set in LLMSpec, if defined both in Common
// and LLMSpec
func (spec *RequirementSpec) SelectActiveAssistant(model string) (string, error) {
	// Helper function to iterate through configs and return the Assistant if matched
	checkModels := func(models interface{}) (string, bool) {
		switch m := models.(type) {
		case []OpenAIModel:
			for _, config := range m {
				if config.Model == model && (spec.Common.Assistant != "" && config.Assistant != "") {
					return config.Assistant, true
				}
				if config.Model == model && (spec.Common.Assistant != "" && config.Assistant == "") {
					return spec.Common.Assistant, true
				}
				if config.Model == model && (spec.Common.Assistant == "" && config.Assistant != "") {
					return config.Assistant, true
				}
			}
		case []OllamaModel:
			for _, config := range m {
				if config.Model == model && (spec.Common.Assistant != "" && config.Assistant != "") {
					return config.Assistant, true
				}
				if config.Model == model && (spec.Common.Assistant != "" && config.Assistant == "") {
					return spec.Common.Assistant, true
				}
				if config.Model == model && (spec.Common.Assistant == "" && config.Assistant != "") {
					return config.Assistant, true
				}

			}
		}
		return "", false
	}

	// Check OpenAIConfig for the matching model
	if assistant, found := checkModels(spec.LLMSpec.OpenAIConfig); found {
		return assistant, nil
	}

	// Check OllamaModel for the matching model
	if assistant, found := checkModels(spec.LLMSpec.OllamaSpec); found {
		return assistant, nil
	}

	// Return an error if no active assistant found for the given model
	return "", errors.New("no active assistant found for the provided model")
}
