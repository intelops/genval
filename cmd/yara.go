package cmd

import (
	"os"
	"path/filepath"

	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/validate"
)

var yaraCmd = &cobra.Command{
	Use:   "yara",
	Short: "Validate packages and files using YARA policies",
	Long: `A user needs to pass the packages and files YAML/JSON format as reqinput and a set of YARA policies
as a policy file for validation.

The required input file in YAML/JSON format or a policy file can be supplied from either a local file or from
a remote URL like https://github.com`,
	Example: `
	# Example usage:
	genval yara --reqinput ./input.yaml --policy ./rules.yar`,
	RunE: runYARACmd,
}

type yaraFlags struct {
	reqinput string
	policy   string
}

var yaraArgs yaraFlags

func init() {
	yaraCmd.Flags().StringVarP(&yaraArgs.reqinput, "reqinput", "r", "", "Input JSON/YAML for validating packages with YARA")
	yaraCmd.Flags().StringVarP(&yaraArgs.policy, "policy", "p", "", "Path for the YARA policy file, policy can be passed from either Local or from remote URL")
	rootCmd.AddCommand(yaraCmd)
}

func runYARACmd(cmd *cobra.Command, args []string) error {
	inputFile := yaraArgs.reqinput
	policy := yaraArgs.policy

	// Compile the YARA rules
	rules, err := validate.CompileYARARules(policy)
	if err != nil {
		log.Fatalf("Error compiling YARA rules: %v", err)
	}

	// If the target is a directory, scan all files inside it
	err = filepath.Walk(inputFile, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() { // Skip directories, only scan regular files
			if scanErr := validate.ScanFile(path, rules); scanErr != nil {
				log.Printf("Failed to scan file %s: %v", path, scanErr)
			}
		}
		return nil
	})
	if err != nil {
		log.Fatalf("Failed to walk directory: %v", err)
	}

	return nil
}
