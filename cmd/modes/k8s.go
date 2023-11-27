package modes

import (
	"fmt"

	validate "github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
)

func ExecuteK8s(reqinput string, policies ...string) {
	if reqinput == "" || len(policies) == 0 {
		fmt.Println("[USAGE]: ./genval --mode=k8s --reqinput=input.json/yaml --policy=<path/to/rego policy>.")
		return
	}

	inputFile := reqinput
	policy := policies

	err := validate.ValidateWithRego(inputFile, policy[0])
	if err != nil {
		log.Errorf("Validation %v failed", err)
		return

	}
}
