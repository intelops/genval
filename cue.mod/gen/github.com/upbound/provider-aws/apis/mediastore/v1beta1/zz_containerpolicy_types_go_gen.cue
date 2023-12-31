// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/mediastore/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ContainerPolicyInitParameters: {
	// The contents of the policy.
	policy?: null | string @go(Policy,*string)
}

#ContainerPolicyObservation: {
	// The name of the container.
	containerName?: null | string @go(ContainerName,*string)
	id?:            null | string @go(ID,*string)

	// The contents of the policy.
	policy?: null | string @go(Policy,*string)
}

#ContainerPolicyParameters: {
	// The name of the container.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/mediastore/v1beta1.Container
	// +kubebuilder:validation:Optional
	containerName?: null | string @go(ContainerName,*string)

	// Reference to a Container in mediastore to populate containerName.
	// +kubebuilder:validation:Optional
	containerNameRef?: null | v1.#Reference @go(ContainerNameRef,*v1.Reference)

	// Selector for a Container in mediastore to populate containerName.
	// +kubebuilder:validation:Optional
	containerNameSelector?: null | v1.#Selector @go(ContainerNameSelector,*v1.Selector)

	// The contents of the policy.
	// +kubebuilder:validation:Optional
	policy?: null | string @go(Policy,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// ContainerPolicySpec defines the desired state of ContainerPolicy
#ContainerPolicySpec: {
	v1.#ResourceSpec
	forProvider: #ContainerPolicyParameters @go(ForProvider)

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
	initProvider?: #ContainerPolicyInitParameters @go(InitProvider)
}

// ContainerPolicyStatus defines the observed state of ContainerPolicy.
#ContainerPolicyStatus: {
	v1.#ResourceStatus
	atProvider?: #ContainerPolicyObservation @go(AtProvider)
}

// ContainerPolicy is the Schema for the ContainerPolicys API. Provides a MediaStore Container Policy.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ContainerPolicy: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.policy) || (has(self.initProvider) && has(self.initProvider.policy))",message="spec.forProvider.policy is a required parameter"
	spec:    #ContainerPolicySpec   @go(Spec)
	status?: #ContainerPolicyStatus @go(Status)
}

// ContainerPolicyList contains a list of ContainerPolicys
#ContainerPolicyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ContainerPolicy] @go(Items,[]ContainerPolicy)
}
