package llm

import "strings"

func CombineResourceAndResults(res, results string) (string, error) {
	var builder strings.Builder

	builder.WriteString(res)
	builder.WriteString(results)

	return builder.String(), nil
}
