package validate

import (
	"testing"
)

// Test case structure
type testCase struct {
	name              string
	dockerfileContent string
	regoPolicyPath    string
	expectedError     bool
	expectedErrorMsg  string
}

// TestValidateDockerfile tests the ValidateDockerfile function
func TestValidateDockerfile(t *testing.T) {
	// Define test cases
	tests := []testCase{
		{
			name:              "Valid Dockerfile and Policy",
			dockerfileContent: "./testdata/multistage.json",
			regoPolicyPath:    "./testdata/rego/multi_stage.rego",
			expectedError:     false,
		},
		{
			name:              "Invalid Policy Path",
			dockerfileContent: "./testdata/singlestage.json",
			regoPolicyPath:    "./invalid/path",
			expectedError:     true,
			expectedErrorMsg:  "error reading the policy file",
		},
		{
			name:              "Empty Dockerfile Content",
			dockerfileContent: "",
			regoPolicyPath:    "./testdata/policies/valid-policy.rego",
			expectedError:     true,
			expectedErrorMsg:  "no Dockerfile content",
		},
		{
			name:              "Valid Dockerfile, Failing Policies",
			dockerfileContent: "./testdata/multistage.json",
			regoPolicyPath:    "./testdata/rego/fail.rego",
			expectedError:     true,
			expectedErrorMsg:  "policy violations found",
		},
		{
			name:              "No Policies Defined",
			dockerfileContent: "./testdata/multistage.json",
			regoPolicyPath:    "",
			expectedError:     true,
			expectedErrorMsg:  "no policies defined",
		},

		// Additional test cases...
	}

	// Iterate over test cases
	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			err := ValidateDockerfile(tc.dockerfileContent, tc.regoPolicyPath)

			if tc.expectedError {
				if err == nil {
					t.Errorf("expected an error, but got none")
				} else if err.Error() != tc.expectedErrorMsg {
					t.Errorf("expected error message '%s', but got '%s'", tc.expectedErrorMsg, err.Error())
				}
			} else if err != nil {
				t.Errorf("did not expect an error, but got %v", err)
			}
		})
	}
}
