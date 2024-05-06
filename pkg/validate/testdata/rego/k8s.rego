package validate_k8s

import rego.v1


deny_latest contains msg if {
input.kind ==	"Deployment"
c:= input.spec.template.spec.containers[i].image
not endswith(c, "latest")
msg:= "Image does not have latest tag"
}


