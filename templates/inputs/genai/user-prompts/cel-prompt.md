# Input:

Generate Common Expression Language (CEL) policy in YAML format for validating following parameters:

- The policy should check if the containers in a Kubernetes Deployment
  do not use` latest` tag.
- The policy should valiodate replicas in a Deployment are always more the three
