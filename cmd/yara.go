package cmd

import (
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type yaraFlags struct {
	reqinput string
	policy   string
}

var yaraArgs yaraFlags

func init() {
	yaraCmd.Flags().StringVarP(&yaraArgs.reqinput, "reqinput", "r", "", "Input JSON/YAML for validating packages with YARA ")
	if err := yaraCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

	yaraCmd.Flags().StringVarP(&yaraArgs.policy, "policy", "p", "", "Path for the YARA policy file, polciy can be passed from either Local or from remote URL")
	rootCmd.AddCommand(yaraCmd)
}

var yaraCmd = &cobra.Command{
	Use:   "yara",
	Short: "Validate packages and files sing YARA policies",
	Long: `A user needs to pass the packages and files YAML/JSON format as reqinput and a set of YARA policies
as a policy file for validation.

The required input file in YAML/JSON format or a policy file can be supplied from either a local file or from
remote URL like https://github.com
 `,
	Example: `
`,
	RunE: runYARACmd,
}

func runYARACmd(cmd *cobra.Command, args []string) error {
	inputFile := yaraArgs.reqinput
	policy := yaraArgs.policy
}
