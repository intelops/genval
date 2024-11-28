package otm

import (
	"fmt"

	"github.com/sirupsen/logrus"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/trace"
)

type otelHook struct {
	tracer trace.Tracer
}

// NewOTelHook creates a new instance of OTelHook
func NewOTelHook(tracer trace.Tracer) *otelHook {
	return &otelHook{tracer: tracer}
}

func (h *otelHook) Fire(entry *logrus.Entry) error {
	fmt.Println("OTelHook Fire invoked")
	ctx := entry.Context
	if ctx == nil {
		return nil
	}
	// Retrieve the span from the context if available
	span := trace.SpanFromContext(entry.Context)

	if !span.IsRecording() {
		return nil
	}

	// Map logrus fields to OpenTelemetry attributes
	attrs := make([]attribute.KeyValue, 0, len(entry.Data))
	for key, value := range entry.Data {
		attrs = append(attrs, attribute.String(key, fmt.Sprintf("%v", value)))
	}
	logrus.Printf("Recording log entry: %s", entry.Message) // Debug log
	// Record the log as an event on the active span
	span.AddEvent(entry.Message, trace.WithAttributes(attrs...))
	return nil
}

func (h *otelHook) Levels() []logrus.Level {
	return logrus.AllLevels
}
