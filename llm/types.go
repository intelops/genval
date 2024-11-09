package llm

import (
	"fmt"
	"os"
	"time"

	"gopkg.in/yaml.v3"
)

type Config struct {
	APIVersion      string          `yaml:"apiVersion"`
	Metadata        Metadata        `yaml:"metadata"`
	RequirementSpec RequirementSpec `yaml:"requirementSpec"`
}

type Metadata struct {
	Name string `yaml:"name"`
}

type RequirementSpec struct {
	Common  CommonSpec `yaml:"common"`
	LLMSpec LLMSpec    `yaml:"llmSpec"`
}

type CommonSpec struct {
	UserPrompt       string `yaml:"userPrompt"`
	Assistant        string `yaml:"assistant"`
	UserSystemPrompt string `yaml:"userSystemPrompt,omitempty"`
	Output           string `yaml:"output,omitempty"`
}

type LLMSpec struct {
	OpenAIConfig []OpenAIModel `yaml:"openAIConfig"`
	OllamaSpec   []OllamaModel `yaml:"ollamaSpec"`
}

type OpenAIModel struct {
	Model string `yaml:"model"`
	// TODO: Add Assistant with precedence
	// Assistant:g
	UseTheModel bool    `yaml:"useTheModel"`
	APIKey      string  `yaml:"apiKey"`
	Temperature float32 `yaml:"temperature"`
	TopP        float32 `yaml:"topP"`
	Streaming   bool    `yaml:"streaming"`
	MaxTokens   int     `yaml:"maxTokens"`
}

type OllamaModel struct {
	Model       string `yaml:"model"`
	UseTheModel bool   `yaml:"useTheModel"`
	// Assiatant:
	Endpoint  string        `yaml:"endpoint"`
	KeepAlive time.Duration `yaml:"keepAlive,omitempty"`
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
	if err := decoder.Decode(&config); err != nil {
		return nil, fmt.Errorf("failed to decode config file: %v", err)
	}
	return &config, nil
}
