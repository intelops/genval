package cuecore

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/google/go-containerregistry/pkg/authn"
	"github.com/google/go-containerregistry/pkg/crane"
	"github.com/google/go-containerregistry/pkg/name"
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

// CheckTagAndPullArchive checks for provided tag to be available in the remote, if available pulls the archive
// and stores it in the specified directory and retuens an error if encountered.
func CheckTagAndPullArchive(url, tool string, archivePath *os.File) error {
	ref, err := name.ParseReference(url)
	if err != nil {
		return fmt.Errorf("error parsing url %s: %v", url, err)
	}

	parts := strings.Split(ref.String(), ":")
	ociref := parts[0]
	desiredTag := parts[1]

	opts := crane.WithAuthFromKeychain((authn.DefaultKeychain))

	tags, err := crane.ListTags(ociref, opts)
	if err != nil {
		return fmt.Errorf("error fetching tags from remote %s: %v	", ociref, err)
	}

	// Check if the desired tag is present in the remote tags
	found := false
	for _, tag := range tags {
		if tag == desiredTag {
			found = true
			break
		}
	}

	if !found {
		return fmt.Errorf("provided version '%s' of tool not found in remote: %v", desiredTag, err)
	}

	// Pull the image from the repository
	img, err := crane.Pull(ref.String())
	if err != nil {
		return fmt.Errorf("error pulling artifact from %s: %v", ref.String(), err)
	}

	// Export the image to the tarball file
	if err := crane.Export(img, archivePath); err != nil {
		return fmt.Errorf("error exporting artifact")
	}
	return nil
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
