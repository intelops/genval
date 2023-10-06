package cueval

import (
	"fmt"
	"io"
	"io/fs"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	embeder "github.com/intelops/genval"
	log "github.com/sirupsen/logrus"
	"gopkg.in/yaml.v3"
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

func Execute(args []string) {
	const modPath = "github.com/intelops/genval"
	staticFS := embeder.CueDef

	td, err := os.MkdirTemp("", "")
	if err != nil {
		log.Fatal(err)
	}
	defer os.RemoveAll(td)

	ctx := cuecontext.New()

	if len(args) != 2 {
		log.Errorf("Usage: [binary_name] -mode=cueval <Resource> <Input JSON>")
		return
	}

	defPath := args[0]
	dataFile := args[1]

	overlay := make(map[string]load.Source)

	err = fs.WalkDir(staticFS, ".", func(p string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if !d.Type().IsRegular() {
			return nil
		}
		f, err := staticFS.Open(p)
		if err != nil {
			return err
		}
		byts, err := io.ReadAll(f)
		if err != nil {
			return err
		}
		op := filepath.Join(td, p)
		overlay[op] = load.FromBytes(byts)
		return nil
	})
	if err != nil {
		log.Fatal(err)
	}

	conf := &load.Config{
		Dir:     td,
		Overlay: overlay,
		Package: "kubernetes",
		Module:  modPath,
	}

	d := strings.ToLower(defPath)
	defName := "#" + strings.Title(d)
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

	bi := load.Instances([]string{modPath + "/schema:kubernetes"}, conf)
	if len(bi) == 0 {
		log.Errorf("no instances found")
	}

	v, err := ctx.BuildInstances(bi)
	if err != nil {
		log.Fatal(err)
	}
	for i, value := range v {
		bi := bi[i]
		fmt.Printf("%v: %.2v\n", bi.PkgName, value)

		lookUp := cue.ParsePath(defName)
		if lookUp.Err() != nil {
			log.Errorf("ParsePath fail: %v", lookUp.Err())
		}

		def := value.LookupPath(lookUp)
		// fmt.Printf("Value from Path: %v", def)
		if def.Err() != nil {
			log.Errorf("Error parsing Path: %v", def.Err())
			return
		}

		// Unify data the CUE Value and Definition, and Check for err
		value := def.Unify(data)
		if value.Err() != nil {
			log.Errorf("Validation failed: %v", value.Err())
			return
		}

		err = value.Validate(cue.Concrete(true), cue.Final())
		if err != nil {
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
	}

	log.Println("Validation Succeeded!")
}
