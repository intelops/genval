package validate

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/intelops/genval/pkg/oci"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/open-policy-agent/opa/rego"
)

func ValidateWithRego(inputContent string, regoPolicyPath string) error {
	// read input is a file
	jsonData, err := parser.ProcessInput(inputContent)
	if err != nil {
		return fmt.Errorf("error reading input content file: %v", err)
	}

	metaFiles, regoPolicy, err := FetchRegoMetadata(regoPolicyPath, metaExt, policyExt)
	if err != nil {
		return err
	}
	var regoFile string
	for _, v := range regoPolicy {
		regoFile = v
	}

	k8sPolicy, err := utils.ReadFile(regoFile)
	if err != nil {
		return fmt.Errorf("error reading the policy file %s: %v", regoFile, err)
	}

	pkg, err := utils.ExtractPackageName(k8sPolicy)
	if err != nil {
		return fmt.Errorf("unable to fetch package name: %v", err)
	}

	var commands map[string]interface{}
	err = json.Unmarshal(jsonData, &commands)
	if err != nil {
		return fmt.Errorf("error Unmarshalling jsonData: %v", err)
	}
	ctx := context.Background()

	// Create regoQuery for evaluation
	regoQuery := rego.New(
		rego.Query("data."+pkg),
		rego.Module(regoFile, string(k8sPolicy)),
		rego.Input(commands),
	)

	// Evaluate the Rego query
	rs, err := regoQuery.Eval(ctx)
	if err != nil {
		return fmt.Errorf("error evaluating query:%v", err)
	}

	// Load metadata from JSON files
	metas, err := LoadRegoMetadata(metaFiles)
	if err != nil {
		return fmt.Errorf("error loading policy metadata: %v", err)
	}

	if err := PrintResults(rs, metas); err != nil {
		return fmt.Errorf("error evaluating rego results for %s: %v", regoPolicyPath, err)
	}
	return nil
}

func ApplyDefaultPolicies(ociURL, path string) (string, error) {
	if err := oci.PullArtifact(context.Background(), ociURL, path); err != nil {
		return "", fmt.Errorf("error pulling policy from %s: %v", ociURL, err)
	}

	return path, nil
}

var HubRegoPolicy = "ghcr.io/santoshkal/genval-security-policies/rego-policies:v0.0.1"
