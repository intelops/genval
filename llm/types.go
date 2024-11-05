package llm

import (
	"fmt"
	"os"
	"time"

	"gopkg.in/yaml.v3"
)

// Config represents the top-level configuration structure
type Config struct {
	APIVersion      string          `yaml:"apiVersion"`
	Metadata        Metadata        `yaml:"metadata"`
	RequirementSpec RequirementSpec `yaml:"requirementSpec"`
}

// Metadata holds metadata information
type Metadata struct {
	Name string `yaml:"name"`
}

// LLMSpec contains the specifications for LLM
type RequirementSpec struct {
	Common  CommonSpec `yaml:"common"`
	LLMSpec LLMSpec    `yaml:"llmSpec"`
}

// CommonSpec holds common specifications
type CommonSpec struct {
	UserPrompt       string `yaml:"userPrompt"`
	UserSystemPrompt string `yaml:"userSystemPrompt,omitempty"` // Optional field
	Assistant        string `yaml:"assistant,omitempty"`
	Output           string `yaml:"output,omitempty"`
}

// SpecificLLMSpec holds specific configurations for different LLMs
type LLMSpec struct {
	OpenAIConfig *OpenAIConfig `yaml:"openAIConfig,omitempty"` // Optional field
	OllamaConfig *OllamaConfig `yaml:"ollamaConfig,omitempty"` // Optional field
}

// OpenAIConfig holds configuration for OpenAI
type OpenAIConfig struct {
	Model            string  `yaml:"model"`                 // Required field
	Assistant        string  `yaml:"assistant,omitempty"`   // Optional field
	APIKey           string  `yaml:"apiKey"`                // Required field
	Temperature      float32 `yaml:"temperature,omitempty"` // Optional with default
	TopP             float32 `yaml:"topP,omitempty"`        // Optional with default
	Streaming        bool    `yaml:"streaming,omitempty"`   // Optional with default
	MaxTokens        int     `yaml:"maxTokens,omitempty"`   // Optional with default
	PresencePenalty  float32 `yaml:"presencePenalty,omitempty"`
	FrequencyPenalty float32 `yaml:"frequencyPenalty,omitempty"`
}

// OllamaConfig holds configuration for Ollama
type OllamaConfig struct {
	Model             string        `yaml:"model"`
	Assistant         string        `yaml:"assistant,omitempty"` // Optional field
	Endpoint          string        `yaml:"endpoint"`
	KeepAliveDuration time.Duration `yaml:"keepAliveDuration,omitempty"` // Optional field
}

type OllamaEndpoint struct {
	Scheme string
	Host   string
	Port   string
}

// LoadConfig reads the configuration from the given file path.
func LoadConfig(configFilePath string) (*Config, error) {
	file, err := os.Open(configFilePath)
	if err != nil {
		return nil, fmt.Errorf("failed to open config file: %v", err)
	}
	defer file.Close()

	var config Config
	decoder := yaml.NewDecoder(file)
	if err := decoder.Decode(config); err != nil {
		return nil, fmt.Errorf("failed to decode config file: %v", err)
	}
	return &config, nil
}
