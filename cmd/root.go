package cmd

import (
	"context"
	"os"

	"github.com/fatih/color"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/metric"

	"github.com/intelops/genval/pkg/otm"
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
		var err error

		tp, err := otm.SetupTracer()
		if err != nil {
			log.Errorf("failed to initialize new trace provuder: %v", err)
			return err
		}

		cleanup := func() {
			_ = tp.Shutdown(context.Background())
		}
		defer cleanup()

		otel.SetTracerProvider(tp)

		tracer := otel.Tracer("genval")

		_, span := tracer.Start(ctx, cmd.Use)
		defer span.End()

		// Instrumentation setup
		shutdown := otm.SetupMetrics()
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
