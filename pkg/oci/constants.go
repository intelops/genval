package oci

import "errors"

const (
	// CreatedAnnotation is the OpenContainers annotation for specifying
	// the date and time on which the OCI artifact was built (RFC 3339).
	CreatedAnnotation = "org.opencontainers.image.created"

	// ConfigMediaType is the OpenContainers artifact media type for the config layer.
	ConfigMediaType = "application/vnd.genval.config.v1+json"

	// ContentMediaType is the OpenContainers artifact media type for the content layer.
	ContentMediaType = "application/vnd.genval.content.v1.tar+gzip"

	ContentTypeAnnotation = "genval.content.type"

	// SourceAnnotation is the OpenContainers annotation for specifying
	// the upstream source of an OCI artifact.
	SourceAnnotation = "org.opencontainers.image.source"

	URLPrefix = "oci://"

	// OCI URLs for Rego policies
	DockerfilePolicies = URLPrefix + "ghcr.io/intelops/policyhub/genval/dockerfile_policies:v0.0.1"
	InfrafilePolicies  = URLPrefix + "ghcr.io/intelops/policyhub/genval/infrafile_policies:v0.0.1"
	TerraformPolicies  = URLPrefix + "ghcr.io/intelops/policyhub/genval/terraform_policies:v0.0.1"
)

// FetchPolicyFromRegistry fetches the policy based on the command provided
func FetchPolicyFromRegistry(cmd string) (string, error) {
	policies := map[string]string{
		"dockerfileval": DockerfilePolicies,
		"infrafile":     InfrafilePolicies,
		"terraform":     TerraformPolicies,
	}

	policy, ok := policies[cmd]
	if !ok {
		return "", errors.New("error getting policy location")
	}

	return policy, nil
}
