// In llm/config.go

package llm

import (
	"fmt"
	"os"
	"time"

	"gopkg.in/yaml.v3"
)

const (
	SystemPromptsDir = ".genval/genai/system_prompts"
	SupportedTools   = ".genval/genai/supported_tools/supported_tools.md"
	BaseDir          = ".genval/genai/"
	BaseURL          = "https://raw.githubusercontent.com/intelops/genval-prompts/refs/heads/main/genai/system_prompts/"
)
