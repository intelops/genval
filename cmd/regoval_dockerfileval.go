package cmd

import (
	"fmt"
	"os"

	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type dockerfilevalFlags struct {
	reqinput string
	policy   string
}

var dockerfilevalArgs dockerfilevalFlags

func init() {
	dockerfilevalCmd.Flags().StringVarP(&dockerfilevalArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .dockerfileval files with rego")
	if err := dockerfilevalCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	dockerfilevalCmd.Flags().StringVarP(&dockerfilevalArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	// if err := dockerfilevalCmd.MarkFlagRequired("policy"); err != nil {
	// 	log.Fatalf("Error marking flag as required: %v", err)
	// }

	regovalCmd.AddCommand(dockerfilevalCmd)
}

var dockerfilevalCmd = &cobra.Command{
	Use:   "dockerfileval",
	Short: "Validate Dockerfile with Rego policies",
	Long: `Using dockerfileval, a user can validate Dockerfiles. Provide a Dockerfile thet needs to be validated
to the --reqinput arg and a set of Rego policies in the --policy arg.

The required input Dockerfile and  Rego policy files can be either be passed through local file paths or remote URLs,
such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `
# Validate Dockerfil with Rego policies by providing the required args from local file system

./genval regoval dockerfileval --reqinput=input.json \
--policy=<'path/to/policy.rego file>

# Provide the required files from remote URL's

./genval regoval dockerfileval --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/Dockerfile-sample \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/dockerfile_policies.rego

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval regoval dockerfileval --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/Dockerfile-sample \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/dockerfile_policies.rego
	`,
	RunE: runDockerfilevalCmd,
}

func runDockerfilevalCmd(cmd *cobra.Command, args []string) error {
	input := dockerfilevalArgs.reqinput
	policy := dockerfilevalArgs.policy

	dockerfilefileContent, err := utils.ReadFile(input)
	if err != nil {
		log.Errorf("Error reading Dockerfile: %v, validation failed: %s\n", input, err)
	}

	if policy == "" {
		fmt.Println("\n" + "Validating with default policies...")

		tempDir, err := os.MkdirTemp("", "policyDirectory")
		if err != nil {
			return fmt.Errorf("error creating policy directory: %v", err)
		}
		defer os.RemoveAll(tempDir)

		defaultRegoPolicies, err := validate.ApplyDefaultPolicies(validate.HubRegoPolicy, tempDir)
		if err != nil {
			return fmt.Errorf("error applying default policies: %v", err)
		}

		err = validate.ValidateDockerfile(string(dockerfilefileContent), defaultRegoPolicies)
		if err != nil {
			log.Errorf("Dockerfile validation failed: %s\n", err)
			return err
		}
	} else {
		err := validate.ValidateDockerfile(string(dockerfilefileContent), policy)
		if err != nil {
			log.Errorf("Dockerfile validation failed: %s\n", err)
			return err
		}
	}

	log.Infof("Dockerfile: %v validation completed!\n", input)
	return nil
}
