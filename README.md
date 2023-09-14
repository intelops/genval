# genval
Verify, Generate and Validate dockerfile, K8s Manifests, Helm, Timoni, Kustomize, K8s Operators, Tekton, GitOps, K8s Infa YAML files, etc. programmatically.


## Simplifying Dockerfile Validation and Generation

**GenVal** is a powerful utility written in Golang that simplifies the process of Dockerfile validation and generation. Whether you're new to Docker or a seasoned pro, GenVal can help you create Dockerfiles that adhere to best practices for security and optimization.

## Why GenVal?

Managing Dockerfiles can be complex. It's crucial to ensure they follow best practices, but this can be time-consuming and error-prone. GenVal takes care of the heavy lifting by automating these processes, making Dockerfile management more efficient.

## Features

- **Input Validation**: GenVal begins by validating your input, which can be provided in JSON format. This initial step ensures that your input data is correctly structured.

- **Dockerfile Generation**: Once your input passes validation, GenVal generates a Dockerfile for you based on the provided data. This Dockerfile will be tailored to your specifications.

- **Best Practice Validation**: After generating the Dockerfile, GenVal doesn't stop there. It checks your Dockerfile against a set of predefined best practices for security and optimization. 

- **Informative Feedback**: If GenVal detects any issues or discrepancies during the best practice validation, it provides informative feedback. This feedback helps you understand what needs improvement in your Dockerfile.

## Getting Started

Using GenVal is straight forward:

`genval` is available as a binary executable for all major platforms, the binaries can be downloaded from the [release page]()

1. **Installation**: To install GenVal on your system. You can downlod the executable binary make its executible and you are ready to go.

```shell
curl https://github.com/santoshkal/genval-poc/releases/download/v0.0.2/genval_0.0.2_<os/arch>.tar.gz
tar -xvf genval_0.0.2_<os/arch>.tar.gz
chmod +x genval
# move the executable to PATH
mv ./genval /usr/local/bin
```
For quick start, there are some pre-built templates to build Dockerfile for popular languages in `/templates/dockerfile-sample` directory. 

Now, you are ready to generate your Dockerfile with following command:


2. **Validation and Generation**: Run GenVal, providing the path to your input JSON or YAML file and the desired path for the generated Dockerfile. GenVal will take care of the rest.

`genval ./templates/dockerfile-samples/go-input.json ./Dockerfile-Golang`

3. **Review Feedback**: GenVal will display feedback based on the best practice validation. If any issues are found, you can use this feedback to refine your Dockerfile.

Here's a simple command to use GenVal:

```shell
genval <path/to/input-json> <path/to/Dockerfile>
```

Replace `<path/to/input-json>` with the path to your input JSON file and `<path/to/Dockerfile>` with the desired path for the generated Dockerfile.

## Application Flow Diagram: 
```mermaid
flowchart
	2{"Input validation"} -.->|"Yes"| 3(["Generate \nDockerfile"])
	1["Input JSON file"] --> 2
	2 -->|"No"| 471222["Update JSON as needed"]
	793804("Validate \nDockerfile") --> 3
	3 -->|"No"| 714538["Update JSON as suggested"]
	3 -->|"Yes"| 4[["Final Dockerfile"]]
```

## Local Developement

If you are interested in building a local Dev env for GenVal, follow [these](CONTRIBUTION.md/#set-up-your-local-development-environment) steps.

GenVal simplifies Dockerfile management by automating validation and generation while ensuring that your Dockerfiles adhere to best practices. It's a valuable tool for both Docker novices and experts.

