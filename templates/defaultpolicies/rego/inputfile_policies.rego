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


# No more than 1 From instruction
# check_base_image{
# 	cmd := input.Dockerfile[_].Instructions[_].from[_]
# 	s:= input.Dockerfile[_].Stage
# 	s == 0
# 	cmd == 1
# }