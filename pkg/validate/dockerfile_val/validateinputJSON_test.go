package validate

import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestValidateInput(t *testing.T) {
	// Load the test policy
	regoPolicy, err := os.ReadFile("inputFilePolicies.rego")
	if err != nil {
		t.Fatalf("Failed to read rego policy: %v", err)
	}
	regoPolicyContent := string(regoPolicy)

	tests := []struct {
		name       string
		inputFile  string
		regoPolicy string
		wantError  bool
		errorMsg   string
	}{
		{
			name:       "Valid YAML input",
			inputFile:  "testData/multiStage.yaml",
			regoPolicy: regoPolicyContent,
			wantError:  false,
		},
		{
			name:       "Valid YAML input",
			inputFile:  "testData/multiStage.json",
			regoPolicy: regoPolicyContent,
			wantError:  false,
		},
		{
			name:       "Valid YAML input",
			inputFile:  "testData/singleStage.yaml",
			regoPolicy: regoPolicyContent,
			wantError:  true,
		},
		{
			name:       "Valid YAML input",
			inputFile:  "testData/singleStage.json",
			regoPolicy: regoPolicyContent,
			wantError:  true,
		},
		{
			name:       "Valid YAML input",
			inputFile:  "testData/trustedImage.yaml",
			regoPolicy: regoPolicyContent,
			wantError:  false,
		},
		{
			name:       "Valid YAML input",
			inputFile:  "testData/trustedImage.json",
			regoPolicy: regoPolicyContent,
			wantError:  false,
		},
		{
			name:       "Valid YAML input",
			inputFile:  "testData/unTrustedImage.yaml",
			regoPolicy: regoPolicyContent,
			wantError:  true,
		},
		{
			name:       "Valid YAML input",
			inputFile:  "testData/unTrustedImage.json",
			regoPolicy: regoPolicyContent,
			wantError:  true,
		},
		// Add more test scenarios
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			inputContent, err := os.ReadFile(tt.inputFile)
			if err != nil {
				t.Fatalf("Failed to read input file: %v", err)
			}

			err = ValidateInput(string(inputContent), tt.regoPolicy)
			if tt.wantError {
				assert.Error(t, err)
				if tt.errorMsg != "" {
					assert.Contains(t, err.Error(), tt.errorMsg)
				}
			} else {
				assert.NoError(t, err)
			}
		})
	}
}
