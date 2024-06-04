package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
	"sigs.k8s.io/release-utils/version"
)

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Prints Genval version information",
	Long:  `All software has versions. This is Genval's`,
	Run: func(cmd *cobra.Command, args []string) {
		vCmd := version.Version()
		err := vCmd.RunE(cmd, args)
		if err != nil {
			fmt.Println("Error:", err)
		}
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
