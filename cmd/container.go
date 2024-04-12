package cmd

import (
	"fmt"
	"os"

	generate "github.com/intelops/genval/pkg/generate/dockerfile_gen"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type dockerfileFlags struct {
	reqinput     string
	output       string
	inputPolicy  string
	outputPolicy string
}

var dockerfileArgs dockerfileFlags

func init() {
	dockerfileCmd.Flags().StringVarP(&dockerfileArgs.reqinput, "reqinput", "r", "", "Input JSON for generating Dockerfile")
	if err := dockerfileCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	dockerfileCmd.Flags().StringVarP(&dockerfileArgs.output, "output", "p", "", "Path to write the Generated Dockefile")
	if err := dockerfileCmd.MarkFlagRequired("output"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	dockerfileCmd.Flags().StringVarP(&dockerfileArgs.inputPolicy, "inputpolicy", "i", "", "Path for the Input policyin Rego, input-policy can be passed from either Local or from remote URL")
	if err := dockerfileCmd.MarkFlagRequired("inputpolicy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	dockerfileCmd.Flags().StringVarP(&dockerfileArgs.outputPolicy, "outputpolicy", "o", "", "Path for Out policy in Rego, Output-policy can be passed from either Local or from remote URL")
	if err := dockerfileCmd.MarkFlagRequired("outputpolicy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	rootCmd.AddCommand(dockerfileCmd)
}

var dockerfileCmd = &cobra.Command{
	Use:   "dockerfile",
	Short: "Generate and Validate Dockerfile",
	Long: `
A user can pass in a JSON file to genval, the passed input will be first evaluated based on input policies,
once input is validated, a Dockerfile will be generated and the generated Dockerfile will be further validated using
the output policies.

Genval Provides flexibility of supplying input files in YAML or JSON formats.All the required input and  policy files
for input and output policies can be supplied from local file paths or remote URLs, such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `
# Generating and validating Dockerfile with local files
./genval dockerfile --reqinput=input.json \
--output=output.Dockerfile \
--inputpolicy=<path/to/input.rego policy> \
--outputpolicy=<path/to/output.rego file>

# Generating and validating Dockewrfile by passing input template and security policies from remote URL's
# like for example https://github.com

./genval dockerfile --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/input-templates/dockerfile_input/clang_input.json \
--output ./output/Dockerfile-cobra \
--inputpolicy https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/default-policies/rego/inputfile_policies.rego \
--outputpolicy https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/default-policies/rego/dockerfile_policies.rego

# For authenticating with GitHub.com, set the env variable GITHUB_TOKEN
# export GITHUB_TOKEN=<Your GitHub PAT>

./genval dockerfile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/dockerfile_input/clang_input.json \
--output ./output/Dockefile-cobra \
--inputpolicy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/inputfile_policies.rego \
--outputpolicy  https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/dockerfile_policies.rego
	`,
	RunE: rundockerfileCmd,
}

func rundockerfileCmd(cmd *cobra.Command, args []string) error {
	inputPath := dockerfileArgs.reqinput
	outputPath := dockerfileArgs.output
	inputPolicyFile := dockerfileArgs.inputPolicy
	outputPolicyFile := dockerfileArgs.outputPolicy

	// Use ParseInputFile to read and unmarshal the input file
	var data generate.DockerfileContent

	err := parser.ParseDockerfileInput(inputPath, &data)
	if err != nil {
		log.Error("Error parsing Dockerfile input:", err)
		return err
	}

	inputContent, err := utils.ReadFile(inputPath)
	if err != nil {
		log.Fatalf("Unable to read input: %v", err)
	}

	// Validate the YAML using OPA
	err = validate.ValidateInput(string(inputContent), inputPolicyFile)
	if err != nil {
		log.Fatalf("Validation error: %v", err)
		return err
	}

	dockerfileContent := generate.GenerateDockerfileContent(&data)

	outputData := []byte(dockerfileContent)
	err = os.WriteFile(outputPath, outputData, 0o644)
	if err != nil {
		log.Error("Error writing Dockerfile:", err)
		return err
	}
	fmt.Printf("Generated Dockerfile saved to: %s\n", outputPath)

	err = validate.ValidateDockerfile(string(outputData), outputPolicyFile)
	if err != nil {
		log.Error("Dockerfile validation failed:", err)
	} else {
		fmt.Printf("Dockerfile validation succeeded!\n")
	}
	return nil
}
