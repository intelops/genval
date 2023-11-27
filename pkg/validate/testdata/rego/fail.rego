package dockerfile_validation

default fail = false

untrusted_base_image {
    input[i].cmd == "from"
    val := split(input[i].value, "/")
    val[0] == "cgr.dev"
}