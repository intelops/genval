package dockerfile_validation

import rego.v1

# # Avoid using cached layers CIS 4.7
deny_caching contains msg if {

	input[i].cmd == "run"
	val := input[i].value
	sb := trim_space(val)

	matches := regex.match(".*?(apk|yum|dnf|apt|pip).+?(install|[dist-|check-|group]?up[grade|date]).*", sb)
	matches == true
  not contains(sb, "--no-cache")
    msg:= "Dockerfile invalidates cache when installing dependencies"
}
