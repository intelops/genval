package validate_k8s


deny_latest{
input.kind ==	"Deployment"
c:= input.spec.templates.specs.containers[i].image
endswith(c, "latest"