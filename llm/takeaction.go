package llm

import (
	"errors"
	"strings"

	openai "github.com/sashabaranov/go-openai"
)

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

func CreateActionCompletion(userPrompt, takeActionPrompt, model string) (openai.ChatCompletionRequest, error) {
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
