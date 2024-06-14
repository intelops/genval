package cmd

import (
	"fmt"
	"os"

	"github.com/intelops/genval/pkg/oci"
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

# Users can you use default policies maintained by the community stored in the https://github.com/intelops/policyhub repo

./genval regoval terraform --reqinput <path to terraform file>
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

	if policy == "" {
		fmt.Println("\n" + "Validating with default policies...")

		tempDir, err := os.MkdirTemp("", "policyDirectory")
		if err != nil {
			return fmt.Errorf("error creating policy directory: %v", err)
		}
		defer os.RemoveAll(tempDir)

		policyLoc, err := oci.FetchPolicyFromRegistry(cmd.Name())
		if err != nil {
			return fmt.Errorf("error fetching policy from registry: %v", err)
		}

		defaultRegoPolicies, err := validate.ApplyDefaultPolicies(policyLoc, tempDir)
		if err != nil {
			return fmt.Errorf("error applying default policies: %v", err)
		}

		err = validate.ValidateWithRego(inputFile, defaultRegoPolicies, processor)
		if err != nil {
			log.Errorf("Dockerfile validation failed: %s\n", err)
			return err
		}
	} else {
		err = validate.ValidateWithRego(inputJSON, policy, processor)
		if err != nil {
			log.Errorf("Validation %v failed", err)
		}
	}
	log.Infof("Terraform resource: %v, validated succussfully.", inputFile)
	return nil
}
