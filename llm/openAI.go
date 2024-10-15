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
	openai "github.com/sashabaranov/go-openai"
)

// LLMConfig holds the backend and API key configuration for the LLM.
type LLMConfig struct {
	LlmBackend string
	LlmAPIKey  string
}

// NewLLMConfig returns a new instance of LLMConfig.
func NewLLMConfig(backend, apiKey string) *LLMConfig {
	return &LLMConfig{
		LlmBackend: backend,
		LlmAPIKey:  apiKey,
	}
}

// NewClient returns a new OpenAI client with the given API key.
func NewClient(apiKey string) *openai.Client {
	return openai.NewClient(apiKey)
}

// LoadConfig prompts the user for the LLM backend and API key.
func LoadConfig() (*LLMConfig, error) {
	reader := bufio.NewReader(os.Stdin)

	fmt.Print("Choose your LLM backend (currently supported: openai.GPT4o, llama3): ")
	backend, err := reader.ReadString('\n')
	if err != nil {
		return nil, err
	}
	backend = strings.TrimSpace(backend) // Remove newline character

	fmt.Print("Enter the name of the Environment variable for your API key: ")
	apiKeyEnv, err := reader.ReadString('\n')
	if err != nil {
		return nil, err
	}
	apiKeyEnv = strings.TrimSpace(apiKeyEnv) // Remove newline character

	apiKey, found := os.LookupEnv(apiKeyEnv)
	if !found || apiKey == "" {
		return nil, fmt.Errorf("environment variable %s not found or empty", apiKeyEnv)
	}

	// Return the LLMConfig struct instead of setting environment variables directly
	return &LLMConfig{
		LlmBackend: backend,
		LlmAPIKey:  apiKey,
	}, nil
}

// DownloadLLMResources downloads files from a GitHub repository directory.
func DownloadLLMResources() error {
	owner := "intelops"
	repo := "genval-prompts"
	dir := "genai/system_prompts"
	destDir := filepath.Join(os.Getenv("HOME"), ".genval/genai")

	err := os.MkdirAll(destDir, 0o755)
	if err != nil {
		return err
	}

	client := github.NewClient(nil)

	// List the contents of the specified directory
	_, contents, _, err := client.Repositories.GetContents(context.Background(), owner, repo, dir, nil)
	if err != nil {
		return fmt.Errorf("failed to get contents: %v", err)
	}

	for _, content := range contents {
		if content.GetType() == "file" {
			err = downloadFile(content.GetDownloadURL(), destDir, content.GetName())
			if err != nil {
				return err
			}
		}
	}

	fmt.Println("All files downloaded successfully.")
	return nil
}

// GenerateCompletion generates a completion using the OpenAI API.
func GenerateCompletion(ctx context.Context, config *LLMConfig, systemPrompt, userPrompt string) (openai.ChatCompletionResponse, error) {
	client := NewClient(config.LlmAPIKey)

	request := openai.ChatCompletionRequest{
		Model:            config.LlmBackend,
		MaxTokens:        2048,
		PresencePenalty:  0.0,
		FrequencyPenalty: 0.0,
		TopP:             0.8,
		Temperature:      0.7,
	}

	request.Messages = append(request.Messages, openai.ChatCompletionMessage{
		Role:    openai.ChatMessageRoleSystem,
		Content: systemPrompt,
	})

	request.Messages = append(request.Messages, openai.ChatCompletionMessage{
		Role:    openai.ChatMessageRoleUser,
		Content: userPrompt,
	})

	resp, err := client.CreateChatCompletion(ctx, request)
	if err != nil {
		return openai.ChatCompletionResponse{}, fmt.Errorf("chat completion error: %v", err)
	}

	return resp, nil
}

// downloadFile downloads a file from a URL and saves it to the specified directory.
func downloadFile(url string, destDir string, fileName string) error {
	fmt.Printf("Downloading %s...\n", fileName)
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
