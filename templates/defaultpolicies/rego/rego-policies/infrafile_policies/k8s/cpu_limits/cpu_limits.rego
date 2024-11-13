package validate_k8s

# import rego.v1
import future.keywords
# import data.k8s.common as lib


check_cpu_limits[msg]{
input.kind ==	"Deployment"
c:= input.spec.template.spec.containers[i]
not valid_key(c.resources.limits,"cpu")
msg:="CPU Limits are set for Deployment"
}   


valid_key(obj, key) {
	_ = obj[key]
	not is_null(obj[key])
} else = false {
	true
}