package cmd

import (
	"fmt"
	"strings"

	"github.com/fatih/color"
	"github.com/intelops/genval/pkg/oci"
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

./genval regoval dockerfileval --reqinput=Dockerfile \
--policy=<'path/to/policy.rego file>

# Provide the required files from remote URL's

./genval regoval dockerfileval --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/Dockerfile-sample \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/dockerfile_policies.rego

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval regoval dockerfileval --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/Dockerfile-sample \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/dockerfile_policies.rego

# Validating of Dockerfile using policies stored in OCI compliant registries

./genval regoval dockerfileval --reqinput=Dockerfile \
--policy oci://ghcr.io/intelops/policyhub/genval/dockerfile_policies:v0.0.1

# Users can you use default policies maintained by the community stored in the https://github.com/intelops/policyhub repo

./genval regoval dockerfileval --reqinput <Path to Dockerfile>
`,
	RunE: runDockerfilevalCmd,
}

func runDockerfilevalCmd(cmd *cobra.Command, args []string) error {
	input := dockerfilevalArgs.reqinput
	policy := dockerfilevalArgs.policy
	processor := validate.DockerfileProcessor{}

	dockerfilefileContent, err := utils.ReadFile(input)
	if err != nil {
		log.Errorf("Error reading Dockerfile: %v, validation failed: %s\n", input, err)
	}

	if policy == "" || strings.HasPrefix(policy, "oci://") {

		tempDir, cleanup, err := utils.TempDirWithCleanup()
		if err != nil {
			return fmt.Errorf("error creating temporary directory: %v", err)
		}
		defer cleanup()

		var defaultRegoPolicies string
		if policy == "" {
			fmt.Println("\n" + "Validating with default policies...")
			policyLoc, err := oci.FetchPolicyFromRegistry(cmd.Name())
			if err != nil {
				return fmt.Errorf("error fetching policy from registry: %v", err)
			}

			defaultRegoPolicies, err = validate.ApplyPolicyiesFromOCI(policyLoc, tempDir)
			if err != nil {
				return fmt.Errorf("error applying default policies: %v", err)
			}
		} else {
			fmt.Printf("\n"+"Pulling poilices from '%v'"+"\n", policy)
			defaultRegoPolicies, err = validate.ApplyPolicyiesFromOCI(policy, tempDir)
			if err != nil {
				return fmt.Errorf("error applying default policies: %v", err)
			}
		}

		err = validate.ValidateWithRego(string(dockerfilefileContent), defaultRegoPolicies, processor)
		if err != nil {
			log.Errorf("Dockerfile validation failed: %s\n", err)
			return err
		}
	} else {
		err := validate.ValidateWithRego(string(dockerfilefileContent), policy, processor)
		if err != nil {
			log.Errorf("Dockerfile validation failed: %s\n", err)
			return err
		}
	}

	log.Infof(color.GreenString("Dockerfile: %v validation completed!\n", input))
	return nil
}
