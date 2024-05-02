package validate

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"path/filepath"

	"github.com/fatih/color"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/open-policy-agent/opa/ast"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

// ValidateDockerfileUsingRego validates a Dockerfile using Rego.
func ValidateDockerfile(dockerfileContent string, regoPolicyPath string) error {
	dockerPolicy, err := utils.ReadFile(regoPolicyPath)
	if err != nil {
		return fmt.Errorf("error reading the policy file %v: %v", regoPolicyPath, err)
	}

	pkg, err := utils.ExtractPackageName(dockerPolicy)
	if err != nil {
		return fmt.Errorf("errr fetching package name from polcy %v: %v", dockerPolicy, err)
	}

	// Prepare Rego input data
	dockerfileInstructions := parser.ParseDockerfileContent(dockerfileContent)

	jsonData, err := json.Marshal(dockerfileInstructions)
	if err != nil {
		return fmt.Errorf("error marshalling %v, to JSON: %v", dockerfileInstructions, err)
	}

	policyName := filepath.Base(regoPolicyPath)

	var commands []map[string]string
	err = json.Unmarshal([]byte(jsonData), &commands)
	if err != nil {
		return fmt.Errorf("error converting JSON to map: %v", err)
	}

	ctx := context.Background()

	compiler, err := ast.CompileModules(map[string]string{
		policyName: string(dockerPolicy),
	})
	if err != nil {
		log.Fatal(err)
		return fmt.Errorf("failed to compile rego policy: %w", err)
	}
	// Create regoQuery for evaluation
	regoQuery := rego.New(
		rego.Query("data."+pkg),
		rego.Compiler(compiler),
		rego.Input(commands),
	)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(ctx)
	if err != nil {
		switch err := err.(type) {
		case ast.Errors:
			for _, e := range err {
				fmt.Printf("code: %v", e.Code)
				fmt.Printf("row: %v", e.Location.Row)
				fmt.Printf("filename: %v", e.Location.File)
			}
			log.Fatal("Error evaluating query:", err)
		}
	}

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy", "Status", "Description"})
	var policyError error
	var desc string
	for _, result := range rs {
		if len(result.Expressions) > 0 {
			keys := result.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				switch v := value.(type) {
				case []interface{}:
					// Check if the slice is not empty
					if len(v) > 0 {
						// If it's not empty, take the first element
						desc = fmt.Sprintf("%v", v[0])
					}
				case string:
					// If value is a string, assign it to desc
					desc = v
				}

				// Perform type assertion to check if value is a slice
				if slice, ok := value.([]interface{}); ok {
					// Check if the slice is empty
					if len(slice) > 0 {
						t.AppendRow(table.Row{key, color.New(color.FgGreen).Sprint("passed"), desc})
					} else {
						t.AppendRow(table.Row{key, color.New(color.FgRed).Sprint("failed"), "NA"})
						policyError = errors.New("policy evaluation failed: " + key)
					}
				} else {
					// Handle other types of values (non-slice)
					if value != nil {
						t.AppendRow(table.Row{key, color.New(color.FgGreen).Sprint("passed"), desc})
					} else {
						t.AppendRow(table.Row{key, color.New(color.FgRed).Sprint("failed"), "NA"})
						policyError = errors.New("policy evaluation failed: " + key)
					}
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
