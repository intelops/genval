package cmd

import (
	"os"

	"github.com/intelops/genval/pkg/log"
	"github.com/spf13/cobra"
)

// rootCommand returns a cobra command for genvalctl CLI tool
func rootCommand() *cobra.Command {
	return &cobra.Command{
		Use:     "genvalctl",
		Aliases: []string{"gvctl"},
		Version: "0.0.1",
		Short:   "genvalctl is a CLI tool to generate and validate files",
		Long: `
		░██████╗░███████╗███╗░░██╗██╗░░░██╗░█████╗░██╗░░░░░░█████╗░████████╗██╗░░░░░
		██╔════╝░██╔════╝████╗░██║██║░░░██║██╔══██╗██║░░░░░██╔══██╗╚══██╔══╝██║░░░░░
		██║░░██╗░█████╗░░██╔██╗██║╚██╗░██╔╝███████║██║░░░░░██║░░╚═╝░░░██║░░░██║░░░░░
		██║░░╚██╗██╔══╝░░██║╚████║░╚████╔╝░██╔══██║██║░░░░░██║░░██╗░░░██║░░░██║░░░░░
		╚██████╔╝███████╗██║░╚███║░░╚██╔╝░░██║░░██║███████╗╚█████╔╝░░░██║░░░███████╗
		░╚═════╝░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░╚════╝░░░░╚═╝░░░╚══════╝

genvalctl is a CLI tool to generate and validate files.
		`,
	}
}

// buildCommand creates and returns the root command for the CLI application.
func buildCommand() *cobra.Command {
	rootCmd := rootCommand()

	return rootCmd
}

// Execute runs the root command and handles any errors.
func Execute() {
	// Get a logger instance
	logger := log.GetLogger()

	// Build the root command
	rootCmd := buildCommand()

	// Execute the root command
	err := rootCmd.Execute()

	// Handle any errors
	if err != nil {
		logger.Errorf("Command failed: %v", err)
		os.Exit(1)
	}
}
