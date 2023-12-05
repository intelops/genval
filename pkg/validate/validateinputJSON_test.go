package validate

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

// Successfully parse valid YAML input
func test_valid_yaml_input(t *testing.T) {
	yamlContent := `
		key1: value1
		key2: value2
		`
	regoPolicyPath := "./testdata/rego/inputfile_policies.rego"

	err := ValidateInput(yamlContent, regoPolicyPath)

	assert.NoError(t, err)
}

// Successfully parse valid YAML input
func TestValidYAMLInput(t *testing.T) {
	// Mock input
	yamlContent := "./testdata/multistage.yaml"

	// Mock rego policy path
	regoPolicyPath := "./testdata/rego/inputfile_policies.rego"

	// Mock expected output
	expectedError := error(nil)

	// Call the function
	err := ValidateInput(yamlContent, regoPolicyPath)

	// Check the result
	assert.Equal(t, expectedError, err)
}

// Successfully parse valid JSON input
func TestValidJSONInput(t *testing.T) {
	// Mock input
	jsonContent := "./testdata/multistage.json"
	// Mock rego policy path
	regoPolicyPath := "./testdata/rego/inputfile_policies.rego"

	// Mock expected output
	expectedError := error(nil)

	// Call the function
	err := ValidateInput(jsonContent, regoPolicyPath)

	// Check the result
	assert.Equal(t, expectedError, err)
}

// Successfully parse valid JSON input from YAML input
func TestValidJSONInputFromYAML(t *testing.T) {
	// Mock input
	yamlContent := "./testdata/multistage.json"

	// Mock rego policy path
	regoPolicyPath := "./testdata/rego/inputfile_policies.rego"

	// Mock expected output
	expectedError := error(nil)

	// Call the function
	err := ValidateInput(yamlContent, regoPolicyPath)

	// Check the result
	assert.Equal(t, expectedError, err)
}

// Return error when input is not valid YAML or JSON
func TestInvalidInputFormat(t *testing.T) {
	// Mock input with invalid content (you may directly pass an invalid string here)
	invalidContent := "this is not valid JSON or YAML"

	// Mock rego policy path
	regoPolicyPath := "./testdata/rego/inputfile_policies.rego"

	// Mock expected output
	expectedErrorMessage := "open this is not valid JSON or YAML: no such file or directory"

	// Call the function
	err := ValidateInput(invalidContent, regoPolicyPath)

	// Check if an error was returned
	if assert.Error(t, err) {
		// Check the error message
		assert.Equal(t, expectedErrorMessage, err.Error())
	}
}
