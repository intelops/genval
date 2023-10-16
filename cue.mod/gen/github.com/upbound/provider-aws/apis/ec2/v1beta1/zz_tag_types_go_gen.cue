// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#TagInitParameters: {
	// The value of the tag.
	value?: null | string @go(Value,*string)
}

#TagObservation: {
	// EC2 resource identifier and key, separated by a comma (,)
	id?: null | string @go(ID,*string)

	// The tag name.
	key?: null | string @go(Key,*string)

	// The ID of the EC2 resource to manage the tag for.
	resourceId?: null | string @go(ResourceID,*string)

	// The value of the tag.
	value?: null | string @go(Value,*string)
}

#TagParameters: {
	// The tag name.
	// +kubebuilder:validation:Required
	key?: null | string @go(Key,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The ID of the EC2 resource to manage the tag for.
	// +kubebuilder:validation:Required
	resourceId?: null | string @go(ResourceID,*string)

	// The value of the tag.
	// +kubebuilder:validation:Optional
	value?: null | string @go(Value,*string)
}

// TagSpec defines the desired state of Tag
#TagSpec: {
	v1.#ResourceSpec
	forProvider: #TagParameters @go(ForProvider)

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
	initProvider?: #TagInitParameters @go(InitProvider)
}

// TagStatus defines the observed state of Tag.
#TagStatus: {
	v1.#ResourceStatus
	atProvider?: #TagObservation @go(AtProvider)
}

// Tag is the Schema for the Tags API. Manages an individual EC2 resource tag
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Tag: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.value) || (has(self.initProvider) && has(self.initProvider.value))",message="spec.forProvider.value is a required parameter"
	spec:    #TagSpec   @go(Spec)
	status?: #TagStatus @go(Status)
}

// TagList contains a list of Tags
#TagList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Tag] @go(Items,[]Tag)
}