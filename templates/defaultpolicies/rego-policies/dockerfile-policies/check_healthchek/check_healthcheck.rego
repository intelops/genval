package dockerfile_validation

import rego.v1


check_healthcheck contains msg if {
  input[i].cmd == "healthcheck"
  msg:= "Dockerfile uses 'HEALTHCHEC' instruction to check the health of a container"
}