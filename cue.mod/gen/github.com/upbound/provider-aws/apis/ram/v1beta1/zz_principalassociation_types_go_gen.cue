// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ram/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#PrincipalAssociationInitParameters: {
}

#PrincipalAssociationObservation: {
	// The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma.
	id?: null | string @go(ID,*string)

	// The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN.
	principal?: null | string @go(Principal,*string)

	// The Amazon Resource Name (ARN) of the resource share.
	resourceShareArn?: null | string @go(ResourceShareArn,*string)
}

#PrincipalAssociationParameters: {
	// The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/organizations/v1beta1.Organization
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	principal?: null | string @go(Principal,*string)

	// Reference to a Organization in organizations to populate principal.
	// +kubebuilder:validation:Optional
	principalRef?: null | v1.#Reference @go(PrincipalRef,*v1.Reference)

	// Selector for a Organization in organizations to populate principal.
	// +kubebuilder:validation:Optional
	principalSelector?: null | v1.#Selector @go(PrincipalSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The Amazon Resource Name (ARN) of the resource share.
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

// PrincipalAssociationSpec defines the desired state of PrincipalAssociation
#PrincipalAssociationSpec: {
	v1.#ResourceSpec
	forProvider: #PrincipalAssociationParameters @go(ForProvider)

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
	initProvider?: #PrincipalAssociationInitParameters @go(InitProvider)
}

// PrincipalAssociationStatus defines the observed state of PrincipalAssociation.
#PrincipalAssociationStatus: {
	v1.#ResourceStatus
	atProvider?: #PrincipalAssociationObservation @go(AtProvider)
}

// PrincipalAssociation is the Schema for the PrincipalAssociations API. Provides a Resource Access Manager (RAM) principal association.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#PrincipalAssociation: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta          @go(ObjectMeta)
	spec:      #PrincipalAssociationSpec   @go(Spec)
	status?:   #PrincipalAssociationStatus @go(Status)
}

// PrincipalAssociationList contains a list of PrincipalAssociations
#PrincipalAssociationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#PrincipalAssociation] @go(Items,[]PrincipalAssociation)
}
