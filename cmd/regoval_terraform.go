package cmd

import (
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type terraformFlags struct {
	reqinput string
	policy   string
}

var terraformArgs terraformFlags

func init() {
	terraformCmd.Flags().StringVarP(&terraformArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .tf files with rego")
	if err := terraformCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	terraformCmd.Flags().StringVarP(&terraformArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	if err := terraformCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

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

TODO: Add examples for validating with default policies

	`,
	RunE: runTerraformCmd,
}

func runTerraformCmd(cmd *cobra.Command, args []string) error {
	inputFile := terraformArgs.reqinput
	policy := terraformArgs.policy

	inputJSON, err := parser.ConvertTFtoJSON(inputFile)
	if err != nil {
		log.Errorf("Error converting tf file: %v", err)
	}

	err = validate.ValidateWithRego(inputJSON, policy)
	if err != nil {
		log.Errorf("Validation %v failed", err)
	}
	log.Infof("Terraform resource: %v, validated succussfully.", inputFile)
	return nil
}
