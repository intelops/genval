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
	Short: "Generates secure configuration files leveraging AI",
	Long: `Interacts with LLM backends ( currently supported: OpenAI and llama3) using configuration provided by the user through CLI args or a config file in YAML format. A user need to set an assistant to work with, currently supported assistants are Cue, CEL, Rego, Dockerfile, Regex. genai based on the assistant and the user prompt will generate desired a secure IaC configuration by interacting with the chosen LLM. If interacting with OpenAI's 4omodels, a user would need to provide aan API key as an ENV Variable (OPENAI_KEY) for authenticating wtth the LLM backend.

	To enhance the reponse generated by the LLM, it is advisable to run 'genval genai init' before using genai command.
// Examples:
	genval genai --assistant dockerfile --model GPT4 --prompt "Create a Dockefile for a sample python project"

	`,
	RunE: runGenaiCmd,
}

type genaiFlags struct {
	model            string
	endpoint         string
	prompt           string
	assistant        string
	userSystemPrompt string
	backend          string
}

var (
	genaiArgs  genaiFlags
	configFile string
)

func init() {
	// Define Cobra flags
	genaiCmd.Flags().StringVarP(&genaiArgs.model, "model", "m", "", "Select the AI model (e.g., GPT4 or Ollama)")
	genaiCmd.Flags().StringVarP(&genaiArgs.endpoint, "endpoint", "e", "", "Specify the endpoint for the LLM")
	genaiCmd.Flags().StringVarP(&genaiArgs.prompt, "prompt", "p", "", "Provide the user prompt for LLM")
	genaiCmd.Flags().StringVarP(&genaiArgs.assistant, "assistant", "a", "", "Specify the assistant for generating IaC files")
	genaiCmd.Flags().StringVarP(&genaiArgs.userSystemPrompt, "user-system-prompt", "u", "", "Provide the system prompt. Only if assistant is set to user")
	genaiCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to config file (YAML format)")

	// Add the genai command to root
	rootCmd.AddCommand(genaiCmd)
}

// runGenaiCmd is the main execution function for the genai command
func runGenaiCmd(cmd *cobra.Command, args []string) error {
	// Load configuration
	cfg, err := loadConfig()
	if err != nil {
		return fmt.Errorf("failed to load configuration: %w", err)
	}
	st, err := llm.ExtractSupportedTools()
	if err != nil {
		return err
	}

	var supportedTool string
	found := false

	for _, tool := range st {
		tool = strings.ToLower(tool)
		if genaiArgs.assistant == tool || cfg.Assistant == tool {
			supportedTool = tool
			found = true
			break
		}
	}

	if !found {
		return fmt.Errorf("unsupported tool %s provided", cfg.Assistant)
	}

	var systemPrompt string

	if cfg.Assistant == "user" {
		if cfg.UserSystemPrompt == "" {
			return fmt.Errorf("user-system-prompt must be provided when assistant is set to 'user'")
		}

		// TODO: Read either geaiArgs or cfg userSystemnPrompt, whichever is provided
		content, err := utils.ReadFile(cfg.UserSystemPrompt)
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

	if cfg.Assistant != "user" {
		localFilePath := filepath.Join(os.Getenv("HOME"), llm.SystemPromptsDir+"/"+supportedTool+"Prompt.md")
		remoteFilePath := llm.BaseURL + supportedTool + "Prompt.md"

		if err := llm.ValidateSystemPrompt(localFilePath, remoteFilePath); err != nil {
			fmt.Errorf("error validatin local and remote files: %v", err)
		}
	}

	if cfg.UserSystemPrompt != "" {
		usc, err := utils.ReadFile(cfg.UserSystemPrompt)
		if err != nil {
			fmt.Errorf("error reading user-system-prompt file: %v", err)
		}
		systemPrompt = string(usc)
	}

	var userPromptContent string

	// Check if the --prompt flag is provided, if so, use it directly as a string
	if genaiArgs.prompt != "" {
		userPromptContent = genaiArgs.prompt
	} else if cfg.UserPrompt != "" {
		// If no --prompt flag, check if a file path is provided in the config
		upc, err := utils.ReadFile(cfg.UserPrompt)
		if err != nil {
			return fmt.Errorf("error reading user prompt file path: %v", err)
		}
		userPromptContent = string(upc)
	}

	// Conditionally call the appropriate LLM backend based on the model defined
	ctx := context.Background()
	if cfg.Model == "GPT4" {
		cfg.Model = openai.GPT4o
		resp, err := cfg.GenerateOpenAIResponse(ctx, cfg.Model, systemPrompt, userPromptContent)
		if err != nil {
			return fmt.Errorf("failed to generate OpenAI response: %w", err)
		}
		fmt.Println("OpenAI Response:", resp)
	} else if cfg.Model == "ollama" {
		resp, err := cfg.GenerateOllamaResponse(ctx, cfg.Model, systemPrompt, userPromptContent)
		if err != nil {
			return fmt.Errorf("failed to generate Ollama response: %w", err)
		}
		fmt.Println("Ollama Response:", resp)
	} else {
		return fmt.Errorf("unsupported model: %s", cfg.Model)
	}

	return nil
}

// loadConfig loads the configuration from either flags or config file.
func loadConfig() (*llm.LLMSpec, error) {
	if configFile != "" {
		spec, err := llm.LoadConfig(configFile)
		if err != nil {
			return nil, err
		}
		mergeFlagsWithConfig(spec)
		return spec, nil
	}

	// No config file provided, load from flags
	return loadConfigFromFlags(), nil
}

// loadConfigFromFlags loads configuration from Cobra flags.
func loadConfigFromFlags() *llm.LLMSpec {
	return &llm.LLMSpec{
		Model:            genaiArgs.model,
		URL:              genaiArgs.endpoint,
		UserPrompt:       genaiArgs.prompt,
		Assistant:        genaiArgs.assistant,
		UserSystemPrompt: genaiArgs.userSystemPrompt,
	}
}

// mergeFlagsWithConfig merges the flag values with the config (if flag values are not empty).
func mergeFlagsWithConfig(spec *llm.LLMSpec) {
	if genaiArgs.model != "" {
		spec.Model = genaiArgs.model
	}
	if genaiArgs.endpoint != "" {
		spec.URL = genaiArgs.endpoint
	}
	if genaiArgs.assistant != "" {
		spec.Assistant = genaiArgs.assistant
	}
}
