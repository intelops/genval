package dockerfile_validation


import rego.v1

# # Ensure that COPY is used instead of ADD CIS 4.9
deny_add contains msg1 if {
    input[i].cmd != "add"
    msg:= ("Dockerfile does not use ADD instruction")
msg1:= ("DOCKERFILE does not use ADD instruction")  
} 




