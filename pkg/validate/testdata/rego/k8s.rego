package validate_k8s

import future.keywords

default deny_latest = false


deny_latest{
input.kind ==	"Deployment"
c:= input.spec.template.spec.containers[i].image
not endswith(c, "latest")
}


