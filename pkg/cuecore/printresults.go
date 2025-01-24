package cuecore

import (
	"os"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/errors"
	"github.com/jedib0t/go-pretty/v6/table"
)

// PrintErrorsInTable displays errors in a tabular format.
func PrintErrorsInTable(cmd, inputFile, policyFile string, errs []errors.Error) {
	t := newTable([]string{"Command", "Input File", "Policy File", "Violation", "Remarks"})

	for _, err := range errs {
		violation, remarks := parseErrorDetails(errors.Details(err, nil))
		t.AppendRow(table.Row{cmd, inputFile, policyFile, violation, remarks})
	}

	t.Render()
}

// PrintValidationSuccess displays success information in a tabular format.
func PrintValidationSuccess(cmd, inputFile, policyFile string, val cue.Value) {
	t := newTable([]string{"Command", "Input File", "Policy File", "Validated Fields"})

	fields := extractValidatedFields(val)
	for _, field := range fields {
		t.AppendRow(table.Row{cmd, inputFile, policyFile, field})
	}

	t.Render()
}

// newTable creates a reusable table writer with standard configurations.
func newTable(headers []string) table.Writer {
	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)

	// Convert headers from []string to table.Row (variadic interface{}).
	var headerRow table.Row
	for _, header := range headers {
		headerRow = append(headerRow, header)
	}

	t.AppendHeader(headerRow)
	return t
}

// parseErrorDetails extracts violation and remarks from an error string.
func parseErrorDetails(detail string) (violation, remarks string) {
	parts := strings.SplitN(detail, ":", 2)
	if len(parts) > 0 {
		violation = parts[0]
	}
	if len(parts) > 1 {
		remarks = strings.TrimSpace(parts[1])
	}
	return violation, remarks
}

// extractValidatedFields walks through a CUE value and extracts validated field paths.
func extractValidatedFields(val cue.Value) []string {
	var fields []string
	val.Walk(func(v cue.Value) bool {
		if path := v.Path().String(); path != "" {
			fields = append(fields, path)
		}
		return true
	}, nil)
	return fields
}
