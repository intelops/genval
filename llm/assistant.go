package llm

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

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
	filePath := filepath.Join(os.Getenv("HOME"), SystemPromptsDir+"/"+promptType+"Prompt"+".md")
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
	supportedTools, err := ExtractSupportedTools()
	if err != nil {
		return "", fmt.Errorf("error fetching list of supported tools: %v", err)
	}

	lowerCaseTool := strings.ToLower(tool)

	if !isSupportedTool(lowerCaseTool, supportedTools) {
		return "", fmt.Errorf("unsupported system prompt; options are: %v", supportedTools)
	}

	prompt, err := loadPromptFromFile(lowerCaseTool)
	if err != nil {
		return "", err
	}
	return prompt.Format(), nil
}

// isSupportedTool checks if the provided tool is in the supported tools list
func isSupportedTool(tool string, supportedTools []string) bool {
	for _, t := range supportedTools {
		if strings.ToLower(t) == tool {
			return true
		}
	}
	return false
}
