package validate

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

// func TestBaseImageTrustworthiness(t *testing.T) {
// 	tests := []struct {
// 		name      string
// 		content   string
// 		expectErr bool
// 	}{
// 		{
// 			name:      "Trusted base image from cgr.dev",
// 			content:   `FROM cgr.dev/chainguard/clang:latest`,
// 			expectErr: false,
// 		},
// 		{
// 			name:      "Untrusted base image",
// 			content:   `FROM golang-alpine:latest`,
// 			expectErr: true,
// 		},
// 	}

// 	for _, tt := range tests {
// 		t.Run(tt.name, func(t *testing.T) {
// 			err := ValidateDockerfile(tt.content, DockerfilePolicy)
// 			if tt.expectErr {
// 				assert.Nil(t, err, "Expected no error for: %s", tt.name)
// 			} else {
// 				assert.NotNil(t, err, "Expected an error for: %s", tt.name)
// 			}
// 		})
// 	}
// }

func TestBaseImage(t *testing.T) {
	content := `
FROM golang-alpine:latest`

	err := ValidateDockerfile(content, DockerfilePolicy)
	assert.NotNil(t, err, "Expected error for using untrusted base image")
}

func TestRootUser(t *testing.T) {
	content := `
FROM ubuntu:latest
USER root
`

	err := ValidateDockerfile(content, DockerfilePolicy)
	assert.NotNil(t, err, "Expected error for using root user")
}

func TestSudoUsage(t *testing.T) {
	content := `
FROM ubuntu:latest
RUN apt-get update && sudo apt-get install -y curl
`

	err := ValidateDockerfile(content, DockerfilePolicy)
	assert.NotNil(t, err, "Expected error for sudo usage")
}

func TestCachedLayers(t *testing.T) {
	content := `
FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl
`

	err := ValidateDockerfile(content, DockerfilePolicy)
	assert.NotNil(t, err, "Expected error for not using --no-cache")
}

func TestAddUsage(t *testing.T) {
	content := `
FROM ubuntu:latest
ADD source.txt /destination.txt
`

	err := ValidateDockerfile(content, DockerfilePolicy)
	assert.NotNil(t, err, "Expected error for using ADD instead of COPY")
}
