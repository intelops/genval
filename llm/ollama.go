package llm

import (
	"context"
	"errors"
	"net"
	"net/http"
	"net/url"

	ollama "github.com/ollama/ollama/api"
	"github.com/ollama/ollama/envconfig"
)

// Config represents the configuration options for the Ollama client.
type Config struct {
	// ModelName is the model name; it should be a name familiar to Ollama from
	// the library at https://ollama.com/library
	ModelName   string
	URL         string
	Temperature float32
	TopP        float32
}

// OllamaClient represents the client to interact with the Ollama API.
type OllamaClient struct {
	client *ollama.Client
	Config
}

var ollamaHost = envconfig.Host

// NewDefaultConfig function creates a new Config with default values.

func NewDefaultConfig(baseURL string) Config {
	if baseURL == "" {
		baseURL = net.JoinHostPort(ollamaHost.Host, ollamaHost.Port)
	}

	return Config{
		ModelName:   "llama3",
		URL:         baseURL,
		Temperature: 0.7,
		TopP:        0.9,
	}
}

// NewOllamaClient creates a new OllamaClient with the provided configuration.
func (config *Config) NewOllamaClient() (*OllamaClient, error) {
	if config.ModelName == "" {
		return nil, errors.New("model name is required")
	}

	client := ollama.NewClient(
		&url.URL{
			Scheme: ollamaHost.Scheme,
			Host:   config.URL,
		},
		http.DefaultClient,
	)

	if client == nil {
		return nil, errors.New("failed to create Ollama client")
	}

	return &OllamaClient{
		client: client,
		Config: *config,
	}, nil
}

func (c *OllamaClient) GenerateResponse(ctx context.Context, model string, prompt string) (string, error) {
	req := &ollama.GenerateRequest{
		Model:  model,
		Prompt: prompt,
		Stream: new(bool),
	}
	reply := ""
	respFunc := func(resp ollama.GenerateResponse) error {
		reply = resp.Response
		return nil
	}

	err := c.client.Generate(ctx, req, respFunc)
	return reply, err
}
