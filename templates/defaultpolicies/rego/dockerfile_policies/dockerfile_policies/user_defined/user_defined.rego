package dockerfile_validation


import rego.v1


# CIS 4.1 Ensure that a user for the container has been created
user_defined contains msg if{
  input[i].cmd == "user"
  msg:= "Ensure that a user for the container has been created"
}