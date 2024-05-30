package cmd

import (
	"fmt"
	"runtime"

	"github.com/containerd/containerd/platforms"
	"github.com/fatih/color"
	"github.com/intelops/genval/pkg/utils"
	"github.com/spf13/cobra"
)

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Prints Genval version information",
	Long:  `All software has versions. This is Genval's`,
	Run: func(cmd *cobra.Command, args []string) {
		version, commitHash, buildTime, err := utils.FetchVersionInfo()
		if err != nil {
			return
		}
		color.New(color.FgHiCyan, color.Bold).Println(`
		:'######:::'########:'##::: ##:'##::::'##::::'###::::'##:::::::
		:##... ##:: ##.....:: ###:: ##: ##:::: ##:::'## ##::: ##:::::::
		:##:::..::: ##::::::: ####: ##: ##:::: ##::'##:. ##:: ##:::::::
		:##::'####: ######::: ## ## ##: ##:::: ##:'##:::. ##: ##:::::::
		:##::: ##:: ##...:::: ##. ####:. ##:: ##:: #########: ##:::::::
		:##::: ##:: ##::::::: ##:. ###::. ## ##::: ##.... ##: ##:::::::
		: ######::: ########: ##::. ##:::. ###:::: ##:::: ##: ########:
		:......::::........::..::::..:::::...:::::..:::::..::........::

		genval is a CLI tool to generate and validate configuration files

		`)
		fmt.Printf("Version:\t%s\n", version)
		fmt.Printf("Git Commit:\t%s\n", commitHash)
		fmt.Printf("OS/Arch:\t%s/%s\n", runtime.GOOS, runtime.GOARCH)
		fmt.Printf("Go version:\t%s\n", runtime.Version())
		fmt.Printf("Build date:\t%s\n", buildTime)
		fmt.Printf("Build platform:\t%s\n", platforms.DefaultString())
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
