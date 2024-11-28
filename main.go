package main

import (
	"context"

	"go.opentelemetry.io/otel"

	"github.com/intelops/genval/cmd"
	"github.com/intelops/genval/pkg/logger"
	"github.com/intelops/genval/pkg/otm"
)

var log = logger.Init()

func main() {
	tracer := otel.Tracer("intelops/genval")

	hook := otm.NewOTelHook(tracer)
	log.AddHook(hook)
	_, span := tracer.Start(context.Background(), "intelops/genval")
	defer span.End()

	cmd.Execute()
}
