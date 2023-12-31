// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/acmpca/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#PermissionInitParameters: {
	// Actions that the specified AWS service principal can use. These include IssueCertificate, GetCertificate, and ListPermissions. Note that in order for ACM to automatically rotate certificates issued by a PCA, it must be granted permission on all 3 actions, as per the example above.
	actions?: [...null | string] @go(Actions,[]*string)

	// AWS service or identity that receives the permission. At this time, the only valid principal is acm.amazonaws.com.
	principal?: null | string @go(Principal,*string)

	// ID of the calling account
	sourceAccount?: null | string @go(SourceAccount,*string)
}

#PermissionObservation: {
	// Actions that the specified AWS service principal can use. These include IssueCertificate, GetCertificate, and ListPermissions. Note that in order for ACM to automatically rotate certificates issued by a PCA, it must be granted permission on all 3 actions, as per the example above.
	actions?: [...null | string] @go(Actions,[]*string)

	// ARN of the CA that grants the permissions.
	certificateAuthorityArn?: null | string @go(CertificateAuthorityArn,*string)
	id?:                      null | string @go(ID,*string)

	// IAM policy that is associated with the permission.
	policy?: null | string @go(Policy,*string)

	// AWS service or identity that receives the permission. At this time, the only valid principal is acm.amazonaws.com.
	principal?: null | string @go(Principal,*string)

	// ID of the calling account
	sourceAccount?: null | string @go(SourceAccount,*string)
}

#PermissionParameters: {
	// Actions that the specified AWS service principal can use. These include IssueCertificate, GetCertificate, and ListPermissions. Note that in order for ACM to automatically rotate certificates issued by a PCA, it must be granted permission on all 3 actions, as per the example above.
	// +kubebuilder:validation:Optional
	actions?: [...null | string] @go(Actions,[]*string)

	// ARN of the CA that grants the permissions.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/acmpca/v1beta1.CertificateAuthority
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	certificateAuthorityArn?: null | string @go(CertificateAuthorityArn,*string)

	// Reference to a CertificateAuthority in acmpca to populate certificateAuthorityArn.
	// +kubebuilder:validation:Optional
	certificateAuthorityArnRef?: null | v1.#Reference @go(CertificateAuthorityArnRef,*v1.Reference)

	// Selector for a CertificateAuthority in acmpca to populate certificateAuthorityArn.
	// +kubebuilder:validation:Optional
	certificateAuthorityArnSelector?: null | v1.#Selector @go(CertificateAuthorityArnSelector,*v1.Selector)

	// AWS service or identity that receives the permission. At this time, the only valid principal is acm.amazonaws.com.
	// +kubebuilder:validation:Optional
	principal?: null | string @go(Principal,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// ID of the calling account
	// +kubebuilder:validation:Optional
	sourceAccount?: null | string @go(SourceAccount,*string)
}

// PermissionSpec defines the desired state of Permission
#PermissionSpec: {
	v1.#ResourceSpec
	forProvider: #PermissionParameters @go(ForProvider)

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
	initProvider?: #PermissionInitParameters @go(InitProvider)
}

// PermissionStatus defines the observed state of Permission.
#PermissionStatus: {
	v1.#ResourceStatus
	atProvider?: #PermissionObservation @go(AtProvider)
}

// Permission is the Schema for the Permissions API. Provides a resource to manage an AWS Certificate Manager Private Certificate Authorities Permission
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Permission: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.actions) || (has(self.initProvider) && has(self.initProvider.actions))",message="spec.forProvider.actions is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.principal) || (has(self.initProvider) && has(self.initProvider.principal))",message="spec.forProvider.principal is a required parameter"
	spec:    #PermissionSpec   @go(Spec)
	status?: #PermissionStatus @go(Status)
}

// PermissionList contains a list of Permissions
#PermissionList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Permission] @go(Items,[]Permission)
}
