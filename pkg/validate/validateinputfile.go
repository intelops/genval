package validate

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"

	"github.com/fatih/color"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/jedib0t/go-pretty/v6/table"
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
	regoContent, err := utils.ReadPolicyFile(regoPolicyPath)
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

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy", "Status"})
	var policyError error

	for _, result := range rs {
		if len(result.Expressions) > 0 {
			keys := result.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				if value != true {
					t.AppendRow(table.Row{key, color.New(color.FgRed).Sprint("failed")})
					policyError = errors.New("policy evaluation failed: " + key)
				} else {
					t.AppendRow(table.Row{key, color.New(color.FgGreen).Sprint("passed")})
				}
			}
		} else {
			log.Error("No policies passed")
			policyError = errors.New("no policies passed")
		}
	}

	t.Render()

	if err != nil {
		return errors.New("error evaluating Rego")
	}

	return policyError
}
