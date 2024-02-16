// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/iam/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#UserGroupMembershipInitParameters: {
}

#UserGroupMembershipObservation: {
	// A list of IAM Groups to add the user to
	groups?: [...null | string] @go(Groups,[]*string)
	id?: null | string @go(ID,*string)

	// The name of the IAM User to add to groups
	user?: null | string @go(User,*string)
}

#UserGroupMembershipParameters: {
	// References to Group to populate groups.
	// +kubebuilder:validation:Optional
	groupRefs?: [...v1.#Reference] @go(GroupRefs,[]v1.Reference)

	// Selector for a list of Group to populate groups.
	// +kubebuilder:validation:Optional
	groupSelector?: null | v1.#Selector @go(GroupSelector,*v1.Selector)

	// A list of IAM Groups to add the user to
	// +crossplane:generate:reference:type=Group
	// +crossplane:generate:reference:refFieldName=GroupRefs
	// +crossplane:generate:reference:selectorFieldName=GroupSelector
	// +kubebuilder:validation:Optional
	groups?: [...null | string] @go(Groups,[]*string)

	// The name of the IAM User to add to groups
	// +crossplane:generate:reference:type=User
	// +kubebuilder:validation:Optional
	user?: null | string @go(User,*string)

	// Reference to a User to populate user.
	// +kubebuilder:validation:Optional
	userRef?: null | v1.#Reference @go(UserRef,*v1.Reference)

	// Selector for a User to populate user.
	// +kubebuilder:validation:Optional
	userSelector?: null | v1.#Selector @go(UserSelector,*v1.Selector)
}

// UserGroupMembershipSpec defines the desired state of UserGroupMembership
#UserGroupMembershipSpec: {
	v1.#ResourceSpec
	forProvider: #UserGroupMembershipParameters @go(ForProvider)

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
	initProvider?: #UserGroupMembershipInitParameters @go(InitProvider)
}

// UserGroupMembershipStatus defines the observed state of UserGroupMembership.
#UserGroupMembershipStatus: {
	v1.#ResourceStatus
	atProvider?: #UserGroupMembershipObservation @go(AtProvider)
}

// UserGroupMembership is the Schema for the UserGroupMemberships API. Provides a resource for adding an IAM User to IAM Groups without conflicting with itself.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#UserGroupMembership: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta         @go(ObjectMeta)
	spec:      #UserGroupMembershipSpec   @go(Spec)
	status?:   #UserGroupMembershipStatus @go(Status)
}

// UserGroupMembershipList contains a list of UserGroupMemberships
#UserGroupMembershipList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#UserGroupMembership] @go(Items,[]UserGroupMembership)
}