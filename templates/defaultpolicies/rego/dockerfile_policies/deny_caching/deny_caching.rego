package dockerfile_validation


import rego.v1


# # Avoid using cached layers CIS 4.7
deny_caching contains msg if {
    input[i].cmd == "run"
    val4:= input[i].value
    matches := regex.match(".*?(apk|yum|dnf|apt|pip).+?(install|[dist-|check-|group]?up[grade|date]).*", val4)
    matches == true
    contains(val4, "--no-cache")
    msg:= "Dockerfile invalidates cache when installing dependencies"
}