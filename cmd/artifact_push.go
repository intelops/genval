package cmd

import (
	"fmt"
	"os"
	"path/filepath"
	"time"

	"github.com/google/go-containerregistry/pkg/authn"
	"github.com/google/go-containerregistry/pkg/compression"
	"github.com/google/go-containerregistry/pkg/crane"
	v1 "github.com/google/go-containerregistry/pkg/v1"
	"github.com/google/go-containerregistry/pkg/v1/empty"
	"github.com/google/go-containerregistry/pkg/v1/mutate"
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
`,
	Example: `
# Build and push the provided file/files as OCI artifact to registry

# Genval provides functionality to sign the artifact using Sigstore cosign tool.
# To sign the artifact set the --sign flag to true (false by default)
# Through this workflow, user needs to open th redirectoin link and authorize with OIDC token

./genval artifact push --reqinput ./templates/defaultpolicies/rego \
--url --dest oci://ghcr.io/santoshkal/artifacts/genval:test \
--sign true

# TODO: Add fucntionality for signing with Cosign genrated pvt key

# User can pass additional annotations in <key=value> pair while pushing the artifact

./genval artifact push --reqinput ./templates/defaultpolicies/rego \
--url --dest oci://ghcr.io/santoshkal/artifacts/genval:test \
--annotations  foo=bar

`,
	RunE: runPushCmd,
}

type pushFlags struct {
	reqinput    string
	dest        string
	annotations []string
	sign        bool
}

var pushArgs pushFlags

func init() {
	pushCmd.Flags().StringVarP(&pushArgs.reqinput, "reqinput", "r", "", "path to the artifact (tar.gz) source files to push")
	if err := pushCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	pushCmd.Flags().StringVarP(&pushArgs.dest, "dest", "d", ".", "Source URl for the registry")
	if err := pushCmd.MarkFlagRequired("dest"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	pushCmd.Flags().StringArrayVarP(&pushArgs.annotations, "annotations", "a", nil, "Set custom annotation in <key>=<value> format")
	pushCmd.Flags().BoolVarP(&pushArgs.sign, "sign", "s", false, "If set to true, signs the artifact with cosign in keyless mode")
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
	log.Println("✔ Artifact created successfully")

	ref, err := oci.ParseOCIURL(source)
	if err != nil {
		log.Printf("Error parsing source: %v", err)
	}
	remoteURL, err := oci.GetGitRemoteURL()
	if err != nil {
		return err
	}
	annotations, err := oci.ParseAnnotations(pushArgs.annotations)
	if err != nil {
		return err
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
	opts := crane.WithAuthFromKeychain((authn.DefaultKeychain))

	if err := crane.Push(img, ref.String(), opts); err != nil {
		log.Fatalf("Error pushing artifact: %v", err)
	}
	spin.Stop()
	digest, err := img.Digest()
	if err != nil {
		log.Errorf("parsing artifact digest failed: %s", err)
	}

	digestURL := ref.Context().Digest(digest.String()).String()

	if pushArgs.sign {
		err := oci.SignCosign(digestURL)
		if err != nil {
			return err
		}
	}

	log.Printf("✔ Artifact pushed successfully to: %v\n, with Digest: %v\n", source, digest)
	log.Printf("Digest URL: %v\n", digestURL)
	return nil
}
