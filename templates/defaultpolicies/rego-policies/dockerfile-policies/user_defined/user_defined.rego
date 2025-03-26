package dockerfile_validation




# CIS 4.1 Ensure that a user for the container has been created
user_defined {
  input[i].cmd == "user"
}


