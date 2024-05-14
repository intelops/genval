package validate

import (
	"errors"
	"fmt"
	"os"
	"regexp"

	"github.com/fatih/color"
	"github.com/intelops/genval/pkg/utils"
	"github.com/jedib0t/go-pretty/v6/table"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

func PrintResults(benchmark []string, result rego.ResultSet) error {
	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy", "Status", "Description", "Benchmark"})
	var policyError error
	var desc string
	// Create a map to associate policies with their benchmarks
	policyToBenchmark := map[string]string{}

	for i, r := range result {
		if i < len(benchmark) {
			if len(r.Expressions) > 0 {
				keys := r.Expressions[0].Value.(map[string]interface{})
				for key, value := range keys {
					policyToBenchmark[key] = benchmark[i]
					fmt.Println(key)
					for _, ben := range benchmark {
						fmt.Println(ben)
					}

					switch v := value.(type) {
					case []interface{}:
						if len(v) > 0 {
							desc = fmt.Sprintf("%v", v[0])
						}
					case string:
						desc = v
					}

					if slice, ok := value.([]interface{}); ok {
						if len(slice) > 0 {
							t.AppendRow(table.Row{key, color.New(color.FgGreen).Sprint("passed"), desc, policyToBenchmark[key]})
						} else {
							t.AppendRow(table.Row{key, color.New(color.FgRed).Sprint("failed"), "NA", "NA"})
							policyError = errors.New("policy evaluation failed: " + key)
						}
					} else {
						if value != nil {
							t.AppendRow(table.Row{key, color.New(color.FgGreen).Sprint("passed"), desc, policyToBenchmark[key]})
						} else {
							t.AppendRow(table.Row{key, color.New(color.FgRed).Sprint("failed"), "NA", "NA"})
							policyError = errors.New("policy evaluation failed: " + key)
						}
					}
				}
			} else {
				log.Error("No policies passed")
				policyError = errors.New("no policies passed")
			}
		}
	}

	t.Render()

	return policyError
}

func fetchMetadataFromPolicyFile(policyFile string) ([]string, error) {
	pb, err := utils.ReadFile(policyFile)
	if err != nil {
		return nil, fmt.Errorf("error reading policy file %s: %v", policyFile, err)
	}
	rebenchmarks := regexp.MustCompile(`benchmark\s*:=\s*"([^"]+)"`)
	pc := string(pb)
	benchmarkMatches := rebenchmarks.FindAllStringSubmatch(pc, -1)

	var benchmarks []string

	for _, match := range benchmarkMatches {
		benchmarks = append(benchmarks, match[1])
	}

	if len(benchmarks) == 0 {
		return nil, fmt.Errorf("error fetching behcnmarks from policyfile %s", policyFile)
	}

	return benchmarks, nil
}
