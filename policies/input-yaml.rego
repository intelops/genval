package validate_input

default check_base_image = false
default check_multi_stage = false

check_base_image{
	cmd := input.Dockerfile[_].Instructions[_].from[_]
	contains(cmd, "cgr.dev/chainguard")
}


check_multi_stage{
	cmd := input.Dockerfile[_].Stage
	cmd > 0
}
