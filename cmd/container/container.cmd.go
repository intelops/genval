package container

import (
	"github.com/intelops/genval/pkg/log"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type containerCmd struct {
	logger *logrus.Logger
}

func NewContainerCommand() *cobra.Command {
	cmd := &containerCmd{
		logger: log.GetLogger(),
	}
	containerCmd := &cobra.Command{
		Use:   "container",
		Short: "Manage containers",
		Long:  `Manage containers`,
		RunE:  cmd.run,
	}
	return containerCmd
}

func (c *containerCmd) run(cmd *cobra.Command, args []string) error {
	c.logger.Info("container command")
	return nil
}
