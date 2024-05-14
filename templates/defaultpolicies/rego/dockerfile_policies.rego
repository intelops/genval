package dockerfile_validation

import rego.v1

untrusted_base_image contains result if {
    input[i].cmd == "from"
    val := split(input[i].value, "/")
    val[0] == "cgr.dev"
    result := {
        "msg": "Dockerfile uses hardened base image from Chainguard",
        "benchmark": "CIS - 4.2"
    }
}

# Do not use root user
deny_root_user contains result if {
    input[i].cmd == "user"
    val2 := input[i].value
    val2 != "root"
    val2 != "0"
    result := {
        "msg": "Dockerfile does not support root user",
        "benchmark": "CIS - 4.1"
    }
}


# CIS 4.1 Ensure that a user for the container has been created
user_defined contains result if{
  input[i].cmd == "user"
  result:={
    "msg": "Ensure that a user for the container has been created",
    "benchmark": "CIS - 4.1"
  }
}   

# # # Do not sudo
deny_sudo contains result if {
    input[i].cmd == "run"
    val3:= input[i].value
    not contains(val3, "sudo")
    result:= {
        "msg": "Dockerfile does not support sudo",
        "benchmark": "CIS - 4.1"
    }
}

# # # Avoid using cached layers CIS 4.7
deny_caching contains result if {
    input[i].cmd == "run"
    val4:= input[i].value
    matches := regex.match(".*?(apk|yum|dnf|apt|pip).+?(install|[dist-|check-|group]?up[grade|date]).*", val4)
    matches == true
    contains(val4, "--no-cache")
    result:={
        "msg": "Dockerfile invalidates cache when installing dependencies",
        "benchmark": "CIS - 4.7"
    }
}

# # # Ensure that COPY is used instead of ADD CIS 4.9
deny_add contains result if {
    input[i].cmd != "add"
    result:={
        "msg": "Dockerfile does not use ADD instruction",
        "benchmark": "CIS - 4.9"
    }
}

# Ensure update/upgrade instructions are not used in the Dockerfile - CIS 4.7
# deny_package_update_instructions contains msg if {
#   blacklist := [" update "," upgrade "]
#   input[i].cmd == "run"
#   val := concat(" ", input[i].value)
#   not contains(val, blacklist[i])
#   msg:= "Ensure update/upgrade instructions are not used in the Dockerfile - CIS 4.7"
# }
