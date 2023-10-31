// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ram/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ResourceAssociationInitParameters: {
	// Amazon Resource Name (ARN) of the resource to associate with the RAM Resource Share.
	resourceArn?: null | string @go(ResourceArn,*string)
}

#ResourceAssociationObservation: {
	// The Amazon Resource Name (ARN) of the resource share.
	id?: null | string @go(ID,*string)

	// Amazon Resource Name (ARN) of the resource to associate with the RAM Resource Share.
	resourceArn?: null | string @go(ResourceArn,*string)

	// Amazon Resource Name (ARN) of the RAM Resource Share.
	resourceShareArn?: null | string @go(ResourceShareArn,*string)
}

#ResourceAssociationParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Amazon Resource Name (ARN) of the resource to associate with the RAM Resource Share.
	// +kubebuilder:validation:Optional
	resourceArn?: null | string @go(ResourceArn,*string)

	// Amazon Resource Name (ARN) of the RAM Resource Share.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ram/v1beta1.ResourceShare
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	resourceShareArn?: null | string @go(ResourceShareArn,*string)

	// Reference to a ResourceShare in ram to populate resourceShareArn.
	// +kubebuilder:validation:Optional
	resourceShareArnRef?: null | v1.#Reference @go(ResourceShareArnRef,*v1.Reference)

	// Selector for a ResourceShare in ram to populate resourceShareArn.
	// +kubebuilder:validation:Optional
	resourceShareArnSelector?: null | v1.#Selector @go(ResourceShareArnSelector,*v1.Selector)
}

// ResourceAssociationSpec defines the desired state of ResourceAssociation
#ResourceAssociationSpec: {
	v1.#ResourceSpec
	forProvider: #ResourceAssociationParameters @go(ForProvider)

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
	initProvider?: #ResourceAssociationInitParameters @go(InitProvider)
}

// ResourceAssociationStatus defines the observed state of ResourceAssociation.
#ResourceAssociationStatus: {
	v1.#ResourceStatus
	atProvider?: #ResourceAssociationObservation @go(AtProvider)
}

// ResourceAssociation is the Schema for the ResourceAssociations API. Manages a Resource Access Manager (RAM) Resource Association.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ResourceAssociation: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.resourceArn) || (has(self.initProvider) && has(self.initProvider.resourceArn))",message="spec.forProvider.resourceArn is a required parameter"
	spec:    #ResourceAssociationSpec   @go(Spec)
	status?: #ResourceAssociationStatus @go(Status)
}

// ResourceAssociationList contains a list of ResourceAssociations
#ResourceAssociationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ResourceAssociation] @go(Items,[]ResourceAssociation)
}
