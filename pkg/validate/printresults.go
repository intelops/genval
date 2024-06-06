package validate

import (
	"encoding/json"
	"fmt"

	"os"

	"github.com/fatih/color"
	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

// PrintResults prints the evaluation results along with the metadata
func PrintResults(result rego.ResultSet, metas []*regoMetadata) error {
	// Create the table
	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Status", "Description", "Severity", "Benchmark", "Category"})

	var allResults []Results
	var idCounter int

	for _, r := range result {
		if len(r.Expressions) > 0 {
			keys := r.Expressions[0].Value.(map[string]interface{})
			for key, value := range keys {
				// Match policy metadata for each key
				matchedKey, meta, err := MatchPolicyMetadata(metas, key)
				if err != nil {
					return fmt.Errorf("error matching key and metadata name: %v", err)
				}
				// Construct rows using the matched metadata
				if key == matchedKey {
					var status string
					var saveStatus string
					if policies, ok := value.([]interface{}); ok {
						// Check if the slice is empty
						if len(policies) > 0 {
							saveStatus = "passed"
							status = color.New(color.FgGreen).Sprint("passed")
						} else {
							saveStatus = "failed"
							status = color.New(color.FgRed).Sprint("failed")
							log.Infof(color.New(color.FgRed).Sprintf("policy evaluation for %s failed", key))
						}
					} else {
						// Handle other types of values (non-slice)
						if value != nil {
							saveStatus = "passed"
							status = color.New(color.FgGreen).Sprint("passed")
						} else {
							saveStatus = "failed"
							status = color.New(color.FgRed).Sprint("failed")
							log.Infof(color.New(color.FgRed).Sprintf("policy evaluation for %s failed", key))
						}
					}
					t.AppendRow([]interface{}{key, status, meta.Description, meta.Severity, meta.Benchmark, meta.Category})
					idCounter++
					// Append results to allResults
					allResults = append(allResults, Results{
						ID:          fmt.Sprintf("%d", idCounter),
						PolicyName:  key,
						Status:      saveStatus,
						Description: meta.Description,
						Severity:    meta.Severity,
						Benchmark:   meta.Benchmark,
						Category:    meta.Category,
					})
				}
			}
		} else {
			fmt.Println("No policies passed")
			log.Println("no policies passed")
		}
	}

	// Render the table after processing all results
	t.Render()

	// Save all results to file as a single JSON array
	if len(allResults) > 0 {
		if err := SaveResults("results.json", allResults); err != nil {
			return fmt.Errorf("error saving results: %v", err)
		}
	}

	return nil
}

type Results struct {
	ID          string `json:"id"`
	PolicyName  string `json:"policyName"`
	Status      string `json:"status"`
	Description string `json:"description"`
	Severity    string `json:"severity"`
	Benchmark   string `json:"benchmark"`
	Category    string `json:"category"`
}

// SaveResults saves the results to a file as a JSON array
func SaveResults(filename string, newResults []Results) error {
	// Serialize the results slice to JSON
	data, err := json.MarshalIndent(newResults, "", "  ")
	if err != nil {
		return fmt.Errorf("error marshalling results to JSON: %v", err)
	}

	// Check if the file exists
	_, err = os.Stat(filename)
	if os.IsNotExist(err) {
		// If the file does not exist, create it
		file, err := os.Create(filename)
		if err != nil {
			return fmt.Errorf("error creating file: %v", err)
		}
		defer file.Close()
	}

	// Write the JSON data to the file
	if err := os.WriteFile(filename, data, 0o644); err != nil {
		return fmt.Errorf("error writing JSON data to file: %v", err)
	}

	return nil
}
