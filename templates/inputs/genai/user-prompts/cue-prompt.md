# Input:

Write a Cuelang Definition to create a Kubernetes Deployment with following parameters:

- name: text-deployment
- image: nginx
- replicas: 3
- securityContext:

  - runAsNonRoot set to true
  - runAsUser set to 1000

- Container SecurityContexts:
  - allowPriviligeEscalation set to false

Make sure the image used does not use `latest` tag.

Also expose the Deployment to a service of type NodePort exposing on 31100.
