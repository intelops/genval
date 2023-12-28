package cuecore

import (
	"errors"
	"fmt"
	"io/fs"
	"net/url"
	"os"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	"github.com/google/go-github/v57/github"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"gopkg.in/yaml.v3"
)

func BuildInstance(ctx *cue.Context, policies []string, conf *load.Config) ([]cue.Value, error) {
	var err error
	bi := load.Instances(policies, conf)
	if len(bi) == 0 {
		return nil, fmt.Errorf("no instances found")
	}
	v, err := ctx.BuildInstances(bi)
	if err != nil {
		log.Errorf("Error building instances: %v", err)
	}
	return v, err
}

func UnifyAndValidate(def cue.Value, data cue.Value) (cue.Value, error) {
	value := def.Unify(data)
	if value.Err() != nil {
		return cue.Value{}, value.Err()
	}

	err := value.Validate(cue.Concrete(true), cue.Final())
	if err != nil {
		return cue.Value{}, err
	}
	return value, nil
}

func MarshalToYAML(value cue.Value) ([]byte, error) {
	o, err := value.MarshalJSON()
	if err != nil {
		return nil, err
	}

	var output map[string]interface{}
	err = yaml.Unmarshal(o, &output)
	if err != nil {
		return nil, err
	}

	return yaml.Marshal(output)
}

// ReadAndCompileData reads the content from the given file path or GitHub URL and compiles it into cue.Value.
func ReadAndCompileData(dataPath string) (map[string]cue.Value, error) {
	token := os.Getenv("GITHUB_TOKEN")
	// Use environment variable for GitHub token
	client := utils.CreateGitHubClient(token)

	// Check if dataPath is a URL
	if u, err := url.ParseRequestURI(dataPath); err == nil && u.Scheme != "" && u.Host != "" {
		return CompileFromURL(client, u)
	}
	// Handle local file or directory
	return CompileFromLocal(dataPath)
}

// GenerateOverlay creates an overlay to store cue schemas from a given directory
func GenerateOverlay(dirPath string, td string, policies []string) (map[string]load.Source, error) {
	overlay := make(map[string]load.Source)

	// Process .cue files in the directory
	err := filepath.WalkDir(dirPath, func(p string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if !d.Type().IsRegular() || !strings.HasSuffix(p, ".cue") {
			return nil
		}

		// Ensure the file is within the specified subdirectories
		relPath, err := filepath.Rel(dirPath, p)
		if err != nil {
			return err
		}
		if !strings.HasPrefix(relPath, "cue.mod/module.cue") && !strings.HasPrefix(relPath, "cue.mod/gen") && !strings.HasPrefix(relPath, "cue.mod") {
			return nil
		}

		// Read and add the file content to the overlay
		byts, err := os.ReadFile(p)
		if err != nil {
			return err
		}
		op := filepath.Join(td, relPath)
		overlay[op] = load.FromBytes(byts)
		return nil
	})
	if err != nil {
		return nil, err
	}

	// Add files from policies
	for _, policy := range policies {
		if !strings.HasSuffix(policy, ".cue") {
			return nil, errors.New("policy file is not a .cue file")
		}

		// Construct the full path to the policy file
		policyPath := filepath.Join(dirPath, policy)

		// Read the policy file
		policyBytes, err := os.ReadFile(policyPath)
		if err != nil {
			log.Printf("Error reading policy file: %v", err)
			return nil, err
		}

		overlay[filepath.Join(td, filepath.Base(policy))] = load.FromBytes(policyBytes)
	}

	return overlay, nil
}

// compileFromURL parses the Github URL, reads the contents and compiles it to Cue Value
func CompileFromURL(client *github.Client, u *url.URL) (map[string]cue.Value, error) {
	dataMap := make(map[string]cue.Value)
	ctx := cuecontext.New()

	// Use fetchFromGitHub to get the file or directory content
	fileCon, dirCon, err := utils.FetchFromGitHub(u.String(), client)
	if err != nil {
		return nil, err
	}

	// Check if it's a directory or a single file
	if len(dirCon) == 0 {
		// If single file
		fileContent, err := fileCon.GetContent()
		if err != nil {
			return nil, err
		}
		compiledData := ctx.CompileBytes([]byte(fileContent))
		if compiledData.Err() != nil {
			return nil, compiledData.Err()
		}
		dataMap[fileCon.GetName()] = compiledData
	} else {
		// If directory
		for _, content := range dirCon {
			if content.GetType() == "file" {
				fileCon, _, err := utils.FetchFromGitHub(content.GetDownloadURL(), client)
				if err != nil {
					log.Errorf("Error reading file from GitHub Directory: %v", err)
					continue
				}
				fileContent, err := fileCon.GetContent()
				if err != nil {
					return nil, err
				}
				compiledData := ctx.CompileBytes([]byte(fileContent))
				if compiledData.Err() != nil {
					return nil, compiledData.Err()
				}
				dataMap[content.GetName()] = compiledData
			}
		}
	}
	return dataMap, nil
}

// compileFromLocal processes either a single file or all files in a directory.
func CompileFromLocal(path string) (map[string]cue.Value, error) {
	dataMap := make(map[string]cue.Value)
	// Check if the path is a directory or a single file.
	fileInfo, err := os.Stat(path)
	if err != nil {
		return nil, err
	}

	if fileInfo.IsDir() {
		// Handle directory.
		files, err := os.ReadDir(path)
		if err != nil {
			return nil, err
		}

		for _, file := range files {
			if !file.IsDir() {
				filePath := filepath.Join(path, file.Name())
				err := compileAndAddFile(filePath, dataMap)
				if err != nil {
					return nil, err
				}
			}
		}
	} else {
		// Handle single file.
		err := compileAndAddFile(path, dataMap)
		if err != nil {
			return nil, err
		}
	}

	return dataMap, nil
}

// compileAndAddFile reads, compiles a file, and appends it to the dataMap.
func compileAndAddFile(filePath string, dataMap map[string]cue.Value) error {
	fileContent, err := os.ReadFile(filePath)
	if err != nil {
		return err
	}
	ctx := cuecontext.New()
	compiledData := ctx.CompileBytes(fileContent)
	if compiledData.Err() != nil {
		return compiledData.Err()
	}
	dataMap[filepath.Base(filePath)] = compiledData
	return nil
}
