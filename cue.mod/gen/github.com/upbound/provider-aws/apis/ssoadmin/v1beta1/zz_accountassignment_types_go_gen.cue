// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ssoadmin/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AccountAssignmentInitParameters: {
}

#AccountAssignmentObservation: {
	// The identifier of the Account Assignment i.e., principal_id, principal_type, target_id, target_type, permission_set_arn, instance_arn separated by commas (,).
	id?: null | string @go(ID,*string)

	// The Amazon Resource Name (ARN) of the SSO Instance.
	instanceArn?: null | string @go(InstanceArn,*string)

	// The Amazon Resource Name (ARN) of the Permission Set that the admin wants to grant the principal access to.
	permissionSetArn?: null | string @go(PermissionSetArn,*string)

	// An identifier for an object in SSO, such as a user or group. PrincipalIds are GUIDs (For example, f81d4fae-7dec-11d0-a765-00a0c91e6bf6).
	principalId?: null | string @go(PrincipalID,*string)

	// The entity type for which the assignment will be created. Valid values: USER, GROUP.
	principalType?: null | string @go(PrincipalType,*string)

	// An AWS account identifier, typically a 10-12 digit string.
	targetId?: null | string @go(TargetID,*string)

	// The entity type for which the assignment will be created. Valid values: AWS_ACCOUNT.
	targetType?: null | string @go(TargetType,*string)
}

#AccountAssignmentParameters: {
	// The Amazon Resource Name (ARN) of the SSO Instance.
	// +kubebuilder:validation:Required
	instanceArn?: null | string @go(InstanceArn,*string)

	// The Amazon Resource Name (ARN) of the Permission Set that the admin wants to grant the principal access to.
	// +kubebuilder:validation:Required
	permissionSetArn?: null | string @go(PermissionSetArn,*string)

	// An identifier for an object in SSO, such as a user or group. PrincipalIds are GUIDs (For example, f81d4fae-7dec-11d0-a765-00a0c91e6bf6).
	// +kubebuilder:validation:Required
	principalId?: null | string @go(PrincipalID,*string)

	// The entity type for which the assignment will be created. Valid values: USER, GROUP.
	// +kubebuilder:validation:Required
	principalType?: null | string @go(PrincipalType,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// An AWS account identifier, typically a 10-12 digit string.
	// +kubebuilder:validation:Required
	targetId?: null | string @go(TargetID,*string)

	// The entity type for which the assignment will be created. Valid values: AWS_ACCOUNT.
	// +kubebuilder:validation:Optional
	targetType?: null | string @go(TargetType,*string)
}

// AccountAssignmentSpec defines the desired state of AccountAssignment
#AccountAssignmentSpec: {
	v1.#ResourceSpec
	forProvider: #AccountAssignmentParameters @go(ForProvider)

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
	initProvider?: #AccountAssignmentInitParameters @go(InitProvider)
}

// AccountAssignmentStatus defines the observed state of AccountAssignment.
#AccountAssignmentStatus: {
	v1.#ResourceStatus
	atProvider?: #AccountAssignmentObservation @go(AtProvider)
}

// AccountAssignment is the Schema for the AccountAssignments API. Manages a Single Sign-On (SSO) Account Assignment
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#AccountAssignment: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta       @go(ObjectMeta)
	spec:      #AccountAssignmentSpec   @go(Spec)
	status?:   #AccountAssignmentStatus @go(Status)
}

// AccountAssignmentList contains a list of AccountAssignments
#AccountAssignmentList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#AccountAssignment] @go(Items,[]AccountAssignment)
}
