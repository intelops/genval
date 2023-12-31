// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/appstream/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#UserStackAssociationInitParameters: {
	// Whether a welcome email is sent to a user after the user is created in the user pool.
	sendEmailNotification?: null | bool @go(SendEmailNotification,*bool)
}

#UserStackAssociationObservation: {
	// Authentication type for the user.
	authenticationType?: null | string @go(AuthenticationType,*string)

	// Unique ID of the appstream User Stack association.
	id?: null | string @go(ID,*string)

	// Whether a welcome email is sent to a user after the user is created in the user pool.
	sendEmailNotification?: null | bool @go(SendEmailNotification,*bool)

	// Name of the stack that is associated with the user.
	stackName?: null | string @go(StackName,*string)

	// Email address of the user who is associated with the stack.
	userName?: null | string @go(UserName,*string)
}

#UserStackAssociationParameters: {
	// Authentication type for the user.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/appstream/v1beta1.User
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("authentication_type",false)
	// +kubebuilder:validation:Optional
	authenticationType?: null | string @go(AuthenticationType,*string)

	// Reference to a User in appstream to populate authenticationType.
	// +kubebuilder:validation:Optional
	authenticationTypeRef?: null | v1.#Reference @go(AuthenticationTypeRef,*v1.Reference)

	// Selector for a User in appstream to populate authenticationType.
	// +kubebuilder:validation:Optional
	authenticationTypeSelector?: null | v1.#Selector @go(AuthenticationTypeSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Whether a welcome email is sent to a user after the user is created in the user pool.
	// +kubebuilder:validation:Optional
	sendEmailNotification?: null | bool @go(SendEmailNotification,*bool)

	// Name of the stack that is associated with the user.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/appstream/v1beta1.Stack
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("name",false)
	// +kubebuilder:validation:Optional
	stackName?: null | string @go(StackName,*string)

	// Reference to a Stack in appstream to populate stackName.
	// +kubebuilder:validation:Optional
	stackNameRef?: null | v1.#Reference @go(StackNameRef,*v1.Reference)

	// Selector for a Stack in appstream to populate stackName.
	// +kubebuilder:validation:Optional
	stackNameSelector?: null | v1.#Selector @go(StackNameSelector,*v1.Selector)

	// Email address of the user who is associated with the stack.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/appstream/v1beta1.User
	// +kubebuilder:validation:Optional
	userName?: null | string @go(UserName,*string)

	// Reference to a User in appstream to populate userName.
	// +kubebuilder:validation:Optional
	userNameRef?: null | v1.#Reference @go(UserNameRef,*v1.Reference)

	// Selector for a User in appstream to populate userName.
	// +kubebuilder:validation:Optional
	userNameSelector?: null | v1.#Selector @go(UserNameSelector,*v1.Selector)
}

// UserStackAssociationSpec defines the desired state of UserStackAssociation
#UserStackAssociationSpec: {
	v1.#ResourceSpec
	forProvider: #UserStackAssociationParameters @go(ForProvider)

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
	initProvider?: #UserStackAssociationInitParameters @go(InitProvider)
}

// UserStackAssociationStatus defines the observed state of UserStackAssociation.
#UserStackAssociationStatus: {
	v1.#ResourceStatus
	atProvider?: #UserStackAssociationObservation @go(AtProvider)
}

// UserStackAssociation is the Schema for the UserStackAssociations API. Manages an AppStream User Stack association.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#UserStackAssociation: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta          @go(ObjectMeta)
	spec:      #UserStackAssociationSpec   @go(Spec)
	status?:   #UserStackAssociationStatus @go(Status)
}

// UserStackAssociationList contains a list of UserStackAssociations
#UserStackAssociationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#UserStackAssociation] @go(Items,[]UserStackAssociation)
}
