package cmd

import (
	"fmt"

	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Print the version number of Genval",
	Long:  `All software has versions. This is Genval's`,
	Run: func(cmd *cobra.Command, args []string) {
		Version, err := utils.GetVersion()
		if err != nil {
			log.Errorf("Error fetching version info: %v", err)
		}
		fmt.Println(Version)
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
