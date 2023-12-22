package dockerfile_validation

default check_multi_stage = false

check_multi_stage {
    input[i].cmd == "#"
    input[i].value == "STAGE 1"
}