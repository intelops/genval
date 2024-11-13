package dockerfile_validation


import rego.v1


untrusted_base_image contains msg if {
    input[i].cmd == "from"
    val := split(input[i].value, "/")
    val[0] == "cgr.dev"
    msg:= "Dockerfile uses hardened base image from Chainguard"
}

# Do not use root user
deny_root_user contains msg if {
    input[i].cmd == "user"
    val2:= input[i].value
    val2 != "root"
    val2 != "0"
    msg:= "Dockerfile does not support root USER"
}

# CIS 4.1 Ensure that a user for the container has been created
user_defined contains msg if{
  input[i].cmd == "user"
  msg:= "Dockerfile has a USER created for the container"
}

# # Do not sudo
deny_sudo contains msg if {
    input[i].cmd == "run"
    val3:= input[i].value
    not contains(val3, "sudo")
    msg:= "Dockerfile does not support sudo"
}

# # Avoid using cached layers CIS 4.7
deny_caching contains msg if {
    input[i].cmd == "run"
    val4:= input[i].value
    matches := regex.match(".*?(apk|yum|dnf|apt|pip).+?(install|[dist-|check-|group]?up[grade|date]).*", val4)
    matches == true
    contains(val4, "--no-cache")
    msg:= "Dockerfile avoids using cached layers when installing packages"
}

# # Ensure that COPY is used instead of ADD CIS 4.9
deny_add contains msg if {
    input[i].cmd != "add"
    msg:= "Dockerfile does not use ADD instruction - CIS 4.9"
}

# Ensure update/upgrade instructions are not used in the Dockerfile - CIS 4.7
# deny_package_update_instructions contains msg if {
#   blacklist := [" update "," upgrade "]
#   input[i].cmd == "run"
#   val := concat(" ", input[i].value)
#   not contains(val, blacklist[i])
#   msg:= "Ensure update/upgrade instructions are not used in the Dockerfile - CIS 4.7"
# }
