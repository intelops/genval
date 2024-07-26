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
	ModelName   string
	URL         string
	Temperature float32
	TopP        float32
}

// OllamaClient represents the client to interact with the Ollama API.
type OllamaClient struct {
	client      *ollama.Client
	model       string
	temperature float32
	topP        float32
}

// NewOllamaClient creates a new OllamaClient with the provided configuration.
func NewOllamaClient(config Config) (*OllamaClient, error) {
	ollamaHost := envconfig.Host
	if config.URL == "" {
		config.URL = net.JoinHostPort(ollamaHost.Host, ollamaHost.Port)
	}

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
		client:      client,
		model:       config.ModelName,
		temperature: config.Temperature,
		topP:        config.TopP,
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
