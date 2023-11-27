package validate

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestEvaluateCEL(t *testing.T) {
	// Define a struct for test cases
	type testCase struct {
		name     string
		input    string
		policy   string
		expected string
		err      bool
	}

	// Create a slice of test cases
	testCases := []testCase{
		{
			name:     "valid input with a valid policy",
			input:    `{"key": "value"}`,
			policy:   `input.key == "value"`,
			expected: "Passed",
			err:      false,
		},
		{
			name:   "valid input with an invalid policy",
			input:  `{"key": "value"}`,
			policy: `input.invalidKey == "value"`,
			err:    true,
		},
		{
			name:   "empty input with a valid policy",
			input:  `{}`,
			policy: `input.key == "value"`,
			err:    true, // Expect an error due to missing key
		},
		{
			name:   "input with a policy that contains invalid syntax",
			input:  `{"key": "value"}`,
			policy: `input.key ==`,
			err:    true,
		},
		{
			name:     "input with a policy that contains invalid types",
			input:    `{"key": 123}`,
			policy:   `input.key == "value"`,
			expected: "Failed", // Expect a result of "Failed" if no error is thrown
			err:      false,
		},
		{
			name:   "input with a policy that contains invalid functions",
			input:  `{"key": "value"}`,
			policy: `input.key.invalidFunction()`,
			err:    true,
		},
	}

	// Iterate over test cases
	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			result, err := evaluateCEL(tc.input, tc.policy)

			if tc.err {
				assert.Error(t, err)
			} else {
				assert.NoError(t, err)
				assert.Equal(t, tc.expected, result)
			}
		})
	}
}
