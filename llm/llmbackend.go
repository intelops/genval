package llm

import (
	"context"
	"errors"
	"fmt"
	"net"
	"net/http"
	"net/url"
	"os"

	ollama "github.com/ollama/ollama/api"
	openai "github.com/sashabaranov/go-openai"
)

// OpenAIClient handles interactions with OpenAI API.
type OpenAIClient struct {
	client *openai.Client
	config *OpenAIModel
}

// OllamaClient handles interactions with Ollama API.
type OllamaClient struct {
	client *ollama.Client
	config *OllamaModel
}

// NewLLMClient initializes the correct LLM client based on the config.
func NewLLMClient(cfg *RequirementSpec) (interface{}, error) {
	for _, openAIConfig := range cfg.LLMSpec.OpenAIConfig {
		if openAIConfig.UseTheModel && openAIConfig.APIKey != "" {
			return createOpenAIClient(&openAIConfig)
		}
	}
	for _, ollamaConfig := range cfg.LLMSpec.OllamaSpec {
		if ollamaConfig.UseTheModel {
			return createOllamaClient(&ollamaConfig)
		}
	}
	return nil, errors.New("no valid LLM configuration found")
}

// createOpenAIClient initializes and returns an OpenAIClient.
func createOpenAIClient(config *OpenAIModel) (*OpenAIClient, error) {
	token, err := readEnv("OPENAI_KEY")
	if err != nil {
		return nil, fmt.Errorf("failed to load OpenAI API key: %w", err)
	}
	client := openai.NewClient(token)
	return &OpenAIClient{client: client, config: config}, nil
}

// createOllamaClient initializes and returns an OllamaClient.
func createOllamaClient(config *OllamaModel) (*OllamaClient, error) {
	e := NewOllamaEndpoint("http", config.Endpoint, "11434")
	client := ollama.NewClient(
		&url.URL{
			Scheme: e.Scheme,
			Host:   e.Host,
		},
		http.DefaultClient,
	)
	if client == nil {
		return nil, fmt.Errorf("failed to create Ollama client")
	}
	return &OllamaClient{client: client, config: config}, nil
}

// readEnv returns the envvar set and returns error if env is empty or not set.
func readEnv(key string) (string, error) {
	value, found := os.LookupEnv(key)
	if !found || value == "" {
		return "", fmt.Errorf("environment variable %s not found", key)
	}
	return value, nil
}

// GenerateOpenAIResponse generates a response using OpenAI.
func (c *RequirementSpec) GenerateOpenAIResponse(ctx context.Context, model, systemPrompt, userPrompt string) (string, error) {
	// spin := utils.StartSpinner("Processing you request, please wait for a moment...")
	// defer spin.Stop()

	var openAIConfig *OpenAIModel
	for _, config := range c.LLMSpec.OpenAIConfig {
		if config.UseTheModel {
			openAIConfig = &config
			break
		}
	}

	if openAIConfig == nil {
		return "", errors.New("no OpenAI model configured for use")
	}

	client, err := createOpenAIClient(openAIConfig)
	if err != nil {
		return "", fmt.Errorf("failed to initialize OpenAI client: %w", err)
	}

	req := openai.ChatCompletionRequest{
		Model:       model,
		Temperature: openAIConfig.Temperature,
		TopP:        openAIConfig.TopP,
		MaxTokens:   openAIConfig.MaxTokens,
	}

	req.Messages = []openai.ChatCompletionMessage{
		{Role: openai.ChatMessageRoleSystem, Content: systemPrompt},
		{Role: openai.ChatMessageRoleUser, Content: userPrompt},
	}

	resp, err := client.client.CreateChatCompletion(ctx, req)
	if err != nil {
		return "", fmt.Errorf("failed to generate OpenAI response: %w", err)
	}
	// spin.Stop()
	return resp.Choices[0].Message.Content, nil
}

// NewOllamaEndpoint creates a new OllamaEndpoint with the provided scheme, host, and port.
func NewOllamaEndpoint(scheme, host, port string) OllamaEndpoint {
	return OllamaEndpoint{
		Scheme: scheme,
		Host:   host,
		Port:   port,
	}
}

// DefaultOllamaEndpoint returns a default OllamaEndpoint.
func DefaultOllamaEndpoint() OllamaEndpoint {
	return NewOllamaEndpoint("http", "localhost", "11434")
}

// GenerateOllamaResponse generates a response using Ollama.
func (c *RequirementSpec) GenerateOllamaResponse(ctx context.Context, systemPrompt, userPrompt string) (string, error) {
	var ollamaConfig *OllamaModel
	for _, config := range c.LLMSpec.OllamaSpec {
		if config.UseTheModel {
			ollamaConfig = &config
			break
		}
	}

	if ollamaConfig == nil {
		return "", errors.New("no Ollama model configured for use")
	}

	e := DefaultOllamaEndpoint()
	u, err := url.Parse(ollamaConfig.Endpoint)
	if err != nil {
		return "", fmt.Errorf("error parsing endpoint: %v", err)
	}
	if u.Scheme == "" {
		ollamaConfig.Endpoint = net.JoinHostPort(e.Host, e.Port)
	}

	client := ollama.NewClient(
		&url.URL{
			Scheme: e.Scheme,
			Host:   ollamaConfig.Endpoint,
		},
		http.DefaultClient,
	)
	if client == nil {
		return "", errors.New("failed to create Ollama client")
	}

	req := &ollama.GenerateRequest{
		Model:     ollamaConfig.Model,
		Prompt:    userPrompt,
		System:    systemPrompt,
		KeepAlive: &ollama.Duration{Duration: ollamaConfig.KeepAlive},
	}

	var reply string
	respFunc := func(resp ollama.GenerateResponse) error {
		reply = resp.Response
		return nil
	}

	if err := client.Generate(ctx, req, respFunc); err != nil {
		return "", fmt.Errorf("error generating response from Ollama: %v", err)
	}
	return reply, nil
}

func (spec *LLMSpec) GetActiveModels() []map[string]string {
	var activeModels []map[string]string

	// Iterate over OpenAIConfig and add models where useTheModel is true
	for _, model := range spec.OpenAIConfig {
		if model.Model != "" && model.UseTheModel {
			activeModels = append(activeModels, map[string]string{
				"type":  "OpenAI",
				"model": model.Model,
			})
		}
	}

	// Iterate over OllamaSpec and add models where useTheModel is true
	for _, model := range spec.OllamaSpec {
		if model.Model != "" && model.UseTheModel {
			activeModels = append(activeModels, map[string]string{
				"type":  "Ollama",
				"model": model.Model,
			})
		}
	}

	return activeModels
}
