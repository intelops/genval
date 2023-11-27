# Genval: Simplifying Configuration Management

  

Genval is a versatile Go utility that simplifies configuration management for a wide range of tools, including Dockerfile, Kubernetes manifests, Helm, Timoni, Kustomize, Kubernetes Operators, Tekton, GitOps, Kubernetes Infrastructure YAML files, and more.

  

## Streamlining validation and Generation of Configurations

  

**Genval** is a robust utility written in Golang that streamlines the management of configurations for various tools. Whether you need Dockerfiles, YAML/JSON manifests for Kubernetes, or custom resource definitions (CRDs), Genval simplifies the process of validation and generation for multiple configuration artifacts.

  

## Why Genval?

  

Managing configurations across different tools can be a daunting task. Ensuring that these configurations adhere to best practices is critical but can be time-consuming and error-prone. Genval automates these processes, making configuration management more efficient.

  

## Key Features

  

### Dockerfile Management

  

-  **Input Validation**: Genval validates your input, typically provided in JSON format, to ensure correct structure.

  

-  **Dockerfile Generation**: After successful validation, Genval generates a Dockerfile based on your input, tailored to your specifications.

  

-  **Best Practice Validation**: Genval doesn't stop at generation; it checks your Dockerfile against predefined best practices for security and optimization.

  

-  **Informative Feedback**: If Genval detects issues during best practice validation, it provides informative feedback to help you improve your Dockerfile.

  

> Note: For Dockerfile validation and generation, `genval` expects a predefined structure for the `JSON` file provided to the `--value` flag. Sample `.json` files can be found in the `./templates/dockerFile-samples` directory.

  

### Managing Kubernetes and CRD Manifests

  

- Genval validates input for required structure based on the tool in use. It can enforce best practices while authoring configuration files for tools like Kubernetes and various CRDs.

  

- Users can provide minimal and custom configurations for a given resource, with Genval populating all necessary fields based on security best practices recommended by the community.

  

- Genval generates YAML manifests according to the required format for the specified resource and tool.

  

## Getting Started

  

To use Genval:

  

