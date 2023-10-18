package main

import (
	"flag"
	"fmt"

	"github.com/intelops/genval/cmd/container"
	"github.com/intelops/genval/cmd/cueval"
)

var mode, resource, reqinput, output, inputpolicy, outputpolicy, policy string

func init() {
	flag.StringVar(&mode, "mode", "", "Specify mode: 'docker' for Dockerfile validation/generation or 'cueval' for K8s resource validation/generation.")
	flag.StringVar(&resource, "resource", "", "Resource for K8s mode (cueval).")
	flag.StringVar(&reqinput, "reqinput", "", "Input value (JSON) for K8s mode (cueval).")
	flag.StringVar(&output, "output", "", "Output file for Docker mode (docker).")
	flag.StringVar(&policy, "policy", "", "Validation policies, .rego for container mode and /cue for cue mode.")
	flag.StringVar(&inputpolicy, "inputpolicy", "", "Rego policy to validate JSON input.")
	flag.StringVar(&outputpolicy, "outputpolicy", "", "Rego policy to validate generated Dockerfile.")

	// Customize flag.Usage to show detailed help topics
	flag.Usage = func() {
		usageText := `
		Usage of genval:

		Modes:
			docker: Dockerfile validation and generation. Arguments: <reqinput.json> <output.Dockerfile> <input.rego policy file> <output.rego policy file>
			Example usage: ./genval -mode=container --reqinput=input.json --output=output.Dockerfile --inputpolicy=<path/to/input.rego policy> --outputpolicy <path/tp/output.rego file>
		
			cueval: K8s resource validation and generation. Use --resource and --value flags.
			Example usage: ./genval -mode=cue --resource=Deployment --reqinput=deployment.json --policy=<path/to/.cue schema>
			
			The resource arg needs a valid Kind, like in above example "Deployment" or StatefulSet,DaemonSet etc.
		
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
		cueval.Execute(resource, reqinput, policy)
	default:
		fmt.Println("Invalid mode. Choose 'docker' or 'cueval'.")
		flag.Usage()
	}
}
