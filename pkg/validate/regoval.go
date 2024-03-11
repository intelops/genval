package validate

import (
	"context"
	"encoding/json"
	"errors"
	"os"

	"github.com/fatih/color"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/jedib0t/go-pretty/v6/table"
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

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy", "Status"})

	for _, result := range rs {
		if len(result.Expressions) > 0 {
			keys := result.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				if value != true {
					t.AppendRow(table.Row{key, color.New(color.FgRed).Sprint("failed")})
				} else {
					t.AppendRow(table.Row{key, color.New(color.FgGreen).Sprint("passed")})
				}
			}
		} else {
			log.Error("No policies passed")
			return errors.New("no policies passed")
		}
	}

	t.Render()
	return nil
}
