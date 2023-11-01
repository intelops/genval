package argo

import "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"

#Application: v1alpha1.#Application & {
	apiVersion: string | *"argoproj.io/v1alpha1"
	kind:       string | *"Application"
	metadata:   _Metadata
	spec: v1alpha.#AppicationSpec & {
		source: {
			repoURL:        string // requires a URL to your manifest repo
			targetRevision: string // requires to track the commit/branch/tag
			path:           string // requires the path to the manifest in the repo
			chart:          string // requires if your app uses Helm
			helm: {
				// All your Helm file values go here               
				...
			}
			// If your app uses Kustomize overlays, they go here
			kustomize: {
				...
			}
			directory: {
				...
			}
			plugin: {
				...
			}
		}

		syncPolicy: {
			automated: {
				...
			}
			syncOptions: [...string]
			retry: {
				...
			}
			...
		}
		...
		revisionHistoryLimit: int
	}
}

_Metadata: {
	name:      *"genval" | string
	namespace: *"genval" | string
	labels: {
		app: string | *"genval"
		env: *"mytest" | string
	}
	...
}
