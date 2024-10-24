package llm

import (
	"context"
	"errors"
	"fmt"
	"net"
	"net/http"
	"net/url"
	"os"
	"time"

	ollama "github.com/ollama/ollama/api"
	openai "github.com/sashabaranov/go-openai"
)

// OpenAIClient handles interactions with OpenAI API.
type OpenAIClient struct {
	client *openai.Client
	config *LLMConfig
}

// OllamaClient handles interactions with Ollama API.
type OllamaClient struct {
	client *ollama.Client
	config *LLMConfig
}

// NewLLMClient initializes the correct LLM client based on the config.
func NewLLMClient(cfg *LLMConfig) (interface{}, error) {
	if cfg.Backend == "openai" {
		// Create the OpenAI client
		return &OpenAIClient{
			client: openai.NewClient(cfg.APIKey),
			config: cfg,
		}, nil
	}

	if cfg.Backend == "ollama" {
		// Create and configure the Ollama client using only the relevant fields from LLMConfig
		e := NewOllamaEndpoint("http", cfg.URL, "11434") // Use the URL from cfg and default scheme/port

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

		// Return the Ollama client
		return &OllamaClient{
			client: client,
			config: cfg,
		}, nil
	}

	// Unsupported backend error
	return nil, fmt.Errorf("unsupported backend: %s", cfg.Backend)
}

// readEnv returns the envvar set and returns error if env is empty or not set.
func readEnv(key string) (string, error) {
	key, found := os.LookupEnv(key)
	if !found && key == "" {
		return "", fmt.Errorf("environment variable %s not found", key)
	}
	return key, nil
}

func (c *LLMConfig) GenerateOpenAIResponse(ctx context.Context, backend, systemPrompt, userPrompt string) (openai.ChatCompletionResponse, error) {
	// Set up the configuration for OpenAI
	cfg := &LLMConfig{
		APIKey: c.APIKey, // Ensure API key is set in LLMConfig
	}

	// Create the OpenAI client using NewLLMClient
	client, err := NewLLMClient(cfg)
	if err != nil {
		return openai.ChatCompletionResponse{}, fmt.Errorf("failed to initialize LLM client: %w", err)
	}

	// Cast the client to OpenAIClient since we are working with OpenAI
	openaiClient, ok := client.(*OpenAIClient)
	if !ok {
		return openai.ChatCompletionResponse{}, fmt.Errorf("failed to cast to OpenAIClient")
	}

	// Prepare the ChatCompletion request
	req := openai.ChatCompletionRequest{
		Model:            c.Model,
		PresencePenalty:  c.PresencePenalty,
		FrequencyPenalty: c.FrequencyPenalty,
		TopP:             c.TopP,
		Temperature:      c.Temperature,
		MaxTokens:        c.MaxTokens,
	}
	req.Messages = append(req.Messages, openai.ChatCompletionMessage{
		Role:    openai.ChatMessageRoleSystem,
		Content: systemPrompt,
	})
	req.Messages = append(req.Messages, openai.ChatCompletionMessage{
		Role:    openai.ChatMessageRoleUser,
		Content: userPrompt,
	})

	// Send the request to OpenAI API
	resp, err := openaiClient.client.CreateChatCompletion(ctx, req)
	if err != nil {
		return openai.ChatCompletionResponse{}, fmt.Errorf("failed to generate OpenAI response: %w", err)
	}

	// Return the response
	return resp, nil
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

func (c *LLMConfig) GenerateOllamaResponse(ctx context.Context, model, systemPrompt, userPrompt string) (string, error) {
	if c.Model == "" {
		return "", errors.New("model name is required")
	}
	// Assume DefaultOllamaEndpoint returns scheme and host information
	e := DefaultOllamaEndpoint()
	// Extract the scheme and host from the URL
	u, err := url.Parse(c.URL)
	if err != nil {
		return "", fmt.Errorf("error parsing endpoint: %v", err)
	}
	if u.Scheme == "" {
		// Default to "http" if no scheme is provided
		c.URL = net.JoinHostPort(e.Host, e.Port)
	}
	client := ollama.NewClient(
		&url.URL{
			Scheme: e.Scheme,
			Host:   c.URL,
		},
		http.DefaultClient,
	)
	if client == nil {
		return "", errors.New("failed to create Ollama client")
	}
	keepAliveDuration := c.KeepAliveDuration * time.Minute
	req := &ollama.GenerateRequest{
		Model:     c.Model,
		Prompt:    userPrompt,
		System:    systemPrompt,
		Stream:    new(bool),
		KeepAlive: &ollama.Duration{Duration: keepAliveDuration},
	}
	reply := ""
	respFunc := func(resp ollama.GenerateResponse) error {
		reply = resp.Response
		return nil
	}
	if err := client.Generate(ctx, req, respFunc); err != nil {
		return "", fmt.Errorf("error generating response from ollama", err)
	}
	return reply, nil
}
