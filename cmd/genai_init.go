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
	genaiCmd.AddCommand(genaiInitCmd)
}

func runGenAIInitCmd(cmd *cobra.Command, args []string) error {
	// Download necessary files
	err := llm.DownloadLLMResources()
	if err != nil {
		return fmt.Errorf("error downloading LLM resources: %v", err)
	}

	fmt.Println("Initialization complete. You can now use 'genval genai' with your configuration.")
	return nil
}
