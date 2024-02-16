package container

import (
	"reflect"
	"testing"

	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
)

func TestNewContainerCommand(t *testing.T) {
	logger := logrus.New()
	containerCmd := NewContainerCommand(logger)

	assert.NotNil(t, cmd.logger, "Logger should be set")
	assert.NotNil(t, cmd.projectName, "Project name should be initialized")
	assert.Equal(t, "container", containerCmd.Use, "Command use should be set correctly")
	assert.Equal(t, "Manage containers", containerCmd.Short, "Command short description should be set correctly")
	assert.Equal(t, "Manage containers", containerCmd.Long, "Command long description should be set correctly")
	assert.Equal(t, reflect.ValueOf(cmd.run).Pointer(), reflect.ValueOf(containerCmd.RunE).Pointer(), "Run function should be set correctly")
}

