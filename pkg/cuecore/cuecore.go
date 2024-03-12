package cuecore

import (
	"errors"
	"fmt"
	"io/fs"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"regexp"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/load"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
	"golang.org/x/net/html"
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

// GetDefinitions reads the files names of teh Cue definitions from the provided path and returns a []filenames and an error
func GetDefinitions(dirPath string) ([]string, error) {
	var filenames []string
	var err error

	if !utils.IsURL(dirPath) {
		entries, err := os.ReadDir(dirPath)
		if err != nil {
			return nil, err
		}
		// Skip directories
		for _, entry := range entries {
			if entry.IsDir() {
				continue
			}
			fileName := entry.Name()
			filenames = append(filenames, fileName)
		}

		return filenames, nil
	}
	// Attempt to parse the content as a URL
	u, err := url.ParseRequestURI(dirPath)
	if err == nil && strings.HasPrefix(u.Hostname(), "github.com") || strings.HasPrefix(u.Hostname(), "raw.githubusercontent.com") {
		fileCon, dirCon, err := utils.FetchFromGitHub(u.String())
		if err != nil {
			return nil, err
		}
		// Check if it's a directory or a single file
		if len(dirCon) == 0 {
			// If single file
			fn := fileCon.Name
			if err != nil {
				return nil, err
			}
			return []string{*fn}, nil
		}
		// If directory
		for _, files := range dirCon {
			if files.GetType() == "file" {
				fileCon, _, err := utils.FetchFromGitHub(files.GetDownloadURL())
				if err != nil {
					log.Errorf("Error reading file from GitHub Directory: %v", err)
					continue
				}
				fn := fileCon.Name
				if err != nil {
					return nil, err
				}
				return []string{*fn}, nil
			}
		}
	} else {
		resp, err := http.Get(dirPath)
		if err != nil {
			return nil, err
		}
		defer resp.Body.Close()

		if resp.StatusCode != http.StatusOK {
			return nil, fmt.Errorf("failed to fetch directory: %s", resp.Status)
		}

		// Parse the HTML content
		doc, err := html.Parse(resp.Body)
		if err != nil {
			return nil, err
		}

		// Extract filenames from the HTML structure
		var filenames []string
		var extractFilenames func(*html.Node)
		extractFilenames = func(n *html.Node) {
			if n.Type == html.ElementNode && n.Data == "a" {
				for _, attr := range n.Attr {
					if attr.Key == "href" {
						filenames = append(filenames, attr.Val)
						break
					}
				}
			}
			for c := n.FirstChild; c != nil; c = c.NextSibling {
				extractFilenames(c)
			}
		}

		extractFilenames(doc)

		return filenames, nil
	}
	return nil, errors.New("unsupported file source. Please provide a valid URL or a local file path")
}

func ExtractModule(dirPath string) (string, error) {
	relativeFilePath := "cue.mod/module.cue"
	fileURL := joinURLPath(dirPath, relativeFilePath)

	// Read the module.cue file
	content, err := utils.ReadFile(fileURL)
	if err != nil {
		return "", err
	}
	// Regular expression to find the module string
	re := regexp.MustCompile(`module:\s*"(.*?)"`)
	matches := re.FindStringSubmatch(string(content))
	if len(matches) < 2 {
		return "", errors.New("module not found in module.cue")
	}

	// Return the extracted module string
	return matches[1], nil
}

func joinURLPath(baseURL, relativePath string) string {
	base, err := url.Parse(baseURL)
	if err != nil {
		panic(err)
	}

	base.Path = filepath.Join(base.Path, relativePath)

	return base.String()
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
		byts, err := utils.ReadFile(p)
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
		policyBytes, err := utils.ReadFile(policyPath)
		if err != nil {
			log.Printf("Error reading policy file: %v", err)
			return nil, err
		}

		overlay[filepath.Join(td, filepath.Base(policy))] = load.FromBytes(policyBytes)
	}

	return overlay, nil
}
