package cmd

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/fatih/color"
	"github.com/jedib0t/go-pretty/v6/table"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/llm"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
)

type celInfrafileFlags struct {
	reqinput   string
	policy     string
	takeAction bool
	model      string
	output     string
}

var celInfrafileArgs celInfrafileFlags

func init() {
	celInfrafileCmd.Flags().StringVarP(&celInfrafileArgs.reqinput, "reqinput", "r", "", "Input JSON/YAML for validating Kubernetes configurations with CEL")
	// if err := celInfrafileCmd.MarkFlagRequired("reqinput"); err != nil {
	// 	log.Fatalf("Error marking flag as required: %v", err)
	// }
	celInfrafileCmd.Flags().StringVarP(&configFile, "config", "c", "", "Path to YAML file to read configs from")
	celInfrafileCmd.Flags().BoolVarP(&celInfrafileArgs.takeAction, "takeaction", "t", false, "Remediate the failures")
	celInfrafileCmd.Flags().StringVarP(&celInfrafileArgs.policy, "policy", "p", "", "Path for the CEL policy file in YAML format, polciy can be passed from either Local or from remote URL")
	celInfrafileCmd.Flags().StringVarP(&celInfrafileArgs.model, "model", "m", "", "AI model to be used for remediation. Required if --takeaction is set to true")
	celInfrafileCmd.Flags().StringVarP(&celInfrafileArgs.output, "output", "o", "", "Output file for the remediation results")
	celvalCmd.AddCommand(celInfrafileCmd)
}

var celInfrafileCmd = &cobra.Command{
	Use:   "infrafile",
	Short: "Validate Kubernetes and related manifests using Common Expression Language (CEL) policies",
	Long: `A user need to pass the Kubernetes manifest in YAML/JSON format as reqinput and a set of CEL policies
as a policy file for validation.

The required input file in YAML/JSON format or CEL policy file can be supplied either through a local file path
or from remote URL's such as those hosted on GitHub (e.g., https://github.com)
 `,
	Example: `
# Validate Kubernetes manifest with Common Expression Language (CEL) policies
# Passing the required files from local

	./genval celval infrafile --reqinput=input.json \
  --policy=<path/to/CELPolicy.Yaml file>

# Provide the required files from remote URL's

./genval celval infrafile --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/input-templates/k8s/deployment.json \
--policy ./templates/defaultpolicies/cel/k8s_cel.yaml

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval celval infrafile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/k8s/deployment.json \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/cel/k8s_cel.yaml


# Remediation of failed results highlighted by regoval
Genval can remediate the failed results by using the --takeaction flag and using an AI model of their choice. Users can also, supply the required configs via a YAML file by passing the '--config' flag.

genval regoval infrafile -c ./templates/inputs/validation_configs/cel/k8s_cel.yaml

An example YAML file can be found in ./templates/inputs/validation_configs/cel/k8s_cel.yaml

`,

	RunE: runCelInfrafileCmd,
}

func runCelInfrafileCmd(cmd *cobra.Command, args []string) error {
	ctx := cmd.Context()

	cfg, err := loadYAMLConfig(configFile)
	if err != nil {
		return fmt.Errorf("error reading config: %v", err)
	}
	inputFile := parseStringFlag(celInfrafileArgs.reqinput, cfg.Common.Reqinput)
	policy := parseStringFlag(celInfrafileArgs.policy, cfg.Common.Policy)
	output := parseStringFlag(celInfrafileArgs.output, cfg.Common.Output)
	takeAction := parseBoolBoolFlag(celInfrafileArgs.takeAction, cfg.Common.Takeaction)
	model := parseModel(cfg)

	var data interface{}
	if err := parser.ParseDockerfileInput(string(inputFile), &data); err != nil {
		log.Fatalf("Unable to process input: %v", err)
	}
	jsonManifest, err := json.Marshal(data)
	if err != nil {
		log.Fatalf("Error marshaling manifest data to JSON: %v", err)
	}
	policies, err := validate.ParseYAMLPolicies(policy)
	if err != nil {
		log.Fatalf("Error parsing YAML policies: %v", err)
	}

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Result", "Description", "Severity", "Benchmark"}) // Set header once.

	failedResults, failedCount, err := validate.EvaluateCELPolicies(policies, string(jsonManifest), t)
	if err != nil {
		log.Fatalf("Error evaluating policies: %v", err)
	}

	t.Render()
	var fr []byte
	failures := failedResults
	var resp string

	for takeAction && failedCount > 0 {
		spin := utils.StartSpinner("Taking action on remediating the errors in input file, please hold on for a moment...\n")
		contentsToCombine := string(jsonManifest)
		if resp != "" {
			contentsToCombine = resp
		}
		resultsFailed := failures
		if fr != nil {
			resultsFailed = fr
		}
		rParams := llm.RemediationParams{
			InputContent: contentsToCombine,
			CelPolicies:  policies,
			Failures:     resultsFailed,
			Command:      cmd.Name(),
			Model:        model,
			APIKey:       cfg.LLMSpec.OpenAIConfig[0].APIKey,
		}
		resp, err = llm.RemediateResource(ctx, cmd.Parent().Name(), rParams)
		if err != nil {
			return fmt.Errorf("error remediating input resource [%v]: %v", inputFile, err)
		}
		spin.Stop()

		t.ResetRows()

		// Re-evaluate policies and append rows
		fr, failedCount, err = validate.EvaluateCELPolicies(rParams.CelPolicies, resp, t)
		if err != nil {
			log.Fatalf("Error evaluating policies: %v", err)
		}

		// Render updated results
		t.Render()

		// If no further failures, exit the loop
		if fr == nil {
			fmt.Println("No Failed results were captured. Remediation is complete.")
			break
		}
	}

	fmt.Println(validate.BorderedOutput(string(resp)))
	if output != "" {
		err = os.WriteFile(output, []byte(resp), 0o644)
		if err != nil {
			log.Error("Error writing final result:", err)
			return err
		}
	}

	writeMessage := color.GreenString("Final Infrafile written to: %v\n", output)
	logMessage := color.GreenString("Validation for: [%v] completed", inputFile)
	log.Info(writeMessage)
	log.Info(logMessage)
	return nil
}
