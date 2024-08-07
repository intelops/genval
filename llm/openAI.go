package llm

import (
	"context"
	"fmt"
	"os"

	openai "github.com/sashabaranov/go-openai"
)

func NewClient(key string) *openai.Client {
	return openai.NewClient(key)
}

var request = openai.ChatCompletionRequest{
	Model:     openai.GPT3Dot5Turbo,
	MaxTokens: 2048,
	Messages: []openai.ChatCompletionMessage{
		{
			Role:    openai.ChatMessageRoleSystem,
			Content: `Act like an experienced DevSecOps engineer with expertise in creating secure and scalable DevOps workflows by writing security policies in OPA/Rego, Common Expression Language (CEL), and Cuelang. Help your users by providing guidance on writing policies with said technologies for validating and generating IaC manifests, ensuring best practices and security compliance are followed.`,
		},
	},
	PresencePenalty:  0.0,
	FrequencyPenalty: 0.0,
	TopP:             0.8,
	Temperature:      0.7,
}

// readEnv returns the envvar set and returns error if env is empty or not set.
func readEnv(key string) (string, error) {
	key, found := os.LookupEnv(key)
	if !found && key == "" {
		return "", fmt.Errorf("environment variable %s not found", key)
	}
	return key, nil
}

func GenerateCompletrion(ctx context.Context, model, prompt string) (openai.ChatCompletionResponse, error) {
	// Env var named 'OPENAI_KEY' needs to be set to interact with openAI API
	token, err := readEnv("OPENAI_KEY")
	if err != nil {
		fmt.Printf("Error loading .env file: %v\n", err)
	}
	client := NewClient(token)

	request.Messages = append(request.Messages, openai.ChatCompletionMessage{
		Role:    openai.ChatMessageRoleUser,
		Content: prompt,
	})
	resp, err := client.CreateChatCompletion(ctx, request)
	if err != nil {
		fmt.Printf("Chat Completion error: %v\n", err)
	}
	return resp, nil
}
