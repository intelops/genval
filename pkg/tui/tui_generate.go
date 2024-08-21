package tui

import (
	tea "github.com/charmbracelet/bubbletea"
)

type GenerateModel struct {
	Choices  []string // List of subcommands or flags
	Selected int      // The selected index
	Result   string   // The selected result
}

func NewGenerateModel() GenerateModel {
	return GenerateModel{
		Choices:  []string{"rego", "cel", "cue"},
		Selected: 0,
	}
}

func (m GenerateModel) Init() tea.Cmd {
	return nil
}

func (m GenerateModel) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {
		case "enter":
			// Store the selected choice and exit the TUI
			m.Result = m.Choices[m.Selected]
			return m, tea.Quit
		case "up":
			if m.Selected > 0 {
				m.Selected--
			}
		case "down":
			if m.Selected < len(m.Choices)-1 {
				m.Selected++
			}
		case "q", "esc": // Allow quitting the TUI with 'q' or 'esc'
			return m, tea.Quit
		}
	}
	return m, nil
}

func (m GenerateModel) View() string {
	s := "Select a subcommand:\n\n"
	for i, choice := range m.Choices {
		cursor := "  " // no cursor
		if m.Selected == i {
			cursor = "> " // cursor!
		}
		s += cursor + choice + "\n"
	}
	s += "\nPress 'q' or 'esc' to quit."
	return s
}
