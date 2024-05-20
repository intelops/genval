package validate

import (
	"path/filepath"
	"testing"

	"github.com/stretchr/testify/assert"
)

type validateWithRegoTestCase struct {
	name          string
	inputContent  string
	regoPolicy    string
	expectedError bool
}

func TestValidateWithRego(t *testing.T) {
	testdataDir := "./testdata"
	testCases := []validateWithRegoTestCase{
		{
			name:          "valid input and policy",
			inputContent:  "deployment.json",
			regoPolicy:    "/rego/test",
			expectedError: false,
		},
		{
			name:          "valid input and invalid policy",
			inputContent:  "deployment.json",
			regoPolicy:    "/rego/k8s-invalid.rego",
			expectedError: true,
		},
		{
			name:          "Invalid input and valid policy",
			inputContent:  "deployment-invalid.json",
			regoPolicy:    "/rego/k8s.rego",
			expectedError: true,
		},
	}

	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			inputFilePath := filepath.Join(testdataDir, tc.inputContent)
			regoPolicyPath := filepath.Join(testdataDir, tc.regoPolicy)

			// Call the function under test
			err := ValidateWithRego(inputFilePath, regoPolicyPath)

			if tc.expectedError {
				assert.Error(t, err)
			} else {
				assert.NoError(t, err)
			}
		})
	}
}
