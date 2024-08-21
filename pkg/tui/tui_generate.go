// pkg/tui/generate.go
package tui

import (
	textinput "github.com/charmbracelet/bubbles/textinput"
	tea "github.com/charmbracelet/bubbletea"
)

type GenerateModel struct {
	Choices           []string        // List of subcommands or flags
	Selected          int             // The selected index
	Stage             string          // Track whether we're selecting an assistant or entering a prompt
	TextInput         textinput.Model // Text input for entering the prompt
	SelectedAssistant string          // To store the selected assistant
}

func NewGenerateModel() GenerateModel {
	ti := textinput.New()
	ti.Placeholder = "Enter your prompt"
	ti.Focus()
	return GenerateModel{
		Choices:   []string{"rego", "cel", "cue"},
		Selected:  0,
		Stage:     "assistant",
		TextInput: ti,
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
			if m.Stage == "assistant" {
				// Save the selected assistant
				m.SelectedAssistant = m.Choices[m.Selected]
				// Move to prompt stage
				m.Stage = "prompt"
				m.TextInput.Focus()
			} else if m.Stage == "prompt" {
				// End TUI and return control back to runGenerateCmd
				return m, tea.Quit
			}
		case "up":
			if m.Stage == "assistant" && m.Selected > 0 {
				m.Selected--
			}
		case "down":
			if m.Stage == "assistant" && m.Selected < len(m.Choices)-1 {
				m.Selected++
			}
		case "ctrl+c":
			return m, tea.Quit
		}

		// Handle text input in prompt stage
		if m.Stage == "prompt" {
			var cmd tea.Cmd
			m.TextInput, cmd = m.TextInput.Update(msg)
			return m, cmd
		}
	}

	return m, nil
}

func (m GenerateModel) View() string {
	if m.Stage == "assistant" {
		s := "Select an assistant:\n\n"
		for i, choice := range m.Choices {
			if m.Selected == i {
				s += "> " + choice + "\n"
			} else {
				s += "  " + choice + "\n"
			}
		}
		return s
	}

	if m.Stage == "prompt" {
		return "Enter your prompt:\n\n" + m.TextInput.View()
	}

	return ""
}
