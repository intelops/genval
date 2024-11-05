package cmd

import (
	"context"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/fatih/color"
	"github.com/sashabaranov/go-openai"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/utils"
)

var genaiCmd = &cobra.Command{
	Use:   "genai",
	Short: "Generates secure configuration files leveraging AI",
	Long: `Interacts with LLM backends (OpenAI, Llama3, etc.) to generate secure IaC configurations based on user-provided prompts.
	Run 'genval genai init' to download resources needed for enhanced responses.
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
	output           string
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
	genaiCmd.Flags().StringVarP(&genaiArgs.userSystemPrompt, "user-system-prompt", "u", "", "Provide the system prompt. Only if assistant is set to 'user'")
	genaiCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to config file (YAML format)")
	genaiCmd.Flags().StringVarP(&genaiArgs.output, "output", "o", "", "Path to output file to store output from the LLM agent")

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

	// Step 1: Ensure required resources are downloaded
	err = llm.DownloadLLMResources()
	if err != nil {
		return fmt.Errorf("error downloading LLM resources: %v", err)
	}

	// Step 2: Extract supported tools and validate assistant
	st, err := llm.ExtractSupportedTools()
	if err != nil {
		return err
	}

	var supportedTool string
	found := false

	for _, tool := range st {
		tool = strings.ToLower(tool)
		if genaiArgs.assistant == tool || cfg.Common.Assistant == tool {
			supportedTool = tool
			found = true
			break
		}
	}

	if !found {
		return fmt.Errorf("unsupported tool %s provided", cfg.Common.Assistant)
	}

	// Step 3: Retrieve system prompt based on the assistant
	systemPrompt, err := getSystemPrompt(cfg, supportedTool)
	if err != nil {
		return err
	}

	// Step 4: Get user prompt content
	userPromptContent, err := getUserPrompt(cfg, genaiArgs)
	if err != nil {
		return err
	}

	// Step 5: Determine output path for LLM response
	outputPath := getOutputPath(genaiArgs, cfg)

	// Step 6: Generate response based on the model and backend
	ctx := context.Background()
	var response string
	openAIConfig := cfg.LLMSpec.OpenAIConfig
	ollamaConfig := cfg.LLMSpec.OllamaConfig
	switch cfg.LLMSpec.OpenAIConfig.Model {
	case "GPT4":
		openAIConfig.Model = openai.GPT4
		response, err = openAIConfig.GenerateOpenAIResponse(ctx, cfg.LLMSpec.OpenAIConfig.Model, systemPrompt, userPromptContent)
	case "ollama":
		response, err = ollamaConfig.GenerateOllamaResponse(ctx, cfg.LLMSpec.OllamaConfig.Model, systemPrompt, userPromptContent)
	default:
		return fmt.Errorf("unsupported model: %s", cfg.LLMSpec.OpenAIConfig.Model)
	}

	if err != nil {
		return fmt.Errorf("error generating response: %v", err)
	}

	// Step 7: Write response to the output file
	err = llm.WriteOutput(outputPath, response)
	if err != nil {
		return fmt.Errorf("error writing output to file: %v", err)
	}

	color.Green("Response successfully written to: %s", outputPath)
	return nil
}

// getSystemPrompt retrieves the system prompt based on the assistant or user-specified file.
func getSystemPrompt(cfg *llm.RequirementSpec, supportedTool string) (string, error) {
	if cfg.Common.Assistant == "user" {
		content, err := utils.ReadFile(cfg.Common.UserSystemPrompt)
		if err != nil {
			return "", fmt.Errorf("error reading user system prompt file: %v", err)
		}
		return string(content), nil
	}

	systemPrompt, err := llm.GetSystemPrompt(supportedTool)
	if err != nil {
		return "", fmt.Errorf("error getting system prompt: %v", err)
	}

	return systemPrompt, nil
}

// getUserPrompt retrieves the user prompt from CLI flags or config file.
func getUserPrompt(cfg *llm.RequirementSpec, args genaiFlags) (string, error) {
	if args.prompt != "" {
		return args.prompt, nil
	} else if cfg.Common.UserPrompt != "" {
		upc, err := utils.ReadFile(cfg.Common.UserPrompt)
		if err != nil {
			return "", fmt.Errorf("error reading user prompt file: %v", err)
		}
		return string(upc), nil
	}
	return "", fmt.Errorf("user prompt not provided")
}

// getOutputPath determines the output path for the LLM response.
func getOutputPath(args genaiFlags, cfg *llm.RequirementSpec) string {
	if args.output != "" {
		return args.output
	}
	if cfg.Common.Output != "" {
		return cfg.Common.Output
	}
	return filepath.Join(os.TempDir(), "genai_response.txt")
}

// loadConfig loads the configuration from either the config file or directly from CLI flags.
func loadConfig() (*llm.RequirementSpec, error) {
	var spec *llm.RequirementSpec

	// Load configuration from file if the config file path is provided
	if configFile != "" {
		// Load config from YAML file as llm.Config type
		config, err := llm.LoadConfig(configFile)
		if err != nil {
			return nil, fmt.Errorf("failed to load config from file: %w", err)
		}

		// Map llm.Config to llm.RequirementSpec
		spec = &llm.RequirementSpec{
			Common: llm.CommonSpec{
				UserPrompt:       config.RequirementSpec.Common.UserPrompt,
				Assistant:        config.RequirementSpec.Common.Assistant,
				UserSystemPrompt: config.RequirementSpec.Common.UserSystemPrompt,
			},
		}
	} else {
		// No config file provided, load directly from flags
		spec = loadConfigFromFlags()
	}

	// Merge CLI flags with the loaded config (if applicable)
	mergeFlagsWithConfig(spec)
	return spec, nil
}

// loadConfigFromFlags loads configuration directly from Cobra flags.
func loadConfigFromFlags() *llm.RequirementSpec {
	return &llm.RequirementSpec{
		Common: llm.CommonSpec{
			UserPrompt:       genaiArgs.prompt,
			Assistant:        genaiArgs.assistant,
			UserSystemPrompt: genaiArgs.userSystemPrompt,
		},
	}
}

// mergeFlagsWithConfig selectively overrides config values with CLI flag values if they are set.
func mergeFlagsWithConfig(spec *llm.RequirementSpec) {
	// Overwrite values in the loaded config only if a corresponding flag is set
	if genaiArgs.assistant != "" {
		spec.Common.Assistant = genaiArgs.assistant
	}
	if genaiArgs.userSystemPrompt != "" {
		spec.Common.UserSystemPrompt = genaiArgs.userSystemPrompt
	}
	if genaiArgs.prompt != "" {
		spec.Common.UserPrompt = genaiArgs.prompt
	}
}
