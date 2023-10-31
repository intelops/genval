package validate

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

// ValidateDockerfileUsingRego validates a Dockerfile using Rego.
func ValidateDockerfile(dockerfileContent string, regoPolicyPath string) error {
	dockerPolicy, err := utils.ReadPolicyFile(regoPolicyPath)
	if err != nil {
		log.WithError(err).Error("Error reading the policy file.")
		return errors.New("error reading the policy file")
	}

	// Prepare Rego input data
	dockerfileInstructions := parser.ParseDockerfileContent(dockerfileContent)

	jsonData, err := json.Marshal(dockerfileInstructions)
	if err != nil {
		log.WithError(err).Error("Error converting to JSON:", err)
		return errors.New("error converting to JSON")
	}

	var commands []map[string]string
	err = json.Unmarshal([]byte(jsonData), &commands)
	if err != nil {
		errWithContext := fmt.Errorf("error converting JSON to map: %v", err)
		log.WithError(err).Error(errWithContext.Error())
		return errWithContext
	}

	ctx := context.Background()

	// Create regoQuery for evaluation
	regoQuery := rego.New(
		rego.Query("data.dockerfile_validation"),
		rego.Module(regoPolicyPath, string(dockerPolicy)),
		rego.Input(commands),
	)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(ctx)
	if err != nil {
		log.Fatal("Error evaluating query:", err)
	}

	var policyError error

	for _, result := range rs {
		if len(result.Expressions) > 0 {
			keys := result.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				if value != true {
					log.Errorf("Dockerfile validation policy: %s failed\n", key)
					policyError = fmt.Errorf("dockerfile validation policy: %s failed", key)
				} else {
					fmt.Printf("Dockerfile validation policy: %s passed\n", key)
				}
			}
		} else {
			log.Error("No policies passed")
		}
	}

	if err != nil {
		log.WithError(err).Error("Error evaluating Rego.")
		return errors.New("error evaluating Rego")
	}

	return policyError
}
