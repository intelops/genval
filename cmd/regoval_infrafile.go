package cmd

import (
	"fmt"
	"os"
	"strings"

	"github.com/fatih/color"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
)

type regoInfrafileFlags struct {
	takeAction bool
	reqinput   string
	policy     string
	ociCreds   string
	model      string
	output     string
}

var regoInfrafileArgs regoInfrafileFlags

func init() {
	regoInfrafileCmd.Flags().BoolVarP(&regoInfrafileArgs.takeAction, "takeaction", "t", false, "Remediate the failures")
	regoInfrafileCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to YAML file to read configs from")
	regoInfrafileCmd.Flags().StringVarP(&regoInfrafileArgs.reqinput, "reqinput", "r", "", "Input JSON/YAML for validating Kubernetes configurations with Rego ")
	regoInfrafileCmd.Flags().StringVarP(&regoInfrafileArgs.model, "model", "m", "", "AI model to be used for remediation. Required if --takeaction is set to true")
	regoInfrafileCmd.Flags().StringVarP(&regoInfrafileArgs.output, "output", "o", "", "Path to write the final output")

	regoInfrafileCmd.Flags().StringVarP(&regoInfrafileArgs.policy, "policy", "p", "", "Path for the CEL policy file, polciy can be passed from either Local or from remote URL")
	regoInfrafileCmd.Flags().StringVarP(&regoInfrafileArgs.ociCreds, "credentials", "a", "", "credentials for interacting with OCI registrirs")

	regovalCmd.AddCommand(regoInfrafileCmd)
}

var regoInfrafileCmd = &cobra.Command{
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

./genval regoval infrafile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/k8s/deployment.json \

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


# Remediation of failed results highlighted by regoval
Genval can remediate the failed results by using the --takeaction flag and using an AI model of their choice. Users can also, supply the required configs via a YAML file by passing the '--config' flag.

genval regoval infrafile -c ./templates/inputs/validation_configs/rego/rego-k8s.yaml

An example YAML file can be found in ./templates/inputs/validation_configs/rego/rego-k8s.yaml.
`,
	RunE: runregoInfrafileCmd,
}

func runregoInfrafileCmd(cmd *cobra.Command, args []string) error {
	cfg, err := loadYAMLConfig(configFile)
	if err != nil {
		return fmt.Errorf("error loading config: %v", err)
	}

	ctx := cmd.Context()

	input := parseStringFlag(regoInfrafileArgs.reqinput, cfg.Common.Reqinput)
	takeaction := parseBoolBoolFlag(regoInfrafileArgs.takeAction, cfg.Common.Takeaction)
	output := parseStringFlag(regoInfrafileArgs.output, cfg.Common.Output)
	policy := parseStringFlag(regoInfrafileArgs.policy, cfg.Common.Policy)
	creds := parseStringFlag(regoInfrafileArgs.ociCreds, cfg.Common.OCICredentials)
	model := parseModel(cfg)

	var failedResults []byte
	var failedCount int
	processor := validate.GenericProcessor{}

	inputContent, err := utils.ReadFile(input)
	if err != nil {
		return fmt.Errorf("error reading the input file: %v", err)
	}

	if policy == "" || strings.HasPrefix(policy, "oci://") {
		if failedResults, failedCount, err = validate.ValidateWithOCIPolicies(string(inputContent),
			policy,
			cmd.Name(),
			creds,
			processor,
		); err != nil {
			return fmt.Errorf("error validating with policies stored in registries: %v", err)
		}
	} else {
		failedResults, failedCount, err = validate.ValidateWithRego(string(inputContent), policy, processor)
		if err != nil {
			return fmt.Errorf("validating %v failed: %v", input, err)
		}
		fmt.Printf("Failed Counts: %v\n", failedCount)
	}

	var resp string
	inputFile := string(inputContent)
	failures := failedResults
	var fr []byte

	for takeaction && failedCount > 0 {
		spin := utils.StartSpinner("Taking action on remediating the errors in Infrafile, please hold-on for a moment...\n")
		// Determine the content to use for the prompt
		contentToCombine := inputFile
		if resp != "" {
			contentToCombine = resp
		}
		resultsFailed := failures
		if fr != nil {
			resultsFailed = fr
		}

		rParams := llm.RemediationParams{
			InputContent:  contentToCombine,
			PolicyContent: policy,
			Failures:      resultsFailed,
			Command:       cmd.Name(),
			Model:         model,
			APIKey:        cfg.LLMSpec.OpenAIConfig[0].APIKey,
		}

		resp, err := llm.RemediateResource(ctx, cmd.Parent().Name(), rParams)
		if err != nil {
			return fmt.Errorf("error remediating resource: [%v] - %v ", inputFile, err)
		}

		spin.Stop()

		fr, failedCount, err = validate.ValidateWithRego(resp, policy, processor)
		if err != nil {
			log.Errorf("Infrafile validation failed: %s\n", err)
			return err
		}
		// If no further failures, exit the loop
		if fr == nil {
			fmt.Println("No Failed results were captured. Remediation is complete.")
			break
		}
	}

	if output != "" {
		err = os.WriteFile(output, []byte(resp), 0o644)
		if err != nil {
			log.Error("Error writing Infrafile:", err)
			return err
		}
	}

	fmt.Println(validate.BorderedOutput(resp))

	writeMessage := color.GreenString("Final Infrafile written to: %v\n", output)
	logMessage := color.GreenString("infrafile validation for: %v completed", inputFile)
	log.Info(writeMessage)
	log.Info(logMessage)
	return nil
}
