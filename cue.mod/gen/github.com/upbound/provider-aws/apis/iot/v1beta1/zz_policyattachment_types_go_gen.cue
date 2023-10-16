// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/iot/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#PolicyAttachmentInitParameters: {
}

#PolicyAttachmentObservation: {
	id?: null | string @go(ID,*string)

	// The name of the policy to attach.
	policy?: null | string @go(Policy,*string)

	// The identity to which the policy is attached.
	target?: null | string @go(Target,*string)
}

#PolicyAttachmentParameters: {
	// The name of the policy to attach.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iot/v1beta1.Policy
	// +kubebuilder:validation:Optional
	policy?: null | string @go(Policy,*string)

	// Reference to a Policy in iot to populate policy.
	// +kubebuilder:validation:Optional
	policyRef?: null | v1.#Reference @go(PolicyRef,*v1.Reference)

	// Selector for a Policy in iot to populate policy.
	// +kubebuilder:validation:Optional
	policySelector?: null | v1.#Selector @go(PolicySelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The identity to which the policy is attached.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iot/v1beta1.Certificate
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	target?: null | string @go(Target,*string)

	// Reference to a Certificate in iot to populate target.
	// +kubebuilder:validation:Optional
	targetRef?: null | v1.#Reference @go(TargetRef,*v1.Reference)

	// Selector for a Certificate in iot to populate target.
	// +kubebuilder:validation:Optional
	targetSelector?: null | v1.#Selector @go(TargetSelector,*v1.Selector)
}

// PolicyAttachmentSpec defines the desired state of PolicyAttachment
#PolicyAttachmentSpec: {
	v1.#ResourceSpec
	forProvider: #PolicyAttachmentParameters @go(ForProvider)

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
	initProvider?: #PolicyAttachmentInitParameters @go(InitProvider)
}

// PolicyAttachmentStatus defines the observed state of PolicyAttachment.
#PolicyAttachmentStatus: {
	v1.#ResourceStatus
	atProvider?: #PolicyAttachmentObservation @go(AtProvider)
}

// PolicyAttachment is the Schema for the PolicyAttachments API. Provides an IoT policy attachment.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#PolicyAttachment: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta      @go(ObjectMeta)
	spec:      #PolicyAttachmentSpec   @go(Spec)
	status?:   #PolicyAttachmentStatus @go(Status)
}

// PolicyAttachmentList contains a list of PolicyAttachments
#PolicyAttachmentList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#PolicyAttachment] @go(Items,[]PolicyAttachment)
}
