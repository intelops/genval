package parser

import (
	"testing"

	"cuelang.org/go/cue/cuecontext"

	"github.com/stretchr/testify/assert"
)

func TestCueToYAML(t *testing.T) {
	tests := []struct {
		name      string
		input     string
		expected  string
		expectErr bool
	}{
		{
			name:     "valid cue to YAML conversion",
			input:    `field: "value"`,
			expected: "field: value\n",
		},
		{
			name:      "invalid cue input",
			input:     `field: `,
			expectErr: true,
		},
		{
			name:     "empty cue input",
			input:    ``,
			expected: "{}\n",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			ctx := cuecontext.New()
			val := ctx.CompileString(tt.input)

			// if val contains errors, it should be checked against the expected error in the testcase
			if val.Err() != nil {
				if tt.expectErr {
					assert.Error(t, val.Err())
				} else {
					t.Fatalf("Unexpected error: %v", val.Err())
				}
				return
			}

			result, err := CueToYAML(val)
			if tt.expectErr {
				assert.Error(t, err)
			} else {
				assert.NoError(t, err)
				assert.Equal(t, tt.expected, string(result))
			}
		})
	}
}
