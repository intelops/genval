package server

import (
	"os"

	"github.com/gin-gonic/gin"
	"github.com/intelops/genval/pkg/log"
)

const PORT = ":3030"

func InitServer() {
	logger := log.GetLogger()
	router := gin.Default()
	err := router.Run(PORT)

	if err != nil {
		logger.Errorf("Error starting server: %s", err)
		os.Exit(1)
	}
}
