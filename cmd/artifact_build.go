package cmd

import (
	"os"
	"path/filepath"

	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/oci"
	"github.com/intelops/genval/pkg/utils"
)

var buildCmd = &cobra.Command{
	Use:   "build",
	Short: "The artifact build command bundles the provided file/s into a OCI compatible tar gz bundle",
	Long: `
The artifact build command takes in a directory or a set of configuration files generated/validated by Genval
and bundles them into a OCI complient tar.gz bundle ready to be pushed to an OCI complient container registry
`,
	Example: `
# Build the generated/validated set of files in to a OCI bundle

./genval artifact build --reqinput <path to source files/directory> \
--output <path to store the OCI bundle>

#Example:
$ ./genval artifact build --reqinput ./templates/inputs \
 --output ./output/artifact.tar.gz
INFO[0000] ✔ Building artifact from: ./templates/inputs
INFO[0000] ✔ Artifact created successfully at: ./output/artifact.tar.gz
`,
	RunE: runBuildCmd,
}

type buildFlags struct {
	reqinput string
	output   string
}

var buildArgs buildFlags

func init() {
	buildCmd.Flags().StringVarP(&buildArgs.reqinput, "reqinput", "r", "", "Path to the source files to build artifact from")
	if err := buildCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	buildCmd.Flags().StringVarP(&buildArgs.output, "output", "o", ".", "Path for storing the built artifact")
	if err := buildCmd.MarkFlagRequired("output"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

	artifactCmd.AddCommand(buildCmd)
}

func runBuildCmd(cmd *cobra.Command, args []string) error {
	inputPath := buildArgs.reqinput
	outputPath := buildArgs.output

	if err := utils.CheckPathExists(inputPath); err != nil {
		log.Errorf("Error reading %s: %s\n", inputPath, err)
		os.Exit(1)
	}

	outputDir := filepath.Dir(outputPath)
	if err := utils.CheckPathExists(outputDir); err != nil {
		log.Errorf("Error reading %s: %s\n", outputPath, err)
		os.Exit(1)
	}

	log.Printf("✔ Building artifact from: %s\n", inputPath)

	// Create a tarball from the input path
	if err := oci.CreateTarball(inputPath, outputPath); err != nil {
		log.Errorf("Error creating tarball: %s", err)
		return err
	}
	log.Printf("✔ Artifact created successfully at: %s\n", outputPath)
	return nil
}
