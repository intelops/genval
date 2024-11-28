package cmd

import (
	"context"
	"fmt"
	"os"
	"time"

	"github.com/fatih/color"
	"github.com/spf13/cobra"
	"go.opentelemetry.io/contrib/instrumentation/runtime"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/trace"

	"github.com/intelops/genval/pkg/otm"
)

var (
	tracer       trace.Tracer
	otelShutdown func(context.Context) error
	// cmdSpan is the currently processing `cobra.Command`'s Span
	cmdSpan trace.Span

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
			shutdown, err := otm.SetupOTelSDK(cmd.Context(), cmd.Use, "v0.1.7")
			if err != nil {
				return fmt.Errorf("failed to set up OpenTelemetry: %w", err)
			}

			tracer = otel.Tracer("intelops/genval")
			// Constructor to create the hook
			hook := otm.NewOTelHook(tracer)

			log.AddHook(hook)
			otelShutdown = shutdown

			// wrap the whole command in a Span
			_, span := otm.StartSpanForCommand(tracer, cmd)
			log.WithContext(cmd.Context()).Info("This is an example log")
			cmdSpan = span
			defer cmdSpan.End()
			return nil
		},
		PersistentPostRunE: func(cmd *cobra.Command, args []string) error {
			// and then make sure it's ended
			defer cmdSpan.End()

			// Collect runtime metrics
			err := runtime.Start(runtime.WithMinimumReadMemStatsInterval(time.Second))
			if err != nil {
				log.WithFields(map[string]interface{}{
					"error": err,
				}).Errorf("OTEL runtime instrumentation failed")
			}

			if otelShutdown != nil {
				err := otelShutdown(cmd.Context())
				if err != nil {
					log.WithContext(cmd.Context()).Errorf("failed shutting spans")
					// log.WithFields(map[string]interface{}{
					// 	"error": err,
					// }).Errorf("Error shuttingDown")
				}
			}

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
		log.WithFields(map[string]interface{}{
			"error": err,
		}).Errorf("Error initializing Command")
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
