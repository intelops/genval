package cmd

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/sashabaranov/go-openai"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
)

type celDockerfileValFlags struct {
	reqinput   string
	policy     string
	output     string
	takeAction bool
	model      string
	apiKey     string
}

var celDockerfileValArgs celDockerfileValFlags

func init() {
	celDockerfileValCmd.Flags().StringVarP(&celDockerfileValArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .dockerfileval files with rego")
	if err := celDockerfileValCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	celDockerfileValCmd.Flags().StringVarP(&celDockerfileValArgs.output, "output", "o", "", "Path to write the Generated Dockefile")
	celDockerfileValCmd.Flags().BoolVarP(&celDockerfileValArgs.takeAction, "takeaction", "t", false, "Remediate the failures")
	celDockerfileValCmd.Flags().StringVarP(&celDockerfileValArgs.model, "model", "m", "", "AI model to be used for remediation. Required if --takeaction is set to true")
	celDockerfileValCmd.Flags().StringVarP(&celDockerfileValArgs.apiKey, "apikey", "a", "", "API key for the AI model. Required if --takeaction is set to true")
	celDockerfileValCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to YAML file to read configs from")

	celDockerfileValCmd.Flags().StringVarP(&celDockerfileValArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	if err := celDockerfileValCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

	celvalCmd.AddCommand(celDockerfileValCmd)
}

var celDockerfileValCmd = &cobra.Command{
	Use:   "dockerfileval",
	Short: "Validate Dockerfile with Common Expression Languiage (CEL) policies",
	Long: `Using celval dockerfileval, a user can validate Dockerfilefiles. Provide a Dockerfile thet needs to be validated
to the --reqinput arg and a set of CEL policies in the --policy arg.

The required input Dockerfile and CEL policy files can be either be passed through local file paths or remote URLs,
such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `
# Validate Dockerfile with CEL policies by providing the required args from local file system

./genval celval dockerfileval --reqinput=input.json \
--policy=<'path/to/CEL policy file>

# Provide the required files from remote URL's

./genval celval dockerfileval --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/Dockerfilefile-sample \
--policy #TODO:

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval celval dockerfileval --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/Dockerfilefile-sample \
--policy #TODO:
	`,
	RunE: runCelDockerfileValCmd,
}

func runCelDockerfileValCmd(cmd *cobra.Command, args []string) error {
	ctx := cmd.Context()
	var failedResults []byte
	var failedCount int

	cfg, err := loadYAMLConfig(configFile)
	if err != nil {
		return fmt.Errorf("error reading config file: %v", err)
	}
	input := cfg.Common.Reqinput
	if celDockerfileValArgs.reqinput != "" {
		input = celDockerfileValArgs.reqinput
	}
	policy := cfg.Common.Policy
	if celDockerfileValArgs.policy != "" {
		policy = celDockerfileValArgs.policy
	}
	takeAction := cfg.Common.Takeaction
	if celDockerfileValArgs.takeAction {
		takeAction = celDockerfileValArgs.takeAction
	}
	var model string
	models := cfg.LLMSpec.GetActiveModels()
	if len(models) > 1 {
		model = models[0]["model"]
	}
	if model == "" {
		model = openai.GPT4
	}

	dockerfileContent, err := utils.ReadFile(input)
	if err != nil {
		log.Errorf("Error reading Dockerfile: %v, validation failed: %s\n", input, err)
	}

	dockerInst := parser.ParseDockerfileContent(string(dockerfileContent))
	dockerfileJSON, err := json.Marshal(dockerInst)
	if err != nil {
		log.Errorf("Error marshaling Dockerfile: %v", err)
		return err
	}
	policies, err := validate.ParseYAMLPolicies(policy)
	if err != nil {
		log.Fatalf("Error parsing YAML policies: %v", err)
	}

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Result", "Description", "Severity", "Benchmark"})

	failedResults, failedCount, err = validate.EvaluateCELPolicies(policies, string(dockerfileJSON), t)
	if err != nil {
		log.Fatalf("Error evaluating policies: %v", err)
	}

	failures := failedResults

	var fr []byte
	var resp string
	for takeAction && failedCount > 0 {
		spin := utils.StartSpinner("Taking action on remediating the errors in Dockerfile, please hold on for a moment...\n")
		contentToCombine := string(dockerfileContent)
		if resp != "" {
			contentToCombine = resp
		}

		// Update `resultsFailed` based on `fr`
		resultsFailed := failures
		if fr != nil {
			resultsFailed = fr
		}
		spin.Stop()
		rParams := llm.RemediationParams{
			InputContent: contentToCombine,
			CelPolicies:  policies,
			Failures:     resultsFailed,
			Command:      cmd.Name(),
			Model:        model,
			ApiKey:       cfg.LLMSpec.OpenAIConfig[0].APIKey,
		}
		resp, err := llm.RemediateResource(ctx, rParams)
		if err != nil {
			return fmt.Errorf("error remediating resource [%v]: %v", input, err)
		}
		fr, failedCount, err = validate.EvaluateCELPolicies(policies, resp, t)
	}

	t.Render()
	return nil
}
