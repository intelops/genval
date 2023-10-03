package kubernetes


import (
	apps "k8s.io/api/apps/v1"
	
)

#Deployment: apps.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"

	metadata: labels: {
		// Reserved labels.
		version: "main"
	}

	spec: apps.#DeploymentSpec & {
		revisionHistoryLimit: int | *5

		strategy: {
			type: string | *"RollingUpdate"
			if type == "RollingUpdate" {
				rollingUpdate: {
					maxSurge:       int | string | *"50%"
					maxUnavailable: int | string | *"0%"
				}
			}
		}

	}
}

// Similarly, add Core_v1 for #PodSpec for pod level data in Deployment/STS/DaemonSet/etc. 