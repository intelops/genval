package validate_k8s

import future.keywords

default deny_latest = false
default deny_secret = false
default deny_priviliged_pod = false

deny_latest{
input.kind ==	"Deployment"
c:= input.spec.template.spec.containers[i].image
not endswith(c, "latest")
}

deny_secret{
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.envFrom
}

deny_secret{
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    env := container.envFrom[_]
    
    not env.secretRef
	}

deny_secret{
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]

    env := container.env[_]
	env.valueFrom != []
}

deny_priviliged_pod{
	input.kind == "Deployment"
	not input.spec.template.spec.securityContext
}

deny_priviliged_pod{
	input.kind == "Deployment"
	podSpec := input.spec.template.spec.securityContext

	not podSpec.priviliged
}
