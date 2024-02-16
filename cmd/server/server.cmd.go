package server

import (
	"github.com/intelops/genval/server"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type serverCmd struct {
	logger *logrus.Logger
}

var cmd *serverCmd

func NewServerCommand(logger *logrus.Logger) *cobra.Command {
	cmd = &serverCmd{
		logger: logger,
	}
	serverCmd := &cobra.Command{
		Use:   "server",
		Short: "Run server",
		Long:  `Run server`,
		RunE:  cmd.run,
	}
	return serverCmd
}

func (sc *serverCmd) run(cbc *cobra.Command, args []string) error {
	server.InitServer()
	return nil
}
