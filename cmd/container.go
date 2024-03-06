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

type containerFlags struct {
	reqinput     string
	output       string
	inputPolicy  string
	outputPolicy string
}

var containerArgs containerFlags

func init() {
	containerCmd.Flags().StringVarP(&containerArgs.reqinput, "reqinput", "r", "", "Input JSON for generating Dockerfile")
	if err := containerCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	containerCmd.Flags().StringVarP(&containerArgs.output, "output", "p", "", "Path to write the Generated Dockefile")
	if err := containerCmd.MarkFlagRequired("output"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	containerCmd.Flags().StringVarP(&containerArgs.inputPolicy, "inputpolicy", "i", "", "Path for the Input policyin Rego, input-policy can be passed from either Local or from remote URL")
	if err := containerCmd.MarkFlagRequired("inputpolicy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	containerCmd.Flags().StringVarP(&containerArgs.outputPolicy, "outputpolicy", "o", "", "Path for Out policy in Rego, Output-policy can be passed from either Local or from remote URL")
	if err := containerCmd.MarkFlagRequired("outputpolicy"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	rootCmd.AddCommand(containerCmd)
}

var containerCmd = &cobra.Command{
	Use:   "container",
	Short: "Generate and Validate Dockerfile",
	Long: `
A user can pass in a JSON file to genval, the passed input will be first evaluated based on input policies,
once input is validated, a Dockerfile will be generated and the generated Dockerfile will be further validated using
the output policies.

Provides flexibility of supplying input files in YAML or JSON formats, as well as policy files for input and output policies.
Genval supports both local file paths or remote URLs, such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `./genval container --reqinput=input.json \
  --output=output.Dockerfile \
  --inputpolicy=<path/to/input.rego policy> \
  --outputpolicy=<path/to/output.rego file>`,
	RunE: runContainerCmd,
}

func runContainerCmd(cmd *cobra.Command, args []string) error {

	inputPath := containerArgs.reqinput
	outputPath := containerArgs.output
	inputPolicyFile := containerArgs.inputPolicy
	outputPolicyFile := containerArgs.outputPolicy

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
