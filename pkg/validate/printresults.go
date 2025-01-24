package validate

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/charmbracelet/lipgloss"
	"github.com/fatih/color"
	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

// PrintResults prints the evaluation results along with the metadata
func PrintResults(result rego.ResultSet, metas []*regoMetadata) ([]byte, int, error) {
	// Create the table
	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Status", "Description", "Severity", "Benchmark", "Category"})

	var resultSlice []byte
	var allResults []Results
	var idCounter int
	var passedCount int
	var failedCount int
	var err error

	for _, r := range result {
		// fmt.Printf("All RESULTS: %v", result)
		if len(r.Expressions) > 0 {
			keys := r.Expressions[0].Value.(map[string]interface{})
			// fmt.Printf("All Results: %v", keys)
			for key, value := range keys {
				// fmt.Printf("result key: %v\n Result Value: %v\n", key, value)
				// Match policy metadata for each key
				matchedKey, meta, err := MatchPolicyMetadata(metas, key)
				if err != nil {
					return nil, failedCount, fmt.Errorf("error matching key and metadata name: %v", err)
				}
				// Construct rows using the matched metadata
				if key == matchedKey {
					var status string
					var saveStatus string
					if policies, ok := value.([]interface{}); ok {
						// Check if the slice is empty
						// fmt.Printf("Policies: %v", policies...)
						if len(policies) > 0 {
							passedCount++
							saveStatus = "passed"
							status = color.New(color.FgGreen).Sprint("passed")
						} else {
							failedCount++
							saveStatus = "failed"
							status = color.New(color.FgRed).Sprint("failed")
							logMessage := color.New(color.FgRed).Sprintf("policy evaluation for '%s' failed", key)
							// log.Info(logMessage)
							log.Warn(logMessage)
						}
					} else {
						// Handle other types of values (non-slice)
						if value != nil {
							passedCount++
							saveStatus = "passed"
							status = color.New(color.FgGreen).Sprint("passed")
						} else {
							failedCount++
							saveStatus = "failed"
							status = color.New(color.FgRed).Sprint("failed")
							statusMessage := (color.New(color.FgRed).Sprintf("policy evaluation for '%s' failed", key))
							// log.Info(statusMessage)
							log.Warn(statusMessage)
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
			log.Println("no policies passed")
		}
	}

	t.Render()
	fmt.Printf("Total Passed: %d, Total Failed: %d\n", passedCount, failedCount)

	// Render the table after processing all results

	// Save all results to file as a single JSON array
	if len(allResults) > 0 {
		if resultSlice, err = SaveResults("results.json", allResults); err != nil {
			return nil, failedCount, fmt.Errorf("error saving results: %v", err)
		}
	}
	failedResults, err := extractFailedPolicies(resultSlice)
	if err != nil {
		return fmt.Errorf("error fetching failed policies: %v", err)
	}
	// llm.ExtractFailedPolicies(resultSlice)
	return failedResults, failedCount, nil
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
func SaveResults(filename string, newResults []Results) ([]byte, error) {
	// Serialize the results slice to JSON
	data, err := json.MarshalIndent(newResults, "", "  ")
	if err != nil {
		return nil, fmt.Errorf("error marshalling results to JSON: %v", err)
	}

	// Check if the file exists
	_, err = os.Stat(filename)
	if os.IsNotExist(err) {
		// If the file does not exist, create it
		file, err := os.Create(filename)
		if err != nil {
			return nil, fmt.Errorf("error creating file: %v", err)
		}
		defer file.Close()
	}

	// Write the JSON data to the file
	if err := os.WriteFile(filename, data, 0o644); err != nil {
		return nil, fmt.Errorf("error writing JSON data to file: %v", err)
	}

	return data, nil
}

// ExtractFailedPoliciesAsBytes filters policies with status "failed" and returns the result as []byte.
func extractFailedPolicies(policiesData []byte) ([]byte, error) {
	var policies []Results

	// Unmarshal the input JSON into a slice of Policy structs.
	if err := json.Unmarshal(policiesData, &policies); err != nil {
		return nil, fmt.Errorf("failed to parse input JSON: %w", err)
	}

	// Filter policies with status "failed".
	var failedPolicies []Results
	for _, policy := range policies {
		if policy.Status == "failed" {
			failedPolicies = append(failedPolicies, policy)
		}
	}

	// Marshal the result back to JSON.
	failedReslts, err := json.Marshal(failedPolicies)
	if err != nil {
		return nil, fmt.Errorf("failed to marshal result JSON: %w", err)
	}

	return failedReslts, nil
}

// DrawBorderedOutputWithLipgloss draws a bordered box around the provided content.
func BorderedOutput(content string) string {
	// Define the style for the border.
	borderStyle := lipgloss.NewStyle().
		// Set normal border with all sides.
		Border(lipgloss.NormalBorder(), true).
		// Set the border color.
		BorderForeground(lipgloss.Color("63")).
		// Add padding inside the border.
		Padding(1, 2).
		// Set a fixed width.
		// Width(150)
		// Wraps whole screen width
		Width(200)

	return borderStyle.Render(content)
}
