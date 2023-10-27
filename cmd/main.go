package main

import (
	"flag"
	"fmt"
	"strings"

	"github.com/intelops/genval/cmd/container"
	"github.com/intelops/genval/cmd/cueval"
)

var mode, resource, reqinput, output, inputpolicy, outputpolicy string

var policies multiValueFlag

func init() {
	flag.StringVar(&mode, "mode", "", "Specify mode: 'container' for Dockerfile validation/generation or 'cue' for K8s resource validation/generation.")
	flag.StringVar(&resource, "resource", "", "Resource for K8s mode (cueval).")
	flag.StringVar(&reqinput, "reqinput", "", "Input value (JSON) for K8s mode (cueval).")
	flag.StringVar(&output, "output", "", "Output path for Dockerfile for in container mode.")
	flag.Var(&policies, "policy", "Validation policies, .cue files to be used in cue mode.")
	flag.StringVar(&inputpolicy, "inputpolicy", "", "Rego policy to validate JSON input in container mode.")
	flag.StringVar(&outputpolicy, "outputpolicy", "", "Rego policy to validate generated Dockerfile in container mode.")

	flag.Usage = func() {
		usageText := `
		Usage of genval:

		Modes:
	        container: Dockerfile validation and generation. Arguments: <reqinput.json> <output.Dockerfile> <input.rego policy file> <output.rego policy file>
		Example usage:

		./genval --mode=container --reqinput=input.json \
		--output=output.Dockerfile \
		--inputpolicy=<path/to/input.rego policy> \
		--outputpolicy <path/tp/output.rego file>
		
		    cue: K8s resource validation and generation. Use --resource and --value flags.
		Example usage:

		./genval --mode=cue --resource=Deployment \
		--reqinput=deployment.json \
		--policy=<path/to/.cue schema>
			
		The "resource" arg in --cue mode needs a valid Kind, like in above example "Deployment" or StatefulSet, DaemonSet etc.
		`
		fmt.Println(usageText)
		flag.PrintDefaults()
	}
}

func main() {
	flag.Parse()

	// Pass arguments after the mode flag

	switch mode {
	case "container":
		// Call the Docker mode's execution function
		container.Execute(reqinput, output, inputpolicy, outputpolicy)
	case "cue":
		// Call the K8s mode's execution function
		cueval.Execute(resource, reqinput, policies...)
	default:
		fmt.Println("Invalid mode. Choose 'container' or 'cue'.")
		flag.Usage()
	}
}

// Implement flag.Value for a slice of strings
type multiValueFlag []string

func (m *multiValueFlag) String() string {
	return strings.Join(*m, ", ")
}

func (m *multiValueFlag) Set(value string) error {
	*m = append(*m, value)
	return nil
}
