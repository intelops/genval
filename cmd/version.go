package cmd

import (
	"github.com/fatih/color"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Prints Genval version information",
	Long:  `All software has versions. This is Genval's`,
	Run: func(cmd *cobra.Command, args []string) {
		Version, err := utils.GetVersion()
		if err != nil {
			log.Errorf("Error fetching version info: %v", err)
		}
		color.New(color.FgHiCyan, color.Bold).Println(Version)
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
