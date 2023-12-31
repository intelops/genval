// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AMILaunchPermissionInitParameters: {
	// AWS account ID for the launch permission.
	accountId?: null | string @go(AccountID,*string)

	// Name of the group for the launch permission. Valid values: "all".
	group?: null | string @go(Group,*string)

	// ARN of an organization for the launch permission.
	organizationArn?: null | string @go(OrganizationArn,*string)

	// ARN of an organizational unit for the launch permission.
	organizationalUnitArn?: null | string @go(OrganizationalUnitArn,*string)
}

#AMILaunchPermissionObservation: {
	// AWS account ID for the launch permission.
	accountId?: null | string @go(AccountID,*string)

	// Name of the group for the launch permission. Valid values: "all".
	group?: null | string @go(Group,*string)

	// Launch permission ID.
	id?: null | string @go(ID,*string)

	// ID of the AMI.
	imageId?: null | string @go(ImageID,*string)

	// ARN of an organization for the launch permission.
	organizationArn?: null | string @go(OrganizationArn,*string)

	// ARN of an organizational unit for the launch permission.
	organizationalUnitArn?: null | string @go(OrganizationalUnitArn,*string)
}

#AMILaunchPermissionParameters: {
	// AWS account ID for the launch permission.
	// +kubebuilder:validation:Optional
	accountId?: null | string @go(AccountID,*string)

	// Name of the group for the launch permission. Valid values: "all".
	// +kubebuilder:validation:Optional
	group?: null | string @go(Group,*string)

	// ID of the AMI.
	// +crossplane:generate:reference:type=AMI
	// +kubebuilder:validation:Optional
	imageId?: null | string @go(ImageID,*string)

	// Reference to a AMI to populate imageId.
	// +kubebuilder:validation:Optional
	imageIdRef?: null | v1.#Reference @go(ImageIDRef,*v1.Reference)

	// Selector for a AMI to populate imageId.
	// +kubebuilder:validation:Optional
	imageIdSelector?: null | v1.#Selector @go(ImageIDSelector,*v1.Selector)

	// ARN of an organization for the launch permission.
	// +kubebuilder:validation:Optional
	organizationArn?: null | string @go(OrganizationArn,*string)

	// ARN of an organizational unit for the launch permission.
	// +kubebuilder:validation:Optional
	organizationalUnitArn?: null | string @go(OrganizationalUnitArn,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// AMILaunchPermissionSpec defines the desired state of AMILaunchPermission
#AMILaunchPermissionSpec: {
	v1.#ResourceSpec
	forProvider: #AMILaunchPermissionParameters @go(ForProvider)

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
	initProvider?: #AMILaunchPermissionInitParameters @go(InitProvider)
}

// AMILaunchPermissionStatus defines the observed state of AMILaunchPermission.
#AMILaunchPermissionStatus: {
	v1.#ResourceStatus
	atProvider?: #AMILaunchPermissionObservation @go(AtProvider)
}

// AMILaunchPermission is the Schema for the AMILaunchPermissions API. Adds a launch permission to an Amazon Machine Image (AMI).
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#AMILaunchPermission: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta         @go(ObjectMeta)
	spec:      #AMILaunchPermissionSpec   @go(Spec)
	status?:   #AMILaunchPermissionStatus @go(Status)
}

// AMILaunchPermissionList contains a list of AMILaunchPermissions
#AMILaunchPermissionList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#AMILaunchPermission] @go(Items,[]AMILaunchPermission)
}
