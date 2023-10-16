// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/kinesis/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#StreamConsumerInitParameters: {
	// Name of the stream consumer.
	name?: null | string @go(Name,*string)
}

#StreamConsumerObservation: {
	// Amazon Resource Name (ARN) of the stream consumer.
	arn?: null | string @go(Arn,*string)

	// Approximate timestamp in RFC3339 format of when the stream consumer was created.
	creationTimestamp?: null | string @go(CreationTimestamp,*string)

	// Amazon Resource Name (ARN) of the stream consumer.
	id?: null | string @go(ID,*string)

	// Name of the stream consumer.
	name?: null | string @go(Name,*string)

	// –  Amazon Resource Name (ARN) of the data stream the consumer is registered with.
	streamArn?: null | string @go(StreamArn,*string)
}

#StreamConsumerParameters: {
	// Name of the stream consumer.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// –  Amazon Resource Name (ARN) of the data stream the consumer is registered with.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kinesis/v1beta1.Stream
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.TerraformID()
	// +kubebuilder:validation:Optional
	streamArn?: null | string @go(StreamArn,*string)

	// Reference to a Stream in kinesis to populate streamArn.
	// +kubebuilder:validation:Optional
	streamArnRef?: null | v1.#Reference @go(StreamArnRef,*v1.Reference)

	// Selector for a Stream in kinesis to populate streamArn.
	// +kubebuilder:validation:Optional
	streamArnSelector?: null | v1.#Selector @go(StreamArnSelector,*v1.Selector)
}

// StreamConsumerSpec defines the desired state of StreamConsumer
#StreamConsumerSpec: {
	v1.#ResourceSpec
	forProvider: #StreamConsumerParameters @go(ForProvider)

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
	initProvider?: #StreamConsumerInitParameters @go(InitProvider)
}

// StreamConsumerStatus defines the observed state of StreamConsumer.
#StreamConsumerStatus: {
	v1.#ResourceStatus
	atProvider?: #StreamConsumerObservation @go(AtProvider)
}

// StreamConsumer is the Schema for the StreamConsumers API. Manages a Kinesis Stream Consumer.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#StreamConsumer: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #StreamConsumerSpec   @go(Spec)
	status?: #StreamConsumerStatus @go(Status)
}

// StreamConsumerList contains a list of StreamConsumers
#StreamConsumerList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#StreamConsumer] @go(Items,[]StreamConsumer)
}