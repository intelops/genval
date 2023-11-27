package modes

import (
	"fmt"

	"github.com/intelops/genval/pkg/parser"
	validate "github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
)

func ExecuteTf(reqinput string, json bool, policies ...string) {
	if reqinput == "" || len(policies) == 0 {
		fmt.Println("[USAGE]: ./genval --mode=tf --reqinput=input.json/yaml --policy=<path/to/rego policy>.")
		return
	}

	inputFile := reqinput
	policy := policies

	inputJSON, err := parser.ConvertTFtoJSON(inputFile)
	if err != nil {
		log.Errorf("Error converting tf file: %v", err)
	}
	if json {
		fmt.Println(inputJSON)
		return
	}

	err = validate.ValidateWithRego(inputJSON, policy[0])
	if err != nil {
		log.Errorf("Validation %v failed", err)
		return
	}
}
