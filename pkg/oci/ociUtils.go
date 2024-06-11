package oci

import (
	"archive/tar"
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	"github.com/google/go-containerregistry/pkg/name"
	log "github.com/sirupsen/logrus"
)

// ExtractTarContents extracts the contents of a tar.Reader to the specified directory.
func ExtractTarContents(tarReader *tar.Reader, destinationDir string) error {
	for {
		header, err := tarReader.Next()
		if err == io.EOF {
			// End of tar archive
			break
		}
		if err != nil {
			log.Errorf("failed to read tar header: %v", err)
			return err
		}

		// Ensure the entry is a regular file
		if header.Typeflag != tar.TypeReg {
			continue
		}

		// Build the full path for the extracted file
		filePath := filepath.Join(destinationDir, header.Name)

		// Create the directory if it doesn't exist
		if err := os.MkdirAll(filepath.Dir(filePath), os.ModePerm); err != nil {
			return fmt.Errorf("failed to create directory: %v", err)
		}

		// Create or open the file for writing
		file, err := os.Create(filePath)
		if err != nil {
			return fmt.Errorf("failed to create file: %v", err)
		}
		defer file.Close()

		// Copy the file contents from the tar reader to the new file
		if _, err := io.Copy(file, tarReader); err != nil {
			return fmt.Errorf("failed to copy file contents: %v", err)
		}
	}

	return nil
}

// GetGitRemoteURL fetches the remote url of the project
func GetGitRemoteURL() (string, error) {
	cmd := exec.Command("git", "config", "--get", "remote.origin.url")
	output, err := cmd.Output()
	if err != nil {
		return "", fmt.Errorf("failed to get Git remote URL: %w", err)
	}
	remoteURL := strings.TrimSpace(string(output))
	return remoteURL, nil
}

func ParseOCIURL(ociURL string) (name.Reference, error) {
	if !strings.HasPrefix(ociURL, URLPrefix) {
		return nil, fmt.Errorf("URL must be in format 'oci://<domain>/<org>/<repo>'")
	}

	url := strings.TrimPrefix(ociURL, URLPrefix)
	ref, err := name.ParseReference(url)
	if err != nil {
		return nil, fmt.Errorf("'%s' invalid URL: %w", ociURL, err)
	}

	return ref, nil
}
