package cmd

import (
	"testing"

	"github.com/intelops/genval/cmd/container"
	"github.com/intelops/genval/cmd/server"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

func TestRootCommand(t *testing.T) {
	cmd := rootCommand()

	if cmd.Use != "genvalctl" {
		t.Errorf("Expected Use to be genvalctl, but got %s", cmd.Use)
	}

	expectedAliases := []string{"gvctl"}
	if !compareStringSlices(cmd.Aliases, expectedAliases) {
		t.Errorf("Expected Aliases to be %v, but got %v", expectedAliases, cmd.Aliases)
	}

	if cmd.Version != "0.0.1" {
		t.Errorf("Expected Version to be 0.0.1, but got %s", cmd.Version)
	}

	expectedShort := "genvalctl is a CLI tool to generate and validate files"
	if cmd.Short != expectedShort {
		t.Errorf("Expected Short to be %s, but got %s", expectedShort, cmd.Short)
	}

	expectedLong := `
		░██████╗░███████╗███╗░░██╗██╗░░░██╗░█████╗░██╗░░░░░░█████╗░████████╗██╗░░░░░
		██╔════╝░██╔════╝████╗░██║██║░░░██║██╔══██╗██║░░░░░██╔══██╗╚══██╔══╝██║░░░░░
		██║░░██╗░█████╗░░██╔██╗██║╚██╗░██╔╝███████║██║░░░░░██║░░╚═╝░░░██║░░░██║░░░░░
		██║░░╚██╗██╔══╝░░██║╚████║░╚████╔╝░██╔══██║██║░░░░░██║░░██╗░░░██║░░░██║░░░░░
		╚██████╔╝███████╗██║░╚███║░░╚██╔╝░░██║░░██║███████╗╚█████╔╝░░░██║░░░███████╗
		░╚═════╝░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░╚════╝░░░░╚═╝░░░╚══════╝

		Genval is a versatile Go utility that simplifies configuration management for a wide range of tools, including Dockerfile, Kubernetes manifests, Helm, Timoni, Kustomize, Kubernetes Operators, Tekton, GitOps, Kubernetes Infrastructure YAML files, and more.
		`
	if cmd.Long != expectedLong {
		t.Errorf("Expected Long to be %s, but got %s", expectedLong, cmd.Long)
	}
}

func TestBuildCommand(t *testing.T) {
    logger := logrus.New()

    t.Run("TestRootCommandCreation", func(t *testing.T) {
        cmd := buildCommand(logger)
        if cmd == nil {
            t.Error("Expected root command to be created, but got nil")
        }
    })

    t.Run("TestContainerCommandAddition", func(t *testing.T) {
        cmd := buildCommand(logger)
        containerCmd := container.NewContainerCommand(logger)
        if !containsCommand(cmd, containerCmd) {
            t.Error("Expected container command to be added to the root command, but it was not found")
        }
    })

    t.Run("TestServerCommandAddition", func(t *testing.T) {
        cmd := buildCommand(logger)
        serverCmd := server.NewServerCommand(logger)
        if !containsCommand(cmd, serverCmd) {
            t.Error("Expected server command to be added to the root command, but it was not found")
        }
    })
}

func containsCommand(cmd *cobra.Command, subCmd *cobra.Command) bool {
    for _, c := range cmd.Commands() {
        if c.Name() == subCmd.Name() {
            return true
        }
    }
    return false
}

func TestExecute(t *testing.T) {
	// Test logger instance retrieval
	t.Run("GetLogger", func(t *testing.T) {
		// Add test logic here
	})

	// Test root command building
	t.Run("BuildCommand", func(t *testing.T) {
		// Add test logic here
	})

	// Test root command execution
	t.Run("ExecuteRootCommand", func(t *testing.T) {
		// Add test logic here
	})

	// Test error handling
	t.Run("HandleErrors", func(t *testing.T) {
		// Add test logic here
	})
}

func compareStringSlices(slice1, slice2 []string) bool {
	if len(slice1) != len(slice2) {
		return false
	}
	for i := range slice1 {
		if slice1[i] != slice2[i] {
			return false
		}
	}
	return true
}

