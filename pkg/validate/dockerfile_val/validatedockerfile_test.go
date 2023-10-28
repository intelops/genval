package validate

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestBaseImage(t *testing.T) {
	content := `
FROM golang-alpine:latest`

	err := ValidateDockerfile(content, "./testdata/rego/dockerfile_policies.rego")
	assert.NotNil(t, err, "Expected error for using untrusted base image")
}

func TestRootUser(t *testing.T) {
	content := `
FROM ubuntu:latest
USER root
`

	err := ValidateDockerfile(content, "./testdata/rego/dockerfile_policies.rego")
	assert.NotNil(t, err, "Expected error for using root user")
}

func TestSudoUsage(t *testing.T) {
	content := `
FROM ubuntu:latest
RUN apt-get update && sudo apt-get install -y curl
`

	err := ValidateDockerfile(content, "./testdata/rego/dockerfile_policies.rego")
	assert.NotNil(t, err, "Expected error for sudo usage")
}

func TestCachedLayers(t *testing.T) {
	content := `
FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl
`

	err := ValidateDockerfile(content, "./testdata/rego/dockerfile_policies.rego")
	assert.NotNil(t, err, "Expected error for not using --no-cache")
}

func TestAddUsage(t *testing.T) {
	content := `
FROM ubuntu:latest
ADD source.txt /destination.txt
`

	err := ValidateDockerfile(content, "./testdata/rego/dockerfile_policies.rego")
	assert.NotNil(t, err, "Expected error for using ADD instead of COPY")
}
