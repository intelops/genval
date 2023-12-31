// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/glue/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#CloudwatchEncryptionInitParameters: {
	// Encryption mode to use for CloudWatch data. Valid values: DISABLED, SSE-KMS. Default value: DISABLED.
	cloudwatchEncryptionMode?: null | string @go(CloudwatchEncryptionMode,*string)
}

#CloudwatchEncryptionObservation: {
	// Encryption mode to use for CloudWatch data. Valid values: DISABLED, SSE-KMS. Default value: DISABLED.
	cloudwatchEncryptionMode?: null | string @go(CloudwatchEncryptionMode,*string)

	// Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)
}

#CloudwatchEncryptionParameters: {
	// Encryption mode to use for CloudWatch data. Valid values: DISABLED, SSE-KMS. Default value: DISABLED.
	// +kubebuilder:validation:Optional
	cloudwatchEncryptionMode?: null | string @go(CloudwatchEncryptionMode,*string)

	// Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)

	// Reference to a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnRef?: null | v1.#Reference @go(KMSKeyArnRef,*v1.Reference)

	// Selector for a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnSelector?: null | v1.#Selector @go(KMSKeyArnSelector,*v1.Selector)
}

#EncryptionConfigurationInitParameters: {
	cloudwatchEncryption?: [...#CloudwatchEncryptionInitParameters] @go(CloudwatchEncryption,[]CloudwatchEncryptionInitParameters)
	jobBookmarksEncryption?: [...#JobBookmarksEncryptionInitParameters] @go(JobBookmarksEncryption,[]JobBookmarksEncryptionInitParameters)

	// A s3_encryption  block as described below, which contains encryption configuration for S3 data.
	s3Encryption?: [...#S3EncryptionInitParameters] @go(S3Encryption,[]S3EncryptionInitParameters)
}

#EncryptionConfigurationObservation: {
	cloudwatchEncryption?: [...#CloudwatchEncryptionObservation] @go(CloudwatchEncryption,[]CloudwatchEncryptionObservation)
	jobBookmarksEncryption?: [...#JobBookmarksEncryptionObservation] @go(JobBookmarksEncryption,[]JobBookmarksEncryptionObservation)

	// A s3_encryption  block as described below, which contains encryption configuration for S3 data.
	s3Encryption?: [...#S3EncryptionObservation] @go(S3Encryption,[]S3EncryptionObservation)
}

#EncryptionConfigurationParameters: {
	// +kubebuilder:validation:Optional
	cloudwatchEncryption: [...#CloudwatchEncryptionParameters] @go(CloudwatchEncryption,[]CloudwatchEncryptionParameters)

	// +kubebuilder:validation:Optional
	jobBookmarksEncryption: [...#JobBookmarksEncryptionParameters] @go(JobBookmarksEncryption,[]JobBookmarksEncryptionParameters)

	// A s3_encryption  block as described below, which contains encryption configuration for S3 data.
	// +kubebuilder:validation:Optional
	s3Encryption: [...#S3EncryptionParameters] @go(S3Encryption,[]S3EncryptionParameters)
}

#JobBookmarksEncryptionInitParameters: {
	// Encryption mode to use for job bookmarks data. Valid values: CSE-KMS, DISABLED. Default value: DISABLED.
	jobBookmarksEncryptionMode?: null | string @go(JobBookmarksEncryptionMode,*string)
}

#JobBookmarksEncryptionObservation: {
	// Encryption mode to use for job bookmarks data. Valid values: CSE-KMS, DISABLED. Default value: DISABLED.
	jobBookmarksEncryptionMode?: null | string @go(JobBookmarksEncryptionMode,*string)

	// Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)
}

#JobBookmarksEncryptionParameters: {
	// Encryption mode to use for job bookmarks data. Valid values: CSE-KMS, DISABLED. Default value: DISABLED.
	// +kubebuilder:validation:Optional
	jobBookmarksEncryptionMode?: null | string @go(JobBookmarksEncryptionMode,*string)

	// Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)

	// Reference to a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnRef?: null | v1.#Reference @go(KMSKeyArnRef,*v1.Reference)

	// Selector for a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnSelector?: null | v1.#Selector @go(KMSKeyArnSelector,*v1.Selector)
}

#S3EncryptionInitParameters: {
	// Encryption mode to use for S3 data. Valid values: DISABLED, SSE-KMS, SSE-S3. Default value: DISABLED.
	s3EncryptionMode?: null | string @go(S3EncryptionMode,*string)
}

#S3EncryptionObservation: {
	// Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)

	// Encryption mode to use for S3 data. Valid values: DISABLED, SSE-KMS, SSE-S3. Default value: DISABLED.
	s3EncryptionMode?: null | string @go(S3EncryptionMode,*string)
}

#S3EncryptionParameters: {
	// Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)

	// Reference to a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnRef?: null | v1.#Reference @go(KMSKeyArnRef,*v1.Reference)

	// Selector for a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnSelector?: null | v1.#Selector @go(KMSKeyArnSelector,*v1.Selector)

	// Encryption mode to use for S3 data. Valid values: DISABLED, SSE-KMS, SSE-S3. Default value: DISABLED.
	// +kubebuilder:validation:Optional
	s3EncryptionMode?: null | string @go(S3EncryptionMode,*string)
}

#SecurityConfigurationInitParameters: {
	// –  Configuration block containing encryption configuration. Detailed below.
	encryptionConfiguration?: [...#EncryptionConfigurationInitParameters] @go(EncryptionConfiguration,[]EncryptionConfigurationInitParameters)
}

#SecurityConfigurationObservation: {
	// –  Configuration block containing encryption configuration. Detailed below.
	encryptionConfiguration?: [...#EncryptionConfigurationObservation] @go(EncryptionConfiguration,[]EncryptionConfigurationObservation)

	// Glue security configuration name
	id?: null | string @go(ID,*string)
}

#SecurityConfigurationParameters: {
	// –  Configuration block containing encryption configuration. Detailed below.
	// +kubebuilder:validation:Optional
	encryptionConfiguration?: [...#EncryptionConfigurationParameters] @go(EncryptionConfiguration,[]EncryptionConfigurationParameters)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// SecurityConfigurationSpec defines the desired state of SecurityConfiguration
#SecurityConfigurationSpec: {
	v1.#ResourceSpec
	forProvider: #SecurityConfigurationParameters @go(ForProvider)

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
	initProvider?: #SecurityConfigurationInitParameters @go(InitProvider)
}

// SecurityConfigurationStatus defines the observed state of SecurityConfiguration.
#SecurityConfigurationStatus: {
	v1.#ResourceStatus
	atProvider?: #SecurityConfigurationObservation @go(AtProvider)
}

// SecurityConfiguration is the Schema for the SecurityConfigurations API. Manages a Glue Security Configuration
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#SecurityConfiguration: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.encryptionConfiguration) || (has(self.initProvider) && has(self.initProvider.encryptionConfiguration))",message="spec.forProvider.encryptionConfiguration is a required parameter"
	spec:    #SecurityConfigurationSpec   @go(Spec)
	status?: #SecurityConfigurationStatus @go(Status)
}

// SecurityConfigurationList contains a list of SecurityConfigurations
#SecurityConfigurationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#SecurityConfiguration] @go(Items,[]SecurityConfiguration)
}
