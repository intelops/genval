package main

import (
	"fmt"
	"os"

	"github.com/santoshkal/genval-poc/pkg/generate"
	"github.com/santoshkal/genval-poc/pkg/parser"
	"github.com/santoshkal/genval-poc/pkg/validate"
	log "github.com/sirupsen/logrus"
)

// const DockerfilePolicy = "./policies/docker-file.rego"

func main() {
	if len(os.Args) != 3 {
		log.Debug("Usage: go run main.go input.yaml output.Dockerfile")
		return
	}

	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: true,
	})

	inputPath := os.Args[1]
	outputPath := os.Args[2]

	// Use ParseInputFile to read and unmarshal the input file
	var data generate.DockerfileContent

	err := parser.ReadAndParseFile(inputPath, &data)
	if err != nil {
		log.Error("Error:", err)
		return
	}

	yamlContent, err := os.ReadFile(inputPath)
	if err != nil {
		log.Fatalf("Error reading YAML file: %v", err)
	}

	// Validate the YAML using OPA
	err = validate.ValidateYAML(string(yamlContent), validate.InputPolicy)
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

	err = validate.ValidateDockerfile(string(outputData), validate.DockerfilePolicy)
	// fmt.Printf("Dockerfile JSON: %s\n", generatedDockerfileContent)
	if err != nil {
		log.Error("Dockerfile validation failed:", err)
		return
	} else {
		fmt.Printf("Dockerfile validation succeeded!\n")
	}
}
