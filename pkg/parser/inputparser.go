package parser

import (
	"encoding/json"
	"errors"
	"path/filepath"
	"strings"

	gyaml "github.com/ghodss/yaml"
	log "github.com/sirupsen/logrus"
	"gopkg.in/yaml.v3"

	"github.com/intelops/genval/pkg/utils"
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

func ParseDockerfileInput(filename string, data interface{}) error {
	fileExtension := filepath.Ext(filename)
	fileExtension = strings.TrimPrefix(fileExtension, ".")

	inputContent, err := utils.ReadFile(filename)
	if err != nil {
		log.Fatalf("Unable to read input: %v", err)
	}
	switch strings.ToLower(fileExtension) {
	case "yaml", "yml":
		err = yaml.Unmarshal(inputContent, data)
	case "json":
		err = json.Unmarshal(inputContent, data)
	default:
		return errors.New("unsupported file format: " + fileExtension)
	}

	if err != nil {
		return err
	}

	return nil
}

// isJSON checks if the input string is JSON.
func IsJSON(str string) bool {
	var js json.RawMessage
	return json.Unmarshal([]byte(str), &js) == nil
}

// // convertYAMLToJSON converts YAML data to JSON.
// func convertYAMLToJSON(data []byte) ([]byte, error) {
// 	var obj map[string]interface{}
// 	err := yaml.Unmarshal(data, &obj)
// 	if err != nil {
// 		return nil, err
// 	}
// 	return json.Marshal(obj)
// }

// processData processes the input and returns JSON data.
func ProcessInput(input string) ([]byte, error) {
	var data []byte
	var err error

	if IsJSON(input) {
		data = []byte(input)
	} else {
		data, err = utils.ReadFile(input)
		if err != nil {
			return nil, err
		}
		if !IsJSON(string(data)) {
			data, err = gyaml.YAMLToJSON(data)
			if err != nil {
				return nil, err
			}
		}
	}

	return data, nil
}
