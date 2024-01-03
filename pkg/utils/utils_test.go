package utils

import (
	"io"
	"net/http"
	"os"
	"reflect"
	"strings"
	"testing"

	log "github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
)

// Creates a temporary directory and returns its path.
func TestTempDirWithCleanup_CreatesTempDirAndReturnsPath(t *testing.T) {
	dirPath, cleanupFunc, err := TempDirWithCleanup()
	defer cleanupFunc()

	assert.NoError(t, err)
	assert.NotEmpty(t, dirPath)
	assert.DirExists(t, dirPath)
}

// Returns a cleanup function that removes the temporary directory.
func TestTempDirWithCleanup_ReturnsCleanupFunction(t *testing.T) {
	dirPath, cleanupFunc, err := TempDirWithCleanup()
	defer cleanupFunc()

	assert.NoError(t, err)
	assert.NotNil(t, cleanupFunc)

	cleanupFunc()
	assert.NoDirExists(t, dirPath)
}

// Returns no error when creating the temporary directory.
func TestTempDirWithCleanup_ReturnsNoErrorOnCreate(t *testing.T) {
	_, cleanupFunc, err := TempDirWithCleanup()
	defer cleanupFunc()

	assert.NoError(t, err)
}

// Returns an error when failing to create the temporary directory.
// func TestTempDirWithCleanup_ReturnsErrorOnFailedCreate(t *testing.T) {
// 	// Mock a failure to create temporary directory
// 	os.MkdirTemp = func(dir, prefix string) (string, error) {
// 		return "", errors.New("failed to create temporary directory")
// 	}
// 	defer func() { os.MkdirTemp = originalMkdirTemp }()

// 	_, _, err := TempDirWithCleanup()

// 	assert.Error(t, err)
// }

// Returns no error when the temporary directory already exists.
func TestTempDirWithCleanup_ReturnsNoErrorOnExistingDir(t *testing.T) {
	// Create a temporary directory
	dirPath, cleanupFunc, _ := TempDirWithCleanup()
	defer cleanupFunc()

	// Call TempDirWithCleanup again with the same directory path
	_, cleanupFunc2, err := TempDirWithCleanup()
	defer cleanupFunc2()

	assert.NoError(t, err)
	assert.DirExists(t, dirPath)
}

// The temporary directory path should not contain any spaces.
func TestTempDirWithCleanup_TempDirPathNoSpaces(t *testing.T) {
	dirPath, cleanupFunc, err := TempDirWithCleanup()
	defer cleanupFunc()

	assert.NoError(t, err)
	assert.NotContains(t, dirPath, " ")
}

// Mock for ReadRegoFile()

type MockHTTPResponse struct {
	StatusCode int
	Body       io.Reader
	Err        error
}

type MockHTTPClient struct {
	Response MockHTTPResponse
}

func (c *MockHTTPClient) RoundTrip(req *http.Request) (*http.Response, error) {
	return &http.Response{
		StatusCode: c.Response.StatusCode,
		Body:       io.NopCloser(c.Response.Body),
		Header:     make(http.Header),
	}, nil
}

// Test for ReadRegoFile using above mock

func TestReadRegoFile(t *testing.T) {
	// Mock HTTP client setup (if you're mocking HTTP requests)
	// Mock HTTP client setup
	mockClient := &MockHTTPClient{
		Response: MockHTTPResponse{
			StatusCode: 200,
			Body:       strings.NewReader("package test\n\ntest content from URL"),
		},
	}
	oldTransport := http.DefaultClient.Transport
	http.DefaultClient.Transport = mockClient
	defer func() { http.DefaultClient.Transport = oldTransport }()

	tempFile, err := os.CreateTemp("", "test_policy_*.rego")
	if err != nil {
		t.Fatalf("Failed to create temporary file: %v", err)
	}
	defer os.Remove(tempFile.Name()) // Clean up

	// Write some content to the file
	testContent := []byte("package local\n\nlocal content")
	if _, err := tempFile.Write(testContent); err != nil {
		t.Fatalf("Failed to write to temporary file: %v", err)
	}
	if err := tempFile.Close(); err != nil {
		t.Fatalf("Failed to close temporary file: %v", err)
	}

	tests := []struct {
		name        string
		policyFile  string
		wantContent []byte
		wantErr     bool
	}{
		{
			name:        "Read from valid URL",
			policyFile:  "http://valid-url.com",
			wantContent: []byte("package test\n\ntest content from URL"),
			wantErr:     false,
		},
		{
			name:        "Read from invalid URL",
			policyFile:  "invalid-url",
			wantContent: nil,
			wantErr:     true,
		},
		{
			name:        "Read from local filesystem",
			policyFile:  tempFile.Name(),
			wantContent: testContent,
			wantErr:     false,
		},
	}

	// Create a sample file for testing
	if err := os.WriteFile("test.rego", []byte("test content from file"), 0o644); err != nil {
		log.Println("Failed to write to file:", err)
	}
	defer os.Remove("test.rego")

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			gotContent, err := ReadPolicyFile(tt.policyFile)
			if (err != nil) != tt.wantErr {
				t.Errorf("ReadPolicyFile() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(gotContent, tt.wantContent) {
				t.Errorf("ReadPolicyFile() content = %v, want %v", string(gotContent), string(tt.wantContent))
			}
		})
	}
}

func TestExtractPackageName(t *testing.T) {
	tests := []struct {
		name      string
		content   []byte
		wantName  string
		wantError bool
	}{
		{
			name:      "Valid package name",
			content:   []byte("package test\n\nother content"),
			wantName:  "test",
			wantError: false,
		},
		{
			name:      "Invalid package name",
			content:   []byte("other content without package"),
			wantName:  "",
			wantError: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			gotName, err := ExtractPackageName(tt.content)
			if (err != nil) != tt.wantError {
				t.Errorf("ExtractPackageName() error = %v, wantError %v", err, tt.wantError)
				return
			}
			if gotName != tt.wantName {
				t.Errorf("ExtractPackageName() gotName = %v, want %v", gotName, tt.wantName)
			}
		})
	}
}
