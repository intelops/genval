// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane/apis/apiextensions/v1

package v1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// LabelCompositionName is the name of the Composition used to create
// this CompositionRevision.
#LabelCompositionName: "crossplane.io/composition-name"

// LabelCompositionHash is a hash of the Composition label, annotation
// and spec used to create this CompositionRevision. Used to identify
// identical revisions.
#LabelCompositionHash: "crossplane.io/composition-hash"

// CompositionRevisionSpec specifies the desired state of the composition
// revision.
#CompositionRevisionSpec: {
	// CompositeTypeRef specifies the type of composite resource that this
	// composition is compatible with.
	// +immutable
	compositeTypeRef: #TypeReference @go(CompositeTypeRef)

	// PatchSets define a named set of patches that may be included by
	// any resource in this Composition.
	// PatchSets cannot themselves refer to other PatchSets.
	// +optional
	patchSets?: [...#PatchSet] @go(PatchSets,[]PatchSet)

	// Environment configures the environment in which resources are rendered.
	// +optional
	environment?: null | #EnvironmentConfiguration @go(Environment,*EnvironmentConfiguration)

	// Resources is the list of resource templates that will be used when a
	// composite resource referring to this composition is created.
	// +optional
	resources: [...#ComposedTemplate] @go(Resources,[]ComposedTemplate)

	// Functions is list of Composition Functions that will be used when a
	// composite resource referring to this composition is created. At least one
	// of resources and functions must be specified. If both are specified the
	// resources will be rendered first, then passed to the functions for
	// further processing.
	// +optional
	functions?: [...#Function] @go(Functions,[]Function)

	// WriteConnectionSecretsToNamespace specifies the namespace in which the
	// connection secrets of composite resource dynamically provisioned using
	// this composition will be created.
	// This field is planned to be removed in a future release in favor of
	// PublishConnectionDetailsWithStoreConfigRef. Currently, both could be
	// set independently and connection details would be published to both
	// without affecting each other as long as related fields at MR level
	// specified.
	// +optional
	writeConnectionSecretsToNamespace?: null | string @go(WriteConnectionSecretsToNamespace,*string)

	// PublishConnectionDetailsWithStoreConfig specifies the secret store config
	// with which the connection details of composite resources dynamically
	// provisioned using this composition will be published.
	// +optional
	// +kubebuilder:default={"name": "default"}
	publishConnectionDetailsWithStoreConfigRef?: null | #StoreConfigReference @go(PublishConnectionDetailsWithStoreConfigRef,*StoreConfigReference)

	// Revision number. Newer revisions have larger numbers.
	// +immutable
	revision: int64 @go(Revision)
}

// CompositionRevisionStatus shows the observed state of the composition
// revision.
#CompositionRevisionStatus: {
	xpv1.#ConditionedStatus
}

// A CompositionRevision represents a revision in time of a Composition.
// Revisions are created by Crossplane; they should be treated as immutable.
// +kubebuilder:printcolumn:name="REVISION",type="string",JSONPath=".spec.revision"
// +kubebuilder:printcolumn:name="XR-KIND",type="string",JSONPath=".spec.compositeTypeRef.kind"
// +kubebuilder:printcolumn:name="XR-APIVERSION",type="string",JSONPath=".spec.compositeTypeRef.apiVersion"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:resource:scope=Cluster,categories=crossplane,shortName=comprev
// +kubebuilder:subresource:status
#CompositionRevision: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta         @go(ObjectMeta)
	spec?:     #CompositionRevisionSpec   @go(Spec)
	status?:   #CompositionRevisionStatus @go(Status)
}

// CompositionRevisionList contains a list of CompositionRevisions.
#CompositionRevisionList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#CompositionRevision] @go(Items,[]CompositionRevision)
}
