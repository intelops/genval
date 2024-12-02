package main

import (
	"github.com/intelops/genval/cmd"
)

func main() {
	// tracer := otel.Tracer("intelops/genval")
	// logProvider := global.GetLoggerProvider()
	// hook := otm.NewHook("Intelops/Genval", otm.WithLoggerProvider(logProvider))
	// log.AddHook(hook)
	// _, span := tracer.Start(context.Background(), "intelops/genval")
	// defer span.End()

	cmd.Execute()
}
