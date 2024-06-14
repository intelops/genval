package cmd

import (
	"os"

	"github.com/fatih/color"
	"github.com/spf13/cobra"
)

// rootCommand returns a cobra command for genvalctl CLI tool
var rootCmd = &cobra.Command{
	Use:   "genval",
	Short: "An agnostic confiuguration management tool for generating and validating IaC files",
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
	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}
}
