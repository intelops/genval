package cmd

import (
	"encoding/json"
	"os"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
	"github.com/jedib0t/go-pretty/v6/table"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type celDockerfileValFlags struct {
	reqinput string
	policy   string
}

var celDockerfileValArgs celDockerfileValFlags

func init() {
	celDockerfileValCmd.Flags().StringVarP(&celDockerfileValArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .dockerfileval files with rego")
	if err := celDockerfileValCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
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
	input := celDockerfileValArgs.reqinput
	policy := celDockerfileValArgs.policy

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
	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Result", "Description", "Severity", "Benchmark"})

	err = validate.EvaluateCELPolicies(policy, string(dockerfileJSON), t)
	if err != nil {
		log.Fatalf("Error evaluating policies: %v", err)
	}

	t.Render()
	return nil
}
