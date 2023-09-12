package validate

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"

	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
	"gopkg.in/yaml.v2"
)

const (
	InputPolicy  = "./policies/input-yaml.rego"
	InputPackage = "data.validate_input"
)

type DockerInstruction map[string][]string

type DockerStage struct {
	Instructions []DockerInstruction `yaml:"instructions"`
	Stage        int                 `yaml:"stage"`
}

type DockerfileYAML struct {
	Dockerfile []DockerStage `yaml:"dockerfile"`
}

func ParseYAML(yamlContent string) (*DockerfileYAML, error) {

	var dockerfileYAML DockerfileYAML
	err := yaml.Unmarshal([]byte(yamlContent), &dockerfileYAML)
	if err != nil {
		return nil, err
	}
	return &dockerfileYAML, nil
}

func ValidateYAML(yamlContent string, regoPolicyPath string) error {
	// Parse the YAML content
	dockerfileYAML, err := ParseYAML(yamlContent)
	if err != nil {
		log.WithError(err).Error("Error parsing YAML.")
		return errors.New("error parsing YAML")
	}

	// Read Rego policy code from file
	regoPolicyCode, err := os.ReadFile(regoPolicyPath)
	if err != nil {
		log.WithError(err).Error("Error reading rego policy.")
		return errors.New("error reading rego policy")
	}

	// Convert the dockerfileYAML struct to a map for rego input
	inputMap := make(map[string]interface{})
	yamlBytes, err := json.Marshal(dockerfileYAML)
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

	// fmt.Printf("inputMap: %v\n", inputMap)

	// Create Rego for query and evaluation
	regoQuery := rego.New(
		rego.Query(InputPackage),
		rego.Module(InputPolicy, string(regoPolicyCode)),
		rego.Input(inputMap),
	)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(context.Background())
	if err != nil {
		return fmt.Errorf("error evaluating Rego: %v", err)
	}

	// Print the results
	for _, result := range rs {
		if len(result.Expressions) > 0 {
			keys := result.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				if value != true {
					log.Errorf("Policy: %s failed\n", key)
					return fmt.Errorf("policy %s failed", key)
				} else {
					log.Infof("Policy: %s passed\n", key)
				}
			}
		} else {
			log.Error("No policies passed or evaluated")
		}
	}

	return nil
}
