package cmd

import (
	"fmt"

	"github.com/sashabaranov/go-openai"
	"github.com/spf13/viper"

	"github.com/intelops/genval/llm"
)

func parseStringFlag(arg string, fallback string) string {
	if arg != "" {
		return arg
	}
	return fallback
}

// Helper to resolve boolean with fallback
func parseBoolBoolFlag(arg bool, fallback bool) bool {
	if arg {
		return arg
	}
	return fallback
}

// Helper to resolve the model with fallback
func parseModel(cfg *llm.RequirementSpec) string {
	models := cfg.LLMSpec.GetActiveModels()
	if len(models) > 1 {
		return models[0]["model"]
	}
	return openai.GPT4
}

func loadYAMLConfig(cfgFile string) (*llm.RequirementSpec, error) {
	var spec llm.Config

	if cfgFile != "" {
		v := viper.New()
		v.SetConfigFile(cfgFile)
		err := v.ReadInConfig()
		if err != nil {
			return nil, fmt.Errorf("failed to load config from file: %w", err)
		}
		v.AutomaticEnv()
		err = v.Unmarshal(&spec)
		if err != nil {
			return nil, fmt.Errorf("failed to load config from file: %w", err)
		}
	}
	return &spec.RequirementSpec, nil
}
