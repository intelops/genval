package cmd

import (
	"encoding/json"
	"os"

	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/otm"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/validate"
)

type celFlags struct {
	reqinput string
	policy   string
}

var celArgs celFlags

func init() {
	celCmd.Flags().StringVarP(&celArgs.reqinput, "reqinput", "r", "", "Input JSON/YAML for validating Kubernetes configurations with CEL")
	if err := celCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	celCmd.Flags().StringVarP(&celArgs.policy, "policy", "p", "", "Path for the CEL policy file in YAML format, polciy can be passed from either Local or from remote URL")
	if err := celCmd.MarkFlagRequired("policy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	celvalCmd.AddCommand(celCmd)
}

var celCmd = &cobra.Command{
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
--policy https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/default-policies/cel/k8s_cel.yaml

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval celval infrafile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/k8s/deployment.json \
--policy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/cel/k8s_cel.yaml




`,

	RunE: runCelCmd,
}

func runCelCmd(cmd *cobra.Command, args []string) error {
	inputFile := celArgs.reqinput
	policy := celArgs.policy

	hook := otm.NewHook("Genval/dockerfileval", otm.WithLoggerProvider(logProvider))
	log.AddHook(hook)

	var data interface{}

	ctx, span := otm.StartSpanForCommand(tracer, cmd)
	defer span.End()
	err := parser.ParseDockerfileInput(string(inputFile), &data)
	if err != nil {
		log.WithContext(ctx).WithFields(map[string]interface{}{
			"inputPath": inputFile,
			"error":     err,
		}).Errorf("Error reading input file: %s", err)
		os.Exit(1)
	}
	data = parser.ConvertToJSON(data)

	jsonManifest, err := json.Marshal(data)
	if err != nil {
		log.WithContext(ctx).WithFields(map[string]interface{}{
			"error": err,
		}).Errorf("Error marshalling data: %s", err)
	}
	policies, err := validate.ParseYAMLPolicies(
		policy)
	if err != nil {
		log.WithContext(ctx).WithFields(map[string]interface{}{
			"policy": policies,
			"error":  err,
		}).Errorf("Error parsing YAML policy: %s", err)
	}

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Result", "Description", "Severity", "Benchmark"})

	err = validate.EvaluateCELPolicies(policies, string(jsonManifest), t)
	if err != nil {
		log.Fatalf("Error evaluating policies: %v", err)
	}

	t.Render()
	return nil
}
