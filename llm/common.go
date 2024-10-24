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

// LLMConfig holds the common configuration for both OpenAI and Ollama.
type LLMConfig struct {
	// SystemPrompt, if any to be supplied by the user. Only applicable if the assistant is set to user
	UserSystemPrompt string `yaml:"user-system-prompt,omitempty"`
	// User Prompt to be supplied by the user
	UserPrompt string `yaml:"userPrompt,omitempty"`
	// LLM Backend
	Backend string `yaml:"backend,omitempty"`
	// Assistant to be used by the user for generating IaC files, supported are (Cue,CEL,Rego,Dockerfile,regex)
	Assistant string `yaml:"assistant,omitempty"`
	// API key to be supplied by the user. Currently used by the GPT4o Model only
	APIKey string `yaml:"api_key,omitempty"`
	// LLM Model to be used to interact with. Currently supported (OpenAI  and llama3)
	Model            string  `yaml:"model,omitempty"`
	MaxTokens        int     `yaml:"max_tokens,omitempty"`
	PresencePenalty  float32 `yaml:"presence_penalty,omitempty"`
	FrequencyPenalty float32 `yaml:"frequency_penalty,omitempty"`
	TopP             float32 `yaml:"top_p,omitempty"`
	Temperature      float32 `yaml:"temperature,omitempty"`
	// URL for the LLM, if hosted locally
	URL               string        `yaml:"url,omitempty"`
	KeepAliveDuration time.Duration `yaml:"keep_alive_duration,omitempty"`
}

type OllamaEndpoint struct {
	Scheme string
	Host   string
	Port   string
}

// LoadConfig reads the configuration from the given file path.
func LoadConfig(configFilePath string) (*LLMConfig, error) {
	file, err := os.Open(configFilePath)
	if err != nil {
		return nil, fmt.Errorf("failed to open config file: %v", err)
	}
	defer file.Close()

	config := &LLMConfig{}
	decoder := yaml.NewDecoder(file)
	if err := decoder.Decode(config); err != nil {
		return nil, fmt.Errorf("failed to decode config file: %v", err)
	}

	return config, nil
}
