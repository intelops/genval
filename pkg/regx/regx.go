package regx

import (
	"fmt"
	"log"
	"os"
	"regexp"

	"github.com/jedib0t/go-pretty/v6/table"
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

// Metadata contains the details from the policy metadata section
type Metadata struct {
	Name        string `yaml:"name"`
	Description string `yaml:"description"`
	Severity    string `yaml:"severity"`
	Benchmark   string `yaml:"benchmark"`
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
	return !scanForPattern(string(content), patterns)
}

// PrintResultTable prints the metadata and result in a formatted table
func PrintResultTable(metadata Metadata, result string) {
	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)

	t.AppendHeader(table.Row{"Name", "Description", "Severity", "Benchmark", "Result"})
	t.AppendRow([]interface{}{
		metadata.Name,
		metadata.Description,
		metadata.Severity,
		metadata.Benchmark,
		result,
	})

	t.Render()
}
