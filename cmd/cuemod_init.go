package cmd

import (
	"archive/tar"
	"errors"
	"fmt"
	"os"
	"path/filepath"

	"github.com/intelops/genval/pkg/cuecore"
	"github.com/intelops/genval/pkg/oci"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var initCmd = &cobra.Command{
	Use:   "init",
	Short: "Init command initializes the workspace for cue command execution",
	Long: `
The init comand is used to initialize the workspace to work with the cue command, It creates all the
required files and directories in the workspace and makes it ready for writing Cue policies and then finally applying them.

`,
	Example: `
	# Users can initialize the Cue workspace with the following commands to write policies for Kubernetes manifests

	./genval cuemod init --tool=k8s

	The above command will create all the required files and directories in the workspace for users to write the policies
for validating and generating the Kubernetes resources.

# Similary avaliable flags for cuemod init are:
--tool=k8s:1.29
--tool=argocd:2.10.4
--tool=tektoncd0.58.0
--too=crosplane:1.15.0
--tool=clusterapi:<version without v>
`,
	RunE: runInitCmd,
}

type initFlags struct {
	tool string
}

var initArgs initFlags

func init() {
	initCmd.Flags().StringVarP(&initArgs.tool, "tool", "t", "", "relevant tool for which the cue workspace should be created")

	cuemodCmd.AddCommand(initCmd)
}

func runInitCmd(cmd *cobra.Command, args []string) error {
	if initArgs.tool == "" {
		return errors.New("atleast one tool needs to be provided to initialize")
	}
	desiredTool, ociURL, err := cuecore.ParseTools(initArgs.tool)
	if err != nil {
		log.Errorf("Error prsing provided tool %s: %v", initArgs.tool, err)
	}

	archivePath, err := cuecore.CreateArchiveWorkspace(initArgs.tool)
	if err != nil {
		log.Errorf("Error initializing archive %s: %v", initArgs.tool, err)
		return err
	}

	tarballPath := filepath.Join(archivePath, "cuemod-"+initArgs.tool+".tar.gz")
	destTar, err := os.Create(tarballPath)
	if err != nil {
		return fmt.Errorf("error creating workpace archive %s: %v", tarballPath, err)
	}
	defer destTar.Close()

	if err := cuecore.CheckTagAndPullArchive(ociURL, desiredTool, destTar); err != nil {
		log.Errorf("Error pulling module for %s from %v: %v", desiredTool, destTar, err)
	}
	extractPath, err := cuecore.CreateExtractWorkspace(initArgs.tool)
	if err != nil {
		log.Errorf("Error initializing workspace files %s: %v", initArgs.tool, err)
		return err
	}

	reader, err := os.Open(tarballPath)
	if err != nil {
		log.Error("error opening archive:")
		return err
	}
	defer reader.Close()

	tarReader := tar.NewReader(reader)

	if err := oci.ExtractTarContents(tarReader, extractPath); err != nil {
		log.Errorf("error extracting archive:")
		return err
	}

	return nil
}
