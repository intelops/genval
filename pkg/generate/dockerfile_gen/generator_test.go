package generate

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGenerateDockerfileContent(t *testing.T) {
	inputData := &DockerfileContent{
		Dockerfile: []DockerfileStage{
			{
				Stage: 0,
				Instructions: []map[string]interface{}{
					{"from": []interface{}{"cgr.dev/chainguard/go:latest as builder"}},
					{"env": []interface{}{"APP_HOME=/app"}},
					{"run": []interface{}{"useradd -m -s /bin/bash -d $APP_HOME myappuser"}},
					{"workdir": []interface{}{"$APP_HOME"}},
					{"run": []interface{}{"--no-cache apt-get update", "apt-get clean", "go mod download"}},
					{"copy": []interface{}{"go.mod go.sum $APP_HOME/"}},
					{"copy": []interface{}{"src/ $APP_HOME/src/"}},
					{"run": []interface{}{"CGO_ENABLED=0 go build -o myapp $APP_HOME/src/main.go"}},
				},
			},
			{
				Stage: 1,
				Instructions: []map[string]interface{}{
					{"from": []interface{}{"cgr.dev/chainguard/static:latest"}},
					{"env": []interface{}{"APP_USER=myappuser", "APP_HOME=/app"}},
					{"run": []interface{}{"useradd -m -s /bin/bash -d $APP_HOME $APP_USER"}},
					{"workdir": []interface{}{"$APP_HOME"}},
					{"copy": []interface{}{"--from=builder $APP_HOME/myapp $APP_HOME/myapp"}},
					{"user": []interface{}{"$APP_USER"}},
					{"entrypoint": []interface{}{"./myapp"}},
				},
			},
		},
	}

	expectedOutput := `# STAGE 0
  FROM cgr.dev/chainguard/go:latest as builder
  ENV APP_HOME=/app
  RUN useradd -m -s /bin/bash -d $APP_HOME myappuser
  WORKDIR $APP_HOME
  RUN --no-cache apt-get update \
      && apt-get clean \
      && go mod download
  COPY go.mod go.sum $APP_HOME/
  COPY src/ $APP_HOME/src/
  RUN CGO_ENABLED=0 go build -o myapp $APP_HOME/src/main.go

# STAGE 1
  FROM cgr.dev/chainguard/static:latest
  ENV APP_USER=myappuser
  ENV APP_HOME=/app
  RUN useradd -m -s /bin/bash -d $APP_HOME $APP_USER
  WORKDIR $APP_HOME
  COPY --from=builder $APP_HOME/myapp $APP_HOME/myapp
  USER $APP_USER
  ENTRYPOINT ["./myapp"]
`

	output := GenerateDockerfileContent(inputData)
	assert.Equal(t, expectedOutput, output)
}

func TestFormatInstruction(t *testing.T) {
	tests := []struct {
		key      string
		value    interface{}
		expected []string
	}{
		{
			key:   "RUN",
			value: []interface{}{"apt-get update", "apt-get install -y curl"},
			expected: []string{
				"RUN apt-get update \\\n      && apt-get install -y curl",
			},
		},
		{
			key:      "CMD",
			value:    []interface{}{"python3", "/app/main.py"},
			expected: []string{"CMD [\"python3\", \"/app/main.py\"]"},
		},
		{
			key:      "FROM",
			value:    "ubuntu:20.04",
			expected: []string{"FROM ubuntu:20.04"},
		},
	}

	for _, test := range tests {
		result := formatInstruction(test.key, test.value)
		assert.Equal(t, test.expected, result)
	}
}

func TestConvertToStrings(t *testing.T) {
	tests := []struct {
		input    interface{}
		expected []string
	}{
		{"hello", []string{"hello"}},
		{[]interface{}{"hello", "world"}, []string{"hello", "world"}},
	}

	for _, test := range tests {
		result := convertToStrings(test.input)
		assert.Equal(t, test.expected, result)
	}
}
