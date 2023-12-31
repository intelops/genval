// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/efs/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DestinationInitParameters: {
	// The availability zone in which the replica should be created. If specified, the replica will be created with One Zone storage. If omitted, regional storage will be used.
	availabilityZoneName?: null | string @go(AvailabilityZoneName,*string)

	// The Key ID, ARN, alias, or alias ARN of the KMS key that should be used to encrypt the replica file system. If omitted, the default KMS key for EFS /aws/elasticfilesystem will be used.
	kmsKeyId?: null | string @go(KMSKeyID,*string)
}

#DestinationObservation: {
	// The availability zone in which the replica should be created. If specified, the replica will be created with One Zone storage. If omitted, regional storage will be used.
	availabilityZoneName?: null | string @go(AvailabilityZoneName,*string)

	// The fs ID of the replica.
	fileSystemId?: null | string @go(FileSystemID,*string)

	// The Key ID, ARN, alias, or alias ARN of the KMS key that should be used to encrypt the replica file system. If omitted, the default KMS key for EFS /aws/elasticfilesystem will be used.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// The region in which the replica should be created.
	region?: null | string @go(Region,*string)

	// The status of the replication.
	status?: null | string @go(Status,*string)
}

#DestinationParameters: {
	// The availability zone in which the replica should be created. If specified, the replica will be created with One Zone storage. If omitted, regional storage will be used.
	// +kubebuilder:validation:Optional
	availabilityZoneName?: null | string @go(AvailabilityZoneName,*string)

	// The Key ID, ARN, alias, or alias ARN of the KMS key that should be used to encrypt the replica file system. If omitted, the default KMS key for EFS /aws/elasticfilesystem will be used.
	// +kubebuilder:validation:Optional
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// The region in which the replica should be created.
	// +kubebuilder:validation:Optional
	region?: null | string @go(Region,*string)
}

#ReplicationConfigurationInitParameters: {
	// A destination configuration block (documented below).
	destination?: [...#DestinationInitParameters] @go(Destination,[]DestinationInitParameters)
}

#ReplicationConfigurationObservation: {
	// When the replication configuration was created.
	creationTime?: null | string @go(CreationTime,*string)

	// A destination configuration block (documented below).
	destination?: [...#DestinationObservation] @go(Destination,[]DestinationObservation)
	id?: null | string @go(ID,*string)

	// The Amazon Resource Name (ARN) of the original source Amazon EFS file system in the replication configuration.
	originalSourceFileSystemArn?: null | string @go(OriginalSourceFileSystemArn,*string)

	// The Amazon Resource Name (ARN) of the current source file system in the replication configuration.
	sourceFileSystemArn?: null | string @go(SourceFileSystemArn,*string)

	// The ID of the file system that is to be replicated.
	sourceFileSystemId?: null | string @go(SourceFileSystemID,*string)

	// The AWS Region in which the source Amazon EFS file system is located.
	sourceFileSystemRegion?: null | string @go(SourceFileSystemRegion,*string)
}

#ReplicationConfigurationParameters: {
	// A destination configuration block (documented below).
	// +kubebuilder:validation:Optional
	destination?: [...#DestinationParameters] @go(Destination,[]DestinationParameters)

	// The region in which the replica should be created.
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The ID of the file system that is to be replicated.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/efs/v1beta1.FileSystem
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	sourceFileSystemId?: null | string @go(SourceFileSystemID,*string)

	// Reference to a FileSystem in efs to populate sourceFileSystemId.
	// +kubebuilder:validation:Optional
	sourceFileSystemIdRef?: null | v1.#Reference @go(SourceFileSystemIDRef,*v1.Reference)

	// Selector for a FileSystem in efs to populate sourceFileSystemId.
	// +kubebuilder:validation:Optional
	sourceFileSystemIdSelector?: null | v1.#Selector @go(SourceFileSystemIDSelector,*v1.Selector)
}

// ReplicationConfigurationSpec defines the desired state of ReplicationConfiguration
#ReplicationConfigurationSpec: {
	v1.#ResourceSpec
	forProvider: #ReplicationConfigurationParameters @go(ForProvider)

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
	initProvider?: #ReplicationConfigurationInitParameters @go(InitProvider)
}

// ReplicationConfigurationStatus defines the observed state of ReplicationConfiguration.
#ReplicationConfigurationStatus: {
	v1.#ResourceStatus
	atProvider?: #ReplicationConfigurationObservation @go(AtProvider)
}

// ReplicationConfiguration is the Schema for the ReplicationConfigurations API. Provides an Elastic File System (EFS) Replication Configuration.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ReplicationConfiguration: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.destination) || (has(self.initProvider) && has(self.initProvider.destination))",message="spec.forProvider.destination is a required parameter"
	spec:    #ReplicationConfigurationSpec   @go(Spec)
	status?: #ReplicationConfigurationStatus @go(Status)
}

// ReplicationConfigurationList contains a list of ReplicationConfigurations
#ReplicationConfigurationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ReplicationConfiguration] @go(Items,[]ReplicationConfiguration)
}
