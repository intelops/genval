package cueval

import (
	"embed"
	"fmt"
	"os"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	log "github.com/sirupsen/logrus"
	"gopkg.in/yaml.v3"
)

// Embed the .cue file and the entire cue.mod directory.
//
//go:embed definitions/*/*.cue
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
		log.Errorf("Usage: [binary_name] -mode=cueval <Resource> <Input JSON>")
		return
	}

	defName := args[0]
	dataFile := args[1]

	overlay := make(map[string]load.Source)

	directory, err := findDirectoryForDefinition(cueDef, defName)
	if err != nil {
		log.Fatalf("Error determining directory for definition: %v", err)
	}

	// Modify this part according to where the CUE files are located.
	cueFilePath := "definitions/" + directory + "/" + directory + ".cue"

	cueContent, err := cueDef.ReadFile(cueFilePath)
	if err != nil {
		log.Fatalf("Failed to read .cue file for %s: %v", directory, err)
	}

	overlay[cueFilePath] = load.FromBytes(cueContent)

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

	bi := load.Instances([]string{"definitions"}, conf)
	if len(bi) > 0 && bi[0].Err != nil {
		log.Errorf("Error in build instance: %v", bi[0].Err)
	}

	v := ctx.BuildInstance(bi[0])

	def := v.LookupPath(cue.ParsePath(defPath))
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

	log.Println("Validation Succeeded!")
}

func findDirectoryForDefinition(cueFS embed.FS, defName string) (string, error) {
	// Try reading the root directory (this would list all the first-level directories)
	entries, err := cueFS.ReadDir("definitions")
	if err != nil {
		return "", fmt.Errorf("error reading 'definitions' directory from embedded FS: %w", err)
	}

	for _, entry := range entries {
		if entry.IsDir() {
			dirName := entry.Name()
			// Check if this directory has a .cue file named after the definition
			if _, err := cueFS.ReadFile("definitions/" + dirName + "/" + dirName + ".cue"); err == nil {
				return dirName, nil
			}
		}
	}

	return "", fmt.Errorf("could not find directory for definition %s", defName)
}
