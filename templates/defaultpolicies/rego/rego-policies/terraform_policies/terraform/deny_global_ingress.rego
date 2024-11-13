package validate_input_tf

import rego.v1


deny_global_ingress contains msg if {
	input.resource[_].aws_security_group
	ing := input.resource[_].aws_security_group.allow_tls.ingress[_]
	denied_cidr := "0.0.0.0/0"
	global := ing.cidr_blocks[_]
	not contains(global, denied_cidr)
	msg:= "Security group does not ingress from all IPv4 addresses "
}