package textinput

import "github.com/charmbracelet/lipgloss"

var (
	titleStyle = lipgloss.NewStyle().Background(lipgloss.Color("#01FAC6")).Foreground(lipgloss.Color("#030303")).Bold(true).Padding(0, 1, 0)
	errorStyle = lipgloss.NewStyle().Foreground(lipgloss.Color("#FF8700")).Bold(true).Padding(0, 0, 0)
)
