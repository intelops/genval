package dockerfile_validation

default fail = false

fail {
    input[i].cmd == "#"
    input[i].value == "stage"
}