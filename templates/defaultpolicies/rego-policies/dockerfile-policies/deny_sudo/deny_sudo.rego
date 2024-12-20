package dockerfile_validation


import rego.v1

# # Do not sudo
deny_sudo contains msg if {
    input[i].cmd == "run"
    val3:= input[i].value
    not contains(val3, "sudo")
    msg:= "Dockerfile does not support sudo"
}