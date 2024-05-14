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
	dockerPolicy, err := utils.ReadFile(regoPolicyPath)
	if err != nil {
		return fmt.Errorf("error reading the policy file %v: %v", regoPolicyPath, err)
	}

	pkg, err := utils.ExtractPackageName(dockerPolicy)
	if err != nil {
		return fmt.Errorf("errr fetching package name from polcy %v: %v", dockerPolicy, err)
	}
	bm, err := fetchMetadataFromPolicyFile(regoPolicyPath)
	if err != nil {
		return fmt.Errorf("error fetching benchmarks from policy file %s: %v", regoPolicyPath, err)
	}
	// fmt.Printf("Benchmarks: %v", bm)

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

	if err := PrintResults(bm, rs); err != nil {
		return fmt.Errorf("error evaluating rego results for %s: %v", regoPolicyPath, err)
	}
	return nil
}
