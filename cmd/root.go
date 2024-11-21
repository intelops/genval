package cmd

import (
	"context"
	"os"

	"github.com/fatih/color"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/exporters/stdout/stdoutmetric"
	"go.opentelemetry.io/otel/metric"
	metricsdk "go.opentelemetry.io/otel/sdk/metric"
	"go.opentelemetry.io/otel/sdk/resource"
	semconv "go.opentelemetry.io/otel/semconv/v1.17.0"
)

// rootCommand returns a cobra command for genvalctl CLI tool
var rootCmd = &cobra.Command{
	Use:   "genval",
	Short: "An agnostic configuration management tool for generating and validating IaC files",
	Long: `
	Genval is a versatile Go utility that simplifies configuration management by generating and validating configuration files
	for a wide range of tools. It supports various file types, including Dockerfile, Kubernetes manifests,
	custom resource definition (CRD) manifests, Terraform files, and more.
`,
	SilenceUsage: true,
	PersistentPreRunE: func(cmd *cobra.Command, args []string) error {
		ctx := context.Background()

		// Instrumentation setup
		shutdown := setupMetrics()
		defer shutdown()

		log.Print("Starting runtime instrumentation")
		m := otel.Meter("genval")

		counter, err := m.Int64Counter(
			"some_prefix_counter",
			metric.WithDescription("My_counter"),
			metric.WithUnit("calls"),
		)
		if err != nil {
			return err
		}

		// Record a metric
		counter.Add(ctx, 1, metric.WithAttributes(attribute.String("cmd", cmd.Use)))

		return nil
	},
}

func init() {
	rootCmd.SetOut(color.Output)
	rootCmd.SetErr(color.Error)
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}
}

// Global variables for resource and exporter
var res = resource.NewWithAttributes(
	semconv.SchemaURL,
	semconv.ServiceNameKey.String("genval"),
)

func setupMetrics() func() {
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

	// Return shutdown function
	return func() {
		if err := provider.Shutdown(context.Background()); err != nil {
			log.Fatalf("failed to shutdown MeterProvider: %v", err)
		}
	}
}
