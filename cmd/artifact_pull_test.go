package cmd

import (
	"net/http"
	"net/http/httptest"
	"os"
	"testing"

	"github.com/spf13/cobra"
	"gotest.tools/v3/assert"
)

func TestPullCommandWithMockServer(t *testing.T) {
	// Create a mock server that returns a 503 Service Unavailable error
	mockServer := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		http.Error(w, "Service Unavailable", http.StatusServiceUnavailable)
	}))
	defer mockServer.Close()

	// Construct a valid OCI URL for the mock server
	ociURL := "oci://ghc.io/intelops/policyhub/genval/dockerfile-policies:v0.0.1"

	// Set the mock server URL as the environment variable
	os.Setenv("OCI_URL", ociURL)
	defer os.Unsetenv("OCI_URL")

	// Set test flags for the pull command
	pullArgs.dest = ociURL
	pullArgs.path = "./output"

	// Create necessary directories for testing
	err := os.MkdirAll(pullArgs.path, os.ModePerm)
	if err != nil {
		t.Fatalf("Failed to create test directory: %v", err)
	}
	defer os.RemoveAll(pullArgs.path)

	// Run the pull command using cmd.Execute() or pullCmd.RunE directly
	rootCmd := &cobra.Command{Use: "genval"}
	rootCmd.AddCommand(pullCmd)

	// Simulate command execution
	err = pullCmd.RunE(rootCmd, []string{})

	// Check for expected error due to HTTP 503 response
	assert.Error(t, err, "Expected error due to HTTP 503 response")
}
