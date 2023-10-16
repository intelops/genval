// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/lambda/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#LayerVersionInitParameters: {
	// List of Architectures this layer is compatible with. Currently x86_64 and arm64 can be specified.
	compatibleArchitectures?: [...null | string] @go(CompatibleArchitectures,[]*string)

	// List of Runtimes this layer is compatible with. Up to 5 runtimes can be specified.
	compatibleRuntimes?: [...null | string] @go(CompatibleRuntimes,[]*string)

	// Description of what your Lambda Layer does.
	description?: null | string @go(Description,*string)

	// prefixed options cannot be used.
	filename?: null | string @go(Filename,*string)

	// Unique name for your Lambda Layer
	layerName?: null | string @go(LayerName,*string)

	// License info for your Lambda Layer. See License Info.
	licenseInfo?: null | string @go(LicenseInfo,*string)

	// S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function.
	s3Bucket?: null | string @go(S3Bucket,*string)

	// S3 key of an object containing the function's deployment package. Conflicts with filename.
	s3Key?: null | string @go(S3Key,*string)

	// Object version containing the function's deployment package. Conflicts with filename.
	s3ObjectVersion?: null | string @go(S3ObjectVersion,*string)

	// Whether to retain the old version of a previously deployed Lambda Layer. Default is false. When this is not set to true, changing any of compatible_architectures, compatible_runtimes, description, filename, layer_name, license_info, s3_bucket, s3_key, s3_object_version, or source_code_hash forces deletion of the existing layer version and creation of a new layer version.
	skipDestroy?: null | bool @go(SkipDestroy,*bool)

	// Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is ${filebase64sha256("file.11.12 or later) or ${base64sha256(file("file.11.11 and earlier), where "file.zip" is the local filename of the lambda layer source archive.
	sourceCodeHash?: null | string @go(SourceCodeHash,*string)
}

#LayerVersionObservation: {
	// ARN of the Lambda Layer with version.
	arn?: null | string @go(Arn,*string)

	// List of Architectures this layer is compatible with. Currently x86_64 and arm64 can be specified.
	compatibleArchitectures?: [...null | string] @go(CompatibleArchitectures,[]*string)

	// List of Runtimes this layer is compatible with. Up to 5 runtimes can be specified.
	compatibleRuntimes?: [...null | string] @go(CompatibleRuntimes,[]*string)

	// Date this resource was created.
	createdDate?: null | string @go(CreatedDate,*string)

	// Description of what your Lambda Layer does.
	description?: null | string @go(Description,*string)

	// prefixed options cannot be used.
	filename?: null | string @go(Filename,*string)
	id?:       null | string @go(ID,*string)

	// ARN of the Lambda Layer without version.
	layerArn?: null | string @go(LayerArn,*string)

	// Unique name for your Lambda Layer
	layerName?: null | string @go(LayerName,*string)

	// License info for your Lambda Layer. See License Info.
	licenseInfo?: null | string @go(LicenseInfo,*string)

	// S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function.
	s3Bucket?: null | string @go(S3Bucket,*string)

	// S3 key of an object containing the function's deployment package. Conflicts with filename.
	s3Key?: null | string @go(S3Key,*string)

	// Object version containing the function's deployment package. Conflicts with filename.
	s3ObjectVersion?: null | string @go(S3ObjectVersion,*string)

	// ARN of a signing job.
	signingJobArn?: null | string @go(SigningJobArn,*string)

	// ARN for a signing profile version.
	signingProfileVersionArn?: null | string @go(SigningProfileVersionArn,*string)

	// Whether to retain the old version of a previously deployed Lambda Layer. Default is false. When this is not set to true, changing any of compatible_architectures, compatible_runtimes, description, filename, layer_name, license_info, s3_bucket, s3_key, s3_object_version, or source_code_hash forces deletion of the existing layer version and creation of a new layer version.
	skipDestroy?: null | bool @go(SkipDestroy,*bool)

	// Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is ${filebase64sha256("file.11.12 or later) or ${base64sha256(file("file.11.11 and earlier), where "file.zip" is the local filename of the lambda layer source archive.
	sourceCodeHash?: null | string @go(SourceCodeHash,*string)

	// Size in bytes of the function .zip file.
	sourceCodeSize?: null | float64 @go(SourceCodeSize,*float64)

	// Lambda Layer version.
	version?: null | string @go(Version,*string)
}

#LayerVersionParameters: {
	// List of Architectures this layer is compatible with. Currently x86_64 and arm64 can be specified.
	// +kubebuilder:validation:Optional
	compatibleArchitectures?: [...null | string] @go(CompatibleArchitectures,[]*string)

	// List of Runtimes this layer is compatible with. Up to 5 runtimes can be specified.
	// +kubebuilder:validation:Optional
	compatibleRuntimes?: [...null | string] @go(CompatibleRuntimes,[]*string)

	// Description of what your Lambda Layer does.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// prefixed options cannot be used.
	// +kubebuilder:validation:Optional
	filename?: null | string @go(Filename,*string)

	// Unique name for your Lambda Layer
	// +kubebuilder:validation:Optional
	layerName?: null | string @go(LayerName,*string)

	// License info for your Lambda Layer. See License Info.
	// +kubebuilder:validation:Optional
	licenseInfo?: null | string @go(LicenseInfo,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function.
	// +kubebuilder:validation:Optional
	s3Bucket?: null | string @go(S3Bucket,*string)

	// S3 key of an object containing the function's deployment package. Conflicts with filename.
	// +kubebuilder:validation:Optional
	s3Key?: null | string @go(S3Key,*string)

	// Object version containing the function's deployment package. Conflicts with filename.
	// +kubebuilder:validation:Optional
	s3ObjectVersion?: null | string @go(S3ObjectVersion,*string)

	// Whether to retain the old version of a previously deployed Lambda Layer. Default is false. When this is not set to true, changing any of compatible_architectures, compatible_runtimes, description, filename, layer_name, license_info, s3_bucket, s3_key, s3_object_version, or source_code_hash forces deletion of the existing layer version and creation of a new layer version.
	// +kubebuilder:validation:Optional
	skipDestroy?: null | bool @go(SkipDestroy,*bool)

	// Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is ${filebase64sha256("file.11.12 or later) or ${base64sha256(file("file.11.11 and earlier), where "file.zip" is the local filename of the lambda layer source archive.
	// +kubebuilder:validation:Optional
	sourceCodeHash?: null | string @go(SourceCodeHash,*string)
}

// LayerVersionSpec defines the desired state of LayerVersion
#LayerVersionSpec: {
	v1.#ResourceSpec
	forProvider: #LayerVersionParameters @go(ForProvider)

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
	initProvider?: #LayerVersionInitParameters @go(InitProvider)
}

// LayerVersionStatus defines the observed state of LayerVersion.
#LayerVersionStatus: {
	v1.#ResourceStatus
	atProvider?: #LayerVersionObservation @go(AtProvider)
}

// LayerVersion is the Schema for the LayerVersions API. Provides a Lambda Layer Version resource. Lambda Layers allow you to reuse shared bits of code across multiple lambda functions.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#LayerVersion: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.layerName) || (has(self.initProvider) && has(self.initProvider.layerName))",message="spec.forProvider.layerName is a required parameter"
	spec:    #LayerVersionSpec   @go(Spec)
	status?: #LayerVersionStatus @go(Status)
}

// LayerVersionList contains a list of LayerVersions
#LayerVersionList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#LayerVersion] @go(Items,[]LayerVersion)
}
