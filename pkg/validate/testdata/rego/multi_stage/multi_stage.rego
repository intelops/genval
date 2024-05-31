package dockerfile_validation

import rego.v1

multi_stage contains msg if {
	cmd := input.dockerfile[_].stage
	cmd > 0
  msg:= "This is a multi-stage Dockerfile"
}
