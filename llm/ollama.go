package llm

import (
	"context"
	"errors"
	"net"
	"net/http"
	"net/url"

	"github.com/kelseyhightower/envconfig"
	ollama "github.com/ollama/ollama/api"
)

// Config represents the configuration options for the Ollama client.
type Config struct {
	client *ollama.Client
	// ModelName is the model name; it should be a name familiar to Ollama from
	// the library at https://ollama.com/library
	ModelName string `envconfig:"MODEL_NAME" default:"llama3"`
	// URL is the base URL for the Ollama API
	URL         string  `envconfig:"ENDPOINT" default:"localhost:11434"`
	Temperature float32 `envconfig:"TEMPERATURE" default:"0.8"`
	TopP        float32 `envconfig:"TOP_P" default:"0.9"`
}

type OllamaEndpoint struct {
	Scheme string
	Host   string
	Port   string
}

// TODO: Use envconfig pkg and Move the Endpoint related code to separate pkg
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

// NewDefaultConfig creates a new Config with default values, potentially overridden by environment variables.
func NewDefaultConfig(baseURL string) (*Config, error) {
	e := DefaultOllamaEndpoint()
	if baseURL == "" {
		baseURL = net.JoinHostPort(e.Host, e.Port)
	}

	config := &Config{
		ModelName:   "llama3",
		URL:         baseURL,
		Temperature: 0.7,
		TopP:        0.9,
	}

	if err := envconfig.Process("", config); err != nil {
		return nil, err
	}

	// Override URL if not set in environment variables
	if config.URL == "" {
		config.URL = baseURL
	}

	return config, nil
}

// NewOllamaClient creates a new OllamaClient with the provided configuration.
func (c *Config) NewOllamaClient() error {
	if c.ModelName == "" {
		return errors.New("model name is required")
	}

	// Extract the scheme and host from the URL
	u, err := url.Parse(c.URL)
	if err != nil {
		return err
	}

	client := ollama.NewClient(
		&url.URL{
			Scheme: u.Scheme,
			Host:   u.Host,
		},
		http.DefaultClient,
	)

	if client == nil {
		return errors.New("failed to create Ollama client")
	}

	c.client = client
	return nil
}

func (c *Config) GenerateResponse(ctx context.Context, model string, prompt string) (string, error) {
	if c.client == nil {
		return "", errors.New("client is not initialized")
	}

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
