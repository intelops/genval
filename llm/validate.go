package llm

import (
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"fmt"
	"io"
	"net/http"

	"github.com/intelops/genval/pkg/utils"
)

// computeSHA256 computes the SHA-256 hash of a file.
func computeSHA256(filePath string) (string, error) {
	data, err := utils.ReadFile(filePath)
	if err != nil {
		return "", err
	}

	hash := sha256.Sum256(data)
	return hex.EncodeToString(hash[:]), nil
}

// fetchRemoteSHA256 fetches the SHA-256 hash of a file from a remote Git repository.
func fetchRemoteSHA256(remoteURL string) (string, error) {
	resp, err := http.Get(remoteURL)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return "", errors.New("failed to fetch remote file")
	}

	data, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	hash := sha256.Sum256(data)
	return hex.EncodeToString(hash[:]), nil
}

// validateFile compares the SHA-256 hash of a local file with that of a remote file.
func ValidateSystemPrompt(localFilePath string, remoteURL string) error {
	localHash, err := computeSHA256(localFilePath)
	if err != nil {
		return fmt.Errorf("error computing local SHA-256: %v", err)
	}

	remoteHash, err := fetchRemoteSHA256(remoteURL)
	if err != nil {
		return fmt.Errorf("error fetching remote SHA-256: %v", err)
	}

	if localHash == remoteHash {
		return nil
	}

	fmt.Println("SHA-256 does not match.")
	return errors.New("file validation failed: local and remote hashes do not match")
}
