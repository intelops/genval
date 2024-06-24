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
$ wget  https://github.com/intelops/genval/releases/download/v${version}/genval_$version}_linux_amd64.tar.gz
# get the signature
$ wget  https://github.com/intelops/genval/releases/download/v${version}/genval_${version}_linux_amd64.tar.gz.sig
# Get the certificate
$ wget  https://github.com/intelops/genval/releases/download/v${version}/genval_${version}_linux_amd64.tar.gz.crt



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


For a quick start, pre-built templates for Dockerfile generation for popular languages can be found in the `./templates/inputs/dockerfile_input` folder. We also maintain all the default policies and input templates in a dedicated [repository](https://github.com/intelops/policyhub).


## Building from Source

The easieast way to build the `genval` executable is using the `build` Makefile target.
`make build`.
This will build the binary from source and place the `genval` binary in the `./bin` folder that can be copied to `/usr/local/bin`.



To build genval from source:

- Clone the Genval repository: `git clone https://github.com/intelops/genval.git`

- Navigate to the project directory: `cd genval`

- Build Genval: `CGO_ENABLED=0 go build -o ./genval .`



The generated binary, genval, will be available in the current working directory. You can move it to your PATH or use it from the current directory.

# Welcome to Genval

Genval provides a range of powerful modes for generating and validating configuration files across various technologies. Each mode serves specific purposes and can be accessed through Genval's main commands:


- `dockerfile`: Generate and validate Dockerfiles, utilizing [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) for validation of Dockerfile
-  `regoval` Validate Dockerfiles, Kubernetes manifests, and Terraform files using Rego policies
-  `celval` Validate Dockerfiles, Kubernetes manifests, and Terraform files with [Common Expression Language (CEL)](https://cel.dev/overview/cel-overview) policies
-  `cue` Generate and validate Kubernetes and related config files leveraging [Cuelang aka CUE](https://cuelang.org/docs/)
-  `cuemod` Create a workspace for generating and validating Kubernetes and related config files.
- `artifact` Manage pushing and pulling built artifacts from OCI compliant container registries.

AAdditionally, a helpful command called `showjson` allows users to view the JSON representation of input files passed to Genval. By using this command, users can specify an input file, such as a **Dockerfile**, **Terraform file** and obtain its corresponding JSON representation. Since many policies are written based on JSON structured input, this feature facilitates users in developing custom policies in **Rego** and **CEL**.

> All commands accept inputs from both local files and remote URLs, such as those from a Git repository in raw format. If you wish to query files from https://github.com, authentication to GitHub via a Personal Access Token (PAT) is required. To set this up, create an environment variable named GITHUB_TOKEN and assign it your PAT. Here's how to do it: export GITHUB_TOKEN=<Your...PAT>.


### Dockerfile Validation and Generation:
To validate and generate Dockerfiles using Genval, use the `dockerfile` command. Provide the path to your input JSON or YAML file using the `--reqinput` flag. Specify the desired output path for the generated Dockerfile along with the `--inputpolicy` and `--outputpolicy` Rego policy files for validating the input JSON and the generated Dockerfile respectively. Genval will handle the validation process seamlessly.

Example:

```
$ genval dockerfile --reqinput=./templates/inputs/dockerfile_input/golang_input.json \
--output Dockerfile \
--inputpolicy ./templates/defaultpolicies/rego/input_policies \
--outputpolicy ./templates/defaultpolicies/rego/dockerfile_policies
 ```

> Customize the values provided in the flags according to your specific input file and Rego policies.
>
> You can supply all arguments to the --reqinput, inputpolicy, and outputpolicy flags from remote URLs, such as those hosted on GitHub (e.g., https://github.com).

> For authenticating with GitHub.com, set the env variable GITHUB_TOKEN:
`export GITHUB_TOKEN=<Your GitHub PAT>`

All the rego policies are housed in a hirearchy containing a `rego` policy and a `JSON` file containing all the metadata related to policy. A user needs to pass the directory containing boththe `.rego` and `.json` files. Genval also accpets a top leval directory containing multiple sub-directories containing multiple rego and accompanied JSON files for validating with more than one policy.

Users can use policies to validate input JSON as well as generated Dockerfile with policies stored in their OCI registries
or with Genval's default Rego policies. Behind the scenes, this action iteracts with OCI registries for pulling the policies.

To facilitate authentication with OCI compliant container registries,
Users can provide credentials through --credentials flag. The creds can be provided via <$USER:$PAT> or <REGISTRY_PAT> format.
If no credentials are provided, Genval searches for the "./docker/config.json" file in the user's $HOME directory.
If this file is found, Genval utilizes it for authentication.

**Validating with Default policies**

```shell
./genval dockerfile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/dockerfile_input/clang_input.json \
--output ./output/Dockefile-cobra
// No credntials provided, will default to $HOME/.docker/config.json for credentials
```

**Validating with policies stored in OCI compliant container registries**

```shell
./genval dockerfile --reqinput https://github.com/intelops/genval-security-policies/blob/patch-1/input-templates/dockerfile_input/clang_input.json \
--output ./output/Dockefile-cobra \
inputpolicy oci://ghcr.io/intelops/policyhub/genval/input_policies:v0.0.1 \
--outputpolicy oci://ghcr.io/intelops/policyhub/genval/dockerfile_policies:v0.0.1 \
--credentials <$GITHUB_PAT> or <$USER:$PAT> format
```
**Review Feedback**: Genval provides feedback based on best practice validation. Use this feedback to refine your Dockerfile.

### Validation of the Dockerfile, Kubernetes manifests and Terraform files using Rego policies

Users can leverage Genval's feature of Validating of resources using policies stored in OCI compliant registries or provide policies stored in their own OCI compliant registries.

To facilitate authentication with OCI compliant container registries, Users can provide credentials through `--credentials` flag while invoking a regoval subcommand. The credentials can
be provided via <$USER:$PAT> or <$REGISTRY_PAT> format. If no credentials are provided, Genval searches for the `./docker/config.json` file in the user's `$HOME` directory. If this file is found, Genval utilizes it for authentication.

**Example**:

./genval regoval dockerfileval --reqinput=Dockerfile \
--policy oci://ghcr.io/intelops/policyhub/genval/dockerfile_policies:v0.0.1
--credentials <GITHUB_PAT> or <USER:PAT>


Users can you use default policies maintained by the community stored in the https://github.com/intelops/policyhub repo

./genval regoval dockerfileval --reqinput <Path to Dockerfile>
// No credntials provided, will default to $HOME/.docker/config.json for credentials


#### Validation of Dockerfiles with Rego policies

```shell
genval regoval dockerfileval --reqinput ./templates/inputs/Dockerfile \
--policy ./templates/defaultpolicies/dockerfile_policies
```

#### Validation of Kubernetes manifests using Rego policies

```shell
genval regoval infrafile --reqinput ./templates/inputs/k8s/deployment.json \
--policy ./templates/defaultpolicies/k8s.rego
```

#### Validation of Terraform files using Rego policies

> Users can directly provide the `.tf` file to genval along with a policy written in Rego for validatin the Terraform file
```shell
genval regoval terraform --reqinput ./templates/inputs/terraform/sec_group.tf \
--policy ./templates/defaultpolicies/terraform.rego
```


### Validation of the Dockerfile, Kubernetes manifests and Terraform files using CEL policies

`celval` is the main command that manages validation of Dockerfiles, Kubernetes manifests, and Terraform files using Common Expression Language (CEL).
The structure for CEL policies is described below:

```yaml
policies:
- apiVersion: v1alpha1
  kind: CELPolicy
  metadata:
    name: Check image with latest tag
    description: Deny Images with latest tag
    severity: Critical
    benchmark: XYZ
  rule: |
    !input.spec.template.spec.containers[0].
    image.endsWith('latest')
```
The `metadata` block contains all the details about the policy, like its name, description, severity and its benchmark of the rule is based on. The `rules` field specifies the CEL expression to be evaluated. For above example, the `rule` will validate and ensure the image in a `Deployments` does not use the `latest ` tag.

#### Validation of Dockerfiles with CEL policies

```shell
genval celval dockerfileval --reqinput=input.json \
--policy=<'path/to/CEL policy file>
```

#### Validation of Kubernetes manifests using Rego policies

```shell
./genval celval infrafile --reqinput=./templates/inputs/k8s/deployment.json \
--policy=./templates/defaultpolicies/cel/k8s.yaml
```


#### Validation of Terraform files using Rego policies

```shell
./genval celval terraform --reqinput ./templates/inputs/terraform/sec_group.tf \
--policy=--policy ./templates/defaultpolicies/cel/terraform.yaml
```


### Validation and Generation of Kubernetes configurations

Genval leverages [cuelang](https://cuelang.org/docs/)for the validation and generation of Kubernetes and CRD manifests. When utilizing Genval for these tasks, employ the cue mode. This mode requires JSON/YAML input via the `--reqinput` flag. Additionally, specify a resource flag, indicating the top-level label defined in the Cue policies. Lastly, provide the Cue policies (Cue definitions) for validation and generation. The `--policy` argument accepts a directory containing a cue.mod directory, which holds the upstream APIs in .cue format for assisting in validating the provided config file. The same directory also contains a policy (Cue definition) for validation and generation.

To aid users in creating workspaces enriched with the required directory structure for the `--policy` argument, Genval offers the [`cuemod init` command](#creating-workspace-for-working-with-cue-mode). This command takes one argument, -`-tool`, which specifies the desired technology. Genval currently supports the following tools:

- `k8s`: For validating and/or generating manifests for Kubernetes.
- `argocd`: For validating and/or generating manifests for ArgoCD
- `tekton`: For validating and/or generating manifests for Tekton
- `crossplane`: TFor validating and/or generating manifests for Crossplane


Users can provide multiple `.cue` policies within the workspace directory, enabling the supply of distinct `.cue` definitions as needed. For example, a DevSecOps/Platform engineering team may provide a schema enforcing security best practices for a specific environment, while development teams can customize policies for validation and generation, tailoring configurations to their particular environments.

Example:

```shell
$ genval cue --reqinput https://github.com/santoshkal/cuemod-demo/tree/main/k8s \
--resource Application \
--policy ./policy
```

This command validates Deployment manifests using the provided `.cue` schema definitions from the `policy` directory and generates the final YAML manifest in the output directory in the current working directory.

>The `--resource` flag in **cue** mode labels the top-level flag in the Cue definitions. In the above example, "Application" defines a Kubernetes Deployment and a Service resource.


For a detailed workflow illustrating the capabilities of Cue and Genval for validating and generating Kubernetes configurations, you can refer to [this document](./cmd/cueval/example.md).
The workflow for adding a Cue schema for Kubernetes CRDs is failry easy, and demostrated in the [CONTRIBUTION.md document](./CONTRIBUTION.md/#contributing-by-adding-a-cue-schema-to-the-project).

### Creating workspace for working with cue mode

In order to utilize the **cue command** effectively, a directory must be provided to the `--policy` flag. This directory is essential and **must** contain a cue.mod directory with upstream configurations for the relevant tool being evaluated, along with one or more `.cue` definitions.

Genval streamlines the creation of such a workspace for several technologies, including Kubernetes, ArgoCD, TektonCD, and Crossplane.

To initiate a workspace, utilize the `cuemod init` command and specify the desired technology using the `--tool` flag

The `cuemod init` command acts as a helper command, facilitating the creation of all necessary files for working with the `cue` command. It validates and retrieves all required dir/files from the OCI registry, placing them on disk for use with the `cue` command.

Currently, the supported tools for initializing `cuemods` are `k8s`, `tektoncd`, `argocd`. `crossplane`, and `clusterAPI`.

```shell
$ genval cuemod init --tool=k8s
```

> Note: If a workspace for a tool that is not available in the above list of supported tools. Genval also supports pulling a custom workspace built and stored by users in OCI registries. The only requirement while building and pushing the workspace to OCI registry, is the the directory structure, which should exactly be in the following order:
```shell
.
├── cue.mod # This directory may contain all Kubernetes types in cue format, generated with "cue get go k8s.io/apis/..." cue command.
└── policy.cue # This is a .cue file containing the Cue definitions/policies
```
`genval cuemod init --tool k8s` command will create a new directory in users current working directory with name `cuemod-k8s:1.29` with following structure:

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

User needs to update the `policy.cue` file with relevant Cue definitions and if necessary add mode Cue definition files to this directory. This worksapcew would be now ready to be passed to the `--policy` argument when working with [`cue` command](#validation-and-generation-of-kubernetes-configurations).

For example:

```shell
$ genval cue --reqinput https://github.com/santoshkal/cuemod-demo/tree/main/k8s \
--resource Application \
--policy ./k8s:1.29/extracted-contents/cuemod-k8s:v1.29
```




### Managing the generated and Validated configuration files

Genval offers comprehensive management capabilities for the configuration files generated and validated. It allows users to build these files as OCI artifacts and store them in OCI-compliant container registries. Additionally, Genval supports pulling the same configuration files from the registry when needed.

To bolster supply chain security workflows, Genval enables users to sign the artifacts after storing them in the registry. Similarly, when pulling any artifact, Genval provides functionality to verify the signatures of the artifacts. This feature leverages **Sigstore's Cosign keyless mode** of signing and verifying artifacts. However, users can also utilize their own private and public keys for signing and verifying the artifacts respectively.

#### Building, pushing, and signing generated and/or verified config files and OCI artifacts

The following command demonstrates building and pushing the OCI artifact (genval:test) to GitHub Container Registry (ghcr.io) while signing the artifact with Cosign in Keyless mode:

```shell
$ ./genval artifact push --reqinput ./templates/defaultpolicies/rego \
--url --dest ghcr.io/santoshkal/artifacts/genval:test \
--sign true
```

#### Pulling tghe stored artifact from the container registry and verifying the signatures
The following command illustrates pulling an artifact (genval:test) stored in the container registry (ghcr.io), verifying the artifact's signatures, and finally storing the contents of the artifact in the ./output directory:

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
