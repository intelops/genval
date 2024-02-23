package modes

import (
	"bytes"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	log "github.com/sirupsen/logrus"
)

func ExecuteShowJSON(reqinput string) {
	var prettyJSON bytes.Buffer

	if strings.HasSuffix(reqinput, ".tf") {
		inputJSON, err := parser.ConvertTFtoJSON(reqinput)
		if err != nil {
			log.Errorf("Error converting tf file: %v", err)
			return
		}

		err = json.Indent(&prettyJSON, []byte(inputJSON), "", "    ")
		if err != nil {
			log.Errorf("Error: %v", err)
			return
		}
	}

	if strings.Contains(reqinput, "Dockerfile") {
		inputContent, err := utils.ReadFile(reqinput)
		if err != nil {
			log.Errorf("Error reading input: %v", err)
		}

		dockerfileContent := parser.ParseDockerfileContent(string(inputContent))
		dockerfileJSON, err := json.Marshal(dockerfileContent)
		if err != nil {
			log.Errorf("Error marshaling Dockerfile: %v", err)
			return
		}

		err = json.Indent(&prettyJSON, dockerfileJSON, "", "    ")
		if err != nil {
			log.Errorf("Error: %v", err)
			return
		}
	}

	if prettyJSON.Len() == 0 {
		fmt.Println("The input must contain .tf extension or Dockerfile")
		return
	}

	fmt.Printf("JSON representation of %v: \n%v\n", reqinput, prettyJSON.String())
}
