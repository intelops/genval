package parser

import (
	"encoding/json"
	"errors"
	"os"
	"path/filepath"
	"strings"

	"gopkg.in/yaml.v3"
)

type InputInstruction map[string][]string

type InputStage struct {
	Instructions []InputInstruction `yaml:"instructions"`
	Stage        int                `yaml:"stage"`
}

type InputYAML struct {
	Dockerfile []InputStage `yaml:"dockerfile"`
}

func ParseYAMLContent(yamlContent string) (*InputYAML, error) {
	var inputfileYAML InputYAML
	err := yaml.Unmarshal([]byte(yamlContent), &inputfileYAML)
	if err != nil {
		return nil, err
	}
	return &inputfileYAML, nil
}

func ReadAndParseFile(filename string, data interface{}) error {
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
