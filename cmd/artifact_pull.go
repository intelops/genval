package cmd

import (
	"context"
	"os"
	"path/filepath"

	"github.com/intelops/genval/pkg/oci"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var pullCmd = &cobra.Command{
	Use:   "pull",
	Short: "The artifact pull command  verifies the artifact with Cosign and pulls the artifact from container registry",
	Long: `
The artifact push command takes in a tar.gz bundle of configuration files generated/validated by Genval
and pushes them into a OCI complient container registry
`,
	Example: `
# Build and push the provided file/files as OCI artifact to registry

# Genval provides functionality to sign the artifact using Sigstore cosign tool.
# To sign the artifact set the --sign flag to true (false by default)
# Through this workflow, user needs to open th redirectoin link and authorize with OIDC token

./genval artifact push --reqinput ./templates/defaultpolicies/rego \
--url --dest oci://ghcr.io/santoshkal/artifacts/genval:test \
--sign true

# User can pass additional annotations in <key=value> format while pushing the artifact

./genval artifact push --reqinput ./templates/defaultpolicies/rego \
--url --dest oci://ghcr.io/santoshkal/artifacts/genval:test \
--annotations  foo=bar

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
	// pullCmd.Flags().StringVar(&pullArgs.certIdentity, "certificate-id", "",
	// 	"The identity expected in a valid Fulcio certificate for verifying the Cosign signature.\n"+
	// 		"Valid values include email address, DNS names, IP addresses, and URIs.\n"+
	// 		"Either --certificate-identity or --certificate-identity-regexp must be set for keyless verification.")
	// pullCmd.Flags().StringVar(&pullArgs.certIdentityRegexp, "certificate-regexp", "",
	// 	"A regular expression alternative to --certificate-identity for verifying the Cosign signature.\n"+
	// 		"Accepts the Go regular expression syntax described at https://golang.org/s/re2syntax.\n"+
	// 		"Either --certificate-identity or --certificate-identity-regexp must be set for keyless verification.")
	// pullCmd.Flags().StringVar(&pullArgs.certiOIDCIssuer, "certificate-OIDC", "",
	// 	"The OIDC issuer expected in a valid Fulcio certificate for verifying the Cosign signature,\n"+
	// 		"e.g. https://token.actions.githubusercontent.com or https://oauth2.sigstore.dev/auth.\n"+
	// 		"Either --certificate-oidc-issuer or --certificate-oidc-issuer-regexp must be set for keyless verification.")
	// pullCmd.Flags().StringVar(&pullArgs.certOIDCIssuerRegexp, "OIDC-regexp", "",
	// 	"A regular expression alternative to --certificate-oidc-issuer for verifying the Cosign signature.\n"+
	// 		"Accepts the Go regular expression syntax described at https://golang.org/s/re2syntax.\n"+
	// 		"Either --certificate-oidc-issuer or --certificate-oidc-issuer-regexp must be set for keyless verification.")

	artifactCmd.AddCommand(pullCmd)
}

func runPullArtifactCmd(cmd *cobra.Command, args []string) error {
	output := filepath.Dir(pullArgs.path)
	if err := utils.CheckPathExists(output); err != nil {
		log.Errorf("Error reading %s: %s\n", output, err)
		os.Exit(1)
	}
	if pullArgs.verify {
		ctx := context.Background()
		co, err := oci.BuildCosignCheckOpts(ctx, pullArgs.cosignKey)
		if err != nil {
			return err
		}
		verified, err := oci.VerifyArifact(ctx, pullArgs.cosignKey, pullArgs.dest, co)
		if err != nil {
			log.Errorf("Artifact varifcation failed: %s", err)
		}
		spin := utils.StartSpinner("pushVarifying artifact")
		defer spin.Stop()
		if verified {
			log.Printf("Artifact %s verified succussfully", pullArgs.dest)
		}
		spin.Stop()
	}
	return nil
}
