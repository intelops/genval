[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/7843/badge)](https://www.bestpractices.dev/projects/7843)
[![Go Report Card](https://goreportcard.com/badge/github.com/intelops/genval)](https://goreportcard.com/report/github.com/intelops/genval)
[![Build Status](https://github.com/intelops/genval/actions/workflows/ci.yaml/badge.svg)](https://github.com/intelops/genval/actions?query=workflow%3Abuild)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


# Genval: Simplifying Configuration Management



Genval is a versatile Go utility that simplifies configuration management for a wide range of tools, including Dockerfile, Kubernetes manifests, Kubernetes, and other infrastructure files.



## Streamlining validation and Generation of Configurations



**Genval** is a robust utility written in Golang that streamlines the management of configurations for various tools. Whether you need Dockerfiles, YAML/JSON manifests for Kubernetes, or custom resource definitions (CRDs), Genval simplifies the process of validation and generation for multiple configuration artifacts.



## Why Genval?go install github.com/sigstore/gitsign@latest
go install github.com/sigstore/gitsign@latest


Managing configurations across different tools can be a daunting task. Ensuring that these configurations adhere to best practices is critical but can be time-consuming and error-prone. Genval automates these processes, making configuration management more efficient.



## Key Features



### Dockerfile Management



-  **Input Validation**: Genval validates your input, typically provided in JSON format, to ensure correct structure.



-  **Dockerfile Generation**: After successful validation, Genval generates a Dockerfile based on your input, tailored to your specifications.



-  **Best Practice Validation**: Genval doesn't stop at generation; it checks your Dockerfile against predefined best practices for security and optimization.



-  **Informative Feedback**: If Genval detects issues during best practice validation, it provides informative feedback to help you improve your Dockerfile.



> Note: For Dockerfile validation and generation, `genval` expects a predefined structure for the `JSON` file provided to the `--reqinput` flag. Sample `.json` files can be found in the `./templates/dockerFile-samples` directory.



### Managing Kubernetes Manifests



- Genval validates input for required structure based on the tool in use. It can enforce best practices while authoring configuration files for tools like Kubernetes and various CRDs.



- Users can provide minimal and custom configurations for a given resource, with Genval populating all necessary fields based on security best practices recommended by the community.



- Genval generates YAML manifests according to the required format for the specified resource and tool.



## Getting Started



To use Genval:



- Download the `genval` binary for your platform from the official [release page](https://github.com/intelops/genval/releases).



## Verifying Binary Signatures



Genval's release process signs binaries using Cosign's keyless signing mode. To verify a specific binary, retrieve the release checksum, signature, and public certificate for your desired `TAG`. Detailed instructions are available in the [Sigstore blog](https://blog.sigstore.dev/cosign-2-0-released/).



```shell

# Example commands to verify a binary for linux_amd64

COMMIT=$(git rev-list --tags --max-count=1)
version=$(git describe --tags ${COMMIT})
version="${version#v}"

# get the artifact
$ wget  https://github.com/santoshkal/genval-fork/releases/download/v${version}/genval_$version}_linux_amd64.tar.gz
# fetch the signature
$ wget  https://github.com/santoshkal/genval-fork/releases/download/v${version}/genval_${version}_linux_amd64.tar.gz.sig
# Get the certificate
$ wget  https://github.com/santoshkal/genval-fork/releases/download/v${version}/genval_${version}_linux_amd64.tar.gz.crt



cosign  verify-blob  \
--certificate-identity  "https://github.com/intelops/genval/.github/workflows/release.yaml@refs/tags/${version}"  \
--certificate-oidc-issuer  "https://token.actions.githubusercontent.com"  \
--cert  ./genval_${version}_linux_amd64.tar.gz.crt  \
--signature  genval_${version}_linux_amd64.tar.gz.sig \
./genval_${version}_linux_amd64.tar.gz
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

- Build Genval: `CGO_ENABLED=0 go build -o ./genval ./cmd`



The generated binary, genval, will be available in the current working directory. You can move it to your PATH or use it from the current directory.

Genval offers four modes which can be accessed through Genval's main commands :


- `dockerfile`: for generating and validaing of Dockefiles - uses [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) for validation of generated Dockerfiles
-  `regoval` for validation of Dockerfiles, Kubernetes manifests, and  Terraform files with Rego policies
-  `celval` for validation of Dockerfiles, Kubernetes manifests, and Terraform files with [Common Expression Language (CEL)](https://cel.dev/overview/cel-overview)) policies
-  `cue` for generation and validation of Kubernetes and related config files levereging [Cuelang aka CUE](https://cuelang.org/docs/))
- `artifact` for managing pusing and pulling the built artifacts from the OCI complient container registries

A helper mode `showjson` is available for user to view the **JSON** representation of the input files passed to Genval. In `--mode showjson` a user can pass the input file, for example a Dockerfile, Terraform file or a Kubernetes YAML manifests and get the JSON representation of that specific input. As most of the policies are written based on input in a JSON structured format. This would enable user to refer this JSON document to write their custom policies in **Rego** and **CEL**.


> All the modes accept inputs that include local files and files obtained from a remote URL, such as those from a Git repositoryin raw format. If you want to query the files from the `https://github.com`. You need to authenticate to GitHub by providing your Personal Access Token. You can do this by creating and an enviornment variable named. Here's how to do it: `export GITHUB_TOKEN=<Your...PAT>`


### Dockerfile Validation and Generation:


Run Genval with the `dockerfile` command, providing the path to your input JSON or YAML file using the `--reqinput` flag and specifying the desired output path for the generated Dockerfile along with `--inputpolicy` and `--outputpolicy` Rego policy files for validating the input JSON and the generated Dockerfile respectively. Genval will take care of the rest.

Example:

```
$ genval dockerfile --reqinput=./templates/inputs/dockerfile_input/golang_input.json \
--output Dockerfile \
--inputpolicy ./templates/defaultpolicies/ rego/inputfile_policies.rego \
--outputpolicy ./templates/defaultpolicies/rego/dockerfile_policies.rego
 ```

> Replace the values provided in the flags with your custom input file and Rego policies.

> All the arguments to the `--reqinput`, `inputpolicy`, and `outputpolicy` can be supplied from a remote URL's, such as those hosted on GitHub (e.g., https://github.com).

> For authenticating with GitHub.com, set the env variable GITHUB_TOKEN:
`export GITHUB_TOKEN=<Your GitHub PAT>`

**Review Feedback**: Genval provides feedback based on best practice validation. Use this feedback to refine your Dockerfile.

### Validation of the Dockerfile, Kubernetes manifests and Terraform files using Rego policies

Genval manages validation with Rego polcies with `regoval` command and for validation of each of the technology a separate subcommand is provided:

#### Validation of Dockerfiles with Rego policies

```shell
genval regoval dockerfileval --reqinput ./templates/inputs/Dockerfile \
--policy ./templates/defaultpolicies/dockerfile_policies.rego
```

#### Validation of Kubernetes manifests using Rego policies

```shell
genval infrafile --reqinput ./templates/inputs/k8s/deployment.json \
--policy ./templates/defaultpolicies/k8s.rego
```

#### Validation of Terraform files using Rego policies

> Users may pass the `.tf` file to genval along with a policy written in Rego for validatin the Terraform file
```shell
genval regoval --reqinput ./templates/inputs/terraform/sec_group.tf \
--policy ./templates/defaultpolicies/terraform.rego
```


### Validation of the Dockerfile, Kubernetes manifests and Terraform files using CEL policies

#TODO: Add example
#### Validation of Dockerfiles with CEL policies
#TODO: Add example

#### Validation of Kubernetes manifests using Rego policies
#TODO: Add example

#### Validation of Terraform files using Rego policies
#TODO: Add example


### Validation and Generation of Kubernetes configurations
#TODO: Update acoring to current workflow

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

### Managing the generated and Validated configuration files

Genval provides the avility to manage the configuration files that are generated and/validated by building them as OCI artifacts and storing them in OCI complient registry and also pulling the same config files from the registry.

To enhance the supply chain security workflow, Genval also enables users to sign the artifacts after storing them in the registry and also verifying for the signatures of the artifacts. This feature leverges [Sigstore's Cosign] keyless mode of signing and verifying the artifacts. However, users may also user their own private and publioc keys for sgning and verifying the artifacts respectively.

#### Building, pushing, and signing generated and/or verified config files and OCI artifacts
#TODO: Add examples for artifact pushing with signing explaining the flow


#### VErifying the stored artifact for valid signatures while pullin the artifacts

#TODO: Add examples for artifact pull with verifying explaining the flow



### Templates

The `./templates` folder holds some sample files to be used in Genval. the `./templates/inputs` holds JSON input templates for both generating Dockerfiles in `container` mode and Kubernetes manifests in `cue` mode. Similarly, all the sample policies for all the modes are stored in `./templates/defaultpolices` directory. User can use these template files to start with and as they go along they can build upon it and customize these policies to suite their specific use cases.