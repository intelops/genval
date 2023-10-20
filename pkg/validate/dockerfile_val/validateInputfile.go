package validate

import (
	"context"
	_ "embed"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

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

	// Read the Rego policy from the given path
	regoContent, err := utils.ReadRegoFile(regoPolicyPath)
	if err != nil {
		return fmt.Errorf("error reading Rego policy: %v", err)
	}

	// Create Rego for query and evaluation
	regoQuery := rego.New(
		rego.Query("data.validate_input"), // Using hardcoded query as before
		rego.Module(regoPolicyPath, string(regoContent)),
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
