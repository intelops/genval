package cuecore

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/joho/godotenv"
)

// ParseTools matches the tool provided is present in the .env file and returns
// the tool, the associated OCI URL and any error encountered
func ParseTools(reqTools string) (string, string, error) {
	if isToolSupported(reqTools) {
		mod := strings.Replace(reqTools, ":", "_", -1)
		umod := strings.ToUpper(mod)

		em, err := godotenv.Read("tools.env")
		if err != nil {
			return "", "", fmt.Errorf("error reading env: %v", err)
		}

		var tool, url string

		for k, v := range em {

			if k == umod {
				tool = k
				url = v
				break
			}
			if tool == "" {
				return "", "", fmt.Errorf("no matching tool found for %s", reqTools)
			}
			if url == "" {
				return "", "", fmt.Errorf("no matching URL found for %s", reqTools)
			}
		}
		return tool, url, nil
	} else {
		lastIndex := strings.LastIndex(reqTools, "/")
		if lastIndex == -1 {
			return "", "", fmt.Errorf("invalid string format")
		}
		return reqTools[lastIndex+1:], reqTools, nil
	}
}

func CreatePath(tool, subDir string) (string, error) {
	path := filepath.Join(tool, subDir)
	dir := filepath.Dir(path)
	if _, err := os.Stat(dir); os.IsNotExist(err) {
		err := os.MkdirAll(dir, 0o755) // Create parent directories if they don't exist
		if err != nil {
			return "", fmt.Errorf("error creating archive workspace: %v", err)
		}
	}

	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.Mkdir(path, 0o755)
		if err != nil {
			return "", fmt.Errorf("error initializing archive workspace: %v", err)
		}
	}
	return path, nil
}

var suporrtedTools = []string{"k8s:1.29", "argocd:2.10.4", "tektoncd:0.58.0", "crosplane:1.15.0"}

func isToolSupported(tool string) bool {
	for _, supportedTool := range suporrtedTools {
		if supportedTool == tool {
			return true
		}
	}
	return false
}
