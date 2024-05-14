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

func ValidateWithRego(inputContent string, regoPolicy string) error {
	// read input is a file
	jsonData, err := parser.ProcessInput(inputContent)
	if err != nil {
		log.Errorf("Error reading input content file: %v", err)
	}

	k8sPolicy, err := utils.ReadFile(regoPolicy)
	if err != nil {
		log.WithError(err).Error("Error reading the policy file")
		return err
	}
	pkg, err := utils.ExtractPackageName(k8sPolicy)
	if err != nil {
		log.Fatalf("Unable to fetch package name: %v", err)
		return err
	}

	var commands map[string]interface{}
	err = json.Unmarshal(jsonData, &commands)
	if err != nil {
		log.Errorf("Cannot Unmarshal jsonData: %v", err)
		return err
	}
	ctx := context.Background()

	// Create regoQuery for evaluation
	regoQuery := rego.New(
		rego.Query("data."+pkg),
		rego.Module(regoPolicy, string(k8sPolicy)),
		rego.Input(commands),
	)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(ctx)
	if err != nil {
		log.Errorf("Error evaluating query:%v", err)
		return err
	}

	if err := PrintResults(rs); err != nil {
		return fmt.Errorf("error evaluating rego results fron policy %s: %v", regoPolicy, err)
	}
	return nil
}
