package logger

import (
	"github.com/sirupsen/logrus"
)

var log = logrus.New()

// Init initializes the logger with a JSON formatter and sets the log level.
func Init() *logrus.Logger {
	log.SetFormatter(&logrus.JSONFormatter{})
	log.SetLevel(logrus.InfoLevel)
	return log
}

// WithFields returns a log entry with the given fields.
func WithFields(fields logrus.Fields) *logrus.Entry {
	return log.WithFields(fields)
}
