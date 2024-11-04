package llm

// LLMSpec holds the common configuration for both OpenAI and Ollama.
type LLMSpec struct {
	UserSystemPrompt  string        `yaml:"userSystemPrompt,omitempty"`
	UserPrompt        string        `yaml:"userPrompt,omitempty"`
	Backend           string        `yaml:"backend,omitempty"`
	Assistant         string        `yaml:"assistant"`
	APIKey            string        `yaml:"apiKey,omitempty"`
	Model             string        `yaml:"model,omitempty"`
	Output            string        `yaml:"output,omitempty"`
	MaxTokens         int           `yaml:"maxTokens,omitempty"`
	PresencePenalty   float32       `yaml:"presencePenalty,omitempty"`
	FrequencyPenalty  float32       `yaml:"frequencyPenalty,omitempty"`
	TopP              float32       `yaml:"topP,omitempty"`
	Temperature       float32       `yaml:"temperature,omitempty"`
	URL               string        `yaml:"url,omitempty"`
	KeepAliveDuration time.Duration `yaml:"keepAliveDuration,omitempty"`
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
