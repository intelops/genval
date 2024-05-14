package validate

import (
	"errors"
	"os"

	"github.com/fatih/color"
	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

func PrintResults(result rego.ResultSet) error {
	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy", "Status", "Description", "Benchmark"})
	var policyError error

	for _, r := range result {
		if len(r.Expressions) > 0 {
			keys := r.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				// fmt.Printf("Value Map: %v\n", value)
				var desc, b string

				switch v := value.(type) {
				case []interface{}:
					if len(v) > 0 {
						if result, ok := v[0].(map[string]interface{}); ok {
							b = result["benchmark"].(string)
							desc = result["msg"].(string)
						}
					}
					// }
				case string:
					// If value is a string, assign it to desc
					desc = v
				case map[string]interface{}:
					// If value is a map, directly access 'benchmark' field
					if bm, ok := v["benchmark"].(string); ok {
						b = bm
					}
				}

				// Perform type assertion to check if value is a slice
				if slice, ok := value.([]interface{}); ok {
					// Check if the slice is empty
					if len(slice) > 0 {
						t.AppendRow(table.Row{key, color.New(color.FgGreen).Sprint("passed"), desc, b})
					} else {
						t.AppendRow(table.Row{key, color.New(color.FgRed).Sprint("failed"), "NA", "NA"})
						policyError = errors.New("policy evaluation failed: " + key)
					}
				} else {
					// Handle other types of values (non-slice)
					if value != nil {
						t.AppendRow(table.Row{key, color.New(color.FgGreen).Sprint("passed"), desc, b})
					} else {
						t.AppendRow(table.Row{key, color.New(color.FgRed).Sprint("failed"), "NA", "NA"})
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
