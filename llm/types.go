package llm

import (
	"fmt"
	"os"
	"time"

	"gopkg.in/yaml.v3"
)

type LLMSpec struct {
	CommonSpec *commonSpec
	OpenAISpec *openAISpec
	OllamaSpec *ollamaSpec
}

type commonSpec struct {
	UserPrompt       string
	UserSystemPrompt string
	Assistant        string
	Output           string
}

type openAISpec struct {
	Model      string
	APIKey     string
	Temprature float32
	TopP       float32
	Streaming  bool
	MaxTokens  int
}

type ollamaSpec struct {
	Endpoint          string
	KeepAliveSuration time.Duration
	URL               string
}

// LLMMetadata and LLMConfig updated to match the YAML structure
type LLMMetadata struct {
	Name string `yaml:"name"`
}

type LLMConfig struct {
	APIVersion string      `yaml:"apiVersion,omitempty"`
	Metadata   LLMMetadata `yaml:"metadata,omitempty"`
	LLMSpec    LLMSpec     `yaml:"llmSpec"`
}

type OllamaEndpoint struct {
	Scheme string
	Host   string
	Port   string
}

// LoadConfig reads the configuration from the given file path.
func LoadConfig(configFilePath string) (*LLMSpec, error) {
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

	// Return the LLMSpec part of the configuration
	return &config.LLMSpec, nil
}
