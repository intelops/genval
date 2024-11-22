package cmd

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/fatih/color"
	"github.com/sashabaranov/go-openai"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/otm"
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
	output           string
}

var (
	genaiArgs  genaiFlags
	configFile string
)

func init() {
	genaiCmd.Flags().StringVarP(&genaiArgs.model, "model", "m", "", "Select the AI model (e.g., GPT4 or Ollama)")
	genaiCmd.Flags().StringVarP(&genaiArgs.endpoint, "endpoint", "e", "", "Specify the endpoint for the LLM")
	genaiCmd.Flags().StringVarP(&genaiArgs.prompt, "prompt", "p", "", "Provide the user prompt for LLM")
	genaiCmd.Flags().StringVarP(&genaiArgs.assistant, "assistant", "a", "", "Specify the assistant for generating IaC files")
	genaiCmd.Flags().StringVarP(&genaiArgs.userSystemPrompt, "user-system-prompt", "u", "", "Provide the system prompt. Only if assistant is set to 'user'")
	genaiCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to config file (YAML format)")
	genaiCmd.Flags().StringVarP(&genaiArgs.output, "output", "o", "", "Path to output file to store output from the LLM agent")

	rootCmd.AddCommand(genaiCmd)
}

func runGenaiCmd(cmd *cobra.Command, args []string) error {
	spin := utils.StartSpinner("Processing your request, please hold-on for a moment...")

	ctx, span := otm.StartSpanForCommand(tracer, cmd)
	defer span.End()
	// Load configuration
	cfg, err := loadConfig()
	if err != nil {
		return fmt.Errorf("failed to load configuration: %w", err)
	}
	if cfg == nil {
		return fmt.Errorf("loadConfig returned a nil configuration")
	}
	var appliedModel string
	// Fetch active models and assign the first one found
	activeModels := cfg.LLMSpec.GetActiveModels()
	if len(activeModels) > 0 {
		appliedModel = activeModels[0]["model"]
	}

	assistant, err := cfg.SelectActiveAssistant(appliedModel)
	fmt.Printf("Applied Assistant: %v\b", assistant)
	if err != nil {
		return fmt.Errorf("error selecting assistant: %v", err)
	}

	st, err := llm.ExtractSupportedTools()
	if err != nil {
		return err
	}

	var supportedTool string
	found := false

	for _, tool := range st {
		tool = strings.ToLower(tool)
		if genaiArgs.assistant == tool || assistant == tool {
			supportedTool = tool
			found = true
			break
		}
	}

	if !found {
		return fmt.Errorf("unsupported tool %s provided", assistant)
	}

	var systemPrompt string

	if assistant == "user" {
		if cfg.Common.UserSystemPrompt == "" {
			return fmt.Errorf("user-system-prompt 'must' be set when Assistant is set to 'user': %v", err)
		}
		content, err := utils.ReadFile(cfg.Common.UserSystemPrompt)
		if err != nil {
			return fmt.Errorf("error reading user-system-prompt file: %v", err)
		}
		systemPrompt = string(content)
	} else {
		var err error
		// Step 3: Retrieve system prompt based on the assistant
		systemPrompt, err = llm.GetSystemPrompt(supportedTool)
		if err != nil {
			return err
		}
	}

	if assistant != "user" {
		localFilePath := filepath.Join(os.Getenv("HOME"), llm.SystemPromptsDir+"/"+supportedTool+"Prompt.md")
		remoteFilePath := llm.BaseURL + supportedTool + "Prompt.md"

		if err := llm.ValidateSystemPrompt(localFilePath, remoteFilePath); err != nil {
			orange := color.New(color.FgHiWhite).Add(color.BgHiBlack).Add(color.Attribute(38), color.Attribute(5), 208)
			orange.Printf("[WARN}: Provided system prompt do not match with original content: %v", err)
		}
	}

	if cfg.Common.UserSystemPrompt != "" {
		usc, err := utils.ReadFile(cfg.Common.UserSystemPrompt)
		if err != nil {
			return fmt.Errorf("error reading user-system-prompt fil: %v", err)
		}
		systemPrompt = string(usc)
	}

	var userPromptContent string

	// Check if the --prompt flag is provided, if so, use it directly as a string
	if genaiArgs.prompt != "" {
		userPromptContent = genaiArgs.prompt
	} else if cfg.Common.UserPrompt != "" {
		// If no --prompt flag, check if a file path is provided in the config
		upc, err := utils.ReadFile(cfg.Common.UserPrompt)
		if err != nil {
			return fmt.Errorf("error reading user prompt file path: %v", err)
		}
		userPromptContent = string(upc)
	}
	// Determine output path for LLM response
	outputPath := getOutputPath(genaiArgs, cfg)

	// Generate response based on the model and backend
	// ctx := context.Background()
	var response string
	switch appliedModel {
	case "GPT4":
		appliedModel = openai.GPT4
		response, err = cfg.GenerateOpenAIResponse(ctx, appliedModel, systemPrompt, userPromptContent)
	case "ollama":
		response, err = cfg.GenerateOllamaResponse(ctx, systemPrompt, userPromptContent)
	default:
		return fmt.Errorf("unsupported model: %s", appliedModel)
	}

	if err != nil {
		return fmt.Errorf("error generating response: %v", err)
	}

	if cfg.Common.Output != "" {
		// Write response to the output file
		err = llm.WriteOutput(outputPath, response)
		if err != nil {
			return fmt.Errorf("error writing output to file: %v", err)
		}
		color.Green("Response successfully written to: %s", outputPath)
	} else {
		fmt.Printf("Genval Response: \n%v\n", response)
	}

	spin.Stop()
	return nil
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

func loadConfig() (*llm.RequirementSpec, error) {
	var spec *llm.RequirementSpec

	if configFile != "" {
		config, err := llm.LoadConfig(configFile)
		if err != nil {
			return nil, fmt.Errorf("failed to load config from file: %w", err)
		}

		spec = &llm.RequirementSpec{
			Common: llm.CommonSpec{
				UserPrompt:       config.RequirementSpec.Common.UserPrompt,
				Assistant:        config.RequirementSpec.Common.Assistant,
				UserSystemPrompt: config.RequirementSpec.Common.UserSystemPrompt,
			},
			LLMSpec: llm.LLMSpec{
				OpenAIConfig: config.RequirementSpec.LLMSpec.OpenAIConfig,
				OllamaSpec:   config.RequirementSpec.LLMSpec.OllamaSpec,
			},
		}
	} else {
		spec = loadConfigFromFlags()
	}

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
