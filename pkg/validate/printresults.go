package validate

import (
	"errors"
	"fmt"
	"os"

	"github.com/fatih/color"
	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/open-policy-agent/opa/rego"
)

// PrintResults prints the evaluation results along with the metadata
func PrintResults(result rego.ResultSet, metas []*regoMetadata) error {
	// Create the table
	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Status", "Description", "Severity", "Benchmark", "Category"})

	var policyError error

	// Match policy metadata outside the loop
	matchedKey, meta, err := MatchPolicyMetadata(metas, result)
	if err != nil {
		return fmt.Errorf("error matching key and metadata name: %v", err)
	}

	for _, r := range result {
		if len(r.Expressions) > 0 {
			keys := r.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				// Construct rows using the matched metadata
				if key == matchedKey {
					var status string
					if policies, ok := value.([]interface{}); ok {
						// Check if the slice is empty
						if len(policies) > 0 {
							status = color.New(color.FgGreen).Sprint("passed")
						} else {
							status = color.New(color.FgRed).Sprint("failed")
							policyError = errors.New("policy evaluation failed: " + key)
						}
					} else {
						// Handle other types of values (non-slice)
						if value != nil {
							status = color.New(color.FgGreen).Sprint("passed")
						} else {
							status = color.New(color.FgRed).Sprint("failed")
							policyError = errors.New("policy evaluation failed: " + key)
						}
					}
					t.AppendRow([]interface{}{key, status, meta.Description, meta.Severity, meta.Benchmark, meta.Category})
				}
			}
		} else {
			fmt.Println("No policies passed")
			policyError = errors.New("no policies passed")
		}
	}

	// Render the table
	t.Render()

	return policyError
}
