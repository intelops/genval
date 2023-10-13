# GenVal: Simplifying Configuration Management

GenVal is a versatile Go utility that simplifies configuration management for a wide range of tools, including Dockerfile, Kubernetes manifests, Helm, Timoni, Kustomize, Kubernetes Operators, Tekton, GitOps, Kubernetes Infrastructure YAML files, and more.

## Streamlining Dockerfile Validation and Generation

**GenVal** is a robust utility written in Golang that streamlines the management of configurations for various tools. Whether you need Dockerfiles, YAML/JSON manifests for Kubernetes, or custom resource definitions (CRDs), GenVal simplifies the process of validation and generation for multiple configuration artifacts.

## Why GenVal?

Managing configurations across different tools can be a daunting task. Ensuring that these configurations adhere to best practices is critical but can be time-consuming and error-prone. GenVal automates these processes, making configuration management more efficient.

## Key Features

### Dockerfile Management

- **Input Validation**: GenVal validates your input, typically provided in JSON format, to ensure correct structure.

- **Dockerfile Generation**: After successful validation, GenVal generates a Dockerfile based on your input, tailored to your specifications.

- **Best Practice Validation**: GenVal doesn't stop at generation; it checks your Dockerfile against predefined best practices for security and optimization.

- **Informative Feedback**: If GenVal detects issues during best practice validation, it provides informative feedback to help you improve your Dockerfile.

> Note: For Dockerfile validation and generation, `genval` expects a predefined structure for the `JSON` file provided to the `--value` flag. Sample `.json` files can be found in the `./templates/dockerFile-samples` directory.

### Managing Kubernetes and CRD Manifests

- GenVal validates input for required structure based on the tool in use. It can enforce best practices while authoring configuration files for tools like Kubernetes and various CRDs.

- Users can provide minimal and custom configurations for a given resource, with GenVal populating all necessary fields based on security best practices recommended by the community.

- GenVal generates complete YAML files according to the required format for the specified resource and tool.

## Getting Started

To use GenVal:

- Download the `genval` binary for your platform from the official [release page](https://github.com/intelops/genval/releases).

## Verifying Binary Signatures

GenVal's release process signs binaries using Cosign's keyless signing mode. To verify a specific binary, retrieve the release checksum, signature, and public certificate for your desired `TAG`. Detailed instructions are available in the [Sigstore blog](https://blog.sigstore.dev/cosign-2-0-released/).

```shell
# Example commands to verify a binary
wget https://github.com/intelops/genval/releases/download/v0.0.1/checksums.txt
wget https://github.com/intelops/genval/releases/download/v0.0.1/checksums.txt.pem
wget https://github.com/intelops/genval/releases/download/v0.0.1/checksums.txt.sig

cosign verify-blob \
--certificate-identity "https://github.com/intelops/genval/.github/workflows/release.yaml@refs/tags/v0.0.1" \
--certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
--cert ./checksums.txt.pem \
--signature ./checksums.txt.sig \
./checksums.txt
```
If verification is successful, you'll see "**Verified OK.**"

## Installation

- Download the genval binary from the official [release page](https://github.com/intelops/genval/releases)
- Make the binary executable: `chmod +x genval`
- Move the executable to your `PATH` for convenience.

## Quick Start

For a quick start, pre-built templates for Dockerfile generation for popular languages can be found in the /templates/dockerFile-sample directory

## Building from Source

To build genval from source:
- Clone the GenVal repository: `git clone https://github.com/intelops/genval.git`
- Navigate to the project directory: `cd genval`
- Build GenVal: `CGO_ENABLED=0 go build -o ./cmd/genval`

The generated binary, genval, will be available in the current working directory. You can move it to your PATH or use it from the current directory.

GenVal offers two modes:

- `docker` for Dockerfile validation and generation
- `cueval` for Kubernetes and CRD validation and generation

### Dockerfile Validation and Generation:

Run GenVal with the --mode docker flag, providing the path to your input JSON or YAML file using the --value flag and specifying the desired output path for the generated Dockerfile. GenVal will take care of the rest.

Example:

`genval --mode docker --value ./templates/dockerfile-samples/go-input.json --output ./Dockerfile-Golang`

> Replace <./templates/dockerfile-samples/go-input.json> with the path to your input JSON file and <./Dockerfile-Golang> with the desired path for the generated Dockerfile.

**Review Feedback**: GenVal provides feedback based on best practice validation. Use this feedback to refine your Dockerfile.