package validate

import (
	"context"
	"encoding/json"
	"fmt"
	"path/filepath"
	"strings"

	"github.com/intelops/genval/pkg/oci"
	"github.com/intelops/genval/pkg/parser"
	"github.com/intelops/genval/pkg/utils"
	"github.com/open-policy-agent/opa/ast"
	"github.com/open-policy-agent/opa/rego"
	log "github.com/sirupsen/logrus"
)

type InputProcessor interface {
	ProcessInput(string) ([]byte, error)
}

// DOckefileProcessor processes Dockerrile input
type DockerfileProcessor struct{}

// d.ProcessInput processes Dockerfile content and returns a []byte or any error
func (d DockerfileProcessor) ProcessInput(content string) ([]byte, error) {
	dockerfileInstructions := parser.ParseDockerfileContent(content)
	jsonData, err := json.Marshal(dockerfileInstructions)
	if err != nil {
		return nil, fmt.Errorf("error marshalling %v, to JSON: %v", dockerfileInstructions, err)
	}
	return jsonData, nil
}

// GenericProcessor processes generic inputs like (YAML, JSON, etc)
type GenericProcessor struct{}

// g.ProcessInput processes generic input contents and returns a []byte or any error
func (g GenericProcessor) ProcessInput(content string) ([]byte, error) {
	jsonData, err := parser.ProcessInput(content)
	if err != nil {
		return nil, fmt.Errorf("error reading input content file: %v", err)
	}
	return jsonData, nil
}
func ValidateWithRego(inputContent, regoPolicyPath string, processor InputProcessor) error {
	metaFiles, regoPolicy, err := FetchRegoMetadata(regoPolicyPath, metaExt, policyExt)
	if err != nil {
		return err
	}
	// Load metadata from JSON files
	metas, err := LoadRegoMetadata(metaFiles)
	if err != nil {
		return fmt.Errorf("error loading policy metadata: %v", err)
	}

	var allResults rego.ResultSet

	for _, regoFile := range regoPolicy {
		// read input is a file
		jsonData, err := processor.ProcessInput(inputContent)
		if err != nil {
			return fmt.Errorf("error reading input content file: %v", err)
		}

		k8sPolicy, err := utils.ReadFile(regoFile)
		if err != nil {
			return fmt.Errorf("error reading the policy file %s: %v", regoFile, err)
		}

		pkg, err := utils.ExtractPackageName(k8sPolicy)
		if err != nil {
			return fmt.Errorf("unable to fetch package name: %v", err)
		}

		policyName := filepath.Base(regoFile)

		var commands interface{}
		err = json.Unmarshal(jsonData, &commands)
		if err != nil {
			return fmt.Errorf("error Unmarshalling jsonData: %v", err)
		}
		ctx := context.Background()
		compiler, err := ast.CompileModules(map[string]string{
			policyName: string(k8sPolicy),
		})
		if err != nil {
			log.Fatal(err)
			return fmt.Errorf("failed to compile rego policy: %w", err)
		}
		// Create regoQuery for evaluation
		regoQuery := rego.New(
			rego.Query("data."+pkg),
			rego.Compiler(compiler),
			rego.Input(commands),
		)

		// Evaluate the Rego query
		rs, err := regoQuery.Eval(ctx)
		if err != nil {
			return fmt.Errorf("error evaluating query:%v", err)
		}
		allResults = append(allResults, rs...)
	}

	if err := PrintResults(allResults, metas); err != nil {
		return fmt.Errorf("error evaluating rego results for %s: %v", regoPolicyPath, err)
	}
	return nil
}

func ApplyPolicyiesFromOCI(ociURL, creds, path string) (string, error) {
	if err := oci.PullArtifact(context.Background(), creds, ociURL, path); err != nil {
		return "", fmt.Errorf("error pulling policy from %s: %v", ociURL, err)
	}

	return path, nil
}

func ValidateWithOCIPolicies(resource, policy, ociURL, creds string, processor InputProcessor) error {
	if policy == "" || strings.HasPrefix(policy, "oci://") {

		tempDir, cleanup, err := utils.TempDirWithCleanup()
		if err != nil {
			return fmt.Errorf("error creating temporary directory: %v", err)
		}
		defer cleanup()

		var defaultRegoPolicies string
		if policy == "" {
			log.Info("Validating with default policies...")
			policyLoc, err := oci.FetchPolicyFromRegistry(ociURL)
			if err != nil {
				return fmt.Errorf("error fetching policy from registry: %v", err)
			}

			defaultRegoPolicies, err = ApplyPolicyiesFromOCI(policyLoc, creds, tempDir)
			if err != nil {
				return fmt.Errorf("error applying default policies: %v", err)
			}
		} else {
			log.Infof("Pulling policies from '%v'", policy)
			defaultRegoPolicies, err = ApplyPolicyiesFromOCI(policy, creds, tempDir)
			if err != nil {
				return fmt.Errorf("error applying default policies: %v", err)
			}
		}

		err = ValidateWithRego(resource, defaultRegoPolicies, processor)
		if err != nil {
			log.Errorf("Dockerfile validation failed: %s\n", err)
			return err
		}
	}
	return nil
}
