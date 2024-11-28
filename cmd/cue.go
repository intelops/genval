package cmd

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	"github.com/fatih/color"
	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/cuecore"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
)

var cueCmd = &cobra.Command{
	Use:   "cue",
	Short: "cue command validates and generates Kubernetes manifests",
	Long: `
The Cue command enables the validation and generation of Kubernetes and related manifests.
Developers can provide an input manifest in either JSON or YAML format. This input is then validated
against a predefined set of Cue definitions (policies) tailored for the specific manifest.	These policies
may include defaults and constraints set on spefic fields of the manifest, offering a way to enforce
secure configurations following induestry best-practices. Developers can target these policies
by providing a top-level label to the --resource flag via the command-line interface.

Upon successful validation, the entire set of Kubernetes manifests is generated and written to the "./output" directory
within the current working directory.

`,
	Example: `
Usecase - 1
# A developer may provide a bare-minimum set of requireents for a Deployment and a Service for a Kubernetes resource as a directory.
The Security/DevOps team would prepare a policy written in Cuelang with all the type checking against the upstream Kubernetes API,
and the mandatory defaults for the Deployment and a Service. Genval will validate the input provided by the developer against
the policy/policies and generate the complete set of manifests in the ./output directory.

# Demo files are stored in https://github.com/santoshkal/cuemod-demo

./genval cue --source ./k8s \
--resource Application
--policy ./policy

./genval cue --source https://github.com/santoshkal/cuemod-demo/tree/main/k8s \
--resource Application \
--policy ./policy
`,
	RunE: runCueCmd,
}

type cueFlags struct {
	source   string
	resource string
	policy   string
}

var cueArgs cueFlags

func init() {
	cueCmd.Flags().StringVarP(&cueArgs.source, "reqinput", "i", "", "Input file in JSON/YAML format for generating/validating manifests")
	cueCmd.Flags().StringVarP(&cueArgs.resource, "resource", "r", "", "A top-level label used to define the Cue Definition")
	cueCmd.Flags().StringVarP(&cueArgs.policy, "policy", "p", "", "a directory containing cue.mod and cue definitions")

	rootCmd.AddCommand(cueCmd)
}

func runCueCmd(cmd *cobra.Command, args []string) error {
	dataPath := cueArgs.source
	defPath := cueArgs.resource
	schemaFile := cueArgs.policy

	td, cleanup, err := utils.TempDirWithCleanup()
	if err != nil {
		log.Fatal(err)
	}
	defer cleanup()
	defer func() {
		if err := utils.CleanupDownloadedDir(); err != nil {
			log.Printf("Error removing cue_downloads directory: %v", err)
		}
	}()

	ctx := cuecontext.New()

	definitions, err := cuecore.GetDefinitions(schemaFile)
	if err != nil {
		log.Fatalf("Error reading Cue Definitions: %v", err)
	}
	modPath, err := cuecore.ExtractModule(schemaFile)
	if err != nil {
		log.Errorf("Error fetching module: %v", err)
	}

	dataSet, err := cuecore.ReadAndCompileData(dataPath)
	if err != nil {
		log.Errorf("Error processing data: %v", err)
		return err
	}

	overlay, err := cuecore.GenerateOverlay(schemaFile, td, definitions)
	if err != nil {
		log.Fatal(err)
	}

	conf := &load.Config{
		Dir:     td,
		Overlay: overlay,
		Module:  modPath,
		Package: "*",
	}

	defName := "#" + defPath

	v, err := cuecore.BuildInstance(ctx, definitions, conf)
	if err != nil {
		log.Fatal(err)
	}

	// Name of the output directory
	outputDir := "output"

	// Check if the output directory exists, if not create it
	if _, err := os.Stat(outputDir); os.IsNotExist(err) {
		err := os.Mkdir(outputDir, 0o755)
		if err != nil {
			log.Fatalf("Error creating output directory: %v", err)
		}
	}
	var outputFiles []string
	for filePath, data := range dataSet {
		for _, value := range v {
			lookUp := cue.ParsePath(defName)
			def := value.LookupPath(lookUp)
			if def.Err() != nil {
				log.Errorf("Error parsing Path: %v", def.Err())
				return err
			}

			unifiedValue, err := cuecore.UnifyAndValidate(def, data)
			if err != nil {
				log.Errorf("Validation failed: %v", err)
				return err
			}

			yamlData, err := parser.CueToYAML(unifiedValue)
			if err != nil {
				log.Errorf("Error Marshaling: %v", err)
				return err
			}

			baseName := filepath.Base(filePath)
			outputFileName := strings.TrimSuffix(baseName, filepath.Ext(baseName)) + ".yaml"
			fullOutputPath := filepath.Join(outputDir, outputFileName)

			err = os.WriteFile(fullOutputPath, yamlData, 0o644)
			if err != nil {
				log.Errorf("Writing YAML: %v", err)
				return err
			}
			outputFiles = append(outputFiles, fullOutputPath)

		}
	}
	color.Green("%v validation succeeded, generated manifests in '%v' directory:\n", defPath, outputDir)
	for _, fileName := range outputFiles {
		fmt.Printf(" - %v\n", fileName)
	}
	return nil
}
