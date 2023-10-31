// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/rds/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DBSnapshotCopyInitParameters: {
	// Whether to copy existing tags. Defaults to false.
	copyTags?: null | bool @go(CopyTags,*bool)

	// The Destination region to place snapshot copy.
	destinationRegion?: null | string @go(DestinationRegion,*string)

	// The name of an option group to associate with the copy of the snapshot.
	optionGroupName?: null | string @go(OptionGroupName,*string)

	// he URL that contains a Signature Version 4 signed request.
	presignedUrl?: null | string @go(PresignedURL,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The external custom Availability Zone.
	targetCustomAvailabilityZone?: null | string @go(TargetCustomAvailabilityZone,*string)

	// The Identifier for the snapshot.
	targetDbSnapshotIdentifier?: null | string @go(TargetDBSnapshotIdentifier,*string)
}

#DBSnapshotCopyObservation: {
	// Specifies the allocated storage size in gigabytes (GB).
	allocatedStorage?: null | float64 @go(AllocatedStorage,*float64)

	// Specifies the name of the Availability Zone the DB instance was located in at the time of the DB snapshot.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Whether to copy existing tags. Defaults to false.
	copyTags?: null | bool @go(CopyTags,*bool)

	// The Amazon Resource Name (ARN) for the DB snapshot.
	dbSnapshotArn?: null | string @go(DBSnapshotArn,*string)

	// The Destination region to place snapshot copy.
	destinationRegion?: null | string @go(DestinationRegion,*string)

	// Specifies whether the DB snapshot is encrypted.
	encrypted?: null | bool @go(Encrypted,*bool)

	// Specifies the name of the database engine.
	engine?: null | string @go(Engine,*string)

	// Specifies the version of the database engine.
	engineVersion?: null | string @go(EngineVersion,*string)

	// Snapshot Identifier.
	id?: null | string @go(ID,*string)

	// Specifies the Provisioned IOPS (I/O operations per second) value of the DB instance at the time of the snapshot.
	iops?: null | float64 @go(Iops,*float64)

	// KMS key ID.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// License model information for the restored DB instance.
	licenseModel?: null | string @go(LicenseModel,*string)

	// The name of an option group to associate with the copy of the snapshot.
	optionGroupName?: null | string  @go(OptionGroupName,*string)
	port?:            null | float64 @go(Port,*float64)

	// he URL that contains a Signature Version 4 signed request.
	presignedUrl?: null | string @go(PresignedURL,*string)
	snapshotType?: null | string @go(SnapshotType,*string)

	// Snapshot identifier of the source snapshot.
	sourceDbSnapshotIdentifier?: null | string @go(SourceDBSnapshotIdentifier,*string)

	// The region that the DB snapshot was created in or copied from.
	sourceRegion?: null | string @go(SourceRegion,*string)

	// Specifies the storage type associated with DB snapshot.
	storageType?: null | string @go(StorageType,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The external custom Availability Zone.
	targetCustomAvailabilityZone?: null | string @go(TargetCustomAvailabilityZone,*string)

	// The Identifier for the snapshot.
	targetDbSnapshotIdentifier?: null | string @go(TargetDBSnapshotIdentifier,*string)

	// Provides the VPC ID associated with the DB snapshot.
	vpcId?: null | string @go(VPCID,*string)
}

#DBSnapshotCopyParameters: {
	// Whether to copy existing tags. Defaults to false.
	// +kubebuilder:validation:Optional
	copyTags?: null | bool @go(CopyTags,*bool)

	// The Destination region to place snapshot copy.
	// +kubebuilder:validation:Optional
	destinationRegion?: null | string @go(DestinationRegion,*string)

	// KMS key ID.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +kubebuilder:validation:Optional
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// Reference to a Key in kms to populate kmsKeyId.
	// +kubebuilder:validation:Optional
	kmsKeyIdRef?: null | v1.#Reference @go(KMSKeyIDRef,*v1.Reference)

	// Selector for a Key in kms to populate kmsKeyId.
	// +kubebuilder:validation:Optional
	kmsKeyIdSelector?: null | v1.#Selector @go(KMSKeyIDSelector,*v1.Selector)

	// The name of an option group to associate with the copy of the snapshot.
	// +kubebuilder:validation:Optional
	optionGroupName?: null | string @go(OptionGroupName,*string)

	// he URL that contains a Signature Version 4 signed request.
	// +kubebuilder:validation:Optional
	presignedUrl?: null | string @go(PresignedURL,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Snapshot identifier of the source snapshot.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/rds/v1beta1.Snapshot
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("db_snapshot_arn",true)
	// +kubebuilder:validation:Optional
	sourceDbSnapshotIdentifier?: null | string @go(SourceDBSnapshotIdentifier,*string)

	// Reference to a Snapshot in rds to populate sourceDbSnapshotIdentifier.
	// +kubebuilder:validation:Optional
	sourceDbSnapshotIdentifierRef?: null | v1.#Reference @go(SourceDBSnapshotIdentifierRef,*v1.Reference)

	// Selector for a Snapshot in rds to populate sourceDbSnapshotIdentifier.
	// +kubebuilder:validation:Optional
	sourceDbSnapshotIdentifierSelector?: null | v1.#Selector @go(SourceDBSnapshotIdentifierSelector,*v1.Selector)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The external custom Availability Zone.
	// +kubebuilder:validation:Optional
	targetCustomAvailabilityZone?: null | string @go(TargetCustomAvailabilityZone,*string)

	// The Identifier for the snapshot.
	// +kubebuilder:validation:Optional
	targetDbSnapshotIdentifier?: null | string @go(TargetDBSnapshotIdentifier,*string)
}

// DBSnapshotCopySpec defines the desired state of DBSnapshotCopy
#DBSnapshotCopySpec: {
	v1.#ResourceSpec
	forProvider: #DBSnapshotCopyParameters @go(ForProvider)

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
	initProvider?: #DBSnapshotCopyInitParameters @go(InitProvider)
}

// DBSnapshotCopyStatus defines the observed state of DBSnapshotCopy.
#DBSnapshotCopyStatus: {
	v1.#ResourceStatus
	atProvider?: #DBSnapshotCopyObservation @go(AtProvider)
}

// DBSnapshotCopy is the Schema for the DBSnapshotCopys API. Manages an RDS database instance snapshot copy.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#DBSnapshotCopy: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.targetDbSnapshotIdentifier) || (has(self.initProvider) && has(self.initProvider.targetDbSnapshotIdentifier))",message="spec.forProvider.targetDbSnapshotIdentifier is a required parameter"
	spec:    #DBSnapshotCopySpec   @go(Spec)
	status?: #DBSnapshotCopyStatus @go(Status)
}

// DBSnapshotCopyList contains a list of DBSnapshotCopys
#DBSnapshotCopyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#DBSnapshotCopy] @go(Items,[]DBSnapshotCopy)
}
