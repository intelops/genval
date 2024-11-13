package validate_k8s

import rego.v1


deny_latest contains msg if {
input.kind ==	"Deployment"
c:= input.spec.template.spec.containers[i].image
not endswith(c, "latest")
msg:= "Image does not use 'latest' tag"
}

deny_secret contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.envFrom
    msg:= "Deployment does not use 'envFrom'"
}

deny_secret contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    env := container.envFrom[_]
    not env.secretRef
    msg:= "Deployment does not use 'secretRef' in ENV"
	}

deny_secret contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    env := container.env[_]
	env.valueFrom != []
    msg:= "Deployment does not use 'valueFrom' in ENV"
}
' 
deny_priviliged_pod contains msg if {
	input.kind == "Deployment"
	not input.spec.template.spec.securityContext
    msg:= "Deployment does not use priviliged pod"
}

deny_priviliged_pod contains msg if {
	input.kind == "Deployment"
	podSpec := input.spec.template.spec.securityContext

	not podSpec.priviliged
    msg:= "Deployment does not use priviliged pod"
}