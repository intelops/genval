package llm

import (
	"errors"
	"fmt"
	"path/filepath"

	"github.com/intelops/genval/pkg/utils"
)

type SystemPrompt struct {
	Type    string
	Content string
}

func (sp *SystemPrompt) Format() string {
	return fmt.Sprintf("\n```\n%s\n```\n", sp.Content)
}

// Load the content from a markdown/text file
func loadPromptFromFile(promptType string) (*SystemPrompt, error) {
	filePath := filepath.Join("prompts", promptType+"Prompt"+".md")
	content, err := utils.ReadFile(filePath)
	if err != nil {
		return nil, fmt.Errorf("failed to load prompt file: %w", err)
	}

	return &SystemPrompt{
		Type:    promptType,
		Content: string(content),
	}, nil
}

// GetSystemPrompt takes in the tool and returns the systemPrompt for the specific tool
func GetSystemPrompt(tool string) (string, error) {
	switch tool {
	case "cue", "cel", "rego", "dockerfile", "regex":
		prompt, err := loadPromptFromFile(tool)
		if err != nil {
			return "", err
		}
		return prompt.Format(), nil
	default:
		return "", errors.New("unsupported system prompt; options are: 'cue', 'cel', 'rego', 'dockerfile', 'regex'")
	}
}
