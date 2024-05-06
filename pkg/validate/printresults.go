package validate

import (
	"errors"
	"fmt"
	"os"

	"github.com/fatih/color"
	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

func PrintResults(result rego.ResultSet) error {
	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy", "Status", "Description"})
	var policyError error
	var desc string
	for _, r := range result {
		if len(r.Expressions) > 0 {
			keys := r.Expressions[0].Value.(map[string]interface{})
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

	return policyError
}
