package validate

import (
	"bufio"
	"encoding/json"
	"fmt"
	"log"
	"strings"

	"github.com/fatih/color"
	"github.com/google/cel-go/cel"
	"github.com/google/cel-go/checker/decls"
	"github.com/intelops/genval/pkg/utils"
	"github.com/jedib0t/go-pretty/v6/table"
)

func evaluateCEL(input string, celPolicy string) (string, error) {
	env, err := cel.NewEnv(
		cel.Declarations(
			decls.NewVar("input", decls.NewMapType(decls.String, decls.Dyn)),
		),
	)
	if err != nil {
		return "Failed", err
	}

	ast, iss := env.Compile(celPolicy)
	if iss.Err() != nil {
		return "Failed", iss.Err()
	}

	prg, err := env.Program(ast)
	if err != nil {
		return "Failed", err
	}

	var jsonData map[string]interface{}
	if err := json.Unmarshal([]byte(input), &jsonData); err != nil {
		return "Failed", err
	}

	out, _, err := prg.Eval(map[string]interface{}{"input": jsonData})
	if err != nil {
		return "Failed", err
	}

	// Check the result and return "Passed" or "Failed"
	if out.Value().(bool) {
		return "Passed", nil
	}
	return "Failed", nil
}

func EvaluateCELPolicies(policyFile string, inputFile string, t table.Writer) error {
	// Set colors for evaluation result
	green := color.New(color.FgGreen).SprintFunc()
	red := color.New(color.FgRed).SprintFunc()

	// Read the policy file
	policyContent, err := utils.ReadFile(policyFile)
	if err != nil {
		log.Fatalf("Unable to read Policy file: %v", err)
	}

	scanner := bufio.NewScanner(strings.NewReader(string(policyContent)))
	var policyName, policy, description, benchmark, severity string
	resetPolicy := func() {
		policyName = ""
		policy = ""
		description = ""
		benchmark = ""
		severity = ""
	}
	resetPolicy()

	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "Name:") {
			if policyName != "" {
				// Evaluate the previous policy before starting the new one
				result, err := evaluateCEL(inputFile, policy)
				var resultColorized string
				if err != nil {
					log.Printf("Error evaluating policy '%s': %v\n", policyName, err)
					resultColorized = red("Error")
				} else if result == "Passed" {
					resultColorized = green(result)
				} else {
					resultColorized = red(result)
				}
				t.AppendRow([]interface{}{policyName, resultColorized, description, severity, benchmark})
			}
			// Start a new policy
			resetPolicy()
			policyName = strings.TrimSpace(strings.TrimPrefix(line, "Name:"))
		} else if strings.HasPrefix(line, "Description:") {
			description = strings.TrimSpace(strings.TrimPrefix(line, "Description:"))
		} else if strings.HasPrefix(line, "Benchmark:") {
			benchmark = strings.TrimSpace(strings.TrimPrefix(line, "Benchmark:"))
		} else if strings.HasPrefix(line, "Severity:") {
			severity = strings.TrimSpace(strings.TrimPrefix(line, "Severity:"))
		} else {
			policy += line + "\n"
		}
	}

	// Evaluate the last policy in the file
	if policyName != "" {
		result, err := evaluateCEL(inputFile, policy)
		var resultColorized string
		if err != nil {
			log.Printf("Error evaluating policy '%s': %v\n", policyName, err)
			resultColorized = red("Error")
		} else if result == "Passed" {
			resultColorized = green(result)
		} else {
			resultColorized = red(result)
		}
		t.AppendRow([]interface{}{policyName, resultColorized, description, severity, benchmark})
	}

	if err := scanner.Err(); err != nil {
		return fmt.Errorf("error reading policies: %v", err)
	}

	return nil
}
