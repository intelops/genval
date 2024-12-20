# conftest policy to test docker image for CIS Docker Benchmark compliance
package main

# from https://github.com/ncheneweth/opa-dockerfile-benchmarks/blob/master/policy/cis-docker-benchmark.rego


deny[msg] {
  not user_defined
  msg = "4.1 Ensure a user for the container has been created (Scored) level 1"
}

user_defined {
  input[i].Cmd == "user"
}

deny[msg] {
  not healthcheck_defined
  msg = "4.6 Ensure HEALTHCHECK instructions have been added to the container image (Scored) level 1"
}

healthcheck_defined {
  input[i].Cmd == "healthcheck"
  trace("4.6 HEALTHCHECK is defined")
}

deny[msg] {
  package_update_or_upgrade_instructions
  msg = "4.7 Ensure update/upgrade instructions are not used in the Dockerfile (Not Scored) level 1"
}

package_update_or_upgrade_instructions {
  blacklist = [" update "," upgrade "]
  input[i].Cmd == "run"
  val := concat(" ", input[i].Value)
  contains(val, blacklist[_])
}


deny[msg] {
  input[i].Cmd == "add"
  msg = "4.9 Ensure COPY is used instead of ADD in Dockerfile (Not Scored) level 1"
}
