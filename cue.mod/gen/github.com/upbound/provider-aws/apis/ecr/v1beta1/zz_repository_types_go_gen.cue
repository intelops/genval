// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ecr/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#EncryptionConfigurationInitParameters: {
	// The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256.
	encryptionType?: null | string @go(EncryptionType,*string)
}

#EncryptionConfigurationObservation: {
	// The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256.
	encryptionType?: null | string @go(EncryptionType,*string)

	// The ARN of the KMS key to use when encryption_type is KMS. If not specified, uses the default AWS managed key for ECR.
	kmsKey?: null | string @go(KMSKey,*string)
}

#EncryptionConfigurationParameters: {
	// The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256.
	// +kubebuilder:validation:Optional
	encryptionType?: null | string @go(EncryptionType,*string)

	// The ARN of the KMS key to use when encryption_type is KMS. If not specified, uses the default AWS managed key for ECR.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	kmsKey?: null | string @go(KMSKey,*string)

	// Reference to a Key in kms to populate kmsKey.
	// +kubebuilder:validation:Optional
	kmsKeyRef?: null | v1.#Reference @go(KMSKeyRef,*v1.Reference)

	// Selector for a Key in kms to populate kmsKey.
	// +kubebuilder:validation:Optional
	kmsKeySelector?: null | v1.#Selector @go(KMSKeySelector,*v1.Selector)
}

#ImageScanningConfigurationInitParameters: {
	// Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false).
	scanOnPush?: null | bool @go(ScanOnPush,*bool)
}

#ImageScanningConfigurationObservation: {
	// Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false).
	scanOnPush?: null | bool @go(ScanOnPush,*bool)
}

#ImageScanningConfigurationParameters: {
	// Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false).
	// +kubebuilder:validation:Optional
	scanOnPush?: null | bool @go(ScanOnPush,*bool)
}

#RepositoryInitParameters: {
	// Encryption configuration for the repository. See below for schema.
	encryptionConfiguration?: [...#EncryptionConfigurationInitParameters] @go(EncryptionConfiguration,[]EncryptionConfigurationInitParameters)

	// If true, will delete the repository even if it contains images.
	// Defaults to false.
	forceDelete?: null | bool @go(ForceDelete,*bool)

	// Configuration block that defines image scanning configuration for the repository. By default, image scanning must be manually triggered. See the ECR User Guide for more information about image scanning.
	imageScanningConfiguration?: [...#ImageScanningConfigurationInitParameters] @go(ImageScanningConfiguration,[]ImageScanningConfigurationInitParameters)

	// The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE.
	imageTagMutability?: null | string @go(ImageTagMutability,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RepositoryObservation: {
	// Full ARN of the repository.
	arn?: null | string @go(Arn,*string)

	// Encryption configuration for the repository. See below for schema.
	encryptionConfiguration?: [...#EncryptionConfigurationObservation] @go(EncryptionConfiguration,[]EncryptionConfigurationObservation)

	// If true, will delete the repository even if it contains images.
	// Defaults to false.
	forceDelete?: null | bool   @go(ForceDelete,*bool)
	id?:          null | string @go(ID,*string)

	// Configuration block that defines image scanning configuration for the repository. By default, image scanning must be manually triggered. See the ECR User Guide for more information about image scanning.
	imageScanningConfiguration?: [...#ImageScanningConfigurationObservation] @go(ImageScanningConfiguration,[]ImageScanningConfigurationObservation)

	// The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE.
	imageTagMutability?: null | string @go(ImageTagMutability,*string)

	// The registry ID where the repository was created.
	registryId?: null | string @go(RegistryID,*string)

	// The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName).
	repositoryUrl?: null | string @go(RepositoryURL,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#RepositoryParameters: {
	// Encryption configuration for the repository. See below for schema.
	// +kubebuilder:validation:Optional
	encryptionConfiguration?: [...#EncryptionConfigurationParameters] @go(EncryptionConfiguration,[]EncryptionConfigurationParameters)

	// If true, will delete the repository even if it contains images.
	// Defaults to false.
	// +kubebuilder:validation:Optional
	forceDelete?: null | bool @go(ForceDelete,*bool)

	// Configuration block that defines image scanning configuration for the repository. By default, image scanning must be manually triggered. See the ECR User Guide for more information about image scanning.
	// +kubebuilder:validation:Optional
	imageScanningConfiguration?: [...#ImageScanningConfigurationParameters] @go(ImageScanningConfiguration,[]ImageScanningConfigurationParameters)

	// The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE.
	// +kubebuilder:validation:Optional
	imageTagMutability?: null | string @go(ImageTagMutability,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// RepositorySpec defines the desired state of Repository
#RepositorySpec: {
	v1.#ResourceSpec
	forProvider: #RepositoryParameters @go(ForProvider)

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
	initProvider?: #RepositoryInitParameters @go(InitProvider)
}

// RepositoryStatus defines the observed state of Repository.
#RepositoryStatus: {
	v1.#ResourceStatus
	atProvider?: #RepositoryObservation @go(AtProvider)
}

// Repository is the Schema for the Repositorys API. Provides an Elastic Container Registry Repository.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Repository: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #RepositorySpec    @go(Spec)
	status?:   #RepositoryStatus  @go(Status)
}

// RepositoryList contains a list of Repositorys
#RepositoryList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Repository] @go(Items,[]Repository)
}
