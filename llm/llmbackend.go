package llm

import (
	"context"
	"errors"
	"fmt"
	"net"
	"net/http"
	"net/url"
	"os"

	"github.com/charmbracelet/lipgloss"
	ollama "github.com/ollama/ollama/api"
	"github.com/tmc/langchaingo/llms"
	openai "github.com/tmc/langchaingo/llms/openai"
)

// OllamaClient handles interactions with Ollama API.
type OllamaClient struct {
	client *ollama.Client
	config *OllamaModel
}

func NewOpenAIClient(config *RequirementSpec) (*openai.LLM, error) {
	var opts openai.Option
	for _, openAIConfig := range config.LLMSpec.OpenAIConfig {
		if openAIConfig.UseTheModel && openAIConfig.APIKey != "" {
			opts = openai.WithToken(openAIConfig.APIKey)
			opts = openai.WithModel(openAIConfig.Model)
		}
	}
	llm, err := openai.New(opts)
	if err != nil {
		return nil, fmt.Errorf("error creating openAI client: %v", err)
	}
	return llm, nil
}

// CreateCallOptions create CallOptions with LLM parameters

func createCallOptions(c *OpenAIModel) (llms.CallOption, error) {
	var copts llms.CallOption
	copts = llms.WithMaxTokens(c.MaxTokens)
	copts = llms.WithTemperature(c.Temperature)
	copts = llms.WithModel(c.Model)

	return copts, nil
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

// DrawBorderedOutputWithLipgloss draws a bordered box around the provided content.
func drawBorderedOutput(content string) string {
	// Define the style for the border.
	borderStyle := lipgloss.NewStyle().
		// Set normal border with all sides.
		Border(lipgloss.NormalBorder(), true).
		// Set the border color.
		BorderForeground(lipgloss.Color("63")).
		// Add padding inside the border.
		Padding(1, 2).
		// Set a fixed width.
		// Width(150)
		// Wraps whole screen width
		Width(200)

	return borderStyle.Render(content)
}

// GenerateOpenAIResponse generates a response using OpenAI.
func (c *RequirementSpec) GenerateOpenAIResponse(ctx context.Context, model, systemPrompt, userPrompt string) (string, error) {
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

	client, err := NewOpenAIClient(c)
	if err != nil {
		return "", fmt.Errorf("error creating new openAI client: %v", err)
	}
	messages := []llms.MessageContent{
		llms.TextParts(llms.ChatMessageTypeSystem, systemPrompt),
		llms.TextParts(llms.ChatMessageTypeHuman, userPrompt),
	}
	var copts llms.CallOption
	for _, openAIModel := range c.LLMSpec.OpenAIConfig {
		copts, err = createCallOptions(&openAIModel)
		if err != nil {
			return "", fmt.Errorf("error creating parameters for OpenAI: %v", err)
		}
	}
	resp, err := client.GenerateContent(ctx, messages, copts)
	if err != nil {
		return "", fmt.Errorf("error generating response from OpenAI: %v", err)
	}

	return drawBorderedOutput(resp.Choices[0].Content), err
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

func (c *LLMSpec) GetActiveModels() []map[string]string {
	var activeModels []map[string]string

	// Iterate over OpenAIConfig and add models where useTheModel is true
	for _, model := range c.OpenAIConfig {
		if model.Model != "" && model.UseTheModel {
			activeModels = append(activeModels, map[string]string{
				"type":  "OpenAI",
				"model": model.Model,
			})
		}
	}

	// Iterate over OllamaSpec and add models where useTheModel is true
	for _, model := range c.OllamaSpec {
		if model.Model != "" && model.UseTheModel {
			activeModels = append(activeModels, map[string]string{
				"type":  "Ollama",
				"model": model.Model,
			})
		}
	}

	return activeModels
}
