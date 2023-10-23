package validate

import (
	"context"
	_ "embed"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/intelops/genval/pkg/parser"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

//go:embed inputfile-policies.rego
var inputPolicy []byte

const (
	// InputPolicy is the name of the Rego policy file used to validate input JSON file.
	InputPolicy = "inputFilePolicies.rego"

	// InputPackage is the name of the Rego package containing input JSON policies.
	InputPackage = "data.validate_input"
)

// ValidateJSON validates input JSON against pre-defined Rego policies
func ValidateInput(yamlContent string, regoPolicyPath string) error {
	// Parse the YAML content
	parsedYAML, err := parser.ParseYAMLContent(yamlContent)
	if err != nil {
		log.WithError(err).Error("Error parsing YAML.")
		return errors.New("error parsing YAML")
	}

	// Convert the dockerfileYAML struct to a map for rego input
	inputMap := make(map[string]interface{})
	yamlBytes, err := json.Marshal(parsedYAML)
	if err != nil {
		log.WithError(err).Error("Error converting dockerfileYAML to JSON.")
		return errors.New("error converting dockerfileYAML to JSON")
	}

	err = json.Unmarshal(yamlBytes, &inputMap)
	if err != nil {
		errWithContext := fmt.Errorf("error converting JSON to map: %v", err)
		log.WithError(err).Error(errWithContext.Error())
		return errWithContext
	}
	ctx := context.Background()

	// Create Rego for query and evaluation
	regoQuery := rego.New(
		rego.Query(InputPackage),
		rego.Module(InputPolicy, string(inputPolicy)),
		rego.Input(inputMap),
	)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(ctx)
	if err != nil {
		return fmt.Errorf("error evaluating Rego: %v", err)
	}

	// Print the results
	for _, result := range rs {
		if len(result.Expressions) > 0 {
			keys := result.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				if value != true {
					log.Errorf("Input Yaml policy: %s failed\n", key)
					return fmt.Errorf("input Yaml policy %s failed", key)
				} else {
					fmt.Printf("Input Yaml policy: %s passed\n", key)
				}
			}
		} else {
			log.Error("No input policies passed or evaluated")
		}
	}

	return nil
}
