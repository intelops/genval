package cmd

import (
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type tfFlags struct {
	reqinput string
	policy   string
}

var tfArgs tfFlags

func init() {
	tfCmd.Flags().StringVarP(&tfArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .tf files with rego")
	if err := tfCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	tfCmd.Flags().StringVarP(&tfArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	if err := tfCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

	rootCmd.AddCommand(tfCmd)
}

var tfCmd = &cobra.Command{
	Use:   "tf",
	Short: "Validate Terraform .tf files with Rego policies",
	Long: `With tf mode, a user can validate raw terraform file with .tf extions.
Provide a valid terraform file with .tf extension in the --reqinput arg and a set of Rego policies in the
--policy arg.

The required input .tf files and  Rego policy files can be either be passed through local file paths or remote URLs,
such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `
# Validate Terraform files with local Rego policies

./genval tf --reqinput=./templates/inputs/terraform/sec_group.tf \
--policy=./templates/defaultpolicies/rego/terraform.rego

# As with all the other commands, showJSON can also read the Dockerfile/.tf file passed through remote URL's

./genval tf --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/input-templates/terraform/sec_group.tf \
--policy https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/default-policies/rego/terraform.rego

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval tf --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/terraform/sec_group.tf \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/terraform.rego
	`,
	RunE: runTfCmd,
}

func runTfCmd(cmd *cobra.Command, args []string) error {
	inputFile := tfArgs.reqinput
	policy := tfArgs.policy

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
