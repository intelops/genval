package validate

import (
	"fmt"
	"log"
	"os"

	yara "github.com/hillu/go-yara/v4"
)

// PrintMatches handles printing matched rules in a simple format.
func printMatches(item string, m yara.MatchRules, err error) {
	if err != nil {
		log.Printf("%s: error: %s", item, err)
		return
	}
	if len(m) == 0 {
		log.Printf("%s: no matches", item)
		return
	}

	for _, match := range m {
		fmt.Printf("%s: Matched rule: %s:%s\n", item, match.Namespace, match.Rule)
	}
}

// CompileYARARules compiles YARA rules from provided files and returns the compiled rules.
func CompileYARARules(ruleFilePaths string) (*yara.Rules, error) {
	compiler, err := yara.NewCompiler()
	if err != nil {
		return nil, fmt.Errorf("failed to create YARA compiler: %w", err)
	}

	// Open the rule file
	f, err := os.Open(ruleFilePaths)
	if err != nil {
		return nil, fmt.Errorf("failed to open YARA rule file: %w", err)
	}
	defer f.Close()

	// Add the file to the compiler
	if err := compiler.AddFile(f, ""); err != nil {
		return nil, fmt.Errorf("failed to add file to compiler: %w", err)
	}

	// Compile the rules
	rules, err := compiler.GetRules()
	if err != nil {
		return nil, fmt.Errorf("failed to compile YARA rules: %w", err)
	}

	return rules, nil
}

// ScanFile scans a file using the provided YARA rules and prints any matched rules.
func ScanFile(filename string, rules *yara.Rules) error {
	scanner, err := yara.NewScanner(rules)
	if err != nil {
		return fmt.Errorf("failed to create YARA scanner: %w", err)
	}

	// Create a variable to hold the match results
	var matches yara.MatchRules

	// Scan the file using YARA rules
	err = scanner.SetCallback(&matches).ScanFile(filename)
	if err != nil {
		return fmt.Errorf("failed to scan file: %w", err)
	}

	// Print the matches
	printMatches(filename, matches, nil)

	return nil
}
