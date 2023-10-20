package cuecore

import (
	"os"
	"testing"

	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
)

func TestIntegration(t *testing.T) {
	// Setting up a basic schema and data for the test
	schemaContent := `package test

field: string
`
	dataContent := `package test

field: "Hello, World!"
`

	// 1. Write schema and data to temp files
	td, err := os.MkdirTemp("", "integration_test")
	if err != nil {
		t.Fatal(err)
	}
	defer os.RemoveAll(td)

	os.WriteFile(td+"/schema.cue", []byte(schemaContent), 0644)
	os.WriteFile(td+"/data.cue", []byte(dataContent), 0644)

	conf := &load.Config{
		Dir:     td,
		Module:  "test",
		Package: "*",
	}

	ctx := cuecontext.New()

	// 2. Use BuildInstance function to build the instances
	values, err := BuildInstance(ctx, "test", conf)
	if err != nil {
		t.Fatalf("Failed to build instance: %v", err)
	}

	if len(values) != 2 { // one for schema and one for data
		t.Fatalf("Expected 2 values but got %d", len(values))
	}

	// 3. Unify the values using UnifyAndValidate function
	unified, err := UnifyAndValidate(values[0], values[1])
	if err != nil {
		t.Fatalf("Failed to unify and validate values: %v", err)
	}

	// 4. Convert the result to YAML using MarshalToYAML function
	yamlData, err := MarshalToYAML(unified)
	if err != nil {
		t.Fatalf("Failed to marshal to YAML: %v", err)
	}

	expectedYAML := "field: Hello, World!\n"
	if string(yamlData) != expectedYAML {
		t.Fatalf("Expected YAML content %q but got %q", expectedYAML, string(yamlData))
	}
}
