package llm

import (
	"context"
	"errors"
	"fmt"
	"strings"

	"github.com/tmc/langchaingo/llms"

	"github.com/intelops/genval/pkg/validate"
)

type RemediationParams struct {
	CelPolicies   []validate.CELPolicy
	Requirements  RequirementSpec
	InputContent  string
	PolicyContent string
	Failures      []byte
	Command       string
	Model         string
	APIKey        string
}

func RemediateResource(ctx context.Context, subDir string, r RemediationParams) (string, error) {
	// Create the user prompt
	source, err := CombineResourceAndResults(r.InputContent, string(r.Failures))
	if err != nil {
		return "", fmt.Errorf("error combining resource and results: %v", err)
	}
	takeActionPrompt, err := GetSystemPrompt(r.Command, subDir)
	if err != nil {
		return "", fmt.Errorf("error getting system prompt: %v", err)
	}

	// Create LLM client
	client, err := NewOpenAIClient(&r.Requirements)
	if err != nil {
		return "", fmt.Errorf("error creating OpenAI client :%v", err)
	}
	msgs := []llms.MessageContent{
		llms.TextParts(llms.ChatMessageTypeSystem, takeActionPrompt),
		llms.TextParts(llms.ChatMessageTypeHuman, source),
	}

	copts := []llms.CallOption{
		llms.WithMaxTokens(4096),
		llms.WithTemperature(0.3),
		llms.WithModel(r.Model),
	}
	// Generate the chat response
	res, err := client.GenerateContent(ctx, msgs, copts...)
	if err != nil {
		return "", fmt.Errorf("failed to generate OpenAI response: %w", err)
	}
	resp := res.Choices[0].Content
	return resp, nil
}

// // chooseContentToCombine determines the content for the next remediation iteration
// func chooseContentToCombine(original, response string) string {
// 	if response != "" {
// 		return response
// 	}
// 	return original
// }

// chooseFailedResults selects the appropriate failed results
// func chooseFailedResults(failedResults []byte, fr []byte) []byte {
// 	if fr != nil {
// 		return fr
// 	}
// 	return failedResults
// }

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

// func CreateChatRequest(userPrompt, takeActionPrompt, model string) (openai.ChatCompletionRequest, error) {
// 	if model == "openai.GPT4" {
// 		model = openai.GPT4
// 	}
// 	req := openai.ChatCompletionRequest{
// 		Model:       model,
// 		Temperature: 0.3,
// 		TopP:        0.3,
// 		MaxTokens:   2048,
// 	}
//
// 	req.Messages = []openai.ChatCompletionMessage{
// 		{Role: openai.ChatMessageRoleSystem, Content: takeActionPrompt},
// 		{Role: openai.ChatMessageRoleUser, Content: userPrompt},
// 	}
//
// 	return req, nil
// }
