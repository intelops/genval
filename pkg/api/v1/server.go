package api

import (
	"bytes"
	"io"
	"net/http"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/intelops/genval/pkg/api/route"
	"github.com/sirupsen/logrus"
)

func requestLoggingMiddleware(logger *logrus.Logger) gin.HandlerFunc {
	start := time.Now()
	return func(c *gin.Context) {
		// Read the request body
		bodyBytes, err := io.ReadAll(c.Request.Body)
		if err != nil {
			logger.WithField("error", err.Error()).Error("Failed to read request body")
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Internal Server Error"})
			c.Abort()
			return
		}
		c.Request.Body = io.NopCloser(bytes.NewBuffer(bodyBytes))
		bodyString := string(bodyBytes)

		// Process request
		c.Next()

		end := time.Now()
		latency := end.Sub(start).Milliseconds()
		// Log request details``
		entry := logger.WithFields(logrus.Fields{
			"status":        c.Writer.Status(),
			"method":        c.Request.Method,
			"path":          c.Request.URL.Path,
			"query_params":  c.Request.URL.Query(),
			"req_body":      bodyString,
			"response_time": latency,
			"client_ip":     c.ClientIP(),
			"user_agent":    c.GetHeader("User-Agent"),
		})

		// Log response details if available
		if len(c.Errors) > 0 {
			entry = entry.WithField("res_error", c.Errors.String())
		}
		logger.SetFormatter(&logrus.JSONFormatter{})
		entry.Info("Request details")
	}
}

func SetupAPI() *gin.Engine {
	r := gin.Default()

	// Create a new Logrus logger instance
	logger := logrus.New()
	logger.SetLevel(logrus.InfoLevel)

	logFile, err := os.OpenFile("server.log", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
	if err == nil {
		// Output logs to both the console and a file
		// logger.Out = io.MultiWriter(os.Stdout, logFile)
		// Output logs to a file
		logger.Out = io.MultiWriter(logFile)

	} else {
		logger.Info("Failed to log to file, using default stderr")
	}

	r.Use(gin.LoggerWithWriter(logger.Writer()))
	r.Use(requestLoggingMiddleware(logger))

	r.POST("/container", route.ContainerHandler)
	r.POST("/cue", route.CueHandler)
	r.POST("/k8s", route.K8sHandler)
	r.POST("/tf", route.TfHandler)
	r.POST("/cel", route.CELHandler)

	return r
}
