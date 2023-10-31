// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sagemaker/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DeviceFleetInitParameters: {
	// A description of the fleet.
	description?: null | string @go(Description,*string)

	// Whether to create an AWS IoT Role Alias during device fleet creation. The name of the role alias generated will match this pattern: "SageMakerEdge-{DeviceFleetName}".
	enableIotRoleAlias?: null | bool @go(EnableIotRoleAlias,*bool)

	// Specifies details about the repository. see Output Config details below.
	outputConfig?: [...#OutputConfigInitParameters] @go(OutputConfig,[]OutputConfigInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#DeviceFleetObservation: {
	// The Amazon Resource Name (ARN) assigned by AWS to this Device Fleet.
	arn?: null | string @go(Arn,*string)

	// A description of the fleet.
	description?: null | string @go(Description,*string)

	// Whether to create an AWS IoT Role Alias during device fleet creation. The name of the role alias generated will match this pattern: "SageMakerEdge-{DeviceFleetName}".
	enableIotRoleAlias?: null | bool @go(EnableIotRoleAlias,*bool)

	// The name of the Device Fleet.
	id?:           null | string @go(ID,*string)
	iotRoleAlias?: null | string @go(IotRoleAlias,*string)

	// Specifies details about the repository. see Output Config details below.
	outputConfig?: [...#OutputConfigObservation] @go(OutputConfig,[]OutputConfigObservation)

	// The Amazon Resource Name (ARN) that has access to AWS Internet of Things (IoT).
	roleArn?: null | string @go(RoleArn,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#DeviceFleetParameters: {
	// A description of the fleet.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Whether to create an AWS IoT Role Alias during device fleet creation. The name of the role alias generated will match this pattern: "SageMakerEdge-{DeviceFleetName}".
	// +kubebuilder:validation:Optional
	enableIotRoleAlias?: null | bool @go(EnableIotRoleAlias,*bool)

	// Specifies details about the repository. see Output Config details below.
	// +kubebuilder:validation:Optional
	outputConfig?: [...#OutputConfigParameters] @go(OutputConfig,[]OutputConfigParameters)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The Amazon Resource Name (ARN) that has access to AWS Internet of Things (IoT).
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	roleArn?: null | string @go(RoleArn,*string)

	// Reference to a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnRef?: null | v1.#Reference @go(RoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnSelector?: null | v1.#Selector @go(RoleArnSelector,*v1.Selector)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#OutputConfigInitParameters: {
	// The AWS Key Management Service (AWS KMS) key that Amazon SageMaker uses to encrypt data on the storage volume after compilation job. If you don't provide a KMS key ID, Amazon SageMaker uses the default KMS key for Amazon S3 for your role's account.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// The Amazon Simple Storage (S3) bucker URI.
	s3OutputLocation?: null | string @go(S3OutputLocation,*string)
}

#OutputConfigObservation: {
	// The AWS Key Management Service (AWS KMS) key that Amazon SageMaker uses to encrypt data on the storage volume after compilation job. If you don't provide a KMS key ID, Amazon SageMaker uses the default KMS key for Amazon S3 for your role's account.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// The Amazon Simple Storage (S3) bucker URI.
	s3OutputLocation?: null | string @go(S3OutputLocation,*string)
}

#OutputConfigParameters: {
	// The AWS Key Management Service (AWS KMS) key that Amazon SageMaker uses to encrypt data on the storage volume after compilation job. If you don't provide a KMS key ID, Amazon SageMaker uses the default KMS key for Amazon S3 for your role's account.
	// +kubebuilder:validation:Optional
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// The Amazon Simple Storage (S3) bucker URI.
	// +kubebuilder:validation:Optional
	s3OutputLocation?: null | string @go(S3OutputLocation,*string)
}

// DeviceFleetSpec defines the desired state of DeviceFleet
#DeviceFleetSpec: {
	v1.#ResourceSpec
	forProvider: #DeviceFleetParameters @go(ForProvider)

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
	initProvider?: #DeviceFleetInitParameters @go(InitProvider)
}

// DeviceFleetStatus defines the observed state of DeviceFleet.
#DeviceFleetStatus: {
	v1.#ResourceStatus
	atProvider?: #DeviceFleetObservation @go(AtProvider)
}

// DeviceFleet is the Schema for the DeviceFleets API. Provides a SageMaker Device Fleet resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws},path=devicefleet
#DeviceFleet: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.outputConfig) || (has(self.initProvider) && has(self.initProvider.outputConfig))",message="spec.forProvider.outputConfig is a required parameter"
	spec:    #DeviceFleetSpec   @go(Spec)
	status?: #DeviceFleetStatus @go(Status)
}

// DeviceFleetList contains a list of DeviceFleets
#DeviceFleetList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#DeviceFleet] @go(Items,[]DeviceFleet)
}
