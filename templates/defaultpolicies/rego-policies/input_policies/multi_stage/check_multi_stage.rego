package validate_input

import rego.v1

check_multi_stage contains msg if {
	cmd := input.dockerfile[_].stage
	cmd > 0
	msg:= "Input template is for multi-stage Dockerfile"
}