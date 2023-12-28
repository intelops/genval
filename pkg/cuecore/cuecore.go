package cuecore

import (
	"fmt"
	"net/url"
	"os"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/load"
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
		return utils.CompileFromURL(client, u)
	}
	// Handle local file or directory
	return utils.CompileFromLocal(dataPath)
}
