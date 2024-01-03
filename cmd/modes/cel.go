package modes

import (
	"encoding/json"
	"os"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/validate"
	"github.com/jedib0t/go-pretty/v6/table"
	log "github.com/sirupsen/logrus"
)

func ExecuteCEL(reqinput string, policies ...string) {
	inputFile := reqinput
	policyFile := policies

	var data interface{}
	// TODO: Change func name
	err := parser.ParseDockerfileInput(string(inputFile), &data)
	if err != nil {
		log.Fatalf("Unable to process input: %v", err)
	}
	data = parser.ConvertToJSON(data)

	jsonManifest, err := json.Marshal(data)
	if err != nil {
		log.Fatalf("Error marshaling manifest data to JSON: %v", err)
	}

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"Policy Name", "Result"})

	for _, policy := range policyFile {
		err := validate.EvaluateCELPolicies(policy, string(jsonManifest), t)
		if err != nil {
			log.Fatalf("Error evaluating policies: %v", err)
		}
	}
	t.Render()
}
