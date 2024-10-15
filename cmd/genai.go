package cmd

import (
	"context"
	"errors"
	"fmt"

	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
)

var generateCmd = &cobra.Command{
	Use:   "genai",
	Short: "Generate configuration files leveraging AI",
	Long: `
	Initialize GenAI configurations. Setup LLM backend with API key and other setup for generating Rego, Cue, and CEL policies to be used with Genval for validating and generation of IaC
	configs`,
	RunE: runGenerateCmd,
}

type generateFlags struct {
	model     string
	endpoint  string
	prompt    string
	assistant string
}

var generateArgs generateFlags

func init() {
	generateCmd.Flags().StringVarP(&generateArgs.model, "model", "m", "", "Select the AI model")
	generateCmd.Flags().StringVarP(&generateArgs.endpoint, "endpoint", "e", "", "Endpoint for the AI model")
	generateCmd.Flags().StringVarP(&generateArgs.prompt, "prompt", "p", "", "Your prompt to the model")
	generateCmd.Flags().StringVarP(&generateArgs.assistant, "assistant", "a", "", "Specify the assistant to use (cue, cel, rego, etc.)")

	rootCmd.AddCommand(generateCmd)
}

func runGenerateCmd(cmd *cobra.Command, args []string) error {
	// Step 1: Load the configuration initialized by `genval genai init`
	config, err := llm.LoadConfig()
	if err != nil {
		return fmt.Errorf("error loading config: %v", err)
	}

	// Step 2: Set the model from the configuration if not provided via flags
	if generateArgs.model == "" {
		generateArgs.model = config.LlmBackend
	}
	if config.LlmAPIKey == "" {
		return errors.New("API key is not set. Please run 'genval genai init' to set the LLM backend and API key.")
	}

	// Step 3: Get the system prompt for the selected assistant
	systemPrompt, err := llm.GetSystemPrompt(generateArgs.assistant)
	if err != nil {
		return fmt.Errorf("error getting system prompt: %v", err)
	}

	// Generate response
	ctx := context.Background()
	resp, err := llm.GenerateCompletion(ctx, config, systemPrompt, generateArgs.prompt)
	if err != nil {
		return fmt.Errorf("error generating response: %v", err)
	}

	fmt.Println(resp.Choices[0].Message.Content)
	return nil
}
