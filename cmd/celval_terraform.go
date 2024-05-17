package cmd

import (
	"os"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/validate"
	"github.com/jedib0t/go-pretty/v6/table"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type celTerraformvalFlags struct {
	reqinput string
	policy   string
}

var celTerraformValArgs celTerraformvalFlags

func init() {
	celTerraformvalCmd.Flags().StringVarP(&celTerraformValArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .dockerfileval files with rego")
	if err := celTerraformvalCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required terraform: %v", err)
	}
	celTerraformvalCmd.Flags().StringVarP(&celTerraformValArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	if err := celTerraformvalCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

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
--policy=--policy ./templates/defaultpolicies/cel/terraform_cel

# Provide the required files from remote URL's
./genval celval terraform celval terraform --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/input-templates/terraform/sec_group.tf \
--policy https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/default-policies/cel/terraform_cel

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval celval terraform --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/terraform/sec_group.tf \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/cel/terraform_cel
	`,
	RunE: runCelTerraformvalCmd,
}

func runCelTerraformvalCmd(cmd *cobra.Command, args []string) error {
	inputFile := celTerraformValArgs.reqinput
	policy := celTerraformValArgs.policy
	inputJSON, err := parser.ConvertTFtoJSON(inputFile)
	if err != nil {
		log.Errorf("Error converting tf file: %v", err)
	}

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Result", "Description", "Severity", "Benchmark"})

	err = validate.EvaluateCELPolicies(policy, string(inputJSON), t)
	if err != nil {
		log.Fatalf("Error evaluating policies: %v", err)
	}

	t.Render()
	return nil
}
