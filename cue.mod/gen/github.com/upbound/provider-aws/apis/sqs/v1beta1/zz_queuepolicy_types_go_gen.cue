// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sqs/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#QueuePolicyInitParameters: {
	// The JSON policy for the SQS queue.
	policy?: null | string @go(Policy,*string)
}

#QueuePolicyObservation: {
	id?: null | string @go(ID,*string)

	// The JSON policy for the SQS queue.
	policy?: null | string @go(Policy,*string)

	// The URL of the SQS Queue to which to attach the policy
	queueUrl?: null | string @go(QueueURL,*string)
}

#QueuePolicyParameters: {
	// The JSON policy for the SQS queue.
	// +kubebuilder:validation:Optional
	policy?: null | string @go(Policy,*string)

	// The URL of the SQS Queue to which to attach the policy
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/sqs/v1beta1.Queue
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.TerraformID()
	// +kubebuilder:validation:Optional
	queueUrl?: null | string @go(QueueURL,*string)

	// Reference to a Queue in sqs to populate queueUrl.
	// +kubebuilder:validation:Optional
	queueUrlRef?: null | v1.#Reference @go(QueueURLRef,*v1.Reference)

	// Selector for a Queue in sqs to populate queueUrl.
	// +kubebuilder:validation:Optional
	queueUrlSelector?: null | v1.#Selector @go(QueueURLSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// QueuePolicySpec defines the desired state of QueuePolicy
#QueuePolicySpec: {
	v1.#ResourceSpec
	forProvider: #QueuePolicyParameters @go(ForProvider)

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
	initProvider?: #QueuePolicyInitParameters @go(InitProvider)
}

// QueuePolicyStatus defines the observed state of QueuePolicy.
#QueuePolicyStatus: {
	v1.#ResourceStatus
	atProvider?: #QueuePolicyObservation @go(AtProvider)
}

// QueuePolicy is the Schema for the QueuePolicys API. Provides a SQS Queue Policy resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#QueuePolicy: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.policy) || (has(self.initProvider) && has(self.initProvider.policy))",message="spec.forProvider.policy is a required parameter"
	spec:    #QueuePolicySpec   @go(Spec)
	status?: #QueuePolicyStatus @go(Status)
}

// QueuePolicyList contains a list of QueuePolicys
#QueuePolicyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#QueuePolicy] @go(Items,[]QueuePolicy)
}