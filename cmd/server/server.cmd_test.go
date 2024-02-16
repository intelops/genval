package server

import (
	"testing"

	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
)

func TestNewServerCommand(t *testing.T) {
	logger := logrus.New()
	serverCommand := NewServerCommand(logger)

	assert.NotNil(t, serverCommand, "Expected server command to not be nil")
	assert.Equal(t, "server", serverCommand.Use, "Expected Use to be 'server'")
	assert.Equal(t, "Run server", serverCommand.Short, "Expected Short to be 'Run server'")
	assert.Equal(t, "Run server", serverCommand.Long, "Expected Long to be 'Run server'")
	assert.NotNil(t, serverCommand.RunE, "Expected RunE to not be nil")
}
