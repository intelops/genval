package validate

import (
	"fmt"
	"os"

	yara "github.com/hillu/go-yara/v4"

	"github.com/intelops/genval/pkg/utils"
)

func CompileYARARules(rulesFilePath string) (*yara.Rules, error) {
	compiler, err := yara.NewCompiler()
	if err != nil {
		return nil, fmt.Errorf("err creating compiler: %v", err)
	}
	rulesFile, err := os.Open(rulesFilePath)
	if err != nil {
		return nil, fmt.Errorf("error opening Yara Rules file: %v", err)
	}
	defer rulesFile.Close()

	if err := compiler.AddFile(rulesFile, ""); err != nil {
		return nil, fmt.Errorf("error adding rules to YARA compiler: %v", err)
	}
	// Compile the rules
	rules, err := compiler.GetRules()
	if err != nil {
		return nil, fmt.Errorf("error compilinhg rules: %v", err)
	}

	return rules, nil
}

// ScanFile scans the provided input file with compiled YARA rules

func ScanFile(inputFilePath string, rules *yara.Rules) ([]yara.MatchRule, error) {
	// Read inputFilePath

	fileContent, err := utils.ReadFile(inputFilePath)
	if err != nil {
		return nil, fmt.Errorf("error reading input file: %v", err)
	}

	// Scan inputContent
	var matches []yara.MatchRule
	err = rules.ScanFile(fileContent, 0, 0, &matches)
	if err != nil {
		return nil, fmt.Errorf("error matching rules: %v", err)
	}
	return matches, nil
}
