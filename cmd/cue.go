package cmd

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	log "github.com/sirupsen/logrus"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	"github.com/intelops/genval/pkg/cuecore"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/spf13/cobra"
)

var cueCmd = &cobra.Command{
	Use:   "cue",
	Short: "The cue command validates and generates Kubernetes manifests",
	Long: `
The Cue command enables the validation and generation of Kubernetes and related manifests.
Users can provide an input manifest in either JSON or YAML format. This input is then validated against a predefined set of Cue definitions
tailored for the specific manifest.	These Cue definitions may include defaults and constraints, offering a way to enforce specific configurations
on the input manifest.
Users can combine these definitions by providing a top-level label to the --resource flag via the command-line interface.

Upon successful validation, the entire set of Kubernetes manifests is generated and written to the "./output" directory
within the current working directory.

`,
	Example: `
# TODO: add examples
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
	cueCmd.Flags().StringVarP(&cueArgs.source, "source", "s", "", "Input file in JSON/YAML format for generating/validating manifests")
	cueCmd.Flags().StringVarP(&cueArgs.resource, "resource", "r", "", "A top-level label used to define the Cue Definition")
	cueCmd.Flags().StringVarP(&cueArgs.policy, "policy", "p", "", "a directory containing cue.mod and cue definitions")

	rootCmd.AddCommand(cueCmd)
}

func runCueCmd(cmd *cobra.Command, args []string) error {
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

	definitions, err := cuecore.GetDefinitions(cueArgs.policy)
	if err != nil {
		log.Fatalf("Error reading Cue Definitions: %v", err)
	}
	modPath, err := cuecore.ExtractModule(cueArgs.policy)
	if err != nil {
		log.Errorf("Error fetching module: %v", err)
	}

	dataSet, err := cuecore.ReadAndCompileData(cueArgs.resource)
	if err != nil {
		log.Errorf("Error processing data: %v", err)
		return err
	}

	overlay, err := cuecore.GenerateOverlay(cueArgs.policy, td, definitions)
	if err != nil {
		log.Fatal(err)
	}

	conf := &load.Config{
		Dir:     td,
		Overlay: overlay,
		Module:  modPath,
		Package: "*",
	}

	defName := "#" + cueArgs.resource

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
	log.Infof("%v validation succeeded, generated manifests in '%v' directory:\n", cueArgs.resource, outputDir)
	for _, fileName := range outputFiles {
		fmt.Printf(" - %v\n", fileName)
	}
	return nil
}
