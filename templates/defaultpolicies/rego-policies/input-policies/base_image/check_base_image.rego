package validate_input

import rego.v1


check_base_image contains msg if {
	cmd := input.dockerfile[_].instructions[_].from[_]
	contains(cmd, "cgr.dev/chainguard")
	msg:= "Input template for Dockerfile uses hardened base image from Chainguard"
}