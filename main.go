package main

import (
	"os"

	"github.com/intelops/genval/cmd"
	"github.com/intelops/genval/pkg/log"
	"github.com/intelops/genval/pkg/storage"
)

func main() {
	logger := log.GetLogger()
	// Initialize Database
	err := storage.InitDatabase()
	if err != nil {
		logger.Debugf("Error initializing database: %v", err)
		os.Exit(1)
	}
	cmd.Execute()
	// TODO: Create server execution
}
