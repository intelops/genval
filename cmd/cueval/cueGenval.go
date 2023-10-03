package cueval

import (
	"embed"
	"io/fs"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	log "github.com/sirupsen/logrus"
	"gopkg.in/yaml.v3"
)

// Embed the def.cue file and the entire cue.mod directory.
//
//go:embed *.cue
var cueDef embed.FS

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

func Execute(args []string) {
	ctx := cuecontext.New()

	if len(args) != 2 {
		log.Errorf("Usage: [binary_name] -mode=k8s <Resource> <Input JSON>")
		return
	}

	defName := args[0]
	dataFile := args[1]

	overlay := make(map[string]load.Source)

	fs.WalkDir(cueDef, ".", func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			log.Errorf("Error reading embedded files: %v", err)
		}
		if !d.Type().IsRegular() {
			return nil
		}
		contents, err := cueDef.ReadFile(path)
		if err != nil {
			log.Errorf("Error reading cueDef: %v", err)
		}
		overlay[filepath.Join("/", path)] = load.FromBytes(contents)
		return nil
	})

	conf := &load.Config{
		Dir:     ".",
		Overlay: overlay,
	}

	d := strings.ToLower(defName)
	defPath := "#" + strings.Title(d)
	// Read the input Json from args and encode the json in CUE value for processing
	ds, err := os.ReadFile(dataFile)
	if err != nil {
		log.Fatalf("Error reading data: %v", err)
		return
	}

	data := ctx.CompileBytes(ds)
	if data.Err() != nil {
		log.Errorf("Error compiling data: %v", data.Err())
		return
	}

	bi := load.Instances([]string{"."}, conf)

	v := ctx.BuildInstance(bi[0])

	def := v.LookupPath(cue.ParsePath(defPath))
	if def.Err() != nil {
		log.Errorf("Error parsing Path: %v", def)
		return
	}

	// Unify data the CUE Value and Definition, and Check for err
	value := def.Unify(data)
	if value.Err() != nil {
		log.Errorf("Validation failed: %v", value.Err())
		return
	}

	err = value.Validate(cue.Concrete(true), cue.Final())
	if value.Err() != nil {
		log.Errorf("Error validating: %v", value.Err())
		return
	}

	o, err := value.MarshalJSON()
	if err != nil {
		log.Errorf("Invalid JSON: %v", err)
		return
	}

	var output map[string]interface{}
	err = yaml.Unmarshal(o, &output)
	if err != nil {
		log.Errorf("Error writing YAML: %v", output)
		return
	}

	yamlData, err := yaml.Marshal(output)
	if err != nil {
		log.Errorf("Error Marshaling: %v", err)
		return
	}

	err = os.WriteFile("output.yaml", yamlData, 0644)
	if err != nil {
		log.Errorf("Writing YAML: %v", err)
		return
	}

	log.Println("Validation Succeeded!")
}
