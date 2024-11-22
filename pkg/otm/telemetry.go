package otm

import (
	"context"
	"log"
	"strings"
	"time"

	"github.com/spf13/cobra"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/exporters/stdout/stdoutmetric"
	"go.opentelemetry.io/otel/exporters/stdout/stdouttrace"
	"go.opentelemetry.io/otel/propagation"
	"go.opentelemetry.io/otel/sdk/instrumentation"
	metricsdk "go.opentelemetry.io/otel/sdk/metric"
	"go.opentelemetry.io/otel/sdk/metric/metricdata"
	"go.opentelemetry.io/otel/sdk/resource"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
	semconv "go.opentelemetry.io/otel/semconv/v1.26.0"
	"go.opentelemetry.io/otel/trace"
)

var tracer trace.Tracer

func SetupMetrics() func() {
	now := time.Now() // Define the current time

	// Create a resource with attributes
	res, err := resource.New(
		context.Background(),
		resource.WithAttributes(
			attribute.String("service.name", "genval"),
			attribute.String("library.language", "Golang"),
		),
	)
	if err != nil {
		log.Fatalf("failed to create resource: %v", err)
	}

	// Define mock data
	mockData := metricdata.ResourceMetrics{
		Resource: res,
		ScopeMetrics: []metricdata.ScopeMetrics{
			{
				Scope: instrumentation.Scope{Name: "genval", Version: "0.1.7"},
				Metrics: []metricdata.Metrics{
					{
						Name:        "system.cpu.time",
						Description: "Accumulated CPU time spent",
						Unit:        "s",
						Data: metricdata.Sum[float64]{
							IsMonotonic: true,
							Temporality: metricdata.CumulativeTemporality,
							DataPoints: []metricdata.DataPoint[float64]{
								{
									Attributes: attribute.NewSet(attribute.String("state", "user")),
									StartTime:  now,
									Time:       now.Add(1 * time.Second),
									Value:      0.5,
								},
							},
						},
					},
					{
						Name:        "system.memory.usage",
						Description: "Memory usage",
						Unit:        "By",
						Data: metricdata.Gauge[int64]{
							DataPoints: []metricdata.DataPoint[int64]{
								{
									Attributes: attribute.NewSet(attribute.String("state", "used")),
									Time:       now.Add(1 * time.Second),
									Value:      100,
								},
							},
						},
					},
				},
			},
		},
	}

	// Create an exporter to output metrics to stdout
	exporter, err := stdoutmetric.New(stdoutmetric.WithPrettyPrint())
	if err != nil {
		log.Fatalf("failed to initialize stdout exporter: %v", err)
	}

	// Create a MeterProvider with the exporter
	provider := metricsdk.NewMeterProvider(
		metricsdk.WithResource(res),
		metricsdk.WithReader(metricsdk.NewPeriodicReader(exporter)),
	)
	otel.SetMeterProvider(provider)

	// Export mock data (for demonstration purposes)
	err = exporter.Export(context.Background(), &mockData)
	if err != nil {
		log.Fatalf("failed to export mock data: %v", err)
	}

	// Return shutdown function
	return func() {
		if err := provider.Shutdown(context.Background()); err != nil {
			log.Fatalf("failed to shutdown MeterProvider: %v", err)
		}
	}
}

func SetupTracer() (*sdktrace.TracerProvider, error) {
	exporter, err := stdouttrace.New(stdouttrace.WithPrettyPrint())
	if err != nil {
		return nil, err
	}

	prop := newPropagator()
	otel.SetTextMapPropagator(prop)
	r, err := resource.Merge(resource.Default(), resource.NewWithAttributes(
		semconv.SchemaURL, semconv.ServiceName("genval")))
	if err != nil {
		log.Fatal(err)
	}
	tp := sdktrace.NewTracerProvider(
		sdktrace.WithBatcher(exporter),
		sdktrace.WithResource(r),
	)
	return tp, nil
}

func newPropagator() propagation.TextMapPropagator {
	return propagation.NewCompositeTextMapPropagator(
		propagation.TraceContext{},
		propagation.Baggage{},
	)
}

func StartSpanForCommand(tracer trace.Tracer, cmd *cobra.Command) (context.Context, trace.Span) {
	// via https://stackoverflow.com/a/78486358/2257038
	commandParts := strings.Fields(cmd.CommandPath())
	command := commandParts[0]
	subcommand := ""
	if len(commandParts) > 1 {
		subcommand = commandParts[1]
	}

	// we ignore the linting finding, as we're making sure that the span is `End`'d as part of a `PersistentPostRunE`
	ctx, span := tracer.Start( //nolint: spancheck
		cmd.Context(),
		cmd.CommandPath(),
		trace.WithAttributes(
			AttributeKeyCobraCommand.String(command),
			AttributeKeyCobraSubcommand.String(subcommand),
			AttributeKeyCobraCommandPath.String(cmd.CommandPath()),
		))

	cmd.SetContext(ctx)
	span = trace.SpanFromContext(ctx)

	return ctx, span //nolint: spancheck
}

const (
	AttributeKeyCobraCommand     attribute.Key = "cobra.command"
	AttributeKeyCobraSubcommand  attribute.Key = "cobra.subcommand"
	AttributeKeyCobraCommandPath attribute.Key = "cobra.commandpath"
)
