package cmd

import (
	"fmt"
	"os"
	"strings"

	"github.com/fatih/color"
	"github.com/sashabaranov/go-openai"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
)

type dockerfilevalFlags struct {
	takeAction bool
	reqinput   string
	policy     string
	ociCreds   string
	model      string
	output     string // Optional path to write the results or remediated Dockerfile after remediation by setting --takeaction = true
}

var dockerfilevalArgs dockerfilevalFlags

func init() {
	dockerfilevalCmd.Flags().BoolVarP(&dockerfilevalArgs.takeAction, "takeaction", "t", false, "remediate the failures")
	dockerfilevalCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to YAML file to read configs from")
	dockerfilevalCmd.Flags().StringVarP(&dockerfilevalArgs.output, "output", "o", "", "Path to write the final Dockefile")

	dockerfilevalCmd.Flags().StringVarP(&dockerfilevalArgs.reqinput, "reqinput", "r", "", "Input JSON for validating Terraform .dockerfileval files with rego")
	// if err := dockerfilevalCmd.MarkFlagRequired("reqinput"); err != nil {
	// 	log.Fatalf("Error marking flag as required: %v", err)
	// }
	dockerfilevalCmd.Flags().StringVarP(&dockerfilevalArgs.model, "model", "m", "", "AI model to be used for remediation. Required if --takeaction is set to true")
	dockerfilevalCmd.Flags().StringVarP(&dockerfilevalArgs.policy, "policy", "p", "", "Path for the Rego policy file, polciy can be passed from either Local or from remote URL")
	dockerfilevalCmd.Flags().StringVarP(&dockerfilevalArgs.ociCreds, "credentials", "a", "", "credentials to interact with OCI registries")

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

# Validating of Dockerfile using policies stored in OCI compliant registries

To facilitate authentication with OCI compliant container registries, Users can provide credentials through --credentials flag. The creds can
be provided via <USER:PAT> or <REGISTRY_PAT> format. If no credentials are provided, Genval searches for the "./docker/config.json"
file in the user's $HOME directory. If this file is found, Genval utilizes it for authentication.

./genval regoval dockerfileval --reqinput=Dockerfile \
--policy oci://ghcr.io/intelops/policyhub/genval/dockerfile_policies:v0.0.1
--credentials <GITHUB_PAT> or <USER:PAT>


# Users can you use default policies maintained by the community stored in the https://github.com/intelops/policyhub repo

./genval regoval dockerfileval --reqinput <Path to Dockerfile>
// No credntials provided, will default to $HOME/.docker/config.json for credentials

# Remediation of failed results highlighted by regoval
Genval can remediate the failed results by using the --takeaction flag and using an AI model of their choice. Users can also, supply the required configs via a YAML file by passing the '--config' flag.

genval regoval infrafile -c ./templates/inputs/validation_configs/dockderfile.yaml

An example YAML file can be found in ./templates/inputs/validation_configs/rego/golang-Dockerfile.yaml

`,
	RunE: runDockerfilevalCmd,
}

func runDockerfilevalCmd(cmd *cobra.Command, args []string) error {
	cfg, err := loadYAMLConfig(configFile)
	if err != nil {
		return fmt.Errorf("error loading config: %v", err)
	}

	ctx := cmd.Context()
	var failedResults []byte
	var failedCount int

	creds := parseStringFlag(dockerfileArgs.ociCreds, cfg.Common.OCICredentials)
	output := parseStringFlag(dockerfileArgs.output, cfg.Common.Output)
	takeAction := parseBoolBoolFlag(dockerfilevalArgs.takeAction, cfg.Common.Takeaction)
	input := parseStringFlag(dockerfileArgs.reqinput, cfg.Common.Reqinput)
	policy := parseStringFlag(dockerfilevalArgs.policy, cfg.Common.Policy)

	var model string
	models := cfg.LLMSpec.GetActiveModels()
	if len(models) > 0 {
		model = models[0]["model"]
	}
	if model == "" {
		model = openai.GPT4
	}
	processor := validate.DockerfileProcessor{}

	dockerfilefileContent, err := utils.ReadFile(input)
	if err != nil {
		log.Errorf("Error reading Dockerfile: %v, validation failed: %s\n", input, err)
	}

	if policy == "" || strings.HasPrefix(policy, "oci://") {
		if failedResults, failedCount, err = validate.ValidateWithOCIPolicies(string(dockerfilefileContent),
			policy,
			cmd.Name(),
			creds,
			processor,
		); err != nil {
			return fmt.Errorf("error validating with policies stored in registries: %v", err)
		}
	} else {
		failedResults, failedCount, err = validate.ValidateWithRego(string(dockerfilefileContent), policy, processor)
		if err != nil {
			log.Errorf("Dockerfile validation failed: %s\n", err)
			return err
		}
	}

	var fr []byte
	var resp string
	dockerfileContent := string(dockerfilefileContent) // Use initial content for the first iteration
	failures := failedResults

	for takeAction && failedCount > 0 {
		spin := utils.StartSpinner("Taking action on remediating the errors in Dockerfile, please hold on for a moment...\n")

		// Determine the content to use for the prompt
		contentToCombine := dockerfileContent
		if resp != "" {
			contentToCombine = resp
		}

		// Update `resultsFailed` based on `fr`
		resultsFailed := failures
		if fr != nil {
			resultsFailed = fr
		}

		rParams := llm.RemediationParams{
			InputContent:  contentToCombine,
			PolicyContent: policy,
			Failures:      resultsFailed,
			Command:       cmd.Use,
			Model:         model,
			ApiKey:        cfg.LLMSpec.OpenAIConfig[0].APIKey,
		}

		resp, err := llm.RemediateResource(ctx, cmd.Parent().Name(), rParams)
		if err != nil {
			return fmt.Errorf("error remediating resource: [%v] - %v", input, err)
		}
		spin.Stop()

		// Validate the response with Rego
		fr, failedCount, err = validate.ValidateWithRego(resp, policy, processor)
		if err != nil {
			log.Errorf("Dockerfile validation failed: %s\n", err)
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
			log.Error("Error writing Dockerfile:", err)
			return err
		}
	}

	fmt.Println(validate.BorderedOutput(resp))
	writeMessage := color.GreenString("Final Dockerfile written to: %v\n", output)
	logMessage := color.GreenString("Dockerfile: %v validation completed!\n", input)

	log.Info(writeMessage)
	log.Info(logMessage)
	return nil
}
