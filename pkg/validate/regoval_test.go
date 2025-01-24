package validate

import (
	"path/filepath"
	"testing"

	"github.com/stretchr/testify/assert"
)

// Helper function to determine the processor type based on the file extension
func getProcessorForInput(inputContent string) InputProcessor {
	if filepath.Ext(inputContent) == ".Dockerfile" {
		return DockerfileProcessor{}
	}
	return GenericProcessor{}
}

type validateWithRegoTestCase struct {
	name          string
	inputContent  string
	regoPolicy    string
	expectedError bool
	takeAction    bool
}

func TestValidateWithRego(t *testing.T) {
	testdataDir := "./testdata"
	testCases := []validateWithRegoTestCase{
		{
			name:          "valid input and policy",
			inputContent:  "deployment.json",
			regoPolicy:    "/rego/test",
			takeAction:    false,
			expectedError: false,
		},
		{
			name:          "valid input and invalid policy",
			inputContent:  "deployment.json",
			regoPolicy:    "/rego/k8s-invalid.rego",
			expectedError: true,
			takeAction:    false,
		},
		{
			name:          "Invalid input and valid policy",
			inputContent:  "deployment-invalid.json",
			regoPolicy:    "/rego/k8s.rego",
			expectedError: true,
			takeAction:    false,
		},
		{
			name:          "valid Dockerfile and policy",
			inputContent:  "Docker-file",
			regoPolicy:    "/rego/dockerfilepolicies/",
			expectedError: false,
			takeAction:    false,
		},
		{
			name:          "invalid Dockerfile and policy",
			inputContent:  "Dockerfile-invalid",
			regoPolicy:    "/rego/docker-invalid.rego",
			expectedError: true,
			takeAction:    false,
		},
	}

	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			inputFilePath := filepath.Join(testdataDir, tc.inputContent)
			regoPolicyPath := filepath.Join(testdataDir, tc.regoPolicy)

			// Determine the appropriate processor
			processor := getProcessorForInput(inputFilePath)

			// Call the function under test
			_, _, err := ValidateWithRego(inputFilePath, regoPolicyPath, processor)

			if tc.expectedError {
				assert.Error(t, err)
			} else {
				assert.NoError(t, err)
			}
		})
	}
}
