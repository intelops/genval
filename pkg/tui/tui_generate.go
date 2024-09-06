// pkg/tui/generate.go
package tui

import (
	"fmt"

	"github.com/charmbracelet/bubbles/key"
	"github.com/charmbracelet/bubbles/textarea"
	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
)

type GenerateModel struct {
	TextArea          textarea.Model // Text input for entering the prompt
	keymap            keymap
	Stage             string   // Track whether we're selecting an assistant or entering a prompt
	SelectedAssistant string   // To store the selected assistant
	Choices           []string // List of subcommands or flags
	Selected          int      // The selected index
}

type keymap struct {
	Up   key.Binding
	Down key.Binding
}

func NewGenerateModel() GenerateModel {
	ta := textarea.New()
	ta.Placeholder = "Enter your prompt"
	ta.Focus()
	ta.SetWidth(50)
	ta.SetHeight(10)
	ta.KeyMap.InsertNewline.SetEnabled(false)
	ta.KeyMap.DeleteWordBackward.SetEnabled(false)
	ta.KeyMap.LineNext = key.NewBinding(key.WithKeys("down"))
	ta.KeyMap.LinePrevious = key.NewBinding(key.WithKeys("up"))
	ta.Blur()
	ta.Prompt = "|"
	ta.ShowLineNumbers = false
	return GenerateModel{
		Choices:  []string{"rego", "cel", "cue", "dockerfile"},
		Selected: 0,
		Stage:    "assistant",
		keymap: keymap{
			Up: key.NewBinding(
				key.WithKeys("up"),           // actual keybindings
				key.WithHelp("↑", "move up"), // corresponding help text
			),
			Down: key.NewBinding(
				key.WithKeys("down"),
				key.WithHelp("↓", "move down"),
			),
		},
		TextArea: ta,
	}
}

var (
	selectedAssistantStyle = lipgloss.NewStyle().Foreground(lipgloss.Color("205")).Italic(false)
	userPromptStyle        = lipgloss.NewStyle().Foreground(lipgloss.Color("219")).Italic(false)
)

func (m GenerateModel) Init() tea.Cmd {
	return textarea.Blink
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
				m.TextArea.Focus()
			} else if m.Stage == "prompt" {
				m.Stage = "done"
				// End TUI and return control back to runGenerateCmd
				return m, tea.Quit
			}
		case "up":
			if m.Stage == "assistant" && m.Selected > 0 {
				m.Selected--
			} else if m.Stage == "prompt" {
				// Move cursor up in textarea
				m.TextArea.CursorUp()
			}
		case "down":
			if m.Stage == "assistant" && m.Selected < len(m.Choices)-1 {
				m.Selected++
			} else if m.Stage == "prompt" {
				// Check if cursor is at the bottom of the textarea view
				if m.TextArea.Line() == m.TextArea.LineCount()-1 {
					// If cursor is at the bottom line, append a newline to the text area
					m.TextArea.SetValue(m.TextArea.Value() + "\n")
				} else {
					m.TextArea.CursorDown()
				}
			}
		case "ctrl+c":
			return m, tea.Quit
		}

		// Handle text input in prompt stage
		if m.Stage == "prompt" {
			var cmd tea.Cmd
			m.TextArea, cmd = m.TextArea.Update(msg)
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
		return "Enter your prompt:\n\n" + m.TextArea.View()
	}
	// When the TUI is done, display the final selections
	if m.Stage == "done" {
		return fmt.Sprintf("\nSelected Assistant: %s\nUser Prompt: %s\n",
			selectedAssistantStyle.Render(m.SelectedAssistant),
			userPromptStyle.Render(m.TextArea.Value()))
	}

	return ""
}
