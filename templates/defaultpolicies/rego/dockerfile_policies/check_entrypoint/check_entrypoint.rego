package dockerfile_validation

import rego.v1
check_entrypoint contains msg if {
 cmdInst := [x | input[i].cmd == "entrypoint"; x := input[i]]
  count(cmdInst) < 2
  msg:= "Dockerfile uses only one 'CMD' instruction"
}