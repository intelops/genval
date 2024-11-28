package otm

import (
	"context"
	"errors"
	"fmt"
	"os"
	"os/signal"
	"time"

	log "github.com/sirupsen/logrus"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/exporters/otlp/otlplog/otlploggrpc"
	"go.opentelemetry.io/otel/exporters/otlp/otlpmetric/otlpmetricgrpc"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
	"go.opentelemetry.io/otel/log/global"
	"go.opentelemetry.io/otel/propagation"
	olog "go.opentelemetry.io/otel/sdk/log"
	"go.opentelemetry.io/otel/sdk/metric"
	"go.opentelemetry.io/otel/sdk/resource"
	"go.opentelemetry.io/otel/sdk/trace"
	semconv "go.opentelemetry.io/otel/semconv/v1.26.0"
	"google.golang.org/grpc"
)

// type Command string

func defaultResources(command string, version string) (*resource.Resource, error) {
	return resource.Merge(
		resource.Default(),
		resource.NewWithAttributes(
			semconv.SchemaURL,
			semconv.ServiceName(string(command)),
			semconv.ServiceVersion(version),
		),
	)
}

func SetupOTelSDK(ctx context.Context, command string, version string) (shutdown func(context.Context) error, err error) {
	ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt)
	defer cancel()

	conn, err := initConn()
	if err != nil {
		log.Errorf("error initialing grpc client: %v", err)
		return nil, err
	}

	res, err := defaultResources(command, version)
	if err != nil {
		return nil, fmt.Errorf("failed to set up default Resource configuration: %w", err)
	}

	var shutdownFuncs []func(context.Context) error

	shutdown = func(ctx context.Context) error {
		var err error
		for _, fn := range shutdownFuncs {
			err = errors.Join(err, fn(ctx))
		}
		shutdownFuncs = nil
		return err
	}

	handleErr := func(inErr error) {
		err = errors.Join(inErr, shutdown(ctx))
	}

	tracerProvider, err := newTraceProvider(ctx, res, conn)
	if err != nil {
		handleErr(err)
		return
	}
	shutdownFuncs = append(shutdownFuncs, tracerProvider.Shutdown)
	otel.SetTracerProvider(tracerProvider)

	// meterProvider, err := newMeterProvider(ctx, res, conn)
	// if err != nil {
	// 	handleErr(err)
	// 	return
	// }
	// shutdownFuncs = append(shutdownFuncs, meterProvider.Shutdown)
	// otel.SetMeterProvider(meterProvider)
	loggerProvider, err := newLoggerProvider(ctx, res, conn)
	if err != nil {
		handleErr(err)
		return
	}
	prop := newPropagator()
	otel.SetTextMapPropagator(prop)

	shutdownFuncs = append(shutdownFuncs, loggerProvider.Shutdown)
	global.SetLoggerProvider(loggerProvider)
	return
}

func newPropagator() propagation.TextMapPropagator {
	return propagation.NewCompositeTextMapPropagator(
		propagation.TraceContext{},
		propagation.Baggage{},
	)
}

func newTraceProvider(ctx context.Context, res *resource.Resource, conn *grpc.ClientConn) (*trace.TracerProvider, error) {
	traceExporter, err := otlptracegrpc.New(ctx, otlptracegrpc.WithGRPCConn(conn))
	if err != nil {
		return nil, fmt.Errorf("failed to create trace exporter: %w", err)
	}

	traceProvider := trace.NewTracerProvider(
		trace.WithResource(res),
		trace.WithBatcher(
			traceExporter,
			trace.WithBatchTimeout(time.Second),
		),
	)
	return traceProvider, nil
}

func newMeterProvider(ctx context.Context, res *resource.Resource, conn *grpc.ClientConn) (*metric.MeterProvider, error) {
	metricExporter, err := otlpmetricgrpc.New(ctx, otlpmetricgrpc.WithGRPCConn(conn))
	if err != nil {
		return nil, fmt.Errorf("failed to create metrics exporter: %w", err)
	}

	meterProvider := metric.NewMeterProvider(
		metric.WithResource(res),
		metric.WithReader(metric.NewPeriodicReader(metricExporter)),
	)
	otel.SetMeterProvider(meterProvider)

	return meterProvider, nil
}

func newLoggerProvider(ctx context.Context, res *resource.Resource, conn *grpc.ClientConn) (*olog.LoggerProvider, error) {
	// and we only support the console-based logging
	logExporter, err := otlploggrpc.New(ctx, otlploggrpc.WithGRPCConn(conn))
	// loggerProvider, err := otlploghttp.New(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to create OTLP log exporter: %w", err)
	}

	loggerProvider := olog.NewLoggerProvider(
		olog.WithResource(res),
		olog.WithProcessor(olog.NewBatchProcessor(logExporter)),
	)
	return loggerProvider, nil
}
