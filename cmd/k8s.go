package cmd

import (
	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type k8sFlags struct {
	reqinput string
	policy   string
}

var k8sArgs k8sFlags

func init() {
	k8sCmd.Flags().StringVarP(&k8sArgs.reqinput, "reqinput", "r", "", "Input JSON/YAML for validating Kubernetes configurations with Rego ")
	if err := k8sCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

	k8sCmd.Flags().StringVarP(&k8sArgs.policy, "policy", "p", "", "Path for the CEL policy file, polciy can be passed from either Local or from remote URL")
	if err := k8sCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

	rootCmd.AddCommand(k8sCmd)
}

var k8sCmd = &cobra.Command{
	Use:   "k8s",
	Short: "Validate Kubernetes and related manidests using Rego policies",
	Long: `A user needs to pass the Kubernetes manifest in YAML/JSON format as reqinput and a set of Rego policies
as a policy file for validation.

The required input file in YAML/JSON format or a policy file can be supplied from either a local file or from
remote URL like https://github.com
 `,
	Example: `
# Validating Kubernetes manifest in local
# The input kubernetes manifest passed to reqinput can be wither YAML or JSON format

./genval k8s --reqinput ./templates/inputs/k8s/deployment.json \
--policy ./templates/defaultpolicies/rego/k8s.rego

# Validating Kubernetes manifest from files stored in remote URL's

./genval k8s --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/input-templates/k8s/deployment.json  \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/k8s.rego

# For authenticating with GitHub for providing files stored in github, we need to authenticate to GitHub by setting up a Env VAriable
export GITHUB_TOKEN=<Your GitHub PAT>

./genval k8s --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/k8s/deployment.json \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/k8s.rego

`,
	RunE: runk8sCmd,
}

func runk8sCmd(cmd *cobra.Command, args []string) error {
	inputFile := k8sArgs.reqinput
	policy := k8sArgs.policy

	err := validate.ValidateWithRego(inputFile, policy)
	if err != nil {
		log.Errorf("Validation %v failed", err)
	}
	log.Infof("K8s manifest %v, validated succussfully.", inputFile)
	return nil
}
