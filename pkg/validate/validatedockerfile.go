package validate

import (
	"context"
	"encoding/json"
	"fmt"
	"path/filepath"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/open-policy-agent/opa/ast"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

// ValidateDockerfileUsingRego validates a Dockerfile using Rego.
func ValidateDockerfile(dockerfileContent string, regoPolicyPath string) error {
	metaFiles, regoPolicy, err := FetchRegoMetadata(regoPolicyPath, metaExt, policyExt)
	if err != nil {
		return err
	}

	// Load metadata from JSON files
	metas, err := LoadRegoMetadata(metaFiles)
	if err != nil {
		return fmt.Errorf("error loading policy metadata: %v", err)
	}

	// Declare a slice to store the results of each policy evaluation
	var allResults rego.ResultSet

	for _, regoFile := range regoPolicy {
		dockerPolicy, err := utils.ReadFile(regoFile)
		if err != nil {
			return fmt.Errorf("error reading the policy file %v: %v", regoPolicy, err)
		}

		pkg, err := utils.ExtractPackageName(dockerPolicy)
		if err != nil {
			return fmt.Errorf("error fetching package name from policy %v: %v", dockerPolicy, err)
		}

		// Prepare Rego input data
		dockerfileInstructions := parser.ParseDockerfileContent(dockerfileContent)

		jsonData, err := json.Marshal(dockerfileInstructions)
		if err != nil {
			return fmt.Errorf("error marshalling %v, to JSON: %v", dockerfileInstructions, err)
		}

		policyName := filepath.Base(regoFile)

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

		// Store the results in the slice
		allResults = append(allResults, rs...)
	}

	// Print all results accumulated from each policy evaluation
	if err := PrintResults(allResults, metas); err != nil {
		return fmt.Errorf("error evaluating rego results for %s: %v", regoPolicyPath, err)
	}

	return nil
}
