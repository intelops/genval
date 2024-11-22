package cmd

import (
	"context"
	"os"
	"runtime"
	"time"

	"github.com/fatih/color"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/metric"
	"go.opentelemetry.io/otel/trace"

	"github.com/intelops/genval/pkg/otm"
)

var (
	tracer  trace.Tracer
	rootCmd = &cobra.Command{
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

			// Setup TracerProvider
			tp, err := otm.SetupTracer()
			if err != nil {
				return err
			}
			defer func() {
				_ = tp.Shutdown(ctx)
			}()
			otel.SetTracerProvider(tp)

			tracer = otel.Tracer("genval.pkg.cmd")

			// Capture additional attributes
			attributes := []attribute.KeyValue{
				attribute.String("command.use", cmd.CommandPath()),
				attribute.StringSlice("command.args", args),
				attribute.String("execution.status", "success"),
				attribute.Float64("execution.duration", float64(time.Second)),
				// System and environment details
				attribute.String("os", runtime.GOOS),
				attribute.String("architecture", runtime.GOARCH),
				attribute.Int("cpu.count", runtime.NumCPU()),
				attribute.String("working.directory", getWorkingDirectory()),
				attribute.String("user.name", os.Getenv("USER")),
				attribute.String("home.directory", os.Getenv("HOME")),
				// Command-specific metadata
				attribute.String("command.id", cmd.Name()),
				attribute.Int("command.arg.count", len(args)),
			}

			ctx, span := tracer.Start(ctx, "rootCmd.execution",
				trace.WithAttributes(
					attributes...,
				))
			defer span.End()

			// Setup Metrics
			shutdownMetrics := otm.SetupMetrics()
			defer shutdownMetrics()
			// Record initial metrics
			meter := otel.Meter("genval")
			counter, err := meter.Int64Counter(
				"command.execution.count",
				metric.WithDescription("Counts the number of command executions"),
			)
			if err != nil {
				return err
			}
			counter.Add(ctx, 1, metric.WithAttributes(attribute.String("command.use", cmd.Use)))

			log.Infof("Command '%s' started with args: %v", cmd.Use, args)
			return nil
		},
		RunE: func(cmd *cobra.Command, args []string) error {
			ctx := context.Background()
			// Start a span for the core command execution
			_, span := tracer.Start(ctx, "rootCmd.run")
			defer span.End()

			// Simulated command logic for demonstration
			time.Sleep(2 * time.Second) // Replace with actual command logic

			log.Info("Command executed successfully")
			return nil
		},
	}
)

func init() {
	rootCmd.SetOut(color.Output)
	rootCmd.SetErr(color.Error)
}

// Execute starts the root command execution
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		log.Error("Error executing rootCmd:", err)
		os.Exit(1)
	}
}

// getWorkingDirectory retrieves the current working directory
func getWorkingDirectory() string {
	dir, err := os.Getwd()
	if err != nil {
		log.Warn("Unable to retrieve working directory:", err)
		return "unknown"
	}
	return dir
}
