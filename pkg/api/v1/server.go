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
	r.POST("/container", route.ContainerHandeler)
	r.POST("/cue", route.CueHandeler)
	r.POST("/k8s", route.K8sHandeler)
	r.POST("/tf", route.TfHandeler)
	r.POST("/cel", route.CELHandeler)

	return r
}
