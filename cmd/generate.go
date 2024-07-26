package cmd

import (
	"context"
	"fmt"

	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
)

var generateCmd = &cobra.Command{
	Use:   "generate",
	Short: "Generate configuration files levereging AI",
	Long: `
	Generate Rego, Cue, and CEL policies to be used with Genval for validating and generation of IaC
	configs`,
	Example: `
	#TODO: Add Examples
	`,
	RunE: runGenerateCmd,
}

type generateFlags struct {
	model    string
	endpoint string
	prompt   string
}

var generateArgs generateFlags

func init() {
	generateCmd.Flags().StringVarP(&generateArgs.model, "model", "m", "", "Select the AI model")
	generateCmd.Flags().StringVarP(&generateArgs.endpoint, "endpoint", "e", "", "Endpoint for the AI model")
	generateCmd.Flags().StringVarP(&generateArgs.prompt, "prompt", "p", "", "Your prompt to the model")
	if err := generateCmd.MarkFlagRequired("prompt"); err != nil {
		fmt.Errorf("Error marking flag as required: %v", err)
	}
	rootCmd.AddCommand(generateCmd)
}

var baseURL = "localhost:11434"

func runGenerateCmd(cmd *cobra.Command, args []string) error {
	c := llm.Config{
		ModelName:   "llama3",
		URL:         baseURL,
		Temperature: 0.7,
		TopP:        0.9,
	}

	client, err := llm.NewOllamaClient(c)
	if err != nil {
		return fmt.Errorf("error creating client: %v", err)
	}
	ctx := context.Background()

	if generateArgs.endpoint == "" {
		generateArgs.endpoint = c.URL
	}

	if generateArgs.model == "" {
		generateArgs.model = c.ModelName
	}

	response, err := client.GenerateResponse(ctx, generateArgs.model, generateArgs.prompt)
	if err != nil {
		return fmt.Errorf("error generating response: %v", err)
	}

	fmt.Println(response)
	return nil
}
