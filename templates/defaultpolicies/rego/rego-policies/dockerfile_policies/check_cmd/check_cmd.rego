package dockerfile_validation

import rego.v1
check_cmd contains msg if {
 cmdInst := [x | input[i].cmd == "cmd"; x := input[i]]
  count(cmdInst) < 2
  msg:= "Dockerfile uses only one 'CMD' instruction"
}