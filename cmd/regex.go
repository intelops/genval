package cmd

import (
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/validate"
)

type regexSearchFlags struct {
	reqinput string
	policy   string
}

var regexSearchArgs regexSearchFlags

func init() {
	regexSearchCmd.Flags().StringVarP(&regexSearchArgs.reqinput, "reqinput", "r", "", "Input file for validating against regex pattern")
	if err := regexSearchCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	regexSearchCmd.Flags().StringVarP(&regexSearchArgs.policy, "policy", "p", "", "Path for the RegeX policy file, polciy can be passed from either Local or from remote URL")
	rootCmd.AddCommand(regexSearchCmd)
}

var regexSearchCmd = &cobra.Command{
	Use:   "regex",
	Short: "Validate resource files with Regex policy match",
	Long:  ``,
	Example: `
# Validate resource files with Regex policies
genval regex --reqinput ./templates/inputs/k8s/deployment.json \
  --policy ./templates/defaultpolicies/regex/policy.yaml
	`,
	RunE: runRegexSearchCmd,
}

func runRegexSearchCmd(cmd *cobra.Command, args []string) error {
	inputFile := regexSearchArgs.reqinput
	policy := regexSearchArgs.policy

	// Load the regex patterns from the policy file
	var patternConfig validate.PatternConfig
	if err := validate.ReadRegxPolicy(policy, &patternConfig); err != nil {
		log.Fatalf("Error reading policy YAML: %v", err)
	}

	// Perform the regex validation on the resource file
	isPass := validate.ScanResourceFile(inputFile, patternConfig.Spec.Pattern)

	// Determine the result and print the table
	result := "Pass"
	if !isPass {
		result = "Fail: Sensitive information found."
	}

	// Print the metadata and result in a table
	validate.PrintResultTable(patternConfig.PolicyMetadata, result)

	return nil
}
