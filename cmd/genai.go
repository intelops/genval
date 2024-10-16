package cmd

import (
	"context"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/sashabaranov/go-openai"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/utils"
)

var genaiCmd = &cobra.Command{
	Use:   "genai",
	Short: "genai configuration files leveraging AI",
	Long: `
	Initialize GenAI configurations. Setup LLM backend with API key and other setup for generating Rego, Cue, and CEL policies to be used with Genval for validating and generation of IaC
	configs`,
	RunE: runGenaiCmd,
}

type genaiFlags struct {
	model            string
	endpoint         string
	prompt           string
	assistant        string
	userSystemPrompt string
}

var genaiArgs genaiFlags

func init() {
	genaiCmd.Flags().StringVarP(&genaiArgs.model, "model", "m", "", "Select the AI model")
	genaiCmd.Flags().StringVarP(&genaiArgs.endpoint, "endpoint", "e", "", "Endpoint for the AI model")
	genaiCmd.Flags().StringVarP(&genaiArgs.prompt, "prompt", "p", "", "Your prompt to the model")
	genaiCmd.Flags().StringVarP(&genaiArgs.assistant, "assistant", "a", "", "Specify the assistant to use (cue, cel, rego, etc.)")
	genaiCmd.Flags().StringVarP(&genaiArgs.userSystemPrompt, "user-systemPrompt", "u", "", "Availabe only if assistant set as user. Path to the user-provided system prompt file")

	rootCmd.AddCommand(genaiCmd)
}

func runGenaiCmd(cmd *cobra.Command, args []string) error {
	if genaiArgs.model == "" {
		genaiArgs.model = openai.GPT4o
	}

	st, err := llm.ExtractSupportedTools()
	if err != nil {
		return err
	}

	var supportedTool string
	found := false

	for _, tool := range st {
		tool = strings.ToLower(tool)
		if genaiArgs.assistant == tool {
			supportedTool = tool
			found = true
			break
		}
	}

	if !found {
		return fmt.Errorf("unsupported tool %s provided", genaiArgs.assistant)
	}

	var systemPrompt string

	if genaiArgs.assistant == "user" {
		if genaiArgs.userSystemPrompt == "" {
			return fmt.Errorf("user-systemPrompt flag must be provided when assistant is set to 'user'")
		}

		content, err := utils.ReadFile(genaiArgs.userSystemPrompt)
		if err != nil {
			return fmt.Errorf("error reading user system prompt file: %v", err)
		}

		systemPrompt = string(content)
	} else {
		var err error
		systemPrompt, err = llm.GetSystemPrompt(supportedTool)
		if err != nil {
			return fmt.Errorf("error getting system prompt: %v", err)
		}
	}
	var localFilePath, remoteFilePath string
	if genaiArgs.assistant != "user" {
		localFilePath = filepath.Join(os.Getenv("HOME"), llm.System_Prompts+"/"+supportedTool+"Prompt.md")
		remoteFilePath = llm.BaseURL + supportedTool + "Prompt.md"
	}

	if err := llm.ValidateSystemPrompt(localFilePath, remoteFilePath); err != nil {
		fmt.Errorf("error validatin local and remote files: %v", err)
	}
	ctx := context.Background()
	resp, err := llm.GenerateCompletion(ctx, genaiArgs.model, systemPrompt, genaiArgs.prompt)
	if err != nil {
		return fmt.Errorf("error generating response: %v", err)
	}

	fmt.Println(resp.Choices[0].Message.Content)
	return nil
}
