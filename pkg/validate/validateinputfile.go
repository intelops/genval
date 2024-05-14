package validate

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

func ValidateInput(yamlContent string, regoPolicyPath string) error {
	inputBytes, err := parser.ProcessInput(yamlContent)
	if err != nil {
		log.Errorf("Error parsing input content: %v", err)
		return err
	}

	// Convert the dockerfileYAML struct to a map for rego input
	inputMap := make(map[string]interface{})

	err = json.Unmarshal(inputBytes, &inputMap)
	if err != nil {
		errWithContext := fmt.Errorf("error converting JSON to map: %v", err)
		log.WithError(err).Error(errWithContext.Error())
		return errWithContext
	}
	ctx := context.Background()

	// Read the Rego policy from the given path
	regoContent, err := utils.ReadFile(regoPolicyPath)
	if err != nil {
		return fmt.Errorf("error reading Rego policy: %v", err)
	}

	pkg, err := utils.ExtractPackageName(regoContent)
	if err != nil {
		log.Fatalf("Unable to fetch package name: %v", err)
	}

	// Create Rego for query and evaluation
	regoQuery := rego.New(
		rego.Query("data."+pkg),
		rego.Module(regoPolicyPath, string(regoContent)),
		rego.Input(inputMap),
	)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(ctx)
	if err != nil {
		return fmt.Errorf("error evaluating Rego: %v", err)
	}

	if err := PrintResults(rs); err != nil {
		return fmt.Errorf("error evaluating rego results fron policy %s: %v", regoPolicyPath, err)
	}
	return nil
}
