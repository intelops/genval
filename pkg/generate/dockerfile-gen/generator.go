package generate

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	log "github.com/sirupsen/logrus"

	"github.com/go-yaml/yaml"
)

// ParseInputFile reads an input file and unmarshals its content into the provided data struct.
func ParseInputFile(filename string, data interface{}) error {
	fileExtension := filepath.Ext(filename)
	fileExtension = strings.TrimPrefix(fileExtension, ".")

	fileContent, err := os.ReadFile(filename)
	if err != nil {
		return err
	}

	switch strings.ToLower(fileExtension) {
	case "yaml", "yml":
		err = yaml.Unmarshal(fileContent, data)
	case "json":
		err = json.Unmarshal(fileContent, data)
	default:
		return errors.New("unsupported file format: " + fileExtension)
	}

	if err != nil {
		return err
	}

	return nil
}

func GenerateDockerfileContent(data *struct {
	Dockerfile []struct {
		Stage        int                      `yaml:"stage"`
		Instructions []map[string]interface{} `yaml:"instructions"`
	} `yaml:"dockerfile"`
}) string {
	var dockerfileContent strings.Builder

	for i, stageData := range data.Dockerfile {
		stageNumber := stageData.Stage
		instructions := stageData.Instructions

		// Add a blank line before each STAGE
		if i > 0 {
			dockerfileContent.WriteString("\n")
		}

		if stageNumber != 0 {
			dockerfileContent.WriteString(fmt.Sprintf("# STAGE %d\n", stageNumber))
		}

		lastInstruction := ""
		for _, instruction := range instructions {
			for key, value := range instruction {
				if key == "FROM" && len(key) > 1 {
					log.Printf("Can not have more than one FROM instruction")
				}
				instructionLines := formatInstruction(key, value)
				if len(instructionLines) > 0 {
					if key == "RUN" || key == "COPY" {
						if lastInstruction == key {
							dockerfileContent.WriteString(" \\\n")
						} else {
							lastInstruction = key
						}
					} else {
						lastInstruction = ""
					}

					for _, line := range instructionLines {
						dockerfileContent.WriteString(fmt.Sprintf("  %s\n", line))
					}
				}
			}
		}
	}

	return dockerfileContent.String()
}
func formatInstruction(key string, value interface{}) []string {
	var result []string

	if strings.HasPrefix(key, "#") {
		result = append(result, key)
		return result
	}

	if strings.HasPrefix(key, "STAGE") {
		result = append(result, "# "+key)
		return result
	}

	switch strings.ToUpper(key) {
	case "RUN", "COPY":
		values := convertToStrings(value)
		if len(values) > 1 {
			chainedValues := strings.Join(values, " \\\n      && ")
			result = append(result, fmt.Sprintf("%s %s", strings.ToUpper(key), chainedValues))
		} else if len(values) == 1 {
			result = append(result, fmt.Sprintf("%s %s", strings.ToUpper(key), values[0]))
		}
	case "CMD", "ENTRYPOINT":
		values := convertToStrings(value)
		if len(values) > 0 {
			result = append(result, fmt.Sprintf("%s [\"%s\"]", strings.ToUpper(key), strings.Join(values, "\", \"")))
		} else if len(values) == 1 {
			result = append(result, fmt.Sprintf("%s \"%s\"", strings.ToUpper(key), values[0]))
		}
	default:
		values := convertToStrings(value)
		for _, val := range values {
			result = append(result, fmt.Sprintf("%s %s", strings.ToUpper(key), val))
		}
	}

	return result
}

func convertToStrings(value interface{}) []string {
	var result []string

	switch v := value.(type) {
	case string:
		result = append(result, v)
	case []interface{}:
		for _, item := range v {
			result = append(result, fmt.Sprintf("%v", item))
		}
	}

	return result
}
