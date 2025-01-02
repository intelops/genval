package cmd

import (
	"fmt"
	"os"
	"strings"

	"github.com/fatih/color"
	"github.com/sashabaranov/go-openai"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
)

type infrafileFlags struct {
	takeAction bool
	reqinput   string
	policy     string
	ociCreds   string
	model      string
	output     string
}

var infrafileArgs infrafileFlags

func init() {
	infrafileCmd.Flags().BoolVarP(&infrafileArgs.takeAction, "takeaction", "t", false, "Remediate the failures")
	infrafileCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to YAML file to read configs from")
	infrafileCmd.Flags().StringVarP(&infrafileArgs.reqinput, "reqinput", "r", "", "Input JSON/YAML for validating Kubernetes configurations with Rego ")
	infrafileCmd.Flags().StringVarP(&infrafileArgs.model, "model", "m", "", "AI model to be used for remediation. Required if --takeaction is set to true")
	infrafileCmd.Flags().StringVarP(&infrafileArgs.output, "output", "o", "", "Path to write the final output")

	infrafileCmd.Flags().StringVarP(&infrafileArgs.policy, "policy", "p", "", "Path for the CEL policy file, polciy can be passed from either Local or from remote URL")
	infrafileCmd.Flags().StringVarP(&infrafileArgs.ociCreds, "credentials", "a", "", "credentials for interacting with OCI registrirs")

	viper.BindPFlags(infrafileCmd.Flags())
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
	cfg, err := loadYAMLConfig(configFile)
	if err != nil {
		return fmt.Errorf("error loading config: %v", err)
	}

	ctx := cmd.Context()

	input := cfg.Common.Reqinput
	if infrafileArgs.reqinput != "" {
		input = infrafileArgs.reqinput
	}

	takeaction := cfg.Common.Takeaction
	if infrafileArgs.model != "" {
		infrafileArgs.takeAction = takeaction
	}
	output := cfg.Common.Output
	if infrafileArgs.output != "" {
		output = infrafileArgs.output
	}
	policy := cfg.Common.Policy
	if infrafileArgs.policy != "" {
		policy = infrafileArgs.policy
	}
	var model string
	models := cfg.LLMSpec.GetActiveModels()
	if len(models) > 1 {
		model = models[0]["model"]
	}
	// CHANGEME
	if model == "" {
		model = openai.GPT4
	}

	var failedResults []byte
	var failedCount int
	processor := validate.GenericProcessor{}

	if policy == "" || strings.HasPrefix(policy, "oci://") {
		if failedResults, failedCount, err = validate.ValidateWithOCIPolicies(input,
			policy,
			cmd.Name(),
			infrafileArgs.ociCreds,
			processor,
			infrafileArgs.takeAction); err != nil {
			return fmt.Errorf("error validating with policies stored in registries: %v", err)
		}
	} else {
		failedResults, failedCount, err = validate.ValidateWithRego(input, policy, processor, infrafileArgs.takeAction)
		if err != nil {
			return fmt.Errorf("validating %v failed: %v", input, err)
		}
	}
	var resp string
	inputFile := input
	failures := failedResults

	for takeaction && failedCount > 0 {
		var fr []byte
		spin := utils.StartSpinner("Taking action on remediating the errors in Infrafile, please hold-on for a moment...\n")
		defer spin.Stop()

		// Determine the content to use for the prompt
		contentToCombine := inputFile
		if resp != "" {
			contentToCombine = resp
		}
		resultsFailed := failures
		if fr != nil {
			resultsFailed = fr
		}

		userPrompt, err := llm.CombineResourceAndResults(contentToCombine, string(resultsFailed))
		if err != nil {
			log.Errorf("error combining resource and results: %v", err)
			return err
		}
		tool := cmd.Use
		takeActionPrompt, err := llm.GetSystemPrompt(tool)

		// User apiKEY as flag to read from ENVVAR
		client := openai.NewClient(os.Getenv(cfg.LLMSpec.OpenAIConfig[0].APIKey))
		// client := openai.NewClient(os.Getenv("OPENAI_KEY"))

		fmt.Printf("Failed Results and Updated Infrafile\n", userPrompt)
		req, err := llm.CreateActionCompletion(userPrompt, takeActionPrompt, model)
		if err != nil {
			return fmt.Errorf("failed to create OpenAI request: %w", err)
		}
		res, err := client.CreateChatCompletion(ctx, req)
		if err != nil {
			return fmt.Errorf("failed to generate OpenAI response: %w", err)
		}
		resp = res.Choices[0].Message.Content
		spin.Stop()

		fr, failedCount, err = validate.ValidateWithRego(resp, policy, processor, cfg.Common.Takeaction)
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
