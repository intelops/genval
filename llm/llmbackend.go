package llm

import (
	"context"
	"errors"
	"fmt"
	"net"
	"net/http"
	"net/url"

	ollama "github.com/ollama/ollama/api"
	"github.com/tmc/langchaingo/llms"
	"github.com/tmc/langchaingo/llms/openai"

	"github.com/intelops/genval/pkg/validate"
)

func generateOpenAIOptions(r *RequirementSpec) ([]openai.Option, error) {
	var opts []openai.Option

	for _, openAIConfig := range r.LLMSpec.OpenAIConfig {
		if openAIConfig.UseTheModel && openAIConfig.APIKey != "" {
			opts = append(opts,
				openai.WithToken(openAIConfig.APIKey),
				openai.WithModel(openAIConfig.Model),
			)
		} else {
			return nil, fmt.Errorf("no Model or APIKey found config. Both must be specified for valid configurations")
		}
	}
	return opts, nil
}

// createOpenAIClient creates an openAI client
func NewOpenAIClient(r *RequirementSpec) (*openai.LLM, error) {
	options, err := generateOpenAIOptions(r)
	if err != nil {
		return nil, err
	}
	client, err := openai.New(options...)
	if err != nil {
		return nil, fmt.Errorf("failed to initialize OpenAI client: %w", err)
	}
	return client, nil
}

// CreateCallOptions creates CallOptions with LLM parameters.
func createCallOptions(c *OpenAIModel) (llms.CallOption, error) {
	// Create a slice of CallOption functions
	options := []llms.CallOption{
		llms.WithMaxTokens(c.MaxTokens),
		llms.WithTemperature(c.Temperature),
		llms.WithModel(c.Model),
	}

	// Combine options into a single CallOption
	return combineCallOptions(options), nil
}

// combineCallOptions combines multiple CallOptions into one.
func combineCallOptions(options []llms.CallOption) llms.CallOption {
	return func(o *llms.CallOptions) {
		for _, opt := range options {
			opt(o)
		}
	}
}

func (r *RequirementSpec) GenerateOpenAIResponse(ctx context.Context, model, systemPrompt, userPrompt string) (string, error) {
	var openAIConfig *OpenAIModel
	for _, config := range r.LLMSpec.OpenAIConfig {
		if config.UseTheModel {
			openAIConfig = &config
			break
		}
	}

	if openAIConfig == nil {
		return "", errors.New("no OpenAI model configured for use")
	}

	client, err := NewOpenAIClient(r)
	if err != nil {
		return "", fmt.Errorf("error creating new openAI client: %v", err)
	}
	messages := []llms.MessageContent{
		llms.TextParts(llms.ChatMessageTypeSystem, systemPrompt),
		llms.TextParts(llms.ChatMessageTypeHuman, userPrompt),
	}
	var copts llms.CallOption
	for _, openAIModel := range r.LLMSpec.OpenAIConfig {
		copts, err = createCallOptions(&openAIModel)
		if err != nil {
			return "", fmt.Errorf("error creating parameters for OpenAI: %v", err)
		}
	}
	resp, err := client.GenerateContent(ctx, messages, copts)
	if err != nil {
		return "", fmt.Errorf("error generating response from OpenAI: %v", err)
	}

	return validate.BorderedOutput(resp.Choices[0].Content), err
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
func (r *RequirementSpec) GenerateOllamaResponse(ctx context.Context, systemPrompt, userPrompt string) (string, error) {
	var ollamaConfig *OllamaModel
	for _, config := range r.LLMSpec.OllamaSpec {
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

func (r *LLMSpec) GetActiveModels() []map[string]string {
	var activeModels []map[string]string

	// Iterate over OpenAIConfig and add models where useTheModel is true
	for _, model := range r.OpenAIConfig {
		if model.Model != "" && model.UseTheModel {
			activeModels = append(activeModels, map[string]string{
				"type":  "OpenAI",
				"model": model.Model,
			})
		}
	}

	// Iterate over OllamaSpec and add models where useTheModel is true
	for _, model := range r.OllamaSpec {
		if model.Model != "" && model.UseTheModel {
			activeModels = append(activeModels, map[string]string{
				"type":  "Ollama",
				"model": model.Model,
			})
		}
	}

	return activeModels
}
