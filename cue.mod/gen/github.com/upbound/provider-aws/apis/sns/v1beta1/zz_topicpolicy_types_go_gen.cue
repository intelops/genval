// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sns/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#TopicPolicyInitParameters: {
	// The fully-formed AWS policy as JSON.
	policy?: null | string @go(Policy,*string)
}

#TopicPolicyObservation: {
	// The ARN of the SNS topic
	arn?: null | string @go(Arn,*string)
	id?:  null | string @go(ID,*string)

	// The AWS Account ID of the SNS topic owner
	owner?: null | string @go(Owner,*string)

	// The fully-formed AWS policy as JSON.
	policy?: null | string @go(Policy,*string)
}

#TopicPolicyParameters: {
	// The ARN of the SNS topic
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/sns/v1beta1.Topic
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	arn?: null | string @go(Arn,*string)

	// Reference to a Topic in sns to populate arn.
	// +kubebuilder:validation:Optional
	arnRef?: null | v1.#Reference @go(ArnRef,*v1.Reference)

	// Selector for a Topic in sns to populate arn.
	// +kubebuilder:validation:Optional
	arnSelector?: null | v1.#Selector @go(ArnSelector,*v1.Selector)

	// The fully-formed AWS policy as JSON.
	// +kubebuilder:validation:Optional
	policy?: null | string @go(Policy,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// TopicPolicySpec defines the desired state of TopicPolicy
#TopicPolicySpec: {
	v1.#ResourceSpec
	forProvider: #TopicPolicyParameters @go(ForProvider)

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
	initProvider?: #TopicPolicyInitParameters @go(InitProvider)
}

// TopicPolicyStatus defines the observed state of TopicPolicy.
#TopicPolicyStatus: {
	v1.#ResourceStatus
	atProvider?: #TopicPolicyObservation @go(AtProvider)
}

// TopicPolicy is the Schema for the TopicPolicys API. Provides an SNS topic policy resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#TopicPolicy: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.policy) || (has(self.initProvider) && has(self.initProvider.policy))",message="spec.forProvider.policy is a required parameter"
	spec:    #TopicPolicySpec   @go(Spec)
	status?: #TopicPolicyStatus @go(Status)
}

// TopicPolicyList contains a list of TopicPolicys
#TopicPolicyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#TopicPolicy] @go(Items,[]TopicPolicy)
}