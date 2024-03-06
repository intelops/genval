package cmd

import (
	"github.com/spf13/cobra"
)

var artifactCmd = &cobra.Command{
	Use:   "artifact",
	Short: "Command that manages building, pushing and pulling of OCI artifacts",
	Long: `
artifact command provides capabilities for building and pushing of the OCI complient artifacts built form the
generated/validated config files using Genval.

Currently, Genval provides artifact build, push, and pull commands. Pull and Push commands provides functionality
to sign and verify the artifacts using the Sigstore cosign tool.
`,
}

func init() {
	rootCmd.AddCommand(artifactCmd)
}
