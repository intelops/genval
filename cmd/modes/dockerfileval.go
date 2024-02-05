package modes

import (
	"fmt"
	"os"

	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
)

func init() {
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: false,
		FieldMap: log.FieldMap{
			log.FieldKeyTime:  "@timestamp",
			log.FieldKeyLevel: "@level",
			log.FieldKeyMsg:   "@message",
		},
	})
}

func ExecuteDockerfileval(reqinput, outputpolicy string) {
	if reqinput == "" || outputpolicy == "" {
		fmt.Println("[USAGE]: ./genval --mode=dockerval --reqinput=./Dockerfile --outputpolicy <path/tp/output.rego file>")
		return
	}
	input := reqinput
	policy := outputpolicy

	dockerfileContent, err := os.ReadFile(input)
	if err != nil {
		log.Printf("Reading Dockerfile: %v", err)
		return
	}

	err = validate.ValidateDockerfile(string(dockerfileContent), policy)
	if err != nil {
		log.Errorf("Dockerfile validation failed: %s", err)
		return
	} else {
		fmt.Printf("Dockerfile validation succeeded!\n")
	}
}
