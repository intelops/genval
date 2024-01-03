package modes

import (
	"fmt"
	"os"

	generate "github.com/intelops/genval/pkg/generate/dockerfile_gen"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
)

func init() {
	// Set up logrus formatting here if needed
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: false,
	})
}

func ExecuteContainer(value, output, inputpolicy, outputpolicy string) {
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

	err := parser.ParseDockerfileInput(inputPath, &data)
	if err != nil {
		log.Error("Error parsing Dockerfile input:", err)
		return
	}

	inputContent, err := utils.ReadPolicyFile(inputPath)
	if err != nil {
		log.Fatalf("Unable to read input: %v", err)
	}

	// Validate the YAML using OPA
	err = validate.ValidateInput(string(inputContent), inputPolicyFile)
	if err != nil {
		log.Fatalf("Validation error: %v", err)
		return
	}

	dockerfileContent := generate.GenerateDockerfileContent(&data)

	outputData := []byte(dockerfileContent)
	err = os.WriteFile(outputPath, outputData, 0o644)
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
