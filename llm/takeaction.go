package llm

import (
	"strings"

	openai "github.com/sashabaranov/go-openai"
)

func CombineResourceAndResults(res, results string) (string, error) {
	var builder strings.Builder

	builder.WriteString(res)
	builder.WriteString(results)

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
