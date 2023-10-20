package utils

import (
	"io"
	"net/http"
	"os"
	"reflect"
	"strings"
	"testing"

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
	// Mock HTTP client
	mockClient := &MockHTTPClient{
		Response: MockHTTPResponse{
			StatusCode: 200,
			Body:       strings.NewReader("test content from URL"),
		},
	}
	http.DefaultClient.Transport = mockClient

	tests := []struct {
		name       string
		policyFile string
		want       []byte
		wantErr    bool
	}{
		{
			name:       "Read from valid URL",
			policyFile: "http://valid-url.com",
			want:       []byte("test content from URL"),
			wantErr:    false,
		},
		{
			name:       "Read from invalid URL",
			policyFile: "invalid-url",
			want:       nil,
			wantErr:    true,
		},
		{
			name:       "Read from local file",
			policyFile: "test.rego",
			want:       []byte("test content from file"),
			wantErr:    false,
		},
		// Add more test cases as needed...
	}

	// Create a sample file for testing
	os.WriteFile("test.rego", []byte("test content from file"), 0644)
	defer os.Remove("test.rego")

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := ReadPolicyFile(tt.policyFile)
			if (err != nil) != tt.wantErr {
				t.Errorf("ReadRegoFile() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("ReadRegoFile() = %v, want %v", got, tt.want)
			}
		})
	}
}
