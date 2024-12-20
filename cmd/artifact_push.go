package cmd

import (
	"context"
	"fmt"
	"os"
	"path/filepath"
	"time"

	"github.com/fatih/color"
	"github.com/google/go-containerregistry/pkg/authn"
	"github.com/google/go-containerregistry/pkg/compression"
	"github.com/google/go-containerregistry/pkg/crane"
	v1 "github.com/google/go-containerregistry/pkg/v1"
	"github.com/google/go-containerregistry/pkg/v1/empty"
	"github.com/google/go-containerregistry/pkg/v1/mutate"
	"github.com/google/go-containerregistry/pkg/v1/remote/transport"
	"github.com/google/go-containerregistry/pkg/v1/tarball"
	"github.com/google/go-containerregistry/pkg/v1/types"
	"github.com/intelops/genval/pkg/oci"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var pushCmd = &cobra.Command{
	Use:   "push",
	Short: "The artifact push command builds an arifact bundle and pushes it to an OCI complient container registry",
	Long: `
The artifact push command takes in a tar.gz bundle of configuration files generated/validated by Genval
and pushes them into a OCI complient container registry

To facilitate authentication with OCI compliant container registries,
Users can provide credentials through --creds flag. The creds can be provided via <USER:PAT> or <REGISTRY_PAT> format.
If no credentials are provided, Genval searches for the "./docker/config.json" file in the user's $HOME directory.
If this file is found, Genval utilizes it for authentication.
`,
	Example: `
# Build and push the provided file/files as OCI artifact to registry

# Genval provides functionality to sign the artifact using Sigstore cosign tool.
# To sign the artifact set the --sign flag to true (false by default)
# Through this workflow, user needs to open th redirectoin link and authorize with OIDC token

./genval artifact push --reqinput ./templates/defaultpolicies/rego \
--dest ghcr.io/santoshkal/artifacts/genval:test \
--sign true
// No credentials provided, will default to $HOME/.docker/config.json for credentials

# Alternatively, users may provide the Cosign generated private key for signing the artifact

./genval artifact push --reqinput ./templates/defaultpolicies/rego \
--dest ghcr.io/santoshkal/artifacts/genval:test \
--sign true
--cosign-key <Path to Cosign private Key>
--credentials <GITHUB_PAT> or <USER:PAT>

# User can pass additional annotations in <key=value> pair while pushing the artifact

./genval artifact push --reqinput ./templates/defaultpolicies/rego \
--dest ghcr.io/santoshkal/artifacts/genval:test \
--annotations  foo=bar

`,
	RunE: runPushCmd,
}

type pushFlags struct {
	reqinput    string
	dest        string
	annotations []string
	sign        bool
	cosignKey   string
	creds       string
}

var pushArgs pushFlags

func init() {
	pushCmd.Flags().StringVarP(&pushArgs.reqinput, "reqinput", "r", "", "path to the source files to push")
	if err := pushCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	pushCmd.Flags().StringVarP(&pushArgs.dest, "dest", "d", ".", "Source URl for the registry")
	if err := pushCmd.MarkFlagRequired("dest"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	pushCmd.Flags().StringArrayVarP(&pushArgs.annotations, "annotations", "a", nil, "Set custom annotation in <key>=<value> format")
	pushCmd.Flags().BoolVarP(&pushArgs.sign, "sign", "s", false, "If set to true, signs the artifact with cosign in keyless mode")
	pushCmd.Flags().StringVarP(&pushArgs.cosignKey, "cosign-key", "k", "", "path to cosign private key")
	pushCmd.Flags().StringVarP(&pushArgs.creds, "credentials", "c", "", "Credentials to authenticate with OCI registries ")
	artifactCmd.AddCommand(pushCmd)
}

func runPushCmd(cmd *cobra.Command, args []string) error {
	if pushArgs.reqinput == "" || pushArgs.dest == "" {
		log.Printf("Required args mising")
	}

	inputPath := pushArgs.reqinput
	source := pushArgs.dest

	if err := utils.CheckPathExists(inputPath); err != nil {
		log.Errorf("Error reading %s: %v\n", inputPath, err)
		os.Exit(1)
	}

	tempDir, err := os.MkdirTemp("", "artifacts")
	if err != nil {
		log.Printf("Error creating Temp dir: %v", err)
	}
	defer os.RemoveAll(tempDir)

	outputPath := filepath.Join(tempDir, "artifact.tar.gz")

	log.Printf("Building artifact from: %v", inputPath)

	// Create a tarball from the input path
	if err := oci.CreateTarball(inputPath, outputPath); err != nil {
		return fmt.Errorf("creating tarball: %w", err)
	}
	log.Info("✔ Artifact created successfully")

	ref, err := oci.ParseOCIReference(source)
	if err != nil {
		log.Errorf("Error parsing source: %v", err)
	}

	remoteURL, err := oci.GetRemoteURL()
	if err != nil {
		return fmt.Errorf("error parsing remote URL, %s: %v", remoteURL, err)
	}
	annotations, err := oci.ParseAnnotations(pushArgs.annotations)
	if err != nil {
		return fmt.Errorf("error parsing annotations %s: %v", pushArgs.annotations, err)
	}

	img := mutate.MediaType(empty.Image, types.OCIManifestSchema1)
	img = mutate.ConfigMediaType(img, oci.ConfigMediaType)
	img = mutate.Annotations(img, annotations).(v1.Image)

	layer, err := tarball.LayerFromFile(outputPath,
		tarball.WithMediaType(oci.ContentMediaType),
		tarball.WithCompression(compression.GZip),
		tarball.WithCompressedCaching)
	if err != nil {
		log.Errorf("Creating content layer failed: %v", err)
	}
	img, err = mutate.Append(img, mutate.Addendum{
		Layer: layer,
		Annotations: map[string]string{
			oci.ContentTypeAnnotation: "genval/bundle",
			oci.CreatedAnnotation:     time.Now().UTC().Format(time.RFC3339),
			oci.SourceAnnotation:      remoteURL,
		},
	})
	if err != nil {
		log.Errorf("appending content to artifact failed: %v", err)
	}

	spin := utils.StartSpinner("pushing artifact")
	defer spin.Stop()

	var opts []crane.Option
	auth, err := oci.GetCreds(pushArgs.creds)
	if err != nil {
		return err
	}

	if pushArgs.creds == "" || auth == nil {
		auth, err = authn.DefaultKeychain.Resolve(ref.Context())
		if err != nil {
			return err
		}
	}

	opts = append(opts, crane.WithAuth(auth))

	topts, err := oci.GenerateCraneOptions(context.Background(), ref.Context().Registry, auth, []string{ref.Context().Scope(transport.PushScope)})
	if err != nil {
		return fmt.Errorf("error creating transport for push operation: %v", err)
	}

	opts = append(opts, topts)
	if err := crane.Push(img, ref.String(), opts...); err != nil {
		log.Fatalf("Error pushing artifact: %v", err)
	}
	spin.Stop()
	digest, err := img.Digest()
	if err != nil {
		log.Errorf("parsing artifact digest failed: %s", err)
	}

	digestURL := ref.Context().Digest(digest.String()).String()

	if pushArgs.sign {
		err := oci.SignCosign(digestURL, pushArgs.cosignKey)
		if err != nil {
			return fmt.Errorf("error signing artifact %s: %v", digestURL, err)
		}
	}

	// Create formatted messages # Fix govet warnings
	artifactMessage := color.GreenString("✔ Artifact pushed successfully to: %v", pushArgs.dest)
	digestMessage := color.GreenString("✔ Digest: %v", digest)
	digestURLMessage := color.GreenString("✔ Digest URL: %v\n", digestURL)

	log.Info(artifactMessage)
	log.Info(digestMessage)
	log.Info(digestURLMessage)
	return nil
}
