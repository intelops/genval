// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/securityhub/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#MemberInitParameters: {
	// The ID of the member AWS account.
	accountId?: null | string @go(AccountID,*string)

	// The email of the member AWS account.
	email?: null | string @go(Email,*string)

	// Boolean whether to invite the account to Security Hub as a member. Defaults to false.
	invite?: null | bool @go(Invite,*bool)
}

#MemberObservation: {
	// The ID of the member AWS account.
	accountId?: null | string @go(AccountID,*string)

	// The email of the member AWS account.
	email?: null | string @go(Email,*string)

	// The ID of the member AWS account (matches account_id).
	id?: null | string @go(ID,*string)

	// Boolean whether to invite the account to Security Hub as a member. Defaults to false.
	invite?: null | bool @go(Invite,*bool)

	// The ID of the master Security Hub AWS account.
	masterId?: null | string @go(MasterID,*string)

	// The status of the member account relationship.
	memberStatus?: null | string @go(MemberStatus,*string)
}

#MemberParameters: {
	// The ID of the member AWS account.
	// +kubebuilder:validation:Optional
	accountId?: null | string @go(AccountID,*string)

	// The email of the member AWS account.
	// +kubebuilder:validation:Optional
	email?: null | string @go(Email,*string)

	// Boolean whether to invite the account to Security Hub as a member. Defaults to false.
	// +kubebuilder:validation:Optional
	invite?: null | bool @go(Invite,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// MemberSpec defines the desired state of Member
#MemberSpec: {
	v1.#ResourceSpec
	forProvider: #MemberParameters @go(ForProvider)

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
	initProvider?: #MemberInitParameters @go(InitProvider)
}

// MemberStatus defines the observed state of Member.
#MemberStatus: {
	v1.#ResourceStatus
	atProvider?: #MemberObservation @go(AtProvider)
}

// Member is the Schema for the Members API. Provides a Security Hub member resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Member: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.accountId) || (has(self.initProvider) && has(self.initProvider.accountId))",message="spec.forProvider.accountId is a required parameter"
	spec:    #MemberSpec   @go(Spec)
	status?: #MemberStatus @go(Status)
}

// MemberList contains a list of Members
#MemberList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Member] @go(Items,[]Member)
}
