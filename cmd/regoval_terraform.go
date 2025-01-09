package cmd

import (
	"fmt"
	"os"
	"strings"

	"github.com/fatih/color"
	"github.com/sashabaranov/go-openai"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
)

type terraformFlags struct {
	takeAction bool
	reqinput   string
	policy     string
	ociCreds   string
	model      string
	output     string
}

var terraformArgs terraformFlags

func init() {
	terraformCmd.Flags().BoolVarP(&terraformArgs.takeAction, "take-action", "t", false, "remediate the failures")
	terraformCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to YAML file to read configs from")
	terraformCmd.Flags().StringVarP(&terraformArgs.model, "model", "m", "", "AI model to be used for remediation. Required if --takeaction is set to true")
	terraformCmd.Flags().BoolVarP(&terraformArgs.takeAction, "takeaction", "t", false, "Remediate the failures")
	terraformCmd.Flags().StringVarP(&terraformArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .tf files with rego")
	// if err := terraformCmd.MarkFlagRequired("reqinput"); err != nil {
	// 	log.Fatalf("Error marking flag as required: %v", err)
	// }
	terraformCmd.Flags().StringVarP(&terraformArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	terraformCmd.Flags().StringVarP(&terraformArgs.ociCreds, "credentials", "c", "", "credentials for interacting with OCI registries")

	viper.BindPFlags(terraformCmd.Flags())
	regovalCmd.AddCommand(terraformCmd)
}

var terraformCmd = &cobra.Command{
	Use:   "terraform",
	Short: "Validate Terraform .tf files with Rego policies",
	Long: `With tf mode, a user can validate raw terraform file with .tf extions.
Provide a valid terraform file with .tf extension in the --reqinput arg and a set of Rego policies in the
--policy arg.

The required input .tf files and  Rego policy files can be either be passed through local file paths or remote URLs,
such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `
# Validate Terraform files with local Rego policies

./genval regoval terraform --reqinput=./templates/inputs/terraform/sec_group.tf \
--policy=./templates/defaultpolicies/rego/terraform.rego

# As with all the other commands, showJSON can also read the Dockerfile/.tf file passed through remote URL's

./genval regoval terraform --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/input-templates/terraform/sec_group.tf \
--policy https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/default-policies/rego/terraform.rego

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval regoval terraform --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/terraform/sec_group.tf \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/terraform.rego


# Validating of Terraform files using policies stored in OCI compliant registries

To facilitate authentication with OCI compliant container registries, Users can provide credentials through --credentials flag. The creds can
be provided via <USER:PAT> or <REGISTRY_PAT> format. If no credentials are provided, Genval searches for the "./docker/config.json"
file in the user's $HOME directory. If this file is found, Genval utilizes it for authentication.

./genval regoval terrafrorm --reqinput=./templaes/inputs/terraform/sec_group.tf \
--policy oci://ghcr.io/intelops/policyhub/genval/terraform_policies:v0.0.1
--credentials <GITHUB_PAT> or <USER:PAT>

# Users can you use default policies maintained by the community stored in the https://github.com/intelops/policyhub repo

./genval regoval terraform --reqinput <path to terraform file>
// No credntials provided, will default to $HOME/.docker/config.json for credentials
	`,
	RunE: runTerraformCmd,
}

func runTerraformCmd(cmd *cobra.Command, args []string) error {
	cfg, err := loadYAMLConfig(configFile)
	if err != nil {
		fmt.Errorf("error reading config: %v", err)
	}

	ctx := cmd.Context()
	var failedResults []byte
	var failedCount int

	creds := cfg.Common.OCICredentials
	if terraformArgs.ociCreds != "" {
		creds = terraformArgs.ociCreds
	}
	output := cfg.Common.Output
	if terraformArgs.output != "" {
		output = terraformArgs.output
	}
	takeAction := cfg.Common.Takeaction
	if terraformArgs.takeAction {
		takeAction = terraformArgs.takeAction
	}
	inputFile := cfg.Common.Reqinput
	if terraformArgs.reqinput != "" {
		inputFile = terraformArgs.reqinput
	}
	policy := cfg.Common.Policy
	if terraformArgs.policy != "" {
		policy = terraformArgs.policy
	}
	var model string
	models := cfg.LLMSpec.GetActiveModels()
	if len(models) > 0 {
		model = models[0]["model"]
	}
	if model == "" {
		model = openai.GPT4
	}
	var processor validate.GenericProcessor

	inputJSON, err := parser.ConvertTFtoJSON(inputFile)
	if err != nil {
		log.Errorf("Error converting tf file: %v", err)
	}

	if policy == "" || strings.HasPrefix(policy, "oci://") {
		if failedResults, failedCount, err = validate.ValidateWithOCIPolicies(inputJSON,
			policy,
			cmd.Name(),
			creds,
			processor,
		); err != nil {
			return fmt.Errorf("error validating with policies stored in registries: %v", err)
		}
	} else {
		failedResults, failedCount, err = validate.ValidateWithRego(inputJSON, policy, processor)
		if err != nil {
			log.Errorf("Validation %v failed", err)
		}
	}

	var fr []byte
	var resp string
	failures := failedResults

	for takeAction && failedCount > 0 {
		spin := utils.StartSpinner("Taking action on remediating the errors in Terraform file, please hond on for a moment...\n")
		contentToCombine := inputJSON
		if resp != "" {
			contentToCombine = resp
		}
		resultsFailed := failures
		if fr != nil {
			resultsFailed = fr
		}

		rParams := llm.RemediationParams{
			InputContent:  contentToCombine,
			PolicyContent: policy,
			Failures:      resultsFailed,
			Command:       cmd.Name(),
			Model:         model,
			ApiKey:        cfg.LLMSpec.OpenAIConfig[0].APIKey,
		}

		resp, err := llm.RemediateResource(ctx, rParams)
		if err != nil {
			fmt.Errorf("error remediating resource: [%v] - %v", inputFile, err)
		}
		spin.Stop()
		fr, failedCount, err = validate.ValidateWithRego(resp, policy, processor)
		if err != nil {
			fmt.Errorf("Terraform file validation failed: %v\n", err)
		}
		// If no further failures, exit the loop
		if fr == nil {
			fmt.Println("No Failed results were captured. Remediation is complete.")
			break
		}
	}
	if output != "" {
		err := os.WriteFile(output, []byte(resp), 0o644)
		if err != nil {
			fmt.Errorf("error writing output: %v", err)
		}
	}
	fmt.Println(validate.BorderedOutput(resp))
	writeMessage := color.GreenString("Final Terraform file weitten to: %v\n", output)
	logMessage := color.GreenString("Terraform resource validation for: %v completed", inputFile)

	log.Infof(writeMessage)
	log.Info(logMessage)
	return nil
}
