[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/7843/badge)](https://www.bestpractices.dev/projects/7843)
[![Go Report Card](https://goreportcard.com/badge/github.com/genvaldev/genval)](https://goreportcard.com/report/github.com/genvaldev/genval)
[![Build Status](https://github.com/genvaldev/genval/actions/workflows/ci.yaml/badge.svg)](https://github.com/genvaldev/genval/actions?query=workflow%3Abuild)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Genval: Simplifying Configuration Management

## Table of Contents
- [Genval: Simplifying Configuration Management](#genval-simplifying-configuration-management)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
    - [Streamlining Validation and Generation of Configurations](#streamlining-validation-and-generation-of-configurations)
    - [Why Genval?](#why-genval)
  - [Key Features](#key-features)
    - [Dockerfile Management](#dockerfile-management)
    - [Managing Kubernetes Manifests](#managing-kubernetes-manifests)
    - [Validation of Configuration Files](#validation-of-configuration-files)
  - [Getting Started](#getting-started)
  - [Verifying Binary Signatures](#verifying-binary-signatures)
  - [Installation](#installation)
    - [Building from Source](#building-from-source)
  - [Quick Start](#quick-start)
  - [Genval Commands Overview](#genval-commands-overview)
    - [Dockerfile Validation and Generation](#dockerfile-validation-and-generation)
    - [Validation Using Rego Policies](#validation-using-rego-policies)
      - [Validation of Dockerfiles with Rego Policies](#validation-of-dockerfiles-with-rego-policies)
      - [Validation of Kubernetes Manifests with Rego Policies](#validation-of-kubernetes-manifests-with-rego-policies)
      - [Validation of Terraform Files with Rego Policies](#validation-of-terraform-files-with-rego-policies)
    - [Validation Using CEL Policies](#validation-using-cel-policies)
      - [Validation of Dockerfiles with CEL Policies](#validation-of-dockerfiles-with-cel-policies)
      - [Validation of Kubernetes Manifests with CEL Policies](#validation-of-kubernetes-manifests-with-cel-policies)
      - [Validation of Terraform Files with CEL Policies](#validation-of-terraform-files-with-cel-policies)
    - [Validation and Generation of Kubernetes Configurations (Cue Mode)](#validation-and-generation-of-kubernetes-configurations-cue-mode)
      - [Creating a Workspace for Cue Mode](#creating-a-workspace-for-cue-mode)
    - [Managing Generated and Validated Configuration Files](#managing-generated-and-validated-configuration-files)
      - [Building, Pushing, and Signing Artifacts](#building-pushing-and-signing-artifacts)
      - [Pulling and Verifying Artifacts](#pulling-and-verifying-artifacts)
      - [A Note on Genval's Authentication Mechanism with Container Registries](#a-note-on-genvals-authentication-mechanism-with-container-registries)
  - [Genval Genai](#genval-genai)
    - [Genval Genai Configuration](#genval-genai-configuration)
      - [Generate a Dockerfile for a Simple Nginx Web Server](#generate-a-dockerfile-for-a-simple-nginx-web-server)
  - [Note: Regex Implementation is in the Testing Phase in the pre-main Branch](#note-regex-implementation-is-in-the-testing-phase-in-the-pre-main-branch)
      - [Generate Regex Policies for GenAI](#generate-regex-policies-for-genai)
      - [Generation of Rego Policies using Genai](#generation-of-rego-policies-using-genai)
      - [Generation of Cuelang Definitions using Genai](#generation-of-cuelang-definitions-using-genai)
      - [Generation of CEL Policies using Genai](#generation-of-cel-policies-using-genai)
    - [Templates](#templates)

---

## Introduction

### Streamlining Validation and Generation of Configurations

Genval is a versatile Go utility that simplifies configuration management for various tools, including Dockerfiles, Kubernetes manifests, and other infrastructure files. It streamlines both the validation and generation of configuration artifacts.

### Why Genval?

Managing configurations across different tools can be a daunting task. Ensuring that these configurations adhere to best practices is critical, yet the process can be time-consuming and error-prone. Genval automates these processes to make configuration management more efficient.

---

## Key Features

### Dockerfile Management

- **Dockerfile Generation**: After successful validation, Genval generates a Dockerfile based on your input, tailored to your specifications.
- **Input Validation**: Genval validates your input for Dockerfile generation—typically provided in JSON format—to ensure the correct structure.
- **Best Practice Validation**: It not only generates the Dockerfile but also checks it against predefined best practices for security and optimization.
- **Informative Feedback**: If issues are detected during validation, Genval provides detailed feedback to help you improve your Dockerfile.

> **Note:** For Dockerfile validation and generation, `genval` expects a predefined structure for the JSON file provided to the `--reqinput` flag. Sample `.json` files can be found in the `./templates/dockerFile-samples` directory.

### Managing Kubernetes Manifests

Genval validates the input based on the required structure for the tool in use, enforcing best practices while authoring configuration files for Kubernetes and various CRDs. Users can provide minimal, custom configurations, and Genval will populate all necessary fields based on community-recommended security best practices. It then generates YAML manifests in the required format.

### Validation of Configuration Files

Genval provides capabilities to validate configurations for different resources and technologies—including Dockerfiles, Kubernetes manifests, and Terraform files—using both Rego and CEL policy languages.

---

## Getting Started

To use Genval:

- Download the `genval` binary for your platform from the official [release page](https://github.com/genvaldev/genval/releases).

---

## Verifying Binary Signatures

Genval's release process signs binaries using Cosign's keyless signing mode. To verify a specific binary, retrieve the release artifact, signature, and public certificate for your desired OS/architecture from the official [releases page](https://github.com/genvaldev/genval/releases). Detailed instructions are available in the [Sigstore blog](https://blog.sigstore.dev/cosign-2-0-released/).

**Example to verify a binary for linux_amd64**

```shell
# get the artifact
$ wget  https://github.com/genvaldev/genval/releases/download/untagged-46f163601b07b52b11d0/genval_0.1.6_linux_amd64.tar.gz
# get the signature
$ wget  https://github.com/genvaldev/genval/releases/download/untagged-46f163601b07b52b11d0/genval_0.1.6_linux_amd64.tar.gz.sig
# Get the certificate
$ wget https://github.com/genvaldev/genval/releases/download/untagged-46f163601b07b52b11d0/genval_0.1.6_linux_amd64.tar.gz.crt


cosign  verify-blob  \
--certificate-identity  "https://github.com/genvaldev/genval/.github/workflows/release.yaml@refs/tags/${version}"  \
--certificate-oidc-issuer  "https://token.actions.githubusercontent.com"  \
--cert  ./genval_0.1.6_linux_amd64.tar.gz.crt  \
--signature  genval_0.1.6_linux_amd64.tar.gz.sig \
./genval_0.1.6_linux_amd64.tar.gz
```

If verification is successful, you'll see "**Verified OK.**"

> For more details on signing/verifying container images and artifacts, refer to the [Sigstore blog](https://blog.sigstore.dev/cosign-2-0-released/).

---

## Installation

There are different ways to install Genval on your system:

- **Installer Script (Linux/macOS):**

  Run the installer script with the following command:

  ```sh
  curl -sL https://raw.githubusercontent.com/genvaldev/genval/refs/heads/pre-main/hack/install.sh | sudo bash -
  ```

  This script detects your OS/architecture and installs the appropriate executable.

- **Manual Download:**

Genvals release process produces [artifacts](https://github.com/genvaldev/genval/releases) for the executable for multiple OS/Architecture as a `tar.gz` bundle and signs it with Cosign keyless mode. Users can download the artifact camplatible for their OS/Arch, untar it and place it in the executable `PATH`, for example, Linux/MacOS you would move it to `/usr/local/bin` for convenience.

```sh
curl -Lo https://github.com/genvaldev/genval/releases/download/v0.1.6/genval_0.1.6_linux_amd64.tar.gz ganval.tar.gz
tar -xzf ./genval.tar.gz
sudo mv genval /usr/local/bin
```

### Building from Source

For development enviornments users can build the `genval` executable is bycloning the Genval project, navidate to the `./genval` directiry and using the `build` Makefile target:

```sh
$ git clone https://github.com/genvaldev/genval.git
$ cd genval
$ make build
```

This command builds the binary from source and places it in the `./bin` folder, and you can test your local updates using the executable in `./bin/genval`.

---

## Quick Start

For a quick start, pre-built templates for Dockerfile generation for popular languages can be found in the `./templates/inputs/dockerfile_input` folder. Default policies and input templates are maintained in a dedicated [repository](https://github.com/genvaldev/policyhub).

---

## Genval Commands Overview

Genval offers a range of powerful modes for generating and validating configuration files across various technologies. Each mode serves a specific purpose and can be accessed through its main commands:

> Users can configure a command in genval either by providing the CLI flags or by providing a YAML file with all the
> arguments to commands described. Some of the example YAML configs can be found in `./templates/defaultpolicies` directory.


> Note: All the genval commands provide an experimantal feature to remediate the input resource using the genai
> capabilities. To use this feature, add the `--takeaction` flag and set the LLM model to `--model` flag to any of the OpenAI models or
> local models through ollama endpoints.


- **`dockerfile`**: Generate and validate Dockerfiles, utilizing [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) for policy-based validation.
- **`regoval`**: Validate Dockerfiles, Kubernetes manifests, and Terraform files using Rego policies.
- **`celval`**: Validate Dockerfiles, Kubernetes manifests, and Terraform files using [Common Expression Language (CEL)](https://cel.dev/overview/cel-overview) policies.
- **`cue`**: Generate and validate Kubernetes and related configuration files leveraging [Cuelang (CUE)](https://cuelang.org/docs/).
- **`cuemod`**: Create a workspace for generating and validating Kubernetes and related configuration files.
- **`artifact`**: Manage pushing and pulling built artifacts from OCI-compliant container registries.
- **`showjson`**: View the JSON representation of input files passed to Genval.

> **Note:** All commands accept inputs from both local files and remote URLs (e.g., raw files from a Git repository). When querying GitHub, authentication via a Personal Access Token (PAT) is required. Set the environment variable as follows:
>
> ```sh
> export GITHUB_TOKEN=<Your GitHub PAT>
> ```

---

### Dockerfile Validation and Generation

To validate and generate Dockerfiles using Genval, use the `dockerfile` command. Provide the path to your input JSON or YAML file using the `--reqinput` flag. Specify the desired output path for the generated Dockerfile along with the `--inputpolicy` and `--outputpolicy` Rego policy files for validating the input and the generated Dockerfile, respectively. Genval handles the validation process seamlessly.

Example:

```sh
$ genval dockerfile --reqinput=./templates/inputs/dockerfile_input/golang_input.json \
--output Dockerfile \
--inputpolicy ./templates/defaultpolicies/rego-policies/input-policies \
--outputpolicy ./templates/defaultpolicies/rego-policies/dockerfile-policies/
```

> Customize the flag values according to your specific input file and Rego policies.
>
> You can supply all arguments to the `--reqinput`, `--inputpolicy`, and `--outputpolicy` flags from remote URLs (e.g., hosted on GitHub).
>
For GitHub authentication, set:

> ```sh
> export GITHUB_TOKEN=<Your GitHub PAT>
> ```


**Note:** All Rego policies are organized in directories containing both the `.rego` files and a corresponding `.json` metadata file. You can pass either a single directory or a top-level directory containing multiple subdirectories with Rego and JSON files for validating multiple policies. Genval supports using policies from your OCI registries or its default Rego policies. If credentials are needed for OCI registry access, provide them using the `--credentials` flag (format: `<$USER:$PAT>` or `<REGISTRY_PAT>`). If omitted, Genval will look for the `./docker/config.json` file in your `$HOME` directory.

---

### Validation Using Rego Policies

Users can validate Dockerfiles, Kubernetes manifests, and Terraform files using policies stored in OCI-compliant registries or provided locally. To authenticate with OCI registries, supply credentials via the `--credentials` flag (format: `<$USER:$PAT>` or `<$REGISTRY_PAT>`). If not provided, Genval checks for the `./docker/config.json` file in your `$HOME` directory.

**Example:**

```sh
$ genval regoval dockerfileval --reqinput=Dockerfile \
--policy oci://ghcr.io/genvaldev/policyhub/genval/dockerfile_policies:v0.0.1 \
--credentials <GITHUB_PAT> or <USER:PAT>
```

Users can also use default policies maintained by the community stored in the [policyhub repository](https://github.com/genvaldev/policyhub).

#### Validation of Dockerfiles with Rego Policies

```sh
$ genval regoval dockerfileval --reqinput ./templates/inputs/Dockerfile \
--policy ./templates/defaultpolicies/rego-policies/dockerfile-policies/
```

#### Validation of Kubernetes Manifests with Rego Policies

```sh
$ genval regoval infrafile --reqinput ./templates/inputs/k8s/deployment.json \
--policy ./templates/defaultpolicies/rego-policies/k8s/
```

#### Validation of Terraform Files with Rego Policies

> Users can provide a `.tf` file along with a Rego policy for validating the Terraform file.

```sh
$ genval regoval terraform --reqinput ./templates/inputs/terraform/sec_group.tf \
--policy ./templates/defaultpolicies/rego-policies/terraform/
```

---

### Validation Using CEL Policies

The `celval` command manages the validation of Dockerfiles, Kubernetes manifests, and Terraform files using Common Expression Language (CEL) policies. Below is an example structure for a CEL policy:

```yaml
policies:
- apiVersion: genvaldev.dev/v1alpha1
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

The `metadata` block includes details such as the policy name, description, severity, and benchmark. The `rule` field contains the CEL expression that, in this example, ensures that a Deployment’s container image does not use the `latest` tag.

#### Validation of Dockerfiles with CEL Policies

```sh
$ genval celval dockerfileval --reqinput=input.json \
--policy=<'path/to/CEL policy file>
```

#### Validation of Kubernetes Manifests with CEL Policies

```sh
$ genval celval infrafile --reqinput=./templates/inputs/k8s/deployment.json \
--policy=./templates/defaultpolicies/cel/k8s.yaml
```

#### Validation of Terraform Files with CEL Policies

```sh
$ genval celval terraform --reqinput ./templates/inputs/terraform/sec_group.tf \
--policy=--policy ./templates/defaultpolicies/cel/terraform.yaml
```

---

### Validation and Generation of Kubernetes Configurations (Cue Mode)

Genval leverages [Cuelang](https://cuelang.org/docs/) for validating and generating Kubernetes and CRD manifests using `cue` mode. This mode requires JSON/YAML input via the `--reqinput` flag. Additionally, you must specify a `--resource` flag that indicates the top-level field defined in your Cue policies, and provide the Cue policies (definitions) for validation and generation. The `--policy` argument accepts a directory containing a `cue.mod` directory (which holds upstream APIs in `.cue` format) along with the policy definitions.

Users can include multiple `.cue` policies within the workspace, allowing different teams to enforce custom policies suited to their environments. For a detailed workflow, refer to [this document](./cmd/cueval/example.md). The process for adding a Cue schema for Kubernetes CRDs is described in the [CONTRIBUTION.md document](./CONTRIBUTION.md/#contributing-by-adding-a-cue-schema-to-the-project).

#### Creating a Workspace for Cue Mode

To use the **cue** command effectively, you must provide a directory to the `--policy` flag. This directory **must** contain a `cue.mod` folder with upstream configurations for the tool being evaluated, along with one or more `.cue` definition files.

Genval streamlines the creation of this workspace for several technologies, including Kubernetes, ArgoCD, TektonCD, and Crossplane. To initialize a workspace, use the `cuemod init` command with the desired technology specified via the `--tool` flag:

```sh
$ genval cuemod init --tool=k8s:latest
```

> **Note:** If a workspace for a tool is not available in the supported list, Genval also supports pulling a custom workspace built and stored by users in OCI registries. The only requirement is that the directory structure must be exactly as follows:
>
> ```plaintext
> .
> ├── cue.mod
> └── policy.cue
> ```

The `genval cuemod init --tool k8s:latest` command creates a new directory (e.g., `k8s:latest`) in your current working directory with the following structure:

```plaintext
./k8s:1.29/
├── archive
└── extracted-content
```

In the above tree, the `archive` directory contains the raw `tar.gz` artifact, and the `extracted-content` directory includes the `cuemod-k8s:v1.xx` folder with all necessary files for using the `cue` command.

The expected structure of the `extracted-content/cuemod-k8s:v1.xx` folder is:

```plaintext
./extracted-content
├── cue.mod
└── input   # Contains the resources to be generated
└── policy  # Contains the Cue policies (definitions)
└── README```

Update the `policy` directory with the relevant Cue definitions and, if necessary, add additional Cue definition files. This workspace is then ready to be used with the `--policy` flag when running the `cue` command.

For example:

```sh
$ genval cue --reqinput https://github.com/santoshkal/cuemod-demo/tree/main/k8s \
--resource Application \
--policy ./k8s:1.29/extracted-contents/cuemod-k8s:v1.xx/policy/  # path to policy
--output ./output  # this flag is required for writing the final generated manifests
```

> The `--resource` flag in **cue** mode labels the top-level field in the Cue definitions. In the above example, "Application" defines a Kubernetes Deployment and Service resource.

---

### Managing Generated and Validated Configuration Files

Genval offers comprehensive management capabilities for configuration files that are generated and validated. It allows you to build these files as OCI artifacts, store them in OCI-compliant container registries, and pull them when needed.

To enhance supply chain security, Genval enables signing of artifacts after they are stored in the registry. Likewise, when pulling an artifact, Genval can verify its signature using **Sigstore's Cosign keyless mode**. Alternatively, you can use your own private and public keys for signing and verification.

#### Building, Pushing, and Signing Artifacts

The following command demonstrates how to build and push an OCI artifact (e.g., `genval:test`) to the GitHub Container Registry (`ghcr.io`), while signing the artifact with Cosign in keyless mode:

```sh
$ genval artifact push --reqinput ./templates/defaultpolicies/rego \
  --dest oci://ghcr.io/santoshkal/artifacts/genval:test \
  --sign true
```

Alternatively, you can provide a Cosign-generated private key for signing the artifact:

```sh
$ genval artifact push --reqinput ./templates/defaultpolicies/rego \
  --dest oci://ghcr.io/santoshkal/artifacts/genval:test \
  --sign true \
  --cosign-key <Path to Cosign private Key> \
  --credentials <GITHUB_PAT> or <USER:PAT>
```

#### Pulling and Verifying Artifacts

To pull an artifact (e.g., `genval:test`) from the container registry, verify its signature, and store its contents in the `./output` directory, use:

```sh
$ genval artifact pull --dest oci://ghcr.io/santoshkal/artifacts/genval:test \
--path ./output \
--verify true
```

You can also verify artifacts using a Cosign public key:

```sh
$ genval artifact pull --dest oci://ghcr.io/santoshkal/artifacts/genval:no-sign \
--path ./output \
--verify true \
--key ./cosign/cosign.pub
```

#### A Note on Genval's Authentication Mechanism with Container Registries

To facilitate authentication with container registries, Genval follows this process:

- **Environment Variables for Username and Password:**
  - Genval checks for `ARTIFACT_REGISTRY_USERNAME` and `ARTIFACT_REGISTRY_PASSWORD`.

- **Environment Variable for Token:**
  - If the username and password are not set, Genval looks for the `ARTIFACT_REGISTRY_TOKEN`.

- **Docker Configuration File:**
  - If neither is set, Genval checks for the default Docker configuration file at `$HOME/.docker/config.json`.

Sometimes users may encounter errors with the `.docker/config.json` file. In such cases, try the following:

- **Login to Container Registry:**

  ```sh
  echo <GITHUB PAT> | docker login ghcr.io -u <username> --password-stdin
  ```

  Once logged in, perform push/pull operations.

- **Logout from Container Registry:**

  ```sh
  docker logout ghcr.io
  ```

Ensure that at least one of these authentication mechanisms is properly set up when interacting with container registries.

---

## Genval Genai

The experimental `genai` command within Genval assists DevOps engineers in formulating security policies for their infrastructure files by leveraging various large language model (LLM) backends. Currently, support is available for OpenAI and Ollama, with plans to integrate additional models soon.

To use this functionality, provide a YAML configuration file that includes all necessary parameters for the selected LLM backend as well as user-specific parameters such as:

- **assistant**: Specifies the tool for which the policy is to be generated.
- **userPrompt**: Contains instructions for the LLM outlining user-specific requirements.
- **output**: Filepath where the generated security policy should be stored.

### Genval Genai Configuration

An example configuration file is as follows:

```yaml
apiVersion: genval/genai/v1beta1
metadata:
  name: test-config
requirementSpec:
  common:
    userPrompt: ./templates/inputs/genai/prompt.txt
    userSystemPrompt:
    # asisstant parameter can be provided in the `requirementSpec.common` as well as `llmSpec.openAIConfig`
    # assistant: dockerfile
  # llmSpec contains vendor specific blocks for each model
  llmSpec:
    openAIConfig:
      # LLM backend model to use for generating security policies
      - model: GPT4
        # assistant defined under `llmSpec` takes precedence if defined in common as well
        assistant: dockerfile
        # Boolean value to define whether to use the model defined above
        useTheModel: true
        # API key for authenticating with a backend (if required)
        apiKey: OPENAI_KEY
        temperature: 0.7
        topP: 0.3
        streaming: true
        maxTokens: 2048
      # Can define other models from OpenAI
      - model:
    # Can define other vendors below, e.g., Ollama:
    # ollamaSpec:
    #   - model: llama3
```

#### Generate a Dockerfile for a Simple Nginx Web Server

Examples for the configuration files for all the genai commands are located in `./templates/defaultpolicies/genai` directory, and all the prompts that are referenced inside the YAML configurations are loacated in `./templates/inputs/genai/user-prompts/` directory.

However, users are encouraged to bring in their own configurations and user prompts and play with genai for generating secure configuration files for cloud native technologies.

```sh
./bin/genval genai -c ./templates/defaultpolicies/genai/dockerfile-config.yaml
```

## Note: Regex Implementation is in the Testing Phase in the pre-main Branch

#### Generate Regex Policies for GenAI

```sh
./bin/genval genai -c ./templates/defaultpolicies/genai/regex-config.yaml
```

#### Generation of Rego Policies using Genai

```sh
./bin/genval genai -c ./templates/defaultpolicies/genai/rego-config.yaml
```

#### Generation of Cuelang Definitions using Genai

```sh
./bin/genval genai -c ./templates/defaultpolicies/genai/cue-config.yaml
```

#### Generation of CEL Policies using Genai

```sh
./bin/genval genai -c ./templates/defaultpolicies/genai/cel-config.yaml
```

---

### Templates

The `./templates` folder contains sample files to help you get started with Genval. The `./templates/inputs` directory holds JSON input templates for generating Dockerfiles (in container mode) and Kubernetes manifests (in cue mode). Similarly, all sample policies for the various modes are stored in the `./templates/defaultpolicies` directory. You can use these template files as a starting point and customize them to suit your specific use cases.
