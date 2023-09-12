package dockerfile_validation


default untrusted_base_image = false
default deny_root_user = false
default deny_sudo = false
default deny_caching = false
default deny_add = false



untrusted_base_image {
    input[i].cmd == "from"
    val := split(input[i].value, "/")
    val[0] == "cgr.dev"
}

# Do not use root user
deny_root_user {
    input[i].cmd == "user"
    val2:= input[i].value
    val2 != "root"
    val2 != "0" 
}

# Do not sudo
deny_sudo{
    input[i].cmd == "run"
    val3:= input[i].value
    not contains(val3, "sudo")
}

# Avoid using cached layers CIS 4.7
deny_caching{
    input[i].cmd == "run"
    val4:= input[i].value
    matches := regex.match(".*?(apk|yum|dnf|apt|pip).+?(install|[dist-|check-|group]?up[grade|date]).*", val4)
    matches == true
    contains(val4, "--no-cache")
}	

# Ensure that COPY is used instead of ADD CIS 4.9
deny_add{
    input[i].cmd != "add"
}

