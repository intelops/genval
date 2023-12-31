// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/fsx/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#BackupInitParameters: {
	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The ID of the volume to back up. Required if backing up a ONTAP Volume.
	volumeId?: null | string @go(VolumeID,*string)
}

#BackupObservation: {
	// Amazon Resource Name of the backup.
	arn?: null | string @go(Arn,*string)

	// The ID of the file system to back up. Required if backing up Lustre or Windows file systems.
	fileSystemId?: null | string @go(FileSystemID,*string)

	// Identifier of the backup, e.g., fs-12345678
	id?: null | string @go(ID,*string)

	// The ID of the AWS Key Management Service (AWS KMS) key used to encrypt the backup of the Amazon FSx file system's data at rest.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// AWS account identifier that created the file system.
	ownerId?: null | string @go(OwnerID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The type of the file system backup.
	type?: null | string @go(Type,*string)

	// The ID of the volume to back up. Required if backing up a ONTAP Volume.
	volumeId?: null | string @go(VolumeID,*string)
}

#BackupParameters: {
	// The ID of the file system to back up. Required if backing up Lustre or Windows file systems.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/fsx/v1beta1.LustreFileSystem
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	fileSystemId?: null | string @go(FileSystemID,*string)

	// Reference to a LustreFileSystem in fsx to populate fileSystemId.
	// +kubebuilder:validation:Optional
	fileSystemIdRef?: null | v1.#Reference @go(FileSystemIDRef,*v1.Reference)

	// Selector for a LustreFileSystem in fsx to populate fileSystemId.
	// +kubebuilder:validation:Optional
	fileSystemIdSelector?: null | v1.#Selector @go(FileSystemIDSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The ID of the volume to back up. Required if backing up a ONTAP Volume.
	// +kubebuilder:validation:Optional
	volumeId?: null | string @go(VolumeID,*string)
}

// BackupSpec defines the desired state of Backup
#BackupSpec: {
	v1.#ResourceSpec
	forProvider: #BackupParameters @go(ForProvider)

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
	initProvider?: #BackupInitParameters @go(InitProvider)
}

// BackupStatus defines the observed state of Backup.
#BackupStatus: {
	v1.#ResourceStatus
	atProvider?: #BackupObservation @go(AtProvider)
}

// Backup is the Schema for the Backups API. Manages a FSx Backup.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Backup: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #BackupSpec        @go(Spec)
	status?:   #BackupStatus      @go(Status)
}

// BackupList contains a list of Backups
#BackupList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Backup] @go(Items,[]Backup)
}
