package validate_input

default check_base_image = false
default check_multi_stage = false

check_base_image{
	cmd := input.dockerfile[_].instructions[_].from[_]
	contains(cmd, "cgr.dev/chainguard")
}


check_multi_stage{
	cmd := input.dockerfile[_].stage
	cmd > 0
}


