package parser

import "strings"

type DockerfileInstruction struct {
	Cmd      string `json:"cmd"`
	Value    string `json:"value"`
	Location int    `json:"location"`
}

func ParseDockerfileContent(content string) []DockerfileInstruction {
	lines := strings.Split(content, "\n")
	var instructions []DockerfileInstruction

	for l, line := range lines {
		parts := strings.Fields(line)
		if len(parts) < 2 {
			continue
		}

		cmd := strings.ToLower(parts[0])
		value := strings.Join(parts[1:], " ")
		l = l + 1

		instructions = append(instructions, DockerfileInstruction{
			Cmd:      cmd,
			Value:    value,
			Location: l,
		})
	}

	return instructions
}
