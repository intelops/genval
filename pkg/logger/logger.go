package logger

import (
	"runtime"

	log "github.com/sirupsen/logrus"
)

func init() {
	// Set log format
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp:   true,
		TimestampFormat: "2006-01-02 15:04:05",
		FieldMap: log.FieldMap{
			log.FieldKeyTime:  "@timestamp",
			log.FieldKeyLevel: "@level",
			log.FieldKeyMsg:   "@message",
		},
	})

	// Set log level
	log.SetLevel(log.DebugLevel)
}

func logWithCaller(fields log.Fields) *log.Entry {
	// Skip 2 levels to get the caller outside of this package
	if pc, file, line, ok := runtime.Caller(2); ok {
		funcName := runtime.FuncForPC(pc).Name()

		// Add the caller info to the provided fields
		fields["file"] = file
		fields["func"] = funcName
		fields["line"] = line
		return log.WithFields(fields)
	}
	return log.WithFields(fields)
}

// Info logs an informational message with caller details
func Info(msg string) {
	logWithCaller(log.Fields{}).Info(msg)
}

// Debug logs a debug message with caller details
func Debug(msg string) {
	logWithCaller(log.Fields{}).Debug(msg)
}

// Warn logs a warning message with caller details
func Warn(msg string) {
	logWithCaller(log.Fields{}).Warn(msg)
}

// Error logs an error message with caller details
func Error(args ...interface{}) {
	logWithCaller(log.Fields{}).Fatal(args...)
}

// Fatal logs a fatal error message with caller details
func Fatal(args ...interface{}) {
	logWithCaller(log.Fields{}).Fatal(args...)
}

// Panic logs a fatal error message with caller details
func Panic(args ...interface{}) {
	logWithCaller(log.Fields{}).Fatal(args...)
}

// Errorf logs a formatted error message with caller details
func Errorf(args ...interface{}) {
	logWithCaller(log.Fields{}).Fatal(args...)
}

// Fatalf logs a formatted fatal message with caller details and exits the program.
func Fatalf(format string, args ...interface{}) {
	logWithCaller(log.Fields{}).Fatalf(format, args...)
}
