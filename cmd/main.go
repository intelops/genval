package main

import (
	"flag"
	"fmt"
	"os"
	"strings"

	"github.com/fatih/color"
	"github.com/intelops/genval/cmd/modes"
)

var mode, resource, reqinput, output, inputpolicy, outputpolicy, policy string
var verify bool
var policies multiValueFlag

func init() {
	flag.StringVar(&mode, "mode", "", "Specify mode: 'container' for Dockerfile validation/generation or 'cue' for K8s resource validation/generation")
	flag.StringVar(&resource, "resource", "", "A top-level label used to define the Cue Definition in cue mode")
	flag.StringVar(&reqinput, "reqinput", "", "Input file in JSON/YAML format for validating in different modes")
	flag.StringVar(&output, "output", "", "Output path for Dockerfile for in container mode")
	// TODO: Change the name policies OR update the logic in all the modes to accept policy as a String instead of []string
	flag.Var(&policies, "policies", "Validation policies, .cue, .rego or CEL policy files to be used in respective mode.")
	flag.StringVar(&inputpolicy, "inputpolicy", "", "Rego policy to validate JSON input in container mode")
	flag.StringVar(&outputpolicy, "outputpolicy", "", "Rego policy to validate generated Dockerfile in container mode")
	flag.BoolVar(&verify, "verify", false, "Flag to perform validation and skip generation of final manifest")
	flag.StringVar(&policy, "policy", "", "a directory containing cue.mod and cue definitions")

	flag.Usage = func() {
		helpText := `
Usage of genval:

Modes:
%s
  - container: Dockerfile validation and generation.
    Arguments: <reqinput.json> <output.Dockerfile> <input.rego policy file> <outfile in JSON and validate theput.rego policy file>
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

%s
  - cel: Validating Kubernetes manifests with CEL.
    Arguments: <reqinput.json> <CEL policy>
    Example usage:
      ./genval --mode=cel --reqinput=deployment.json --policy=<path/to/CEL policy>

%s
  - showjson: Helper mode to print the JSON representation of input.
    Arguments: <Dockerfile Or .tf file> 
    Example usage:
	  ./genval --mode=showjson --reqinput=Dockerfle
						
`

		modeHeading := color.New(color.FgGreen, color.Bold).SprintfFunc()
		fmt.Fprintf(os.Stderr, helpText, modeHeading("Container Mode:"), modeHeading("Cue Mode:"),
			modeHeading("K8s Mode:"), modeHeading("Terraform Mode:"), modeHeading("CEL Mode:"),
			modeHeading("ShowJSON Mode:"))
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
		modes.ExecuteCue(reqinput, resource, verify, policy)
	case "k8s":
		// Call the K8s with rego mode's execution function
		modes.ExecuteK8s(reqinput, policies...)
	case "tf":
		// Call the Tf with rego mode's execution function
		modes.ExecuteTf(reqinput, policies...)
	case "showjson":
		// Call the showjson mode for prining the JSON representation of reqinput files
		modes.ExecuteShowJSON(reqinput)
	case "cel":
		// Call cel mode for validating Kubernetes manifests with CEL
		modes.ExecuteCEL(reqinput, policies...)
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
