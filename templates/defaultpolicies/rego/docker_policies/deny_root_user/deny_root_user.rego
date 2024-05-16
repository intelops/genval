package dockerfile_validation


import rego.v1

# Do not use root user
deny_root_user contains msg if {
    input[i].cmd == "user"
    val2:= input[i].value
    val2 != "root"
    val2 != "0"
    msg:= "Dockerfile does not support root user"
}
