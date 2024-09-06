package cmd

import (
	"context"
	"errors"
	"fmt"

	tea "github.com/charmbracelet/bubbletea"
	"github.com/sashabaranov/go-openai"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/tui"
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
	model     string
	endpoint  string
	prompt    string
	assistant []string
}

var generateArgs generateFlags

func init() {
	generateCmd.Flags().StringVarP(&generateArgs.model, "model", "m", "", "Select the AI model")
	generateCmd.Flags().StringVarP(&generateArgs.endpoint, "endpoint", "e", "", "Endpoint for the AI model")
	generateCmd.Flags().StringVarP(&generateArgs.prompt, "prompt", "p", "", "Your prompt to the model")
	// if err := generateCmd.MarkFlagRequired("prompt"); err != nil {
	// 	fmt.Errorf("Error marking flag as required: %v", err)
	// }
	generateCmd.Flags().StringSliceVarP(&generateArgs.assistant, "assistant", "a", nil, "Specify the assistant to use to generate policies, currently supported: (eg: cue, cel, rego)")

	rootCmd.AddCommand(generateCmd)
}

var baseURL = "localhost:11434"

func runGenerateCmd(cmd *cobra.Command, args []string) error {
	var selectedAssistant string
	if generateArgs.prompt == "" {
		p := tea.NewProgram(tui.NewGenerateModel())
		m, err := p.Run()
		if err != nil {
			return fmt.Errorf("error starting TUI: %v", err)
		}
		model := m.(tui.GenerateModel)

		generateArgs.prompt = model.TextArea.Value()
		selectedAssistant = model.SelectedAssistant
		// Print the user input and assistant after Bubbletea quits
		// fmt.Printf("\nSelected Assistant: %s\n", selectedAssistant)
		// fmt.Printf("User Prompt: %s\n", generateArgs.prompt)
	}

	systemPrompt, err := llm.GetSystemPrompt(selectedAssistant)
	if err != nil {
		return fmt.Errorf("error getting system prompt: %v", err)
	}
	if generateArgs.model == "" {
		generateArgs.model = openai.GPT4o

		// Ensure only one assistant is specified
		if len(generateArgs.assistant) > 1 {
			return errors.New("please specify only one assistant (cue, cel, or rego)")
		}

		ctx, cancel := context.WithCancel(cmd.Context())
		defer cancel()

		resp, err := llm.GenerateCompletion(ctx, systemPrompt, generateArgs.prompt)
		if err != nil {
			return fmt.Errorf("error generating response: %v", err)
		}
		fmt.Println(resp.Choices[0].Message.Content)
		return nil
	}

	// Use default base URL if --endpoint is not provided
	url := baseURL
	if generateArgs.endpoint != "" {
		url = generateArgs.endpoint
	}

	c, err := llm.NewDefaultConfig(url)
	if err != nil {
		return fmt.Errorf("error initializing ollama configurations:%v", err)
	}

	if err := c.NewOllamaClient(); err != nil {
		return fmt.Errorf("error creating client: %v", err)
	}

	ctx := context.Background()

	if generateArgs.endpoint != "" {
		c.URL = generateArgs.endpoint
	}

	if generateArgs.model != "" {
		c.ModelName = generateArgs.model
	}

	response, err := c.GenerateResponse(ctx, generateArgs.model, systemPrompt, generateArgs.prompt)
	if err != nil {
		return fmt.Errorf("error generating response: %v", err)
	}

	fmt.Println(response)
	return nil
}
