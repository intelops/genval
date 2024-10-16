package llm

import (
	"context"
	"fmt"
	"os"

	openai "github.com/sashabaranov/go-openai"
)

// NewClient returns a new OpenAI client with the given API key.
func NewClient(apiKey string) *openai.Client {
	return openai.NewClient(apiKey)
}

// readEnv returns the envvar set and returns error if env is empty or not set.
func readEnv(key string) (string, error) {
	key, found := os.LookupEnv(key)
	if !found && key == "" {
		return "", fmt.Errorf("environment variable %s not found", key)
	}
	return key, nil
}

// GenerateCompletion generates a completion using the OpenAI API.
func GenerateCompletion(ctx context.Context, backend, systemPrompt, userPrompt string) (openai.ChatCompletionResponse, error) {
	token, err := readEnv("OPENAI_KEY")
	if err != nil {
		fmt.Printf("Error loading .env file: %v\n", err)
	}
	client := NewClient(token)

	request := openai.ChatCompletionRequest{
		Model:            backend,
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
