package oci

import (
	"archive/tar"
	"fmt"
	"io"
	"net/url"
	"os"
	"path/filepath"
	"strings"

	"github.com/go-git/go-git/v5"
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

// GetGitRemoteURL fetches the remote url
func GetRemoteURL() (string, error) {
	// Open the existing repository in the current directory
	repo, err := git.PlainOpen(".")
	if err != nil {
		return "", fmt.Errorf("unable to open the git repository: %w", err)
	}

	remoteName := "origin"
	remote, err := repo.Remote(remoteName)
	if err != nil {
		return "", fmt.Errorf("unable to determine upstream git vcs url: %w", err)
	}

	remoteConfig := remote.Config()
	remoteURL := remoteConfig.URLs[0]

	normalizedURL, err := url.Parse(remoteURL)
	if err != nil {
		// URL is most likely a git+ssh:// type URL, represented
		// in the way git itself does so.

		// Take the user@host:repo and turn it into user@host/repo.
		remoteURL = strings.Replace(remoteURL, ":", "/", 1)
		remoteURL = fmt.Sprintf("git+ssh://%s", remoteURL)

		normalizedURL, err = url.Parse(remoteURL)
		if err != nil {
			return "", fmt.Errorf("unable to parse %s as a git vcs url: %w", remoteURL, err)
		}
	}

	// sanitize any user authentication data from the VCS URL
	normalizedURL.User = nil

	return normalizedURL.String(), nil
}

func ParseOCIReference(ociURL string) (name.Reference, error) {
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
