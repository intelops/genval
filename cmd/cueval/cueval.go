package cueval

import (
	"fmt"
	"os"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	embeder "github.com/intelops/genval"
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

func Execute(resource string, value, policy string) {
	const modPath = "github.com/intelops/genval"
	staticFS := embeder.CueDef

	td, cleanup, err := utils.TempDirWithCleanup()
	if err != nil {
		log.Fatal(err)
	}
	defer cleanup()

	ctx := cuecontext.New()

	// defPath := args[0]
	// dataFile := args[1]
	if resource == "" || value == "" || policy == "" {
		log.Errorf("Usage: [binary_name] -mode=cueval --resource=<Resource> --value=<Input JSON>")
		return
	}

	defPath := resource
	dataFile := value
	schemaFile := []string{policy}

	overlay, err := utils.GenerateOverlay(staticFS, td, schemaFile)
	if err != nil {
		log.Fatal(err)
	}

	conf := &load.Config{
		Dir:     td,
		Overlay: overlay,
		Module:  modPath,
		Package: "_",
	}

	res, data, err := utils.ReadAndCompileData(defPath, dataFile)
	if err != nil {
		log.Fatalf("Error processing data: %v", err)
		return
	}

	defName := "#" + defPath

	v, err := cuecore.BuildInstance(ctx, modPath, conf)
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

	fmt.Printf("%v validation succeeded, generated manifest: %v.yaml\n", defPath, res)
}
