package parser

import (
	"encoding/json"
	"errors"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/intelops/genval/pkg/utils"
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

func ParseDockerfileInput(filename string, data interface{}) error {
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

// isJSON checks if the input string is JSON.
func isJSON(str string) bool {
	var js json.RawMessage
	return json.Unmarshal([]byte(str), &js) == nil
}

// readData reads data from a URL or a local file.
func readData(input string) ([]byte, error) {
	if utils.IsURL(input) {
		resp, err := http.Get(input)
		if err != nil {
			return nil, err
		}
		defer resp.Body.Close()
		return io.ReadAll(resp.Body)
	}
	return os.ReadFile(input)
}

// convertYAMLToJSON converts YAML data to JSON.
func convertYAMLToJSON(data []byte) ([]byte, error) {
	var obj interface{}
	err := yaml.Unmarshal(data, &obj)
	if err != nil {
		return nil, err
	}
	return json.Marshal(obj)
}

// processData processes the input and returns JSON data.
func ProcessInput(input string) ([]byte, error) {
	var data []byte
	var err error

	if isJSON(input) {
		data = []byte(input)
	} else {
		data, err = readData(input)
		if err != nil {
			return nil, err
		}
		if !isJSON(string(data)) {
			data, err = convertYAMLToJSON(data)
			if err != nil {
				return nil, err
			}
		}
	}

	return data, nil
}
