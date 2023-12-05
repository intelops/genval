package validate

import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestValidateInput(t *testing.T) {

	regoPolicyContent := "./testdata/rego/inputfile_policies.rego"
	tests := []struct {
		name       string
		inputFile  string
		regoPolicy string
		wantError  bool
		errorMsg   string
	}{
		{
			name:       "Valid YAML input",
			inputFile:  "./testdata/multistage.yaml",
			regoPolicy: regoPolicyContent,
			wantError:  false,
		},
		{
			name:       "Valid JSON input",
			inputFile:  "./testdata/multistage.json",
			regoPolicy: regoPolicyContent,
			wantError:  false,
		},
		{
			name:       "Invalid YAML input",
			inputFile:  "./testdata/singlestage.yaml",
			regoPolicy: regoPolicyContent,
			wantError:  true,
		},
		{
			name:       "Invalid JSON input",
			inputFile:  "./testdata/singlestage.json",
			regoPolicy: regoPolicyContent,
			wantError:  true,
		},
		{
			name:       "Valid YAML input",
			inputFile:  "./testdata/trustedimage.yaml",
			regoPolicy: regoPolicyContent,
			wantError:  false,
		},
		{
			name:       "Valid YAML input",
			inputFile:  "./testdata/trustedimage.json",
			regoPolicy: regoPolicyContent,
			wantError:  false,
		},
		{
			name:       "Invalid YAML input",
			inputFile:  "./testdata/untrustedimage.yaml",
			regoPolicy: regoPolicyContent,
			wantError:  true,
		},
		{
			name:       "Invalid JSON input",
			inputFile:  "./testdata/untrustedimage.json",
			regoPolicy: regoPolicyContent,
			wantError:  true,
		},
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
