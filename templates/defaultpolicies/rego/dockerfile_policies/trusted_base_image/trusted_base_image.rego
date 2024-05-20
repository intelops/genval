package dockerfile_validation

import rego.v1

trusted_base_image contains msg if {
    input[i].cmd == "from"
    val := split(input[i].value, "/")
    val[0] == "cgr.dev"
    msg :="Dockerfile uses hardened base image from Chainguard"
}