package cmd

import (
	"fmt"
	"strings"

	"github.com/fatih/color"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/validate"
)

type infrafileFlags struct {
	reqinput string
	policy   string
	ociCreds string
}

var infrafileArgs infrafileFlags

func init() {
	infrafileCmd.Flags().StringVarP(&infrafileArgs.reqinput, "reqinput", "r", "", "Input JSON/YAML for validating Kubernetes configurations with Rego ")
	if err := infrafileCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

	infrafileCmd.Flags().StringVarP(&infrafileArgs.policy, "policy", "p", "", "Path for the CEL policy file, polciy can be passed from either Local or from remote URL")
	infrafileCmd.Flags().StringVarP(&infrafileArgs.ociCreds, "credentials", "c", "", "credentials for interacting with OCI registrirs")
	regovalCmd.AddCommand(infrafileCmd)
}

var infrafileCmd = &cobra.Command{
	Use:   "infrafile",
	Short: "Validate Kubernetes and related manidests using Rego policies",
	Long: `A user needs to pass the Kubernetes manifest in YAML/JSON format as reqinput and a set of Rego policies
as a policy file for validation.

The required input file in YAML/JSON format or a policy file can be supplied from either a local file or from
remote URL like https://github.com
 `,
	Example: `
# Validating Kubernetes manifest fro local disk
# The input kubernetes manifest passed to reqinput can be wither YAML or JSON format

./genval regoval infrafile --reqinput ./templates/inputs/k8s/deployment.json \
--policy ./templates/defaultpolicies/rego/k8s.rego

# Validating Kubernetes manifest from files stored in remote URL's

./genval regoval infrafile --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/input-templates/k8s/deployment.json  \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/k8s.rego

# For authenticating with GitHub for providing files stored in github, we need to authenticate to GitHub by setting up a Env VAriable
export GITHUB_TOKEN=<Your GitHub PAT>

./genval regoval infrafile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/k8s/deployment.json \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/k8s.rego

# Validating of ubernetes manifests using policies stored in OCI compliant registries

To facilitate authentication with OCI compliant container registries, Users can provide credentials through --credentials flag. The creds can
be provided via <USER:PAT> or <REGISTRY_PAT> format. If no credentials are provided, Genval searches for the "./docker/config.json"
file in the user's $HOME directory. If this file is found, Genval utilizes it for authentication.

./genval regoval infrafile --reqinput=./templates/input/k8s/deployment.yaml \
--policy oci://ghcr.io/intelops/policyhub/genval/infrafile_policies:v0.0.1
--credentials <GITHUB_PAT> or <USER:PAT>


# Users can you use default policies maintained by the community stored in the https://github.com/intelops/policyhub repo

./genval --regoval infrafile --reqinput <Path to Infrafile like k8s>
// No credntials provided, will default to $HOME/.docker/config.json for credentials
`,
	RunE: runinfrafileCmd,
}

func runinfrafileCmd(cmd *cobra.Command, args []string) error {
	inputFile := infrafileArgs.reqinput
	policy := infrafileArgs.policy
	processor := validate.GenericProcessor{}

	if policy == "" || strings.HasPrefix(policy, "oci://") {
		if err := validate.ValidateWithOCIPolicies(inputFile,
			policy,
			cmd.Name(),
			infrafileArgs.ociCreds,
			processor); err != nil {
			return fmt.Errorf("error validating with policies stored in registries: %v", err)
		}
	} else {
		err := validate.ValidateWithRego(inputFile, policy, processor)
		if err != nil {
			return fmt.Errorf("validating %v failed: %v", inputFile, err)
		}
	}
	logMessage := color.GreenString("infrafile validation for: %v completed", inputFile)
	log.Info(logMessage)
	return nil
}
