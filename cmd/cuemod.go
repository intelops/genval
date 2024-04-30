package cmd

import (
	"github.com/spf13/cobra"
)

var cuemodCmd = &cobra.Command{
	Use:   "cuemod",
	Short: "cuemod command manages workspace for interacting with Cue valoidation and generation",
}

func init() {
	rootCmd.AddCommand(cuemodCmd)
}
