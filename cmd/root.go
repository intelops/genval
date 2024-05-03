package cmd

import (
	"os"

	"github.com/fatih/color"
	"github.com/spf13/cobra"
)

// rootCommand returns a cobra command for genvalctl CLI tool
var rootCmd = &cobra.Command{
	Use:   "genval",
	Short: "genval is a CLI tool to generate and validate configuration files",
	Long: `
	Genval is a versatile Go utility that simplifies configuration management by generating and validating configuration files
	for a wide range of tools. It supports various file types, including Dockerfile, Kubernetes manifests,
	custom resource definition (CRD) manifests, Terraform files, and more.
`,
}

func init() {
	rootCmd.SetOut(color.Output)
	rootCmd.SetErr(color.Error)
}

func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}
