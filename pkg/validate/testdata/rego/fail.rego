package dockerfile_validation

import rego.v1


untrusted_base_image contains msg if {
    input[i].cmd == "from"
    val := split(input[i].value, "/")
    val[0] == "cgr.dev"
    msg:= "Image does noyt contain latest tag"
}