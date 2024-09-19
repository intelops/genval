package regx

import (
	"fmt"
	"log"
	"regexp"

	"gopkg.in/yaml.v2"

	"github.com/intelops/genval/pkg/utils"
)

// PatternConfig represents the input YAML structure for regex patterns
type PatternConfig struct {
	APIVersion string   `yaml:"apiVersion"`
	Metadata   Metadata `yaml:"metadata"`
	Spec       struct {
		Pattern []string `yaml:"pattern"`
	} `yaml:"spec"`
}

type Metadata struct {
	Name string `yaml:"name"`
}

// readYAML reads and parses a YAML file into the provided target structure
func ReadRegxPolicy(path string, target interface{}) error {
	data, err := utils.ReadFile(path)
	if err != nil {
		return err
	}

	if err := yaml.Unmarshal(data, target); err != nil {
		return err
	}
	return nil
}

// scanForPattern scans the content for a specific regex pattern
func scanForPattern(content string, patterns []string) bool {
	for _, pattern := range patterns {
		r := regexp.MustCompile(pattern)
		if r.MatchString(content) {
			fmt.Printf("Pattern found: %s\n", pattern)
			return true
		}
	}
	return false
}

// scanResourceFile reads the provided file and scans it for sensitive info
func ScanResourceFile(resourcePath string, patterns []string) bool {
	content, err := utils.ReadFile(resourcePath)
	if err != nil {
		log.Fatalf("Failed to read the resource file: %v\n", err)
	}

	fmt.Printf("Scanning file: %s\n", resourcePath)
	if scanForPattern(string(content), patterns) {
		fmt.Printf("The resource [%v] contains sensitive pattern: %v", resourcePath, patterns)
		return false // Sensitive pattern found
	}
	fmt.Printf("No sensitive patterns found in resource: [%v]", resourcePath)
	return true // No sensitive patterns found
}