- Download the `genval` binary for your platform from the official [release page](https://github.com/intelops/genval/releases).

  

## Verifying Binary Signatures

  

Genval's release process signs binaries using Cosign's keyless signing mode. To verify a specific binary, retrieve the release checksum, signature, and public certificate for your desired `TAG`. Detailed instructions are available in the [Sigstore blog](https://blog.sigstore.dev/cosign-2-0-released/).

  

```shell

# Example commands to verify a binary

$ wget  https://github.com/intelops/genval/releases/download/v0.0.1/checksums.txt
$ wget  https://github.com/intelops/genval/releases/download/v0.0.1/checksums.txt.pem
$ wget  https://github.com/intelops/genval/releases/download/v0.0.1/checksums.txt.sig

  

cosign  verify-blob  \
--certificate-identity  "https://github.com/intelops/genval/.github/workflows/release.yaml@refs/tags/v0.0.1"  \
--certificate-oidc-issuer  "https://token.actions.githubusercontent.com"  \
--cert  ./checksums.txt.pem  \
--signature  ./checksums.txt.sig  \
./checksums.txt
```
If verification is successful, you'll see "**Verified OK.**"

  

## Installation

  

- Download the genval binary from the official [release page](https://github.com/intelops/genval/releases)

- Move the executable to your `PATH` for convenience.

  

## Quick Start
 

For a quick start, pre-built templates for Dockerfile generation for popular languages can be found in the `./templates/inputs/dockerfile_input` folder.
  

## Building from Source

The easieast way to build the `genval` executable is using the `build` Makefile target.
`make build`. 
This will build the binary from source and place the `genval` binary in the `./bin` folder. 

  

To build genval from source:

- Clone the Genval repository: `git clone https://github.com/intelops/genval.git`

- Navigate to the project directory: `cd genval`

- Build Genval: `CGO_ENABLED=0 go build -o ./cmd/genval`

  

The generated binary, genval, will be available in the current working directory. You can move it to your PATH or use it from the current directory.

Genval offers four modes:


-  `container` for Dockerfile validation with rego policies and generation of validated Dockerfile
-  `cue` for Kubernetes and CRD validation and generation
-  `k8s` for validating Kubernetes manifests with Rego policies
-  `tf`  for validating Terraform resource files with Rego policies


> All the modes accept inputs that include local files and files obtained from a remote URL, such as those from a Git repository. 
  

### Dockerfile Validation and Generation:
  

Run Genval with the `--mode container` flag, providing the path to your input JSON or YAML file using the `--reqinput` flag and specifying the desired output path for the generated Dockerfile along with `--inputpolicy` and `--outputpolicy` for validating the input JSON and the generated Dockerfile respectively. Genval will take care of the rest. 

Example:

```
$ genval --mode container --reqinput ./templates/inputs/dockerfile_input/golang_input.json \
  --output ./Dockerfile-Golang  \
  --inputpolicy ./templatates/defaultpolicies/rego/inputfile_policies.rego \
  --outputpolicy ./templatates/defaultpolicies/rego/dockerfile_policies.rego
 ```
  

> Replace the values provided in the flags with your custom input file and Rego policies.

  

**Review Feedback**: Genval provides feedback based on best practice validation. Use this feedback to refine your Dockerfile.


### Validation and Generation of Kubernetes configurations


The validation and generation of Kubernetes and CRD manifests are facilitated through the use of [cuelang](https://cuelang.org/docs/). When using Genval for validating and generating Kubernetes and related manifests, make use of the Genval tool in `cue` mode. This mode necessitates JSON input provided via the `--reqinput` flag. Furthermore, you should specify a `resource` flag, indicating the Kubernetes or CRD `Kind` that requires validation. Additionally, attach the `.cue schema definitions` to the `--policy` flag. These policy files can be provided from the users local file system or from a remote URL, like a Git repository.

You have the flexibility to employ multiple `--policy` flags, allowing you to supply distinct `.cue` definitions as needed. For instance, your DevSecOps/Platform engineering team can furnish a schema that enforces security best practices for a specific environment, encompassing all the pertinent mandatory fields. This approach leaves room for custom fields like `metadata`, `image`, `replicas`, specific to a **Deployment**, to be provided by the development teams. In the `cue` mode, development teams can then contribute their customized policies for validation and generation, tailoring the configurations to suit their particular environments.

  

Example:


```shell
$ genval  --mode  cue  --reqinput  ./templates/inputs/cue/deploy,json  \
  --resource  Deployment  \
  --policy  ./templates/defaultpolicies/cue/deployment.cue  \
  --policy  ./templates/defaultpolicies/cue/dev-deployment.cue
```

The above command will validate a Deployment manifests using the provided `.cue` schema definitions provided as policies and generate the final YAML manifet in the `cwd`.

> The `--resource` flag in `cue` mode needs a valid Kind, like in above example "Deployment" or StatefulSet, DaemonSet etc.


For a detailed workflow illustrating the capabilities of Cue and Genval for validating and generating Kubernetes configurations, you can refer to [this document](./cmd/cueval/example.md).
The workflow for adding a Cue schema for Kubernetes CRDs is failry easy, and demostrated in the [CONTRIBUTION.md document](./CONTRIBUTION.md/#contributing-by-adding-a-cue-schema-to-the-project).  

### Validation of Kubernetes resources with Repgo policies

To validate Kubernetes manifests with Rego policies, users can use `--mode k8s` with `--reqinput` for providing the required input in JSON or YAML format, and `--policy` flag to pass in the Rego policies.

Example:

```shell
genval --mode k8s --reqinput <Path/to/input/yaml/json file> \
    --policy <Path/to/.rego policy>
```

### Validate Terraform resource files with Rego policies

To validate the Terraform resource file in `.tf` format. Use `--mode tf` with two flags as above `--reqinput` and `--policy`. The Genval tool internally will transform the input `.tf` file in JSON and validate the resource file with Rego policies.

To write custom policies, users might require to know the `JSON` representation of the input `.tf` file. In order to get the `JSON` representation of the `.tf` users can use `--json` flag after passing the `--reqinput` and `--policy` flags. This will print the JSON doc for the input. Now, users can pipe it to tools lie [jq](https://jqlang.github.io/jq/) to get a prettified JSOn representation that could help user write rego policies.

Example:

```shell
genval --mode tf --reqinput ../templates/inputs/terraform/sec-group.tf \
    --policy ./templates/defaultpolicies/rego/terraform.rego \
    --json true jq .
{
  "resource": [
    {
      "aws_security_group": {
        "allow_tls": {
          "description": "Allow TLS inbound traffic",
          "egress": [
            {
              ...
```

### Templates

The `./templates` folder holds some sample files to be used in Genval. the `./templates/inputs` holds JSON input templates for both generating Dockerfiles in `container` mode and Kubernetes manifests in `cue` mode. Similarly, all the default policies for both the modes are stored in `./templates/defaultpolices` directory. User can use these template files to start with and as they go along they can customize these files to suite their specific use cases.  