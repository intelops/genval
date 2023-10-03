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
