package parser

import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestParseYAMLContent(t *testing.T) {
	validYAML := `
dockerfile:
- stage: 1
  instructions:
  - run:
    - "echo hello"
- stage: 2
  instructions:
  - run:
    - "echo world"
`
	yamlData, err := ParseYAMLContent(validYAML)
	assert.NoError(t, err)
	if yamlData != nil { // Add a check here to prevent nil pointer dereference
		assert.Equal(t, 2, len(yamlData.Dockerfile))
	}

	invalidYAML := `
dockerfile
  - stage: 1
    instructions:
      run: ["echo hello"]
`
	_, err = ParseYAMLContent(invalidYAML)
	assert.Error(t, err)
}

func TestReadAndParseFile(t *testing.T) {
	// Create temp yaml file
	yamlFile, _ := os.CreateTemp("", "test*.yaml")
	_, err := yamlFile.WriteString(`
dockerfile:
- stage: 1
  instructions:
  - run:
    - "echo hello"
- stage: 2
  instructions:
  - run:
    - "echo world"
`)
	assert.NoError(t, err)
	defer os.Remove(yamlFile.Name())

	// Read and parse YAML file
	var yamlData InputYAML
	err = ReadAndParseFile(yamlFile.Name(), &yamlData)
	assert.NoError(t, err)
	assert.Equal(t, 2, len(yamlData.Dockerfile))

	// Create temp json file
	jsonFile, _ := os.CreateTemp("", "test*.json")
	_, err = jsonFile.WriteString(`{"dockerfile":[{"stage":1,"instructions":[{"run":["echo hello"]}]},{"stage":2,"instructions":[{"run":["echo world"]}]}]}`)
	assert.NoError(t, err)
	defer os.Remove(jsonFile.Name())

	// Read and parse JSON file
	var jsonData InputYAML
	err = ReadAndParseFile(jsonFile.Name(), &jsonData)
	assert.NoError(t, err)
	assert.Equal(t, 2, len(jsonData.Dockerfile))

	// Test unsupported file format
	unsupportedFile, _ := os.CreateTemp("", "test*.txt")
	defer os.Remove(unsupportedFile.Name())
	err = ReadAndParseFile(unsupportedFile.Name(), &jsonData)
	assert.Error(t, err)
	assert.Equal(t, "unsupported file format: txt", err.Error())

	// Test file read error
	err = ReadAndParseFile("nonexistentfile.yaml", &jsonData)
	assert.Error(t, err)
}
