package validate

import (
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
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
					idCounter++
					// Append results to allResults
					allResults = append(allResults, Results{
						ID:          fmt.Sprintf("%d", idCounter),
						PolicyName:  key,
						Status:      status,
						Description: meta.Description,
						Severity:    meta.Severity,
						Benchmark:   meta.Benchmark,
						Category:    meta.Category,
					})
				}
			}
		} else {
			fmt.Println("No policies passed")
			policyError = errors.New("no policies passed")
		}
	}

	fmt.Println("Rendering table")
	// Render the table after processing all results
	t.Render()

	// Save all results to file as a single JSON array
	if len(allResults) > 0 {
		if err := SaveResults("results.json", allResults); err != nil {
			return fmt.Errorf("error saving results: %v", err)
		}
	}

	return policyError
}

type Result struct {
	ID          string `json:"id"`
	PolicyName  string `json:"policyName"`
	Status      string `json:"status"`
	Description string `json:"description"`
	Severity    string `json:"severity"`
	Benchmark   string `json:"benchmark"`
	Category    string `json:"category"`
}

type Results Result

// SaveResults saves the results to a file as a JSON array
func SaveResults(filename string, newResults []Results) error {
	var existingResults []Results

	// Read existing file content
	data, err := os.ReadFile(filename)
	if err == nil {
		// Unmarshal existing JSON content into the slice
		if err := json.Unmarshal(data, &existingResults); err != nil {
			return fmt.Errorf("error unmarshalling existing results: %v", err)
		}
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("error reading existing file: %v", err)
	}

	// Append new results to existing results
	existingResults = append(existingResults, newResults...)

	// Serialize the combined results slice to JSON
	data, err = json.MarshalIndent(existingResults, "", "  ")
	if err != nil {
		return fmt.Errorf("error marshalling results to JSON: %v", err)
	}

	// Write the JSON data to the file
	if err := ioutil.WriteFile(filename, data, 0644); err != nil {
		return fmt.Errorf("error writing JSON data to file: %v", err)
	}

	return nil
}
