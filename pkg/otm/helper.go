package otm

import (
	"context"
	"os"
	"runtime"
	"strings"

	"github.com/spf13/cobra"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/trace"
)

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
			attribute.Int("process.id", os.Getpid()),
			attribute.Int("user.id", os.Getuid()),
			attribute.Int("cpu.num", runtime.NumCPU()),
			attribute.Int("num.goroutines", runtime.NumGoroutine()),
			// attribute.StringSlice("read.trace", runtime.ReadTrace()),
		))

	cmd.SetContext(ctx)

	return ctx, span //nolint: spancheck
}

const (
	AttributeKeyCobraCommand     attribute.Key = "cobra.command"
	AttributeKeyCobraSubcommand  attribute.Key = "cobra.subcommand"
	AttributeKeyCobraCommandPath attribute.Key = "cobra.commandpath"
)
