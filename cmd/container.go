package cmd

import (
	"fmt"
	"os"
	"strings"

	"github.com/fatih/color"
	generate "github.com/intelops/genval/pkg/generate/dockerfile_gen"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/intelops/genval/pkg/validate"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type dockerfileFlags struct {
	reqinput     string
	output       string
	inputPolicy  string
	outputPolicy string
	ociCreds     string
}

var dockerfileArgs dockerfileFlags

func init() {
	dockerfileCmd.Flags().StringVarP(&dockerfileArgs.reqinput, "reqinput", "r", "", "Input JSON for generating Dockerfile")
	if err := dockerfileCmd.MarkFlagRequired("reqinput"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	dockerfileCmd.Flags().StringVarP(&dockerfileArgs.output, "output", "p", "", "Path to write the Generated Dockefile")
	if err := dockerfileCmd.MarkFlagRequired("output"); err != nil {
		log.Fatalf("Error marking flag as required: %v", err)
	}
	dockerfileCmd.Flags().StringVarP(&dockerfileArgs.inputPolicy, "inputpolicy", "i", "", "Path for the Input policyin Rego, input-policy can be passed from either Local or from remote URL")

	dockerfileCmd.Flags().StringVarP(&dockerfileArgs.outputPolicy, "outputpolicy", "o", "", "Path for Out policy in Rego, Output-policy can be passed from either Local or from remote URL")
	dockerfileCmd.Flags().StringVarP(&dockerfileArgs.ociCreds, "credentials", "c", "", "Credentaals for interacting with OCI registries")

	rootCmd.AddCommand(dockerfileCmd)
}

var dockerfileCmd = &cobra.Command{
	Use:   "dockerfile",
	Short: "Generate and validate Dockerfile",
	Long: `
A user can pass in a JSON file to genval, the passed input will be first evaluated based on input policies,
once input is validated, a Dockerfile will be generated and the generated Dockerfile will be further validated using
the output policies.

Genval Provides flexibility of supplying input files in YAML or JSON formats.All the required input and  policy files
for input and output policies can be supplied from local file paths or remote URLs, such as those hosted on GitHub (e.g., https://github.com)
`,
	Example: `
# Generating and validating Dockerfile with local files
./genval dockerfile --reqinput=input.json \
--output=output.Dockerfile \
--inputpolicy=<path/to/input.rego policy> \
--outputpolicy=<path/to/output.rego file>

# Generating and validating Dockewrfile by passing input template and security policies from remote URL's
# like for example https://github.com

./genval dockerfile --reqinput https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/input-templates/dockerfile_input/clang_input.json \
--output ./output/Dockerfile-cobra \
--inputpolicy https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/default-policies/rego/inputfile_policies.rego \
--outputpolicy https://raw.githubusercontent.com/intelops/genval-security-policies/patch-1/default-policies/rego/dockerfile_policies.rego

# For authenticating with GitHub.com, set the env variable GITHUB_TOKEN
# export GITHUB_TOKEN=<Your GitHub PAT>

./genval dockerfile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/dockerfile_input/clang_input.json \
--output ./output/Dockefile-cobra \
--inputpolicy https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/inputfile_policies.rego \
--outputpolicy  https://github.com/intelops/genval-security-policies/blob/patch-1/default-policies/rego/dockerfile_policies.rego

# Users can use policies to validate input JSON as well as generated Dockerfile with policies stored in their OCI registries
or with Genval's default Rego policies. Behind the scenes, this action iteracts with OCI registries for pulling the policies.

To facilitate authentication with OCI compliant container registries,
Users can provide credentials through --credentials flag. The creds can be provided via <USER:PAT> or <REGISTRY_PAT> format.
If no credentials are provided, Genval searches for the "./docker/config.json" file in the user's $HOME directory.
If this file is found, Genval utilizes it for authentication.

# Validating with Default policies

./genval dockerfile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/dockerfile_input/clang_input.json \
--output ./output/Dockefile-cobra
// No credntials provided, will default to $HOME/.docker/config.json for credentials

# Validating with policies stored in OCI compliant container registries

./genval dockerfile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/dockerfile_input/clang_input.json \
--output ./output/Dockefile-cobra \
inputpolicy oci://ghcr.io/intelops/policyhub/genval/input_policies:v0.0.1 \
--outputpolicy oci://ghcr.io/intelops/policyhub/genval/dockerfile_policies:v0.0.1 \
--credentials <GITHUB_PAT> or <USER:PAT>

	`,
	RunE: rundockerfileCmd,
}

func rundockerfileCmd(cmd *cobra.Command, args []string) error {
	inputPath := dockerfileArgs.reqinput
	outputPath := dockerfileArgs.output
	inputPolicyFile := dockerfileArgs.inputPolicy
	outputPolicyFile := dockerfileArgs.outputPolicy
	var dprocessor validate.DockerfileProcessor
	var gprocessor validate.GenericProcessor

	// Use ParseInputFile to read and unmarshal the input file
	var data generate.DockerfileContent

	err := parser.ParseDockerfileInput(inputPath, &data)
	if err != nil {
		log.Error("Error parsing Dockerfile input:", err)
		return err
	}

	inputContent, err := utils.ReadFile(inputPath)
	if err != nil {
		log.Fatalf("Unable to read input: %v", err)
	}

	if inputPolicyFile == "" || strings.HasPrefix(inputPolicyFile, "oci://") {
		if err := validate.ValidateWithOCIPolicies(string(inputContent),
			inputPolicyFile,
			"inputPolicy",
			dockerfileArgs.ociCreds,
			dprocessor); err != nil {
			return fmt.Errorf("error validating with policies stored in registriy: %v", err)
		}
	} else {
		err = validate.ValidateWithRego(string(inputContent), inputPolicyFile, gprocessor)
		if err != nil {
			log.Fatalf("Validation error: %v", err)
			return err
		}
	}

	dockerfileContent := generate.GenerateDockerfileContent(&data)

	outputData := []byte(dockerfileContent)
	err = os.WriteFile(outputPath, outputData, 0o644)
	if err != nil {
		log.Error("Error writing Dockerfile:", err)
		return err
	}
	color.Green(fmt.Sprintf("Generated Dockerfile saved to: %s\n", outputPath))

	if outputPolicyFile == "" || strings.HasPrefix(outputPolicyFile, "oci://") {
		if err := validate.ValidateWithOCIPolicies(string(outputData),
			outputPolicyFile,
			"dockerfileval",
			dockerfileArgs.ociCreds,
			dprocessor); err != nil {
			return fmt.Errorf("error validating with policies stored in registry: %v", err)
		}
	} else {
		err = validate.ValidateWithRego(string(outputData), outputPolicyFile, dprocessor)
		if err != nil {
			log.Fatalf("Validation error: %v", err)
			return err
		}
	}

	color.Green("Validation of generated Dockerfile completed")
	return nil
}
