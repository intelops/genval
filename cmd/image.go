package cmd

import (
	"github.com/spf13/cobra"
)

var imageCmd = &cobra.Command{
	Use:   "image",
	Short: "Command that manages building and pushing of container images built from validated Dockerfiles",
	Long: `
image command provides capabilities for building and pushing of thecontainer images built form the
generated/validated Dockerfiles using Genval.

Currently, Genval provides image build and image push commands. Push command provides functionality
to signthe container image using the Sigstore cosign tool.

Authentication is necessary for all commands related to managing container images within registries. By default,
the system retrieves credentials from the default keychain located at "~/.docker/config.json".
However, if such a keychain is not available, users can alternatively provide their own credentials using environment variables.
To do so, set the required credentials as environment variables in the following format:

export ARTIFACT_REGISTRY_USERNAME=<your username>
export ARTIFACT_REGISTRY_PASSWORD=<your password>
`,
}

func init() {
	rootCmd.AddCommand(imageCmd)
}
