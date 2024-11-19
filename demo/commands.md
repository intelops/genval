# Demo commands

#### Genval executable from pre-main branch

## Getting started

To use Genval, we can download the `genval` binary for your platform from the official [release
page](https://github.com/intelops/genval/releases). The easies way to get genval executable is by building it from
source.

- Clone the Genval repository: `git clone https://github.com/intelops/genval.git`
- Navigate to the project directory: `cd genval`
- Use the Makefile target to generate the genval executable: `make build`. This command will place the `genval` executable in the `./bin` directory. You can then use the genval application with `./bin/genval <command> <options>`

## Dockerfile generation and validation

All the policies and input can also be provided from Remote URLs like Github as well.
A auth needs to be set up for genval to communicate with remote for pulling the input and policies.
This is how you can do that:

`export GITHUB_TOEKN=<Your GITHUB TOKEN>`

```shell
./bin/genval dockerfile --reqinput ./templates/inputs/dockerfile_input/clang_input.json \
--output ./output/Dockerfile-save \
--inputpolicy ./templates/defaultpolicies/rego-policies/input_policies/ \
--outputpolicy ./templates/defaultpolicies/rego-policies/dockerfile_policies
```

The above set of commands will take the input (a specific structure of JSON required by Genval) in JSON format provided
to the `--reqinput` arg, It validates the provided input with a set of Rego validation policies give in `--inputpolicy`
arg. Then generates a proper Dockerfile then genval will again validate the generated Dockerfile with another set of
Rego validation policies and writes the Dockerfile to the required destination provuded in `--output` argument.

## Validating available Dockerfile

The following command takes a Dockerfile as input and then valuidates it with Rego validation policies

```shell
./bin/genval regoval dockerfileval --reqinput ./templates/inputs/Dockerfile \
--policy ./templates/defaultpolicies/rego-policies/dockerfile-policies
```

## Validating Kubernetes manifests

The set of commands below will perform validation on a infrastructure files like, Kubernetes or any CRDs with a set of
Rego validation policies.

```shell
 ./bin/genval regoval infrafile --reqinput ./templates/inputs/k8s/deployment.json \
 --policy ./templates/defaultpolicies/rego-policies/infrafile-policies
```

## Validating Terraform files with Rego Policies

Genval can also validate different Terraform `.tf` files using a set of Rego policies.

```shell
./bin/genval regoval terraform --reqinput ./templates/inputs/terraform/sec_group.tf \
--policy ./templates/defaultpolicies/rego-policies/terraform-policies/terraform
```

## Validating with CEL policies

Other than validating resources using Rego, Genval also provdes flexibility to vlaidate infrastructure files like
Kubernetes and CRDs with a set of Common Expression Language (CEL) policies

```shell
./bin/genval celval infrafile --reqinput ./templates/inputs/k8s/deployment.json \
--policy ./templates/defaultpolicies/cel/k8s_cel.yaml
```

## Push policies, generated/validated config files to OCI registries

### A Note on Genval's Authentication mechanism with Container registries

To facilitate authentication with container registries, Genval follows this process:

- Environment Variables for Username and Password:

  - Genval checks for the environment variables `ARTIFACT_REGISTRY_USERNAME` and `ARTIFACT_REGISTRY_PASSWORD` for authentication.

- Environment Variable for **Token**:

  - If the **Username** and **Password** environment variables are not found, Genval will then look for the environment variable `ARTIFACT_REGISTRY_TOKEN`.

- Docker Configuration File:

  - If none of the above environment variables are set, Genval will check for the default Docker configuration file located at `$HOME/.docker/config.json` for authentication credentials.

    Sometimes with `.docker/config.json` users may encounter some errors while interacting with registries. Please login and logout from the registry account to resolve the issue:

  - **Login to Container Registry**:

    `echo <GITHUB PAT> | echo docker login ghcr.io -u <username> --password-stdin>`

    Once login, try to perform push/pull operations, and if it succeeds. Great!!!

    If not, Try the following:

  - **Logout from Container Registry**:

    `docker logout ghcr.io`

    This step should authenticate and allow you to perform push/pull actions on the registry, provided your credentials were passed in correctly.

    Please ensure that at least one of these authentication mechanisms is set up when interacting with container registries.

```shell
./bin/genval artifact push --reqinput ./templates/defaultpolicies/rego-policies/dockerfile_policies/ \
--dest oci://ghcr.io/santoshkal/policyhub/dockerfile-policies:v0.0.1 \
--sign true \
--annotations "authors=ksantoshkal@intelops.dev
```

### Output:

```shell
➜  ./bin/genval-demo git:(main) ✗ ./genval artifact push --reqinput ./defaultpolicies/rego-policies/dockerfile_policies/ \
--dest oci://ghcr.io/santoshkal/policyhub/dockerfile-policies:v0.0.1 \
--sign true \
--annotations "author=santoshkal@intelops.dev"
INFO[0000] Building artifact from: ./defaultpolicies/rego/dockerfile_policies/
INFO[0000] ✔ Artifact created successfully
INFO[0003] cosign: Enter the verification code XNFD-RDQF in your browser at: https://oauth2.sigstore.dev/auth/device?user_code=XNFD-RDQF
INFO[0003] cosign: Code will be valid for 300 seconds
INFO[0019] cosign: Token received!
INFO[0027] cosign: Generating ephemeral keys...
INFO[0027] cosign: Retrieving signed certificate...
INFO[0027] cosign: Non-interactive mode detected, using device flow.
INFO[0027] cosign: Successfully verified SCT...
INFO[0027] cosign:
INFO[0027] cosign:      The sigstore service, hosted by sigstore a Series of LF Projects, LLC, is provided pursuant to the Hosted Project Tools Terms of Use, available at https://lfprojects.org/policies/hosted-project-tools-terms-of-use/.
INFO[0027] cosign:      Note that if your submission includes personal data associated with this signed artifact, it will be part of an immutable record.
INFO[0027] cosign:      This may include the email address associated with the account with which you authenticate your contractual Agreement.
INFO[0027] cosign:      This information will be used for signing this artifact and will be stored in public transparency logs and cannot be removed later, and is subject to the Immutable Record notice at https://lfprojects.org/policies/hosted-project-tools-immutable-records/.
INFO[0027] cosign:
INFO[0027] cosign: By typing 'y', you attest that (1) you are not submitting the personal data of any other person; and (2) you understand and agree to the statement and the Agreement terms at the URLs listed above.
INFO[0027] cosign: tlog entry created with index: 102571795
INFO[0027] cosign: Pushing signature to: ghcr.io/santoshkal/policyhub/dockerfile-policies
INFO[0027] ✔ Artifact pushed successfully to: ghcr.io/santoshkal/policyhub/dockerfile-policies:v0.0.1
, with Digest: sha256:d367ecba061823b2cb59ee853b76be797ce724c3157acc8046d03d5f3ae496b4
INFO[0027] Digest URL: ghcr.io/santoshkal/policyhub/dockerfile-policies@sha256:d367ecba061823b2cb59ee853b76be797ce724c3157acc8046d03d5f3ae496b4
```

## Verify and pull an artifact from OCI registry

```shell
./bin/genval artifact pull --dest oci://ghcr.io/santoshkal/policyhub/dockerfile-policies:v0.0.1 \
--path ./output \
--verify true
```

### Output

> The contents of the artifact will be extracted in the directory provided in the `path` flag, `./output` in above command.

```shell
➜  genval-demo git:(main) ✗ ./bin/genval artifact pull --dest oci://ghcr.io/santoshkal/policyhub/dockerfile-policies:v0.0.1 \
> --path ./output \
> --verify true
⣯ Verifying artifact
Verification for ghcr.io/santoshkal/policyhub/dockerfile-policies:v0.0.1 --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates
Certificate subject: ksantosh@intelops.dev
Certificate issuer URL: https://github.com/login/oauth
Artifact from ghcr.io/santoshkal/policyhub/dockerfile-policies:v0.0.1 pulled and stored in :./output
```

# CUELANG

Create a workspace using `cuemod` command for working with cue:

- create a `cue.mod` and necessary structure for working with `cue` command

```shell
./bin/genval cuemod init --tool=k8s:latest
```

Now place all the `.cue` policies files under `./K8S_1.29/extracted_content/policy` directory and provide the path to `--policy` flag while using `cue` command as following:

Generate application Kubernetes configuration from bare minimum config files :


```shell
./bin/genval cue --reqinput ./templates/inputs/cue/combined \
--resource Application \
--policy ./templates/defaultpolicies/cue/policy/
```

## Output

```shell
Application validation succeeded, generated manifests in 'output' directory:
 - output/deploy.yaml
 - output/service.yaml
```
