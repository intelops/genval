package validate

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
)

func FetchRegoMetadata(policyDir, metaExt, regoExt string) ([]string, []string, error) {
	var metaFiles []string
	var regoFiles []string

	err := filepath.Walk(policyDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if !info.IsDir() {
			if filepath.Ext(info.Name()) == metaExt {
				metaFiles = append(metaFiles, path)
			} else if filepath.Ext(info.Name()) == regoExt {
				regoFiles = append(regoFiles, path)
			}
		}

		return nil
	})

	if len(regoFiles) == 0 {
		return nil, nil, fmt.Errorf("no Rego policy file found in the directory: %s", policyDir)
	}

	return metaFiles, regoFiles, err
}

// LoadRegoMetadata loads the contents of the metadata files into a slice of pointers to RegoMeta structs
func LoadRegoMetadata(filePaths []string) ([]*regoMetadata, error) {
	var metas []*regoMetadata

	for _, path := range filePaths {
		file, err := os.Open(path)
		if err != nil {
			return nil, err
		}
		defer file.Close()

		var meta regoMetadata
		err = json.NewDecoder(file).Decode(&meta)
		if err != nil {
			return nil, err
		}

		metas = append(metas, &meta)
	}

	return metas, nil
}

// MatchPolicyMetadata matches the RegoMeta policy names with the Rego evaluation results and returns the matched key
func MatchPolicyMetadata(metas []*regoMetadata, key string) (string, *regoMetadata, error) {
	for _, meta := range metas {
		if key == meta.PolicyName {
			return key, meta, nil
		}
	}
	return "", nil, fmt.Errorf("no matching policy name found for key: %s", key)
}
