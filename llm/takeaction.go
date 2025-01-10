package llm

import (
	"context"
	"errors"
	"fmt"
	"os"
	"strings"

	openai "github.com/sashabaranov/go-openai"

	"github.com/intelops/genval/pkg/validate"
)

type RemediationParams struct {
	CelPolicies   []validate.CELPolicy
	InputContent  string
	PolicyContent string
	Failures      []byte
	Command       string
	Model         string
	ApiKey        string
}

func RemediateResource(ctx context.Context, r RemediationParams) (string, error) {
	// Create the user prompt
	source, err := CombineResourceAndResults(r.InputContent, string(r.Failures))
	if err != nil {
		return "", fmt.Errorf("error combining resource and results: %v", err)
	}
	// Generate the response from LLM
	takeActionPrompt, err := GetSystemPrompt(r.Command)
	if err != nil {
		return "", fmt.Errorf("error getting system prompt: %v", err)
	}
	// Create LLM client
	client := openai.NewClient(os.Getenv(r.ApiKey))
	// Create the request
	req, err := CreateChatRequest(source, takeActionPrompt, r.Model)
	if err != nil {
		return "", fmt.Errorf("failed to create OpenAI request: %w", err)
	}
	// Generate the chat response
	res, err := client.CreateChatCompletion(ctx, req)
	if err != nil {
		return "", fmt.Errorf("failed to generate OpenAI response: %w", err)
	}
	resp := res.Choices[0].Message.Content
	return resp, nil
}

// chooseContentToCombine determines the content for the next remediation iteration
func chooseContentToCombine(original, response string) string {
	if response != "" {
		return response
	}
	return original
}

// chooseFailedResults selects the appropriate failed results
func chooseFailedResults(failedResults []byte, fr []byte) []byte {
	if fr != nil {
		return fr
	}
	return failedResults
}

func CombineResourceAndResults(res, results string) (string, error) {
	if res == "" {
		return "", errors.New("empty resource")
	}
	if results == "" {
		return "", errors.New("empty results")
	}

	var builder strings.Builder
	if _, err := builder.WriteString(res); err != nil {
		return "", err
	}

	if _, err := builder.WriteString("\n"); err != nil {
		return "", err
	}
	if _, err := builder.WriteString(results); err != nil {
		return "", err
	}

	return builder.String(), nil
}

func CreateChatRequest(userPrompt, takeActionPrompt, model string) (openai.ChatCompletionRequest, error) {
	if model == "openai.GPT4" {
		model = openai.GPT4
	}
	req := openai.ChatCompletionRequest{
		Model:       model,
		Temperature: 0.3,
		TopP:        0.3,
		MaxTokens:   2048,
	}

	req.Messages = []openai.ChatCompletionMessage{
		{Role: openai.ChatMessageRoleSystem, Content: takeActionPrompt},
		{Role: openai.ChatMessageRoleUser, Content: userPrompt},
	}

	return req, nil
}
