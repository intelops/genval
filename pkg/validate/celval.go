package validate

import (
	"encoding/json"
	"fmt"
	"log"
	"os"

	"github.com/fatih/color"
	"github.com/google/cel-go/cel"
	"github.com/google/cel-go/checker/decls"
	"github.com/jedib0t/go-pretty/v6/table"
	"gopkg.in/yaml.v2"
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

func EvaluateCELPolicies(policies []CELPolicy, inputFile string, t table.Writer) error {
	green := color.New(color.FgGreen).SprintFunc()
	red := color.New(color.FgRed).SprintFunc()

	for _, policy := range policies {
		result, err := evaluateCEL(inputFile, policy.Rule)
		var resultColorized string
		if err != nil {
			log.Printf("Error evaluating policy '%s': %v\n", policy.Metadata.Name, err)
			resultColorized = red("Error")
		} else if result == "Passed" {
			resultColorized = green(result)
		} else {
			resultColorized = red(result)
		}
		t.AppendRow(table.Row{
			policy.Metadata.Name,
			resultColorized,
			policy.Metadata.Description,
			policy.Metadata.Severity,
			policy.Metadata.Benchmark,
		})
	}

	return nil
}

type PolicyFile struct {
	Policies []CELPolicy `yaml:"policies"`
}

func ParseYAMLPolicies(policyFile string) ([]CELPolicy, error) {
	data, err := os.ReadFile(policyFile)
	if err != nil {
		return nil, fmt.Errorf("unable to read policy file: %v", err)
	}

	var policyFileData PolicyFile

	err = yaml.Unmarshal(data, &policyFileData)
	if err != nil {
		return nil, fmt.Errorf("error unmarshalling YAML: %v", err)
	}
	return policyFileData.Policies, nil
}
