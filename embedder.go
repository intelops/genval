// embedlogic.go

package main

import (
	"embed"
	"io/fs"
	"log"
	"strings"

	"cuelang.org/go/cue/load"
	"github.com/intelops/genval/cmd/cueval"
)

//go:embed schema/*.cue cue.mod/*/*.cue
var cueDef embed.FS

// init initializes the Entrypoint.
func init() {
	cueval.Entrypoint = make(map[string]load.Source)

	err := fs.WalkDir(cueDef, ".", func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			log.Printf("Error processing entry %s: %v", path, err)
			return err
		}

		// Skip directories or non-regular files
		if d == nil || d.Type().IsDir() || !d.Type().IsRegular() {
			return nil
		}

		if strings.Contains(path, ".cue") {
			f, err := cueDef.ReadFile(path)
			if err != nil {
				log.Printf("Error reading embedded .cue file %s: %v", path, err)
				return err
			}
			cueval.Entrypoint[path] = load.FromBytes(f)
		}
		return nil
	})

	if err != nil {
		log.Fatalf("Error walking embedded content: %v", err)
	}
}
