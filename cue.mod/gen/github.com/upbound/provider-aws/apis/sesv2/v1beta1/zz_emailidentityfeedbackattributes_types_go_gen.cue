// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sesv2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#EmailIdentityFeedbackAttributesInitParameters: {
	// Sets the feedback forwarding configuration for the identity.
	emailForwardingEnabled?: null | bool @go(EmailForwardingEnabled,*bool)
}

#EmailIdentityFeedbackAttributesObservation: {
	// Sets the feedback forwarding configuration for the identity.
	emailForwardingEnabled?: null | bool   @go(EmailForwardingEnabled,*bool)
	id?:                     null | string @go(ID,*string)
}

#EmailIdentityFeedbackAttributesParameters: {
	// Sets the feedback forwarding configuration for the identity.
	// +kubebuilder:validation:Optional
	emailForwardingEnabled?: null | bool @go(EmailForwardingEnabled,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// EmailIdentityFeedbackAttributesSpec defines the desired state of EmailIdentityFeedbackAttributes
#EmailIdentityFeedbackAttributesSpec: {
	v1.#ResourceSpec
	forProvider: #EmailIdentityFeedbackAttributesParameters @go(ForProvider)

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
	initProvider?: #EmailIdentityFeedbackAttributesInitParameters @go(InitProvider)
}

// EmailIdentityFeedbackAttributesStatus defines the observed state of EmailIdentityFeedbackAttributes.
#EmailIdentityFeedbackAttributesStatus: {
	v1.#ResourceStatus
	atProvider?: #EmailIdentityFeedbackAttributesObservation @go(AtProvider)
}

// EmailIdentityFeedbackAttributes is the Schema for the EmailIdentityFeedbackAttributess API.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#EmailIdentityFeedbackAttributes: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta                     @go(ObjectMeta)
	spec:      #EmailIdentityFeedbackAttributesSpec   @go(Spec)
	status?:   #EmailIdentityFeedbackAttributesStatus @go(Status)
}

// EmailIdentityFeedbackAttributesList contains a list of EmailIdentityFeedbackAttributess
#EmailIdentityFeedbackAttributesList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#EmailIdentityFeedbackAttributes] @go(Items,[]EmailIdentityFeedbackAttributes)
}
