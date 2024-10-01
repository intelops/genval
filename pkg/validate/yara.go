package validate

import (
	"fmt"
	"log"
	"os"
	"path/filepath"

	yara "github.com/hillu/go-yara/v4"
)

// printMatches handles printing matched rules in a simple format.
func printMatches(item string, m yara.MatchRule, err error) {
	if err != nil {
		log.Printf("%s: error: %s", item, err)
		return
	}
	if len(m.Matches) == 0 {
		log.Printf("%s: no matches", item)
		return
	}

	fmt.Printf("%s: Matched rule: %s:%s\n", item, m.Namespace, m.Rule)
}

// compileYARARules compiles YARA rules from provided files and returns the compiled rules.
func compileYARARules(ruleFilePaths []string) (*yara.Rules, error) {
	compiler, err := yara.NewCompiler()
	if err != nil {
		return nil, fmt.Errorf("failed to create YARA compiler: %w", err)
	}

	for _, ruleFile := range ruleFilePaths {
		f, err := os.Open(ruleFile)
		if err != nil {
			return nil, fmt.Errorf("failed to open YARA rule file: %w", err)
		}
		defer f.Close()

		// Add the file to the compiler
		if err := compiler.AddFile(f, ""); err != nil {
			return nil, fmt.Errorf("failed to add file to compiler: %w", err)
		}
	}

	rules, err := compiler.GetRules()
	if err != nil {
		return nil, fmt.Errorf("failed to compile YARA rules: %w", err)
	}

	return rules, nil
}

// scanFile scans a file using the provided YARA rules and prints any matched rules.
func scanFile(filename string, rules *yara.Rules) error {
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
	for _, match := range matches {
		printMatches(filename, match, nil)
	}

	return nil
}

func main() {
	if len(os.Args) < 3 {
		fmt.Printf("Usage: %s <yara_rules_file> <file_or_directory_to_scan>\n", os.Args[0])
		return
	}

	ruleFiles := []string{os.Args[1]} // YARA rule file
	targetPath := os.Args[2]          // File or directory to scan

	// Compile the YARA rules
	rules, err := compileYARARules(ruleFiles)
	if err != nil {
		log.Fatalf("Error compiling YARA rules: %v", err)
	}

	// If the target is a directory, scan all files inside it
	err = filepath.Walk(targetPath, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() { // Skip directories, only scan regular files
			if scanErr := scanFile(path, rules); scanErr != nil {
				log.Printf("Failed to scan file %s: %v", path, scanErr)
			}
		}
		return nil
	})
	if err != nil {
		log.Fatalf("Failed to walk directory: %v", err)
	}
}
