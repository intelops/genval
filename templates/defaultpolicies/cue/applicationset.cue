package argocd

import v1alpha1 "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"

#ApplicationSet: v1alpha1.#ApplicationSet & {
	apiVersion: string | *"argoproj.io/v1alpha1"
	kind:       string | *"ApplicationSet"
	metadata: {
		name:      string | *"test"*
		namespace: string | *"test"
	}
	spec: {
		generators: [{
			clusters: selector: matchLabels: type: "production"
		}]
		template: {
			metadata: name: string | *"test"
			spec: {
				project: "my-project"
				source: {
					repoURL:        string | *"https://github.com/argoproj/argocd-example-apps/"
					targetRevision: "HEAD"
					path:           "guestbook"
				}

				destination: {
					server:    "{{server}}"
					namespace: string | *"test"
				}
			}
		}
	}
}

