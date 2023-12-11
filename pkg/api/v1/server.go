package api

import (
	"os"

	"github.com/gin-gonic/gin"
	"github.com/intelops/genval/pkg/api/route"
	"github.com/sirupsen/logrus"
)

var log = logrus.New()

func init() {
	// Open a file for logging
	file, err := os.OpenFile("server.log", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
	if err == nil {
		log.Out = file
	} else {
		log.Debug("Failed to log to file, using default stderr")
	}
}

func SetupAPI() *gin.Engine {
	r := gin.Default()
	r.POST("/container", route.CallEndpoint)
	r.POST("/cue", route.CallEndpoint)
	r.POST("/k8s", route.CallEndpoint)
	r.POST("/tf", route.CallEndpoint)
	r.POST("/cel", route.CallEndpoint)

	return r
}
