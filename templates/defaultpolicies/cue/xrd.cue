package crossplane


import ext "github.com/crossplane/crossplane/apis/apiextensions/v1"

#XRD: ext.#CompositeResourceDefinition & {
    apiVersion:  string | *"apiextensions.crossplane.io/v1"
kind:       string | *"CompositeResourceDefinition"
metadata: name: string | *"sgsallowoutgoing.pet2cattle.com"
spec: {
	group: string | *"intelops.com"
	names: {
		kind:   "SGAllowOutgoing"
		plural: "sgsallowoutgoing"
	}
	versions: [{
		name:          "v1alpha1"
		served:        true
		referenceable: true
		schema: openAPIV3Schema: {
			type: "object"
			properties: spec: {
				type: string | "object"
				properties: parameters: {
					type: "object"
					properties: region: type: "string"
					required: ["region"]
				}
				required: [
					"parameters",
					...,
				]
				...
			}
		}
	}]
}
}