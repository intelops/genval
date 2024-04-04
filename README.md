[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/7843/badge)](https://www.bestpractices.dev/projects/7843)
[![Go Report Card](https://goreportcard.com/badge/github.com/intelops/genval)](https://goreportcard.com/report/github.com/intelops/genval)
[![Build Status](https://github.com/intelops/genval/actions/workflows/ci.yaml/badge.svg)](https://github.com/intelops/genval/actions?query=workflow%3Abuild)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


# Genval: Simplifying Configuration Management



Genval is a versatile Go utility that simplifies configuration management for a wide range of tools, including Dockerfile, Kubernetes manifests, and other infrastructure files.



## Streamlining validation and Generation of Configurations



**Genval** is a robust utility written in Golang that streamlines the management of configuration files for various tools. Whether you need Dockerfiles, YAML/JSON manifests for Kubernetes, or custom resource definitions (CRDs), Genval simplifies the process of validation and generation for multiple configuration artifacts.



## Why Genval?

Managing configurations across different tools can be a daunting task. Ensuring that these configurations adhere to best practices is critical, at the same time it can be time-consuming and error-prone. Genval automates these processes, making configuration management more efficient.



## Key Features



### Dockerfile Management



-  **Dockerfile Generation**: After successful validation, Genval generates a Dockerfile based on your input, tailored to your specifications.


-  **Input Validation**: Genval validates your input for generation of Dockerfile, typically provided in JSON format, to ensure correct structure.


-  **Best Practice Validation**: Genval doesn't stop at generation; it checks your Dockerfile against predefined best practices for security and optimization.


-  **Informative Feedback**: If Genval detects issues during best practice validation, it provides informative feedback to help you improve your Dockerfile.



> Note: For Dockerfile validation and generation, `genval` expects a predefined structure for the `JSON` file provided to the `--reqinput` flag. Sample `.json` files can be found in the `./templates/dockerFile-samples` directory.



### Managing Kubernetes Manifests



- Genval validates input for required structure based on the tool in use. It can enforce best practices while authoring configuration files for tools like Kubernetes and various CRDs.

- Users can provide minimal and custom configurations for a given resource, with Genval populating all necessary fields based on security best practices recommended by the community.



- Genval generates YAML manifests according to the required format for the specified resource and tool.

### Validation of configuration file

Genval provides capabilities to validate configuration for different resources and technologies, including Dockerfile, Kubernetes manifests, and Terraform files using Rego and CEL policy languages.


## Getting Started

To use Genval:



- Download the `genval` binary for your platform from the official [release page](https://github.com/intelops/genval/releases).



## Verifying Binary Signatures



Genval's release process signs binaries using Cosign's keyless signing mode. To verify a specific binary, retrieve the release artifact, signature, and public certificate for your desired os/arch. Detailed instructions are available in the [Sigstore blog](https://blog.sigstore.dev/cosign-2-0-released/).

**Example to verify a binary for linux_amd64**

```shell


COMMIT=$(git rev-list --tags --max-count=1)
version=$(git describe --tags ${COMMIT})
version="${version#v}"

# get the artifact
$ wget  https://github.com/santoshkal/genval-fork/releases/download/v${version}/genval_$version}_linux_amd64.tar.gz
# get the signature
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

> For more details on signing/verifying container images and artifacts refer this [Sigstore blog](https://blog.sigstore.dev/cosign-2-0-released/)


## Installation



- Download the genval binary from the official [release page](https://github.com/intelops/genval/releases)

- Move the executable to `/usr/local/bin` for convenience.



## Quick Start


For a quick start, pre-built templates for Dockerfile generation for popular languages can be found in the `./templates/inputs/dockerfile_input` folder.


## Building from Source

The easieast way to build the `genval` executable is using the `build` Makefile target.
`make build`.
This will build the binary from source and place the `genval` binary in the `./bin` folder that can be copied to `/usr/local/bin`.



To build genval from source:

- Clone the Genval repository: `git clone https://github.com/intelops/genval.git`

- Navigate to the project directory: `cd genval`

- Build Genval: `CGO_ENABLED=0 go build -o ./genval ./cmd`



The generated binary, genval, will be available in the current working directory. You can move it to your PATH or use it from the current directory.

# Using Genval

Genval offers following modes which can be accessed through Genval's main commands :


- `dockerfile`: for generating and validaing of Dockefiles - uses [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) for validation of generated Dockerfiles
-  `regoval` for validation of Dockerfiles, Kubernetes manifests, and  Terraform files with Rego policies
-  `celval` for validation of Dockerfiles, Kubernetes manifests, and Terraform files with [Common Expression Language (CEL)](https://cel.dev/overview/cel-overview)) policies
-  `cue` for generation and validation of Kubernetes and related config files levereging [Cuelang aka CUE](https://cuelang.org/docs/)
-  `cuemod` for creating workspace for generation and validation of Kubernetes and related config files
- `artifact` for managing pusing and pulling the built artifacts from the OCI complient container registries

A helper mode `showjson` is available for user to view the **JSON** representation of the input files passed to Genval. In `--mode showjson` a user can pass the input file, for example a Dockerfile, Terraform file or a Kubernetes YAML manifests and get the JSON representation of that specific input. As most of the policies are written based on input in a JSON structured format. This would enable user to refer this JSON document to write their custom policies in **Rego** and **CEL**.


> All the modes accept inputs that include local files and files from a remote URL, such as those from a Git repositoryin raw format. If you want to query the files from the `https://github.com`. You need to authenticate to GitHub by providing your Personal Access Token. You can do this by creating and an enviornment variable named. Here's how to do it: `export GITHUB_TOKEN=<Your...PAT>`


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

> Users can directly provide the `.tf` file to genval along with a policy written in Rego for validatin the Terraform file
```shell
genval regoval --reqinput ./templates/inputs/terraform/sec_group.tf \
--policy ./templates/defaultpolicies/terraform.rego
```


### Validation of the Dockerfile, Kubernetes manifests and Terraform files using CEL policies

`celval` is the main command that manages validation of Dockerfiles, Kubernetes manifests, and Terraform files using Common Expression Language (CEL).

#### Validation of Dockerfiles with CEL policies

```shell
genval celval dockerfileval --reqinput=input.json \
--policy=<'path/to/CEL policy file>
```

#### Validation of Kubernetes manifests using Rego policies

```shell
./genval celval infrafile --reqinput=input.json \
--policy=<path/to/policy.rego file>
```


#### Validation of Terraform files using Rego policies

```shell
./genval celval terraform --reqinput ./templates/inputs/terraform/sec_group.tf \
--policy=--policy ./templates/defaultpolicies/cel/terraform_cel
```


### Validation and Generation of Kubernetes configurations

The validation and generation of Kubernetes and CRD manifests are facilitated through the use of [cuelang](https://cuelang.org/docs/). When using Genval for validating and generating Kubernetes and related manifests, make use of the Genval tool in `cue` mode. This mode necessitates JSON/YAML input provided via the `--reqinput` flag. Furthermore, you should specify a `resource` flag, indicating the the top level label defined in the Cue policies. Finally, we need to provide the Cue policies ( Cue definitions) for validation and generation. The `--policy` arg accepts a directory that contains a `cue.mod` directory, which contains the upstream APIs in `.cue` format for assisting in validating the provided config file with upstream APIs. The directory provided to the `--policy` argument also contains a policy (CUE definition) for validation and generation.

To help users with creation of workspaces enriched with the required directory structure to be provided to the `--policy` argument. Genaval also provides a command `cuemod init`. This commands accepts one argument, namely `--tool` this argument accepts the technology we require. Currently Genval supports following tools:

- `k8s`: To deal with validating and/or generating manifests for Kubernetes
- `argocd`: To deal with validating and/or generating manifests for ArgoCD
- `tekton`: To deal with validating and/or generating manifests for Tekton
- `crossplane`: To deal with validating and/or generating manifests for Crossplane


You have the flexibility to provide multiple `.cue` policies within the workspace directory, allowing you to supply distinct `.cue` definitions as needed. For instance, your DevSecOps/Platform engineering team can furnish a schema that enforces security best practices for a specific environment, encompassing all the pertinent mandatory fields. This approach leaves room for custom fields like `metadata`, `image`, `replicas`, specific to a **Deployment**, to be provided by the development teams. In the `cue` mode, development teams can then contribute their customized policies for validation and generation, tailoring the configurations to suit their particular environments.



Example:


```shell
$ genval cue --reqinput https://github.com/santoshkal/cuemod-demo/tree/main/k8s \
--resource Application \
--policy ./policy
```

The above command will validate a Deployment manifests using the provided `.cue` schema definitions provided as policies from the `policy` directory and generate the final YAML manifet in the **output** directory in the `cwd`.

> The `--resource` flag in `cue` mode top level flag labeld in the Cue definitions, like in above example "Application" labels defines a Kubernetes Deployment and a Service resource.


For a detailed workflow illustrating the capabilities of Cue and Genval for validating and generating Kubernetes configurations, you can refer to [this document](./cmd/cueval/example.md).
The workflow for adding a Cue schema for Kubernetes CRDs is failry easy, and demostrated in the [CONTRIBUTION.md document](./CONTRIBUTION.md/#contributing-by-adding-a-cue-schema-to-the-project).

### Creating workspace for working with cue mode

As outlined above, the cue command requires a directory to be provided to the `--policy` flag, this directory **must** contain a `cue.mod` directory containing upstream configuration for the required tool we are trying to evaluate against and one or more `.cue` Cue definitions.

Genval assists in creating such a workflow for some of the technologies, like Kubernetes, ArgoCD, TektonCD, Crossplane.

To create a workspace, we need to use the `cuemod init` command and provide a technolgy we need the worskspace configuration created to the `--tool` flag:

`cuemod init` command is sort of a helper command the creates all the required files for working in the cue mode. It mainly verifies and pulls all the required files from the OCI registry and places them on the disk to be used with `cue` command.

```shell
$ genval cuemod init --tool=k8s`
```

This command will create a new directory in users current working directory with name `cuemod-k8s:1.29` with following structure:

```shell
./k8s:1.29/
├── archive
└── extracted-content
```

In the above directory tree, the `archive` sub-directiry will contain the raw artifact in `tar.gz` format, and in the `extracted-content` sub-directory `cuemod-k8s:v1.29` directory will contain all the required files for working with `cue` command
following will be the structure of the `extracted-content` sub-directory:

```shell
./extracted-content
├── cue.mod
└── policy.cue
└── README.md
```




### Managing the generated and Validated configuration files

Genval provides the ability to manage the configuration files that are generated and/validated by building them as OCI artifacts and storing them in OCI complient container registry and also pulling the same config files from the registry when required.

To enhance the supply chain security workflow, Genval also enables users to sign the artifacts after storing them in the registry. Similary while pulling any artifact Genval also provides functionality to verify the signatures of the artifacts. This feature leverges [Sigstore's Cosign] keyless mode of signing and verifying the artifacts. However, users may also user their own private and public keys for sgning and verifying the artifacts respectively.

#### Building, pushing, and signing generated and/or verified config files and OCI artifacts

The following command builds and pushes the OCI artifact (genval:test) to GitHub container registry - ghcr.io and duly signs the artifact with Cosign in Keyless mode.

```shell
$ ./genval artifact push --reqinput ./templates/defaultpolicies/rego \
--url --dest ghcr.io/santoshkal/artifacts/genval:test \
--sign true
```

#### Pulling tghe stored artifact from the container registry and verifying the signatures
The following command demostrates pulling an artifact (genval:test) stored in the container registry - ghcr.io, verifying the artifacts
signatures, and finally storing the contents of the artifact in the `./output` directory.

```shell
./genval artifact pull --dest ghcr.io/santoshkal/artifacts/genval:test \
--path ./output \
--verify true
```

Users can also verify artifacts signed with cosign private key and the verify the artifact using the associated cosign public key:

```shell
$ genval artifact pull --dest oci://ghcr.io/santoshkal/artifacts/genval:no-sign \
--path ./output \
--verify true \
--key ./cosign/cosign.pub
```

### Templates

The `./templates` folder holds some sample files to be used in Genval. the `./templates/inputs` holds JSON input templates for both generating Dockerfiles in `container` mode and Kubernetes manifests in `cue` mode. Similarly, all the sample policies for all the modes are stored in `./templates/defaultpolices` directory. User can use these template files to start with and as they go along they can build upon it and customize these policies to suite their specific use cases.