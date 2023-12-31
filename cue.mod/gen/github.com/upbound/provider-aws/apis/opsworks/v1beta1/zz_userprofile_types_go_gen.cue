// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/opsworks/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#UserProfileInitParameters: {
	// Whether users can specify their own SSH public key through the My Settings page
	allowSelfManagement?: null | bool @go(AllowSelfManagement,*bool)

	// The users public key
	sshPublicKey?: null | string @go(SSHPublicKey,*string)

	// The ssh username, with witch this user wants to log in
	sshUsername?: null | string @go(SSHUsername,*string)
}

#UserProfileObservation: {
	// Whether users can specify their own SSH public key through the My Settings page
	allowSelfManagement?: null | bool @go(AllowSelfManagement,*bool)

	// Same value as user_arn
	id?: null | string @go(ID,*string)

	// The users public key
	sshPublicKey?: null | string @go(SSHPublicKey,*string)

	// The ssh username, with witch this user wants to log in
	sshUsername?: null | string @go(SSHUsername,*string)

	// The user's IAM ARN
	userArn?: null | string @go(UserArn,*string)
}

#UserProfileParameters: {
	// Whether users can specify their own SSH public key through the My Settings page
	// +kubebuilder:validation:Optional
	allowSelfManagement?: null | bool @go(AllowSelfManagement,*bool)

	// The users public key
	// +kubebuilder:validation:Optional
	sshPublicKey?: null | string @go(SSHPublicKey,*string)

	// The ssh username, with witch this user wants to log in
	// +kubebuilder:validation:Optional
	sshUsername?: null | string @go(SSHUsername,*string)

	// The user's IAM ARN
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.User
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	userArn?: null | string @go(UserArn,*string)

	// Reference to a User in iam to populate userArn.
	// +kubebuilder:validation:Optional
	userArnRef?: null | v1.#Reference @go(UserArnRef,*v1.Reference)

	// Selector for a User in iam to populate userArn.
	// +kubebuilder:validation:Optional
	userArnSelector?: null | v1.#Selector @go(UserArnSelector,*v1.Selector)
}

// UserProfileSpec defines the desired state of UserProfile
#UserProfileSpec: {
	v1.#ResourceSpec
	forProvider: #UserProfileParameters @go(ForProvider)

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
	initProvider?: #UserProfileInitParameters @go(InitProvider)
}

// UserProfileStatus defines the observed state of UserProfile.
#UserProfileStatus: {
	v1.#ResourceStatus
	atProvider?: #UserProfileObservation @go(AtProvider)
}

// UserProfile is the Schema for the UserProfiles API. Provides an OpsWorks User Profile resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#UserProfile: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.sshUsername) || (has(self.initProvider) && has(self.initProvider.sshUsername))",message="spec.forProvider.sshUsername is a required parameter"
	spec:    #UserProfileSpec   @go(Spec)
	status?: #UserProfileStatus @go(Status)
}

// UserProfileList contains a list of UserProfiles
#UserProfileList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#UserProfile] @go(Items,[]UserProfile)
}
