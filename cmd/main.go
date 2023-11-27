package main

import (
	"flag"
	"fmt"
	"os"
	"strings"

	"github.com/fatih/color"
	"github.com/intelops/genval/cmd/modes"
)

var mode, resource, reqinput, output, inputpolicy, outputpolicy string
var verify, json bool
var policies multiValueFlag

func init() {
	flag.StringVar(&mode, "mode", "", "Specify mode: 'container' for Dockerfile validation/generation or 'cue' for K8s resource validation/generation.")
	flag.StringVar(&resource, "resource", "", "Resource for K8s mode (cueval).")
	flag.StringVar(&reqinput, "reqinput", "", "Input value (JSON) for K8s mode (cueval).")
	flag.StringVar(&output, "output", "", "Output path for Dockerfile for in container mode.")
	flag.Var(&policies, "policy", "Validation policies, .cue files to be used in cue mode.")
	flag.StringVar(&inputpolicy, "inputpolicy", "", "Rego policy to validate JSON input in container mode.")
	flag.StringVar(&outputpolicy, "outputpolicy", "", "Rego policy to validate generated Dockerfile in container mode.")
	flag.BoolVar(&verify, "verify", false, "Flag to perform validation and skip generation of final manifest")
	flag.BoolVar(&json, "json", false, "Prints the JSON representation of the input passed")
	flag.Usage = func() {
		helpText := `
Usage of genval:

Modes:
%s
  - container: Dockerfile validation and generation.
    Arguments: <reqinput.json> <output.Dockerfile> <input.rego policy file> <output.rego policy file>
    Example usage:
      ./genval --mode=container --reqinput=input.json \
        --output=output.Dockerfile \
        --inputpolicy=<path/to/input.rego policy> \
        --outputpolicy=<path/to/output.rego file>

%s
  - cue: K8s resource validation and generation.
    Arguments: <reqinput.json> <resource> <CUE schema policy>
    Example usage:
      ./genval --mode=cue --resource=Deployment \
        --reqinput=deployment.json \
        --policy=<path/to/.cue schema>
    Note: The "resource" arg in "cue" mode needs a valid Kind, like "Deployment", "StatefulSet", "DaemonSet", etc.

%s
  - k8s: K8s resource validation with Rego policies.
    Arguments: <reqinput.json> <Rego policy>
    Example usage:
      ./genval --mode=k8s --reqinput=deployment.json --policy=<path/to/.rego policy>

%s
  - tf: Terraform resource validation with Rego policies.
    Arguments: <reqinput.json> <Rego policy>
    Example usage:
      ./genval --mode=tf --reqinput=deployment.json --policy=<path/to/.rego policy>
						
`

		modeHeading := color.New(color.FgGreen, color.Bold).SprintfFunc()
		fmt.Fprintf(os.Stderr, helpText, modeHeading("Container Mode:"), modeHeading("Cue Mode:"), modeHeading("K8s Mode:"), modeHeading("Terraform Mode:"))
		flagsHeader := color.New(color.FgYellow, color.Bold).Sprint("Available flags:")
		fmt.Fprintf(os.Stderr, "\n%s\n\n", flagsHeader)

		flag.PrintDefaults()
	}
}

func main() {
	flag.Parse()

	// Pass arguments after the mode flag

	switch mode {
	case "container":
		// Call the Docker mode's execution function
		modes.ExecuteContainer(reqinput, output, inputpolicy, outputpolicy)
	case "cue":
		// Call the Cue mode's execution function
		modes.ExecuteCue(reqinput, resource, verify, policies...)
	case "k8s":
		// Call the K8s with rego mode's execution function
		modes.ExecuteK8s(reqinput, policies...)
	case "tf":
		// Call the Tf with rego mode's execution function
		modes.ExecuteTf(reqinput, json, policies...)
	default:
		fmt.Println("Invalid mode. Choose 'container', 'cue', 'k8s' or 'tf'.")
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
