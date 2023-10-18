package utils

import (
	"io"
	"io/fs"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	log "github.com/sirupsen/logrus"
)

// TempDirWithCleanup creates a temporary directory and returns its path along with a cleanup function.
func TempDirWithCleanup() (dirPath string, cleanupFunc func(), err error) {
	td, err := os.MkdirTemp("", "")
	if err != nil {
		log.Fatal(err)
		return "", nil, err
	}
	return td, func() {
		os.RemoveAll(td)
	}, nil
}

func GenerateOverlay(staticFS fs.FS, td string, additionalFiles []string) (map[string]load.Source, error) {
	overlay := make(map[string]load.Source)

	// Walk through and add files from the embedded fs
	err := fs.WalkDir(staticFS, ".", func(p string, d fs.DirEntry, err error) error {
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
		return nil, err
	}

	// Add files from additionalFiles
	for _, filePath := range additionalFiles {
		fileBytes, err := os.ReadFile(filePath)
		if err != nil {
			return nil, err
		}
		overlay[filepath.Join(td, filepath.Base(filePath))] = load.FromBytes(fileBytes)
	}

	return overlay, nil
}

func toCamelCase(s string) string {
	return strings.ToLower(s[:1]) + s[1:]
}

// ReadAndCompileData reads the content from the given file path and compiles it using CUE.
func ReadAndCompileData(defPath string, dataFile string) (titleCaseDefPath string, data cue.Value, err error) {
	ds, err := os.ReadFile(dataFile)
	if err != nil {
		return "", cue.Value{}, err
	}

	ctx := cuecontext.New()
	compiledData := ctx.CompileBytes(ds)
	if compiledData.Err() != nil {
		return "", cue.Value{}, compiledData.Err()
	}

	titleCaseDefPath = toCamelCase(defPath)
	return titleCaseDefPath, compiledData, nil
}

func ReadSchemaFile(schema string) []byte {
	schemaData, err := os.ReadFile(schema)
	if err != nil {
		log.Fatalf("Error reading schema:%v", err)
	}
	return schemaData

}
