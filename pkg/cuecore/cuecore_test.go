package cuecore

import (
	"os"
	"strings"
	"testing"

	embeder "github.com/intelops/genval"
	"github.com/intelops/genval/pkg/utils"

	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
)

func TestBuildInstance(t *testing.T) {
	tests := []struct {
		name           string
		schemaContent  string
		expectError    bool
		expectedErrMsg string
	}{
		{
			name: "ValidSchema",
			schemaContent: `package schema

                            field: "value"`,
			expectError: false,
		},
		// {
		// 	name: "InvalidSchema",
		// 	schemaContent: `package schema

		// 					name 123`,
		// 	expectError: true,
		// },
		// Further tests can be added as needed...
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Setup a temporary directory
			td, err := os.MkdirTemp("", "testdata")
			if err != nil {
				t.Fatal(err)
			}
			defer os.RemoveAll(td)

			schemaFilePath := td + "/schema.cue"
			os.WriteFile(schemaFilePath, []byte(tt.schemaContent), 0644)

			staticFS := embeder.CueDef
			modPath := "github.com/intelops/genval"

			overlay, err := utils.GenerateOverlay(staticFS, td, []string{schemaFilePath})
			if err != nil {
				t.Fatal(err)
			}

			conf := &load.Config{
				Dir:     td,
				Overlay: overlay,
				Module:  modPath,
			}

			ctx := cuecontext.New()

			// Call the BuildInstance function
			v, err := BuildInstance(ctx, modPath, conf)
			if err != nil {
				t.Fatalf("Unexpected error: %v", err)
			}

			if len(v) > 0 {
				for _, value := range v {
					if value.Err() != nil {
						err = value.Err()
						break
					}
				}
			}

			if tt.expectError {
				if err == nil {
					t.Fatal("Expected an error, but got none")
				}
				if tt.expectedErrMsg != "" && !strings.Contains(err.Error(), tt.expectedErrMsg) {
					t.Fatalf("Expected error to contain '%s', but got: %v", tt.expectedErrMsg, err)
				}
			} else if err != nil {
				t.Fatalf("Expected no error, but got: %v", err)
			}
		})
	}
}
