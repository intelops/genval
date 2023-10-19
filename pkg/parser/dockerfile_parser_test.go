package parser

import (
	"encoding/json"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestParseDockerfileContent(t *testing.T) {
	validDockerfile := `
FROM ubuntu:20.04
RUN apt-get update && apt-get install -y curl
LABEL version="1.0"
`

	instructions := ParseDockerfileContent(validDockerfile)
	assert.Equal(t, 3, len(instructions))
	assert.Equal(t, "from", instructions[0].Cmd)
	assert.Equal(t, "ubuntu:20.04", instructions[0].Value)
	assert.Equal(t, "run", instructions[1].Cmd)
	assert.Equal(t, "apt-get update && apt-get install -y curl", instructions[1].Value)
	assert.Equal(t, "label", instructions[2].Cmd)
	assert.Equal(t, `version="1.0"`, instructions[2].Value)

	// Check JSON validity
	jsonData, err := json.Marshal(instructions)
	assert.NoError(t, err)

	var unmarshaled []DockerfileInstruction
	err = json.Unmarshal(jsonData, &unmarshaled)
	assert.NoError(t, err)
	assert.Equal(t, instructions, unmarshaled)

	edgeCaseDockerfile := `
FROM 
LABEL
SINGLE_WORD
`

	// Should skip lines with no values
	instructionsEdge := ParseDockerfileContent(edgeCaseDockerfile)
	assert.Equal(t, 0, len(instructionsEdge))
	// Should return empty slice for empty content
	emptyDockerfile := ""
	instructionsEmpty := ParseDockerfileContent(emptyDockerfile)
	assert.Equal(t, 0, len(instructionsEmpty))
}
