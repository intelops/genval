package cmd

import (
	"fmt"
	"os"

	"github.com/fatih/color"
	"github.com/jedib0t/go-pretty/v6/table"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
)

type celTerraformvalFlags struct {
	reqinput   string
	policy     string
	model      string
	output     string
	takeAction bool
}

var celTerraformValArgs celTerraformvalFlags

func init() {
	celTerraformvalCmd.Flags().StringVarP(&celTerraformValArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .dockerfileval files with rego")
	celTerraformvalCmd.Flags().StringVarP(&celTerraformValArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	celTerraformvalCmd.Flags().StringVarP(&celTerraformValArgs.model, "model", "m", "", "AI model to be used for remediation. Required if --takeaction is set to true")
	celTerraformvalCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to YAML file to read configs from")
	celTerraformvalCmd.Flags().StringVarP(&celTerraformValArgs.output, "output", "o", "", "Output file for the remediation results")
	celTerraformvalCmd.Flags().BoolVarP(&celTerraformValArgs.takeAction, "takeaction", "t", false, "Remediate the failures")

	celvalCmd.AddCommand(celTerraformvalCmd)
}

var celTerraformvalCmd = &cobra.Command{
	Use:   "terraform",
	Short: "Validate Terraform .tf files with Common Expression Languiage (CEL) policies",
	Long: `Using celval terraform command, a user can validate Terraform .tf files. Provide a .tf Terraform file thet needs to be validated
to the --reqinput arg and a set of CEL policies in the --policy arg.

The required input for Terraform files and CEL policy files can be either be passed through local file paths or remote URLs,
such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `
# Validate Terraform files with CEL policies by providing the required args from local file system

./genval celval terraform --reqinput ./templates/inputs/terraform/sec_group.tf \
--policy=--policy ./templates/defaultpolicies/cel/terraform.yaml

# Provide the required files from remote URL's
./genval celval terraform celval terraform --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/input-templates/terraform/sec_group.tf \
--policy https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/default-policies/cel/terraform.yaml

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval celval terraform --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/terraform/sec_group.tf \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/cel/terraform.yaml

	# Remediation of failed results highlighted by regoval
Genval can remediate the failed results by using the --takeaction flag and using an AI model of their choice. Users can also, supply the required configs via a YAML file by passing the '--config' flag.

genval celval dockerfileval -c ./templates/inputs/validation_configs/cel/terraform.yaml

An example YAML file can be found in ./templates/inputs/validation_configs/terraform.yaml

	`,
	RunE: runCelTerraformvalCmd,
}

func runCelTerraformvalCmd(cmd *cobra.Command, args []string) error {
	ctx := cmd.Context()
	cfg, err := loadYAMLConfig(configFile)
	if err != nil {
		return fmt.Errorf("error reading config file: %v", err)
	}

	inputFile := parseStringFlag(celTerraformValArgs.reqinput, cfg.Common.Reqinput)
	policy := parseStringFlag(celTerraformValArgs.policy, cfg.Common.Policy)
	output := parseStringFlag(celTerraformValArgs.output, cfg.Common.Output)
	takeAction := parseBoolBoolFlag(celTerraformValArgs.takeAction, cfg.Common.Takeaction)
	model := parseModel(cfg)

	inputJSON, err := parser.ConvertTFtoJSON(inputFile)
	if err != nil {
		log.Errorf("Error converting tf file: %v", err)
	}

	policies, err := validate.ParseYAMLPolicies(policy)
	if err != nil {
		log.Fatalf("Error parsing YAML policies: %v", err)
	}

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Result", "Description", "Severity", "Benchmark"})

	failedResults, failedCount, err := validate.EvaluateCELPolicies(policies, string(inputJSON), t)
	if err != nil {
		log.Fatalf("Error evaluating policies: %v", err)
	}

	t.Render()
	failures := failedResults

	var fr []byte
	var resp string

	for takeAction && failedCount > 0 {

		spin := utils.StartSpinner("Taking action on remediating the errors in Terraform file, please hold on for a moment...\n")
		contentToCombine := string(inputJSON)
		if resp != "" {
			contentToCombine = resp
		}

		resultsFailed := failures
		if fr != nil {
			resultsFailed = fr
		}

		rParams := llm.RemediationParams{
			InputContent: contentToCombine,
			CelPolicies:  policies,
			Failures:     resultsFailed,
			Command:      cmd.Name(),
			Model:        model,
			APIKey:       cfg.LLMSpec.OpenAIConfig[0].APIKey,
		}
		resp, err = llm.RemediateResource(ctx, cmd.Parent().Name(), rParams)
		if err != nil {
			return fmt.Errorf("error remediating Terraform file [%v]: %v", inputFile, err)
		}
		spin.Stop()

		fr, failedCount, err = validate.EvaluateCELPolicies(policies, resp, t)
		if err != nil {
			return fmt.Errorf("error evaluating remediated input: %v", err)
		}
	}
	t.Render()
	if output != "" {
		err = os.WriteFile(output, []byte(resp), 0o644)
		if err != nil {
			log.Error("Error writing Dockerfile:", err)
			return err
		}
	}

	fmt.Println(validate.BorderedOutput(string(resp)))

	writeMessage := color.GreenString("Final Terraform fle written to: %v\n", output)
	logMessage := color.GreenString("Validation for: [%v] completed", inputFile)
	log.Info(writeMessage)
	log.Info(logMessage)
	return nil
}
