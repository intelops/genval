package k8s

import (
	apps "k8s.io/api/apps/v1"
	core "k8s.io/api/core/v1"
)

#Application: #Deployment | #Service

#Deployment: apps.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"

	metadata: #Metadata

	spec: apps.#DeploymentSpec & {
		replicas:             int | *3
		revisionHistoryLimit: int | *5 // Defaults to 5

		template: {
			metadata: labels: {
				version: "changeMe"
			}
			spec: core.#PodSpec & {
				containers: [{
					image: =~"^.*[^:latest]$"
					// ... [other fields]

					securityContext: {
						privileged:               bool | *false | !true // Containers should not be privileged
						allowPrivilegeEscalation: bool | *false         // Containers should not allow privilege escalation
						runAsNonRoot:             bool | *true | !false // Containers should run as non-root user
						runAsUser:                int | *1001
						runAsGroup:               int | *1001
					}
					resources: core.#ResourceRequirements & {
						limits: {
							cpu:    string | *"100m"
							memory: string | *"256Mi"
						}
						requests: {
							cpu:    string | *"100m"
							memory: string | *"256Mi"
						}

					}
				}]
			}
		}
	}
}

#Service: core.#Service & {
	apiVersion: string | *"v1"
	kind:       string | *"Service"
	metadata:   #Metadata

	spec: {
		selector: _labels
		ports: [...#Port]
		type: string | *"ClusterIP"
	}
}

#Container: {
	name:  string | *"testsvc"
	image: string
	ports: [...#ContainerPort] | *[]
	...
}

#ContainerPort: {
	containerPort: int
	protocol:      string | *"TCP"
	...
}

#Port: {
	port:       int
	targetPort: int
	protocol:   string | *"TCP"
	...
}

#Metadata: {
	name:      *"genval" | string
	namespace: *"genval" | string
	labels:    _labels
	...
}

_labels: {
	app: string | *"genval"
	env: *"mytest" | string
	...
}
