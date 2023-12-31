// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/keyspaces/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#KeyspaceInitParameters: {
	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#KeyspaceObservation: {
	// The ARN of the keyspace.
	arn?: null | string @go(Arn,*string)

	// The name of the keyspace.
	id?: null | string @go(ID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#KeyspaceParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// KeyspaceSpec defines the desired state of Keyspace
#KeyspaceSpec: {
	v1.#ResourceSpec
	forProvider: #KeyspaceParameters @go(ForProvider)

	// THIS IS A BETA FIELD. It will be honored
	// unless the Management Policies feature flag is disabled.
	// InitProvider holds the same fields as ForProvider, with the exception
	// of Identifier and other resource reference fields. The fields that are
	// in InitProvider are merged into ForProvider when the resource is created.
	// The same fields are also added to the terraform ignore_changes hook, to
	// avoid updating them after creation. This is useful for fields that are
	// required on creation, but we do not desire to update them after creation,
	// for example because of an external controller is managing them, like an
	// autoscaler.
	initProvider?: #KeyspaceInitParameters @go(InitProvider)
}

// KeyspaceStatus defines the observed state of Keyspace.
#KeyspaceStatus: {
	v1.#ResourceStatus
	atProvider?: #KeyspaceObservation @go(AtProvider)
}

// Keyspace is the Schema for the Keyspaces API. Provides a Keyspaces Keyspace.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Keyspace: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #KeyspaceSpec      @go(Spec)
	status?:   #KeyspaceStatus    @go(Status)
}

// KeyspaceList contains a list of Keyspaces
#KeyspaceList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Keyspace] @go(Items,[]Keyspace)
}
