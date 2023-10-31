// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/schemas/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DiscovererInitParameters: {
	// The description of the discoverer. Maximum of 256 characters.
	description?: null | string @go(Description,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#DiscovererObservation: {
	// The Amazon Resource Name (ARN) of the discoverer.
	arn?: null | string @go(Arn,*string)

	// The description of the discoverer. Maximum of 256 characters.
	description?: null | string @go(Description,*string)

	// The ID of the discoverer.
	id?: null | string @go(ID,*string)

	// The ARN of the event bus to discover event schemas on.
	sourceArn?: null | string @go(SourceArn,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#DiscovererParameters: {
	// The description of the discoverer. Maximum of 256 characters.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The ARN of the event bus to discover event schemas on.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/cloudwatchevents/v1beta1.Bus
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	sourceArn?: null | string @go(SourceArn,*string)

	// Reference to a Bus in cloudwatchevents to populate sourceArn.
	// +kubebuilder:validation:Optional
	sourceArnRef?: null | v1.#Reference @go(SourceArnRef,*v1.Reference)

	// Selector for a Bus in cloudwatchevents to populate sourceArn.
	// +kubebuilder:validation:Optional
	sourceArnSelector?: null | v1.#Selector @go(SourceArnSelector,*v1.Selector)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// DiscovererSpec defines the desired state of Discoverer
#DiscovererSpec: {
	v1.#ResourceSpec
	forProvider: #DiscovererParameters @go(ForProvider)

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
	initProvider?: #DiscovererInitParameters @go(InitProvider)
}

// DiscovererStatus defines the observed state of Discoverer.
#DiscovererStatus: {
	v1.#ResourceStatus
	atProvider?: #DiscovererObservation @go(AtProvider)
}

// Discoverer is the Schema for the Discoverers API. Provides an EventBridge Schema Discoverer resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Discoverer: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #DiscovererSpec    @go(Spec)
	status?:   #DiscovererStatus  @go(Status)
}

// DiscovererList contains a list of Discoverers
#DiscovererList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Discoverer] @go(Items,[]Discoverer)
}
