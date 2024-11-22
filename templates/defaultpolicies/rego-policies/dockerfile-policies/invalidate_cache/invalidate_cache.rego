package dockerfile_validation

import rego.v1

invalidate_cache contains msg if {
    input[i].cmd == "run"
    val := input[i].val
    some j
    c:= trim_space(val[j])
    startswith(c,"apk")
    contains(c, "add")
    contains(c, "update")
    not contains(c, "--no-cache")
    msg:= "Ensure 'RUN' should not contain 'apk add' command without '--no-cache' switch"
}