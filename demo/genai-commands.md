# Commands to interact with genval GenAI features

- Generate a Dockerfile for a simple web Nginx web serve:

`./bin/genval genai -c ./templates/defaultpolicies/genai/dockerfile-config.yaml`

## Note: Regex implementation is in testing phase in pre-main branch

- Generate Regex polcies for GenAI:

`./bin/genval genai -c ./templates/defaultpolicies/genai/regex-config.yaml`

- Generation of Rego Policies using Genai

`./bin/genval genai -c ./templates/defaultpolicies/genai/rego-config.yaml`

- Generation of Cuelang Definitions using Genai

`./bin/genval genai -c ./templates/defaultpolicies/genai/cue-config.yaml`

- Generation of CEL policies using Genai

`./bin/genval genai -c ./templates/defaultpolicies/genai/cel-config.yaml`
