// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#TrafficMirrorFilterInitParameters: {
	// A description of the filter.
	description?: null | string @go(Description,*string)

	// List of amazon network services that should be mirrored. Valid values: amazon-dns.
	networkServices?: [...null | string] @go(NetworkServices,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#TrafficMirrorFilterObservation: {
	// The ARN of the traffic mirror filter.
	arn?: null | string @go(Arn,*string)

	// A description of the filter.
	description?: null | string @go(Description,*string)

	// The name of the filter.
	id?: null | string @go(ID,*string)

	// List of amazon network services that should be mirrored. Valid values: amazon-dns.
	networkServices?: [...null | string] @go(NetworkServices,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#TrafficMirrorFilterParameters: {
	// A description of the filter.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// List of amazon network services that should be mirrored. Valid values: amazon-dns.
	// +kubebuilder:validation:Optional
	networkServices?: [...null | string] @go(NetworkServices,[]*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// TrafficMirrorFilterSpec defines the desired state of TrafficMirrorFilter
#TrafficMirrorFilterSpec: {
	v1.#ResourceSpec
	forProvider: #TrafficMirrorFilterParameters @go(ForProvider)

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
	initProvider?: #TrafficMirrorFilterInitParameters @go(InitProvider)
}

// TrafficMirrorFilterStatus defines the observed state of TrafficMirrorFilter.
#TrafficMirrorFilterStatus: {
	v1.#ResourceStatus
	atProvider?: #TrafficMirrorFilterObservation @go(AtProvider)
}

// TrafficMirrorFilter is the Schema for the TrafficMirrorFilters API. Provides an Traffic mirror filter
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#TrafficMirrorFilter: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta         @go(ObjectMeta)
	spec:      #TrafficMirrorFilterSpec   @go(Spec)
	status?:   #TrafficMirrorFilterStatus @go(Status)
}

// TrafficMirrorFilterList contains a list of TrafficMirrorFilters
#TrafficMirrorFilterList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#TrafficMirrorFilter] @go(Items,[]TrafficMirrorFilter)
}
