package container

import (
	"fmt"
	"os"

	generate "github.com/intelops/genval/pkg/generate/dockerfile_gen"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	validate "github.com/intelops/genval/pkg/validate/dockerfile_val"
	log "github.com/sirupsen/logrus"
)

func init() {
	// Set up logrus formatting here if needed
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: false,
	})
}

func Execute(value, output, inputpolicy, outputpolicy string) {
	if value == "" || output == "" || inputpolicy == "" || outputpolicy == "" {
		fmt.Println("[USAGE]: ./genval --mode=container --reqinput=input.json --output=output.Dockerfile --inputpolicy=<path/to/input.rego policy> --outputpolicy <path/tp/output.rego file>")
		return
	}

	// inputPath := args[0]
	// outputPath := args[1]
	inputPath := value
	outputPath := output
	inputPolicyFile := inputpolicy
	outputPolicyFile := outputpolicy

	// Use ParseInputFile to read and unmarshal the input file
	var data generate.DockerfileContent

	input, err := utils.ProcessInputs([]string{inputPath})
	if err != nil {
		log.Errorf("Error reading URL: %v", err)
	}

	err = parser.ReadAndParseFile(input[0], &data)
	if err != nil {
		log.Error("Error:", err)
		return
	}

	yamlContent, err := os.ReadFile(input[0])
	if err != nil {
		log.Fatalf("Error reading YAML file: %v", err)
	}

	// Validate the YAML using OPA
	err = validate.ValidateInput(string(yamlContent), inputPolicyFile)
	if err != nil {
		log.Fatalf("Validation error: %v", err)
		return
	}

	dockerfileContent := generate.GenerateDockerfileContent(&data)

	outputData := []byte(dockerfileContent)
	err = os.WriteFile(outputPath, outputData, 0644)
	if err != nil {
		log.Error("Error writing Dockerfile:", err)
		return
	}
	fmt.Printf("Generated Dockerfile saved to: %s\n", outputPath)

	err = validate.ValidateDockerfile(string(outputData), outputPolicyFile)
	if err != nil {
		log.Error("Dockerfile validation failed:", err)
		return
	} else {
		fmt.Printf("Dockerfile validation succeeded!\n")
	}
}
