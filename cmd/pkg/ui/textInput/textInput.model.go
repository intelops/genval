package textinput

import "github.com/charmbracelet/bubbles/textinput"

type (
	errMsg error
)

// Output represents the text provided in a textinput step
type Output struct {
	Output string
}

// Output.update updates the value of the Output
func (o *Output) update(val string) {
	o.Output = val
}

// A textnput.model contains the data for the textinput step.
//
// It has the required methods that make it a bubbletea.Model
type model struct {
	textInput textinput.Model
	err       error
	output    *Output
	header    string
}