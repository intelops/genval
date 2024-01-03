package modes

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	"github.com/intelops/genval/pkg/cuecore"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
)

func init() {
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: false,
		FieldMap: log.FieldMap{
			log.FieldKeyTime:  "@timestamp",
			log.FieldKeyLevel: "@level",
			log.FieldKeyMsg:   "@message",
		},
	})
}

func ExecuteCue(reqinput, resource string, verify bool, policy string) {
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

	if resource == "" || reqinput == "" || policy == "" {
		fmt.Println("[Usage]: genval --mode=cue --resource=<Resource> --reqinput=<Input JSON> --policy <path/to/.cue schema file>")
		return
	}

	dataPath := reqinput
	defPath := resource
	schemaFile := policy

	definitions, err := utils.GetDefinitions(policy)
	if err != nil {
		log.Fatalf("Error reading Cue Definitions: %v", err)
	}
	modPath, err := utils.ExtractModule(policy)
	if err != nil {
		log.Errorf("Error fetching module: %v", err)
	}

	dataSet, err := cuecore.ReadAndCompileData(dataPath)
	if err != nil {
		log.Errorf("Error processing data: %v", err)
		return
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
				return
			}

			unifiedValue, err := cuecore.UnifyAndValidate(def, data)
			if err != nil {
				log.Errorf("Validation failed: %v", err)
				return
			}

			// Only generate YAML if verify is set to false -- default
			if !verify {
				yamlData, err := parser.CueToYAML(unifiedValue)
				if err != nil {
					log.Errorf("Error Marshaling: %v", err)
					return
				}

				baseName := filepath.Base(filePath)
				outputFileName := strings.TrimSuffix(baseName, filepath.Ext(baseName)) + ".yaml"
				fullOutputPath := filepath.Join(outputDir, outputFileName)

				err = os.WriteFile(fullOutputPath, yamlData, 0o644)
				if err != nil {
					log.Errorf("Writing YAML: %v", err)
					return
				}
				outputFiles = append(outputFiles, fullOutputPath)
			}
		}
	}

	// Only print the success log for generation if verify is false
	if !verify {
		log.Infof("%v validation succeeded, generated manifests in '%v' directory:\n", defPath, outputDir)
		for _, fileName := range outputFiles {
			fmt.Printf(" - %v\n", fileName)
		}
	} else {
		log.Infof("%v validation succeeded\n\n", dataPath)
	}
}
