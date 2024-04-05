package oci

import (
	"archive/tar"
	"compress/gzip"
	"context"
	"errors"
	"fmt"
	"io"
	"io/fs"
	"os"
	"path/filepath"
	"strings"

	"github.com/google/go-containerregistry/pkg/authn"
	"github.com/google/go-containerregistry/pkg/crane"
	"github.com/google/go-containerregistry/pkg/name"
	"github.com/intelops/genval/pkg/cuecore"
	log "github.com/sirupsen/logrus"
)

func ParseAnnotations(args []string) (map[string]string, error) {
	annotations := map[string]string{}
	for _, annotation := range args {
		kv := strings.Split(annotation, "=")
		if len(kv) != 2 {
			return annotations, fmt.Errorf("invalid annotation %s, must be in the format key=value", annotation)
		}
		annotations[kv[0]] = kv[1]
	}

	return annotations, nil
}

// CreateTarball creates a tarball from a file or directory.
func CreateTarball(sourcePath, outputPath string) error {
	outputFile, err := os.Create(outputPath)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	gzipWriter := gzip.NewWriter(outputFile)
	defer gzipWriter.Close()

	tarWriter := tar.NewWriter(gzipWriter)
	defer tarWriter.Close()

	// Get the list of files and directories to be included in the tarball
	var fileList []string
	var topLevelDir string
	fileInfo, err := os.Stat(sourcePath)
	if err != nil {
		return err
	}
	if fileInfo.IsDir() {
		// If sourcePath is a directory, recursively get all files in the directory
		topLevelDir = filepath.Base(sourcePath)
		err := filepath.WalkDir(sourcePath, func(path string, d fs.DirEntry, err error) error {
			if err != nil {
				return err
			}
			fileList = append(fileList, path)
			return nil
		})
		if err != nil {
			return err
		}
	} else {
		// If sourcePath is a file, add the file to the fileList
		fileList = append(fileList, sourcePath)
		topLevelDir = ""
	}

	// Iterate over each file to add it to the tarball
	for _, filePath := range fileList {
		// Calculate the relative path of the file within the source directory
		relPath, err := filepath.Rel(sourcePath, filePath)
		if err != nil {
			return err
		}
		// Fix path separator for tarball (always use forward slashes)
		relPath = strings.ReplaceAll(relPath, `\`, "/")

		fileInfo, err := os.Stat(filePath)
		if err != nil {
			return err
		}

		header, err := tar.FileInfoHeader(fileInfo, "")
		if err != nil {
			return err
		}

		// Update the name field in the header to preserve directory structure
		if topLevelDir != "" {
			header.Name = filepath.Join(topLevelDir, relPath)
		} else {
			header.Name = relPath
		}

		if err := tarWriter.WriteHeader(header); err != nil {
			return err
		}

		if !fileInfo.IsDir() {
			file, err := os.Open(filePath)
			if err != nil {
				return err
			}
			defer file.Close()

			// Copy file content to tarball
			if _, err := io.Copy(tarWriter, file); err != nil {
				return err
			}
		}
	}

	return nil
}

// PullArtifact checks if tag exists and pull's the artifact from remote repository and writes to disk
func PullArtifact(ctx context.Context, dest, path string) error {
	if dest == "" {
		return errors.New("artifact URL can not be empty")
	}
	if fs, err := os.Stat(path); err != nil || !fs.IsDir() {
		log.Errorf("Invalid Output path: %s requires a directory", err)
		return err
	}
	ref, err := name.ParseReference(dest)
	if err != nil {
		log.Errorf("Invalid URL: %v", err)
		return err
	}

	parts := strings.Split(ref.String(), ":")
	url := parts[0]
	desiredTag := parts[1]

	opts := make([]crane.Option, 0)

	// Try to use crane.WithAuthFromKeychain(authn.DefaultKeychain)
	keychainOpts := []crane.Option{crane.WithAuthFromKeychain(authn.DefaultKeychain)}
	if _, err := crane.ListTags(url, keychainOpts...); err == nil {
		opts = append(opts, keychainOpts...)
	} else {
		// Fallback to using credentials provided as ENV variable with crane.WithAuth(auth)

		opts, err = GetCreds()
		if err != nil {
			return fmt.Errorf("error reading credentials: %v", err)
		}
	}
	tags, err := crane.ListTags(url, opts...)
	if err != nil {
		log.Error("Error fetching tags from remote")
		return err
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
		log.Errorf("Provided artifact tag '%s' not found in remote", desiredTag)
		return err
	}

	// Pull the image from the repository
	img, err := crane.Pull(ref.String(), opts...)
	if err != nil {
		log.Error("error pulling artifact:")
		return err
	}

	tempDir, err := os.MkdirTemp("", "artifact")
	if err != nil {
		log.Error("error creating temp dir:")
		return err
	}
	defer os.RemoveAll(tempDir)

	tarballPath := filepath.Join(tempDir, "artifact.tar.gz")

	destTar, err := os.Create(tarballPath)
	if err != nil {
		log.Error("error creating tarball file:")
		return err
	}
	defer destTar.Close()

	// Export the image to the tarball file
	if err := crane.Export(img, destTar); err != nil {
		log.Error("error exporting artifact")
		return err
	}

	reader, err := os.Open(tarballPath)
	if err != nil {
		log.Error("error opening tarball file:")
		return err
	}
	defer reader.Close()

	tarReader := tar.NewReader(reader)

	if err := ExtractTarContents(tarReader, path); err != nil {
		log.Errorf("error extracting artifact:")
		return err
	}

	return nil
}

func GetCreds() ([]crane.Option, error) {
	opts := []crane.Option{}
	homeDir, err := os.UserHomeDir()
	if err != nil {
		return nil, fmt.Errorf("error getting user's home directory: %v", err)
	}
	credPath := filepath.Join(homeDir, ".docker", "config.json")
	_, err = os.Stat(credPath)
	if err != nil {
		if os.IsNotExist(err) {
			// Docker config file doesn't exist, check environment variables
			user, ok := os.LookupEnv("ARTIFACT_REGISTRY_USERNAME")
			if !ok {
				return nil, errors.New("ARTIFACT_REGISTRY_USERNAME environment variable not set")
			}

			pass, ok := os.LookupEnv("ARTIFACT_REGISTRY_PASSWORD")
			if !ok {
				return nil, errors.New("ARTIFACT_REGISTRY_PASSWORD environment variable not set")
			}

			if user == "" || pass == "" {
				return nil, errors.New("username or password is empty")
			}

			// Create authentication config
			authConfig := authn.AuthConfig{Username: user, Password: pass}
			opts = append(opts, crane.WithAuth(authn.FromConfig(authConfig)))
		} else {
			// Other error occurred while checking for Docker config file
			return nil, fmt.Errorf("error checking Docker config at %s: %v", credPath, err)
		}
	} else {
		// Docker config file exists, use default keychain
		opts = append(opts, crane.WithAuthFromKeychain(authn.DefaultKeychain))
	}

	return opts, nil
}

func CreateWorkspace(tool, desiredTool, ociURL string) error {
	archivePath, err := cuecore.CreatePath(tool, "archive")
	if err != nil {
		return fmt.Errorf("error initializing archive %s: %v", tool, err)
	}

	tarballPath := filepath.Join(archivePath, "cuemod-"+tool+".tar.gz")
	destTar, err := os.Create(tarballPath)
	if err != nil {
		return fmt.Errorf("error creating workpace archive %s: %v", tarballPath, err)
	}
	defer destTar.Close()

	if err := cuecore.CheckTagAndPullArchive(ociURL, desiredTool, destTar); err != nil {
		log.Errorf("Error pulling module for %s from %v: %v", desiredTool, destTar, err)
	}
	extractPath, err := cuecore.CreatePath(tool, "extracted-content")
	if err != nil {
		return fmt.Errorf("error initializing workspace files %s: %v", tool, err)
	}

	reader, err := os.Open(tarballPath)
	if err != nil {
		return fmt.Errorf("error opening archive %s: %v", tarballPath, err)
	}
	defer reader.Close()

	tarReader := tar.NewReader(reader)

	if err := ExtractTarContents(tarReader, extractPath); err != nil {
		return fmt.Errorf("error extracting archive: %s", err)
	}
	return nil
}
