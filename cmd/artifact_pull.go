package cmd

import (
	"context"
	"fmt"
	"os"
	"path/filepath"

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
# TODO: Test this workflow

./genval artifact pull --dest ghcr.io/santoshkal/artifacts/genval:test \
--path ./output \
--key <Path to Cosign Public key> for verification
--verify true

# Uses can also pull the artifact with verifying the signatures of the artifact
in the container registry and unpack the archive in desired path

./genval artifact pull --dest ghcr.io/santoshkal/artifacts/genval:test \
--path ./output
`,
	RunE: runPullArtifactCmd,
}

type pullFlags struct {
	path      string
	dest      string
	verify    bool
	cosignKey string
}

var pullArgs pullFlags

func init() {
	pullCmd.Flags().StringVarP(&pullArgs.path, "path", "p", "", "path for storing the pulled artifact")
	pullCmd.Flags().StringVarP(&pullArgs.dest, "dest", "d", "", "destination URL for pulling the artifact from")
	pullCmd.Flags().BoolVarP(&pullArgs.verify, "verify", "v", false, "Set signature verification of the artifact using Sigstore cosign")
	pullCmd.Flags().StringVarP(&pullArgs.cosignKey, "key", "k", "", "Cosign public key for varifying the artifact")

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
			log.Errorf("Artifact verification failed: %s", err)
			os.Exit(1)
		}

		if verified {
			fmt.Printf("Artifact %s verified successfully", pullArgs.dest)
		} else {
			fmt.Println("Artifact verification failed.")
		}

		spin.Stop()
	}

	if err := oci.PullArtifact(context.Background(), pullArgs.dest, pullArgs.path); err != nil {
		log.Errorf("Error pulling artifact from remote : %v", err)
		return err
	}

	log.Printf("Artifact from %s pulled and stored in :%s", pullArgs.dest, pullArgs.path)
	return nil
}
