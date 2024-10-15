package cmd

import (
	"fmt"

	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
)

var genaiInitCmd = &cobra.Command{
	Use:   "init",
	Short: "Initialize GenAI configurations",
	Long:  `Initialize the LLM backend and API key, and download necessary files to set up GenAI.`,
	RunE:  runGenAIInitCmd,
}

func init() {
	generateCmd.AddCommand(genaiInitCmd)
}

func runGenAIInitCmd(cmd *cobra.Command, args []string) error {
	// Step 1: Ask user for LLM backend and API key
	config, err := llm.LoadConfig()
	if err != nil {
		return fmt.Errorf("error prompting for LLM backend and API key: %v", err)
	}

	// Now you can use the `config` object for any future initialization
	fmt.Printf("Succussfully authenticated with LLM Backend: %s\n", config.LlmBackend)

	// Step 2: Download necessary files
	err = llm.DownloadLLMResources()
	if err != nil {
		return fmt.Errorf("error downloading LLM resources: %v", err)
	}

	// Save config to a file for future use (optional step)
	err = saveConfigToFile(config)
	if err != nil {
		return fmt.Errorf("error saving config: %v", err)
	}

	fmt.Println("Initialization complete. You can now use 'genval genai' with your configuration.")
	return nil
}

// saveConfigToFile saves the LLMConfig to a file for future use.
func saveConfigToFile(config *llm.LLMConfig) error {
	// Implementation to save config (e.g., to a JSON or YAML file) goes here
	// Example: Write to ~/.genval/config.json
	return nil
}
