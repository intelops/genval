package cmd

import (
	"context"
	"fmt"
	"os"
	"path/filepath"

	"github.com/fatih/color"

	"github.com/intelops/genval/pkg/oci"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var pullCmd = &cobra.Command{
	Use:   "pull",
	Short: "The artifact pull command verifies and pulls the artifact from container registry ",
	Long: `
The artifact pull command pull the artifact stored in the remote container registry.
If --verify flag is set to true (false by default), Genval will verify the artifact's signature
which is signed by Cosign in Keyless mode and pull the artifact, and unpack the tar.gz archive in desired path.

To facilitate authentication with OCI compliant container registries,
Users can provide credentials through --creds flag. The creds can be provided via <USER:PAT> or <REGISTRY_PAT> format.
If no credentials are provided, Genval searches for the "./docker/config.json" file in the user's $HOME directory.
If this file is found, Genval utilizes it for authentication.


`,
	Example: `
# Verify the Cosign signature and Pull the artifact in Keyless mode
  and unpack the archive in desired path
# https://github.com/sigstore/cosign/blob/main/KEYLESS.md.

./genval artifact pull --dest ghcr.io/santoshkal/artifacts/genval:test \
--path ./output \
--verify true

# User can also pull the artifact by providing the Cosign generated public-key
  and unpack the archive in desired path

./genval artifact pull --dest ghcr.io/santoshkal/artifacts/genval:no-sign \
--path ./output \
--verify true \
--pub-key ./cosign/cosign.pub
--credentials <GITHUB_PAT> or <USER:PAT>

# Uses can also pull the artifact with verifying the signatures of the artifact
  in the container registry and unpack the archive in desired path

./genval artifact pull --dest ghcr.io/santoshkal/artifacts/genval:test \
--path ./output
// No credentials provided, will default to $HOME/.docker/config.json for credentials
`,
	RunE: runPullArtifactCmd,
}

type pullFlags struct {
	path      string
	dest      string
	verify    bool
	cosignKey string
	creds     string
}

var pullArgs pullFlags

func init() {
	pullCmd.Flags().StringVarP(&pullArgs.path, "path", "p", "", "path for storing the pulled artifact")
	pullCmd.Flags().StringVarP(&pullArgs.dest, "dest", "d", "", "destination URL for pulling the artifact from")
	pullCmd.Flags().BoolVarP(&pullArgs.verify, "verify", "v", false, "Set signature verification of the artifact using Sigstore cosign")
	pullCmd.Flags().StringVarP(&pullArgs.cosignKey, "pub-key", "k", "", "Cosign public key for varifying the artifact")
	pullCmd.Flags().StringVarP(&pullArgs.creds, "credentials", "c", "", "Credentials to authenticate with OCI registries ")
	artifactCmd.AddCommand(pullCmd)
}

func runPullArtifactCmd(cmd *cobra.Command, args []string) error {
	// ctx :=
	output := filepath.Dir(pullArgs.path)
	if err := utils.CheckPathExists(output); err != nil {
		log.Errorf("Error reading %s: %s\n", output, err)
		os.Exit(1)
	}

	if pullArgs.verify {
		spin := utils.StartSpinner("Verifying artifact")
		defer spin.Stop()

		verified, err := oci.VerifyArifact(context.Background(), pullArgs.dest, pullArgs.cosignKey)
		if err != nil {
			color.Red("Artifact verification failed: %s", err)
			os.Exit(1)
		}

		if verified {
			fmt.Printf("Artifact %s verified successfully", pullArgs.dest)
		} else {
			color.Red("Artifact verification failed.")
		}

		spin.Stop()
	}
	spin := utils.StartSpinner("Pulling Artifact...")
	defer spin.Stop()

	if err := oci.PullArtifact(context.Background(), pullArgs.creds, pullArgs.dest, pullArgs.path); err != nil {
		errorMessage := color.RedString("Error pulling artifact from remote: %v", err)
		return fmt.Errorf("%s", errorMessage)
	}
	spin.Stop()
	color.Green("Artifact from %s pulled and stored in :%s", pullArgs.dest, pullArgs.path)
	return nil
}
