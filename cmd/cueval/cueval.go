package cueval

import (
	"embed"
	"fmt"
	"os"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	"github.com/intelops/genval/pkg/cuecore"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
)

// Embed all `.cue` files in the cue.mod directory.

// go:embed cue.mod/module.cue cue.mod/gen/**/*.cue cue.mod
var CueDef embed.FS

func Execute(resource, reqinput string, policies ...string) {

	const modPath = "github.com/intelops/genval"
	staticFS := CueDef

	td, cleanup, err := utils.TempDirWithCleanup()
	if err != nil {
		log.Fatal(err)
	}
	defer cleanup()

	ctx := cuecontext.New()

	if resource == "" || reqinput == "" || len(policies) == 0 {
		fmt.Println("[Usage]: genval --mode=cue --resource=<Resource> --reqinput=<Input JSON> --policy <path/to/.cue schema file>")
		return
	}

	defPath := resource
	dataFile := reqinput
	schemaFile := policies

	definitions, err := utils.ProcessInputs(schemaFile)
	if err != nil {
		log.Errorf("Error reading URL: %v", err)
	}
	overlay, err := utils.GenerateOverlay(staticFS, td, definitions)
	if err != nil {
		log.Fatal(err)
	}

	conf := &load.Config{
		Dir:     td,
		Overlay: overlay,
		Module:  modPath,
		Package: "*",
	}

	input, err := utils.ProcessInputs([]string{dataFile})
	if err != nil {
		log.Errorf("Error reading URL: %v", err)
	}
	res, data, err := utils.ReadAndCompileData(defPath, input[0])
	if err != nil {
		log.Fatalf("Error processing data: %v", err)
		return
	}

	defName := "#" + defPath

	v, err := cuecore.BuildInstance(ctx, definitions, conf)
	if err != nil {
		log.Fatal(err)
	}

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

		yamlData, err := parser.CueToYAML(unifiedValue)
		if err != nil {
			log.Errorf("Error Marshaling: %v", err)
			return
		}

		err = os.WriteFile(res+".yaml", yamlData, 0644)
		if err != nil {
			log.Errorf("Writing YAML: %v", err)
			return
		}
	}

	if err := utils.CleanupDownloadedDir(); err != nil {
		log.Errorf("Error removing cue_downloads directory: %v", err)
	}

	log.Infof("validation for %v succeeded, generated manifest: %v.yaml\n\n", defPath, res)
}
