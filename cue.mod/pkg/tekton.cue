package tekton

import v1 "github.com/tektoncd/pipeline/pkg/apis/pipeline/v1"

#Pipeline: v1.#Pipeline & {
	apiVersion: "tekton.dev/v1"
	kind:       "Pipeline"

	metadata: {
		name: string
		labels?: {
			app: string
		}
	}

	spec: {
		description?: string
		params?: [...{
			name: string
			description?: string
			default?: string
		}]
		tasks: [...{
			name: string
			taskRef: {
				name:      string
				kind?:     *"Task" | "ClusterTask"
				apiVersion?: "tekton.dev/v1beta1"
			}
			params?: [...{
				name:  string
				value: string
			}]
		}]
	}
}

#Task: v1.#Task & {
	apiVersion: "tekton.dev/v1"
	kind:       "Task"

	metadata: {
		name: string
		labels?: {
			app: string
		}
	}

	spec: {
		description?: string
		params?: [...{
			name: string
			description?: string
			default?: string
		}]
		steps: [...{
			name: string
			image: =~"^((?!:latest).)*$"
			// ... [other step fields]

			securityContext: {
				privileged:    *false // Containers should not be privileged
				runAsNonRoot:  *true  // Containers should run as non-root user
			}
		}]
	}
}
