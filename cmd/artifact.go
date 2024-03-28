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

Authentication is necessary for all commands related to managing artifacts within registries. By default,
the system retrieves credentials from the default keychain located at "~/.docker/config.json".
However, if such a keychain is not available, users can alternatively provide their own credentials using environment variables.
To do so, set the required credentials as environment variables in the following format:

export ARTIFACT_REGISTRY_USERNAME=<your username>
export ARTIFACT_REGISTRY_PASSWORD=<your password>
`,
}

func init() {
	rootCmd.AddCommand(artifactCmd)
}
