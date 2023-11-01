package tekton

import "github.com/tektoncd/pipeline/pkg/apis/pipeline/v1beta1"

#Pipeline: v1beta1.#Pipeline & {
	apiVersion: string | *"tekton.dev/v1beta1"
	kind:       string | *"Pipeline"
	metadata:   _Metadata
	spec:       v1beta1.#PipelineSpec & {
		params: [...{
			name:        string 
			description: string
			...
		}]
		tasks: [...{
			name: string
			taskRef: name: string
			params: [...{
				name:  string
				value: string
				...
			}]
		}]
		results: [...{
			name:        string
			description: string
			value:       string
			...
		}]
	}}

_Metadata: {
	name:      *"genval" | string
	namespace: *"genval" | string
	labels: {
		app: string | *"genval"
		env: *"mytest" | string
	}
	...
}
