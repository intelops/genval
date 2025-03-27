package cmd

import (
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/regx"
)

type regxSearchFlags struct {
	reqinput string
	policy   string
}

var regxSearchArgs regxSearchFlags

func init() {
	regxSearchCmd.Flags().StringVarP(&regxSearchArgs.reqinput, "reqinput", "r", "", "Input file for validating against regex pattern")
	if err := terraformCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	regxSearchCmd.Flags().StringVarP(&regxSearchArgs.policy, "policy", "p", "", "Path for the RegeX policy YAML file, polciy can be passed from either Local or from remote URL")
	rootCmd.AddCommand(regxSearchCmd)
}

var regxSearchCmd = &cobra.Command{
	Use:   "regx",
	Short: "Validate resource files with Regex policy match",
	Long:  `Validates any type of file and scans for any sensitive keywords defined in the policy YAML file`,
	Example: `
# Validate resource files with Regex policies

	$ genval regx --reqinput ./templates/input/k8s/deployment.json \
  --policy ./templates/defaultpolicies/regex/policy.yaml
	`,
	RunE: runRegxSearchCmd,
}

func runRegxSearchCmd(cmd *cobra.Command, args []string) error {
	inputFile := regxSearchArgs.reqinput
	policy := regxSearchArgs.policy

	// Load the regex patterns from the policy file
	var patternConfig regx.PatternConfig
	if err := regx.ReadRegxPolicy(policy, &patternConfig); err != nil {
		log.Fatalf("Error reading policy YAML: %v", err)
	}

	// Perform the regex validation on the resource file
	isPass := regx.ScanResourceFile(inputFile, patternConfig.Spec.Pattern)

	// Determine the result and print the table
	result := "Pass"
	if !isPass {
		result = "Fail: Sensitive information found."
	}

	// Print the metadata and result in a table
	regx.PrintResultTable(patternConfig.Metadata, result)

	return nil
}
