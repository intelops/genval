package kubernetes
import (
	apps "k8s.io/api/apps/v1"
	autoscaling "k8s.io/api/autoscaling/v1"
	batch "k8s.io/api/batch/v1"
	core "k8s.io/api/core/v1"
	networking "k8s.io/api/networking/v1"
	policy "k8s.io/api/policy/v1"
	rbac "k8s.io/api/rbac/v1"
	storage "k8s.io/api/storage/v1"
)

// TODO: Add additional Kubernetes API types and CRDs here

#Namespace:             core.#Namespace
#NetworkPolicy:         networking.#NetworkPolicy
#ResourceQuota:         core.#ResourceQuota
#LimitRange:            core.#LimitRange
#PodDisruptionBudget:   policy.#PodDisruptionBudget
#ServiceAccount:        core.#ServiceAccount
#Secret:                core.#Secret
#ConfigMap:             core.#ConfigMap
#StorageClass:          storage.#StorageClass
#PersistentVolume:      core.#PersistentVolume
#PersistentVolumeClaim: core.#PersistentVolumeClaim
#ClusterRole:           rbac.#ClusterRole
#ClusterRoleBinding:    rbac.#ClusterRoleBinding
#Role:                  rbac.#Role
#RoleBinding:           rbac.#RoleBinding
#Service:               core.#Service
#DaemonSet:             apps.#DaemonSet
#Pod:                   core.#Pod
#ReplicationController: core.#ReplicationController
#ReplicaSet:            apps.#ReplicaSet

#HorizontalPodAutoscaler: autoscaling.#HorizontalPodAutoscaler
#StatefulSet:             apps.#StatefulSet
#Job:                     batch.#Job
#CronJob:                 batch.#CronJob
#Ingress:                 networking.#Ingress

#Deployment: apps.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"

	metadata: labels: {
		// Mandatory labels.
		version: "changeMe"
	}

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
