package cmd

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"strings"

	"github.com/spf13/cobra"

	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
)

type showJSONFlags struct {
	reqinput string
}

var showJSONArgs showJSONFlags

func init() {
	showJSONCmd.Flags().StringVarP(&showJSONArgs.reqinput, "reqinput", "r", "", "required input as .tf or a Dockefile ")
	if err := showJSONCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}

	rootCmd.AddCommand(showJSONCmd)
}

var showJSONCmd = &cobra.Command{
	Use:   "showJSON",
	Short: "A helper command for printing the JSON representation of .tf and Dockerfile",
	Long: `
showJSON is a helper command enabling user to visualize the JSON representation of the .tf and Dockerfiles.
The succussfule execution of the command will print the JSON representation of the passed input .tf or a Dockefile to the StdOut.
Based on this JSON representation, users can write Rego or CEL polices for their technologies and validate them through Genval.

The required input as .tf or a Dockerfile can be either passed through local file paths or remote URLs, such as those hosted on GitHub (e.g., https://github.com)
	`,
	Example: `
# Currently, showJSOn prints JSON format for .tf and Dockerfiles only

# preint the JSON representation of Dockerfile to StdOut

./genval showJSON --reqinput ./output/Dockerfile


# As with all the other commands, showJSON can also read the Dockerfile/.tf file passed through remote URL's

./genval showJSON --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/Dockerfile-sample

# We need to authenticate with GitHub if we intend to pass the required file stired in the GitHub repo
export GITHUB_TOKEN=<your GitHub PAT>

./genval showJSON --reqinput hhttps://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/terraform/sec_group.tf
	`,
	RunE: runshowJSONCmd,
}

func runshowJSONCmd(cmd *cobra.Command, args []string) error {
	if showJSONArgs.reqinput == "" {
		fmt.Println("[USAGE]: ./genval showJSON --reqinput=Dockerfile/ec2.tf")
		log.Panicf("Required params not found")
	}
	input := showJSONArgs.reqinput
	var prettyJSON bytes.Buffer

	if strings.HasSuffix(input, ".tf") {
		inputJSON, err := parser.ConvertTFtoJSON(input)
		if err != nil {
			log.Errorf("Error converting tf file: %v", err)
			return err
		}

		err = json.Indent(&prettyJSON, []byte(inputJSON), "", "    ")
		if err != nil {
			log.Errorf("Error: %v", err)
			return err
		}
	}

	if strings.Contains(input, "Dockerfile") {
		inputContent, err := utils.ReadFile(input)
		if err != nil {
			log.Errorf("Error reading input: %v", err)
		}

		dockerfileContent := parser.ParseDockerfileContent(string(inputContent))
		dockerfileJSON, err := json.Marshal(dockerfileContent)
		if err != nil {
			log.Errorf("Error marshaling Dockerfile: %v", err)
			return err
		}

		err = json.Indent(&prettyJSON, dockerfileJSON, "", "    ")
		if err != nil {
			log.Errorf("Error: %v", err)
			return err
		}
	}

	if prettyJSON.Len() == 0 {
		log.Errorf("The input: %v, must contain .tf extension or Dockerfile", input)
		return errors.New("input must contain .tf extension or Dockerfile")
	}

	log.Infof("JSON representation of %v: \n%v\n", input, prettyJSON.String())
	return nil
}
