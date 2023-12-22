package validate_input_tf

default deny_global_ingress = false

deny_global_ingress {
	input.resource[_].aws_security_group
	ing := input.resource[_].aws_security_group.allow_tls.ingress[_]
	denied_cidr := "0.0.0.0/0"
	global := ing.cidr_blocks[_]
	not contains(global, denied_cidr)
}
