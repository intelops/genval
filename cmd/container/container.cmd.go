package container

import (
	tea "github.com/charmbracelet/bubbletea"
	textinput "github.com/intelops/genval/cmd/pkg/ui/textInput"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type containerCmd struct {
	logger      *logrus.Logger
	projectName *textinput.Output
}

var cmd *containerCmd

func NewContainerCommand(logger *logrus.Logger) *cobra.Command {
	cmd = &containerCmd{
		logger:      logger,
		projectName: &textinput.Output{},
	}
	containerCmd := &cobra.Command{
		Use:   "container",
		Short: "Manage containers",
		Long:  `Manage containers`,
		RunE:  cmd.run,
	}
	return containerCmd
}

func (c *containerCmd) run(cbc *cobra.Command, args []string) error {
	tProgram := tea.NewProgram(textinput.InitialTextInputModel(cmd.projectName, "Container name: "))
	if _, err := tProgram.Run(); err != nil {
		c.logger.Printf("Error running program: %s", err)
		cobra.CheckErr(textinput.CreateErrorInputModel(err).Err())
		return err
	}
	c.logger.Printf("Container name: %s", c.projectName.Output)
	return nil
}
