// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/redshift/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#SnapshotCopyGrantInitParameters: {
	// A friendly name for identifying the grant.
	snapshotCopyGrantName?: null | string @go(SnapshotCopyGrantName,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#SnapshotCopyGrantObservation: {
	// Amazon Resource Name (ARN) of snapshot copy grant
	arn?: null | string @go(Arn,*string)
	id?:  null | string @go(ID,*string)

	// The unique identifier for the customer master key (CMK) that the grant applies to. Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN. If not specified, the default key is used.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// A friendly name for identifying the grant.
	snapshotCopyGrantName?: null | string @go(SnapshotCopyGrantName,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#SnapshotCopyGrantParameters: {
	// The unique identifier for the customer master key (CMK) that the grant applies to. Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN. If not specified, the default key is used.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +kubebuilder:validation:Optional
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// Reference to a Key in kms to populate kmsKeyId.
	// +kubebuilder:validation:Optional
	kmsKeyIdRef?: null | v1.#Reference @go(KMSKeyIDRef,*v1.Reference)

	// Selector for a Key in kms to populate kmsKeyId.
	// +kubebuilder:validation:Optional
	kmsKeyIdSelector?: null | v1.#Selector @go(KMSKeyIDSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// A friendly name for identifying the grant.
	// +kubebuilder:validation:Optional
	snapshotCopyGrantName?: null | string @go(SnapshotCopyGrantName,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// SnapshotCopyGrantSpec defines the desired state of SnapshotCopyGrant
#SnapshotCopyGrantSpec: {
	v1.#ResourceSpec
	forProvider: #SnapshotCopyGrantParameters @go(ForProvider)

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
	initProvider?: #SnapshotCopyGrantInitParameters @go(InitProvider)
}

// SnapshotCopyGrantStatus defines the observed state of SnapshotCopyGrant.
#SnapshotCopyGrantStatus: {
	v1.#ResourceStatus
	atProvider?: #SnapshotCopyGrantObservation @go(AtProvider)
}

// SnapshotCopyGrant is the Schema for the SnapshotCopyGrants API. Creates a snapshot copy grant that allows AWS Redshift to encrypt copied snapshots with a customer master key from AWS KMS in a destination region.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#SnapshotCopyGrant: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.snapshotCopyGrantName) || (has(self.initProvider) && has(self.initProvider.snapshotCopyGrantName))",message="spec.forProvider.snapshotCopyGrantName is a required parameter"
	spec:    #SnapshotCopyGrantSpec   @go(Spec)
	status?: #SnapshotCopyGrantStatus @go(Status)
}

// SnapshotCopyGrantList contains a list of SnapshotCopyGrants
#SnapshotCopyGrantList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#SnapshotCopyGrant] @go(Items,[]SnapshotCopyGrant)
}
