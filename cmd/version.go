package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var (
	VERSION    = "0.0.1"
	versionCmd = &cobra.Command{
		Use:   "version",
		Short: "Print the version number of Genval",
		Long:  `All software has versions. This is Genval's`,
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Genval version: v%v\n", VERSION)
		},
	}
)

func init() {
	rootCmd.AddCommand(versionCmd)
}
