package cmd

import (
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type dockervalFlags struct {
	reqinput string
	policy   string
}

var dockervalArgs dockervalFlags

func init() {
	dockervalCmd.Flags().StringVarP(&dockervalArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .dockerval files with rego")
	if err := dockervalCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	dockervalCmd.Flags().StringVarP(&dockervalArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	if err := dockervalCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

	rootCmd.AddCommand(dockervalCmd)
}

var dockervalCmd = &cobra.Command{
	Use:   "dockerval",
	Short: "Validate Dockerfile with Rego policies",
	Long: `Using dockerval, a user can validate Dockerfiles. Provide a Dockerfile thet needs to be validated
to the --reqinput arg and a set of Rego policies in the --policy arg.

The required input Dockerfile and  Rego policy files can be either be passed through local file paths or remote URLs,
such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `
# Validate Dockerile with Rego policies
#	Providing the required args from local file system

./genval dockerval --reqinput=input.json \
--policy=<'path/to/policy.rego file>

# Provide the required files from remote URL's

./genval dockerval --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/Dockerfile-sample \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/dockerfile_policies.rego

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval dockerval --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/Dockerfile-sample \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/dockerfile_policies.rego
	`,
	RunE: runDockervalCmd,
}

func runDockervalCmd(cmd *cobra.Command, args []string) error {
	input := dockervalArgs.reqinput
	policy := dockervalArgs.policy

	dockerfileContent, err := utils.ReadFile(input)
	if err != nil {
		log.Errorf("Error reading Dockerfile: %v, validation failed: %s\n", input, err)
	}

	err = validate.ValidateDockerfile(string(dockerfileContent), policy)
	if err != nil {
		log.Errorf("Dockerfile validation failed: %s\n", err)
	}
	log.Infof("Dockerfile: %v validation succeeded!\n", input)
	return nil
}
