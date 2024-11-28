package cmd

import (
	"fmt"
	"strings"

	"github.com/fatih/color"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/validate"
)

type terraformFlags struct {
	reqinput string
	policy   string
	ociCreds string
}

var terraformArgs terraformFlags

func init() {
	terraformCmd.Flags().StringVarP(&terraformArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .tf files with rego")
	if err := terraformCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	terraformCmd.Flags().StringVarP(&terraformArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	terraformCmd.Flags().StringVarP(&terraformArgs.ociCreds, "credentials", "c", "", "credentials for interacting with OCI registries")
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
	inputFile := terraformArgs.reqinput
	policy := terraformArgs.policy
	var processor validate.GenericProcessor

	inputJSON, err := parser.ConvertTFtoJSON(inputFile)
	if err != nil {
		log.Errorf("Error converting tf file: %v", err)
	}

	if policy == "" || strings.HasPrefix(policy, "oci://") {
		if err := validate.ValidateWithOCIPolicies(inputJSON,
			policy,
			cmd.Name(),
			terraformArgs.ociCreds,
			processor); err != nil {
			return fmt.Errorf("error validating with policies stored in registries: %v", err)
		}
	} else {
		err = validate.ValidateWithRego(inputJSON, policy, processor)
		if err != nil {
			log.Errorf("Validation %v failed", err)
		}
	}
	logMessage := color.GreenString("Terraform resource validation for: %v completed", inputFile)
	log.Info(logMessage)
	return nil
}
