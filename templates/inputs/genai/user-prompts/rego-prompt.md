# Input:

Write a rego policy following `rego.v1` syntax for Genval. The policy should acheive the following:
- validate that the `image` used in a Kubernetes Deployment does not use `latest` tag
- Container specs should always specify `securityContext.Priviliged` as  `false`
- Container specs should not allow `priviligeEscalation` in the PodSepc.


# Output:
- Provide all the Rego policies in code-blocks
- Provide a brief description of each policy in a markdown format