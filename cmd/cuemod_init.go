package cmd

import (
	"bufio"
	"context"
	"errors"
	"fmt"
	"os"

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

# Similarly available flags for cuemod init are:
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
	key  string
}

var initArgs initFlags

func init() {
	initCmd.Flags().StringVarP(&initArgs.tool, "tool", "t", "", "relevant tool for which the cue workspace should be created")
	initCmd.Flags().StringVarP(&initArgs.key, "key", "k", "", "Cosign public key for verification of artifact signature")

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
	// key := ""
	verified, err := oci.VerifyArifact(context.Background(), ociURL, initArgs.key)
	log.Printf("Verified artifact: %v", verified)
	if err != nil {
		return fmt.Errorf("error varifying artifact: %v", err)
	}
	if !verified {
		fmt.Println("The artifact is not verified.")
		fmt.Println("Would you like to proceed? If yes, press 'y', else press 'n'.")

		reader := bufio.NewReader(os.Stdin)
		input, err := reader.ReadString('\n')
		if err != nil {
			return fmt.Errorf("error reading input: %s", err)
		}

		input = trimNewline(input)
		if input == "y" {
			fmt.Println("Proceeding...")

			if err := oci.CreateWorkspace(initArgs.tool, desiredTool, ociURL); err != nil {
				log.Errorf("Error creating workspace: %v", err)
			}
			log.Infof("Workspace verified and created")
		} else if input == "n" {
			fmt.Println("Operation cancelled.")
			// Place your code here for what should happen if the user chooses not to proceed
		} else {
			fmt.Println("Invalid input. Please enter 'y' or 'n'.")
		}
	} else if err := oci.CreateWorkspace(initArgs.tool, desiredTool, ociURL); err != nil {
		log.Errorf("Error creating workspace: %v", err)
	}
	return nil
}

func trimNewline(s string) string {
	return s[:len(s)-1]
}
