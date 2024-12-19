package validate_k8s

import rego.v1


deny_secret_env contains msg if {
	input.kind == "Deployment"
	container := input.spec.template.spec.containers[i]
	not container.envFrom[i].secretRef
	msg := "Deployment does not use 'secretRef' in ENV"
}