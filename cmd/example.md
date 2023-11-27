# Validation and generation of Kubernetes Deployment using Genval

## Introduction

In this guide, we'll explore the usage of the Genval tool in Cue mode for validating and generating Kubernetes YAML manifests, specifically focusing on Kubernetes Deployments. Genval simplifies the process of ensuring your Kubernetes configurations adhere to security best practices and industry standards. While we use Kubernetes Deployments as an example, the same principles apply to other Kubernetes resources, ArgoCD, TektonCD, Crossplane, and ClusterAPI resources.

## What is Cue

Cue is a versatile configuration language and runtime environment designed to fulfill various tasks, including defining and validating data schemas, configuring files, and generating configuration artifacts. It presents a succinct and expressive syntax tailored for efficient configuration management while providing advanced features like type checking, constraints, and code generation.


One of Cue's standout features is its robust [type system](https://cuelang.org/docs/tutorials/tour/types/types/), which empowers developers to specify and enforce data types within their configuration files. This type checking capability greatly enhances the reliability and stability of configurations. Additionally, Cue allows developers to establish [constraints](https://cuelang.org/docs/tutorials/tour/intro/constraints/) or rules that configuration data must follow. Enforcing these constraints ensures that configurations align with specific business requirements or predefined rules, elevating the overall quality and correctness of configurations.

## Flow diagram fo Cue mode

<p align="center">
  <img src="../cueval.svg" />
</p>




## Genval in action

The core idea behind using Genval in Cue mode is as follows:

- **Cue Schema**: DevOps or platform engineers create a Cue schema that abstracts the complex requirements of a Kubernetes Deployment resource. This schema defines various aspects of the Deployment, such as:

  - `securityContext:`
  - Resource limits and requests
  - any constraints in container images, like no use of `latest` image tags
  - Probes like `livenessProbe` and/or `readinessProbe`
  - And more

An example Cue schema can be found in `./templates/defaultpolicies/cue/deployment.json`. The Cue format closely resembles JSON. Importing the Kubernetes APIs helps map fields/structs in the `deployment.cue` schema to upstream Kubernetes APIs. For instance:


```cue
package k8s

import (
    apps "k8s.io/api/apps/v1"
    core "k8s.io/api/core/v1"
)

#Deployment: apps.#Deployment & {
	apiVersion: "apps/v1"
  kind:       "Deployment"

  // Removed for brevity
  ...
}
```

In this example, we map the #Deployment definition to the apps.#Deployment object defined in our cue.mod, which is created by importing the Go APIs into Cue types.

- **Cue Definitions**: Definitions in Cue are marked with a `#` symbol, indicating they are used for validation and not included as data output. The `&` symbol unifies nested fields, mapping them to `#Deployment`.
- **Validation with Input JSON**: Developers provide a minimal input JSON for a Deployment, without worrying about the complex requirements. A sample input JSON for a Deployment is located at `./templates/inputs/cue/deploy.json`.
- **Validation and Generation**: With both the input in JSON format and the Cue schema in place, Genval leverages Cue's powerful validation and generation capabilities. Run the following command:

```shell
$ genval --mode cue --reqinput ./templates/inputs/cue/deploy.json \ # input to be validated
    --resource Deployment   # a Kind of resource we are trying to validate and generate, needs a valid Kind
    --policy ./templates/defaultpolicies/cue/deployment.cue # Our Cue schema/policy for Deployment
    --policy ./templates/defaultpolicies/cue/metadata.cue  # We can pass multiple policies/schemas referring them in   the main policy `deployment.cue`.  
```
  - `--reqinput`: Specifies the input to be validated. The `reqinput` accepts a single Cue Definition or a directory containing multiple Definitions.
  - `--resource`: Defines the Kubernetes resource kind to validate and generate. It must correspond to a valid Kind.
  - `--policy`: Points to the Cue schema/policy for Deployment. Multiple policies/schemas can be used by referencing them in the main policy `deployment.cue`.

- **Validation Result**: If the input passes validation, Genval responds with:

```shell
$ INFO[0000] validation for Deployment succeeded, generated manifest: deployment.yaml
```

The complete, validated deployment.yaml is generated and written to the current working directory.

- **Validation-Only Mode**: If you only want to validate input against a policy without generating a manifest, set the `--verify` flag to true (it's false by default).

By following these steps, you can efficiently validate and generate Kubernetes YAML manifests using Genval in Cue mode, ensuring your configurations meet security requirements and best practices.

