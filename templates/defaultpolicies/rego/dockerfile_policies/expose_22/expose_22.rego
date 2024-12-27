package dockerfile_validation

import rego.v1

deny_port_22 contains msg if {
	# Ensure there is at least one EXPOSE instruction
	some i
	input[i].cmd == "expose"

	# Check if the EXPOSE instruction does not expose port 22
	port := to_number(input[i].value)
	port == 22
	msg := "Dockerfile exposes prohibited port 22"
}

deny_port_22 contains msg if {
	# Ensure there is at least one EXPOSE instruction
	some i
	input[i].cmd != "expose"

	msg := "Dockerfile exposes prohibited port 22"
}
