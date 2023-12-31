// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/appconfig/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ConfigurationProfileInitParameters: {
	// Description of the configuration profile. Can be at most 1024 characters.
	description?: null | string @go(Description,*string)

	// URI to locate the configuration. You can specify the AWS AppConfig hosted configuration store, Systems Manager (SSM) document, an SSM Parameter Store parameter, or an Amazon S3 object. For the hosted configuration store, specify hosted. For an SSM document, specify either the document name in the format ssm-document://<Document_name> or the ARN. For a parameter, specify either the parameter name in the format ssm-parameter://<Parameter_name> or the ARN. For an Amazon S3 object, specify the URI in the following format: s3://<bucket>/<objectKey>.
	locationUri?: null | string @go(LocationURI,*string)

	// Name for the configuration profile. Must be between 1 and 64 characters in length.
	name?: null | string @go(Name,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Type of configurations contained in the profile. Valid values: AWS.AppConfig.FeatureFlags and AWS.Freeform.  Default: AWS.Freeform.
	type?: null | string @go(Type,*string)

	// Set of methods for validating the configuration. Maximum of 2. See Validator below for more details.
	validator?: [...#ValidatorInitParameters] @go(Validator,[]ValidatorInitParameters)
}

#ConfigurationProfileObservation: {
	// Application ID. Must be between 4 and 7 characters in length.
	applicationId?: null | string @go(ApplicationID,*string)

	// ARN of the AppConfig Configuration Profile.
	arn?: null | string @go(Arn,*string)

	// The configuration profile ID.
	configurationProfileId?: null | string @go(ConfigurationProfileID,*string)

	// Description of the configuration profile. Can be at most 1024 characters.
	description?: null | string @go(Description,*string)

	// AppConfig configuration profile ID and application ID separated by a colon (:).
	id?: null | string @go(ID,*string)

	// URI to locate the configuration. You can specify the AWS AppConfig hosted configuration store, Systems Manager (SSM) document, an SSM Parameter Store parameter, or an Amazon S3 object. For the hosted configuration store, specify hosted. For an SSM document, specify either the document name in the format ssm-document://<Document_name> or the ARN. For a parameter, specify either the parameter name in the format ssm-parameter://<Parameter_name> or the ARN. For an Amazon S3 object, specify the URI in the following format: s3://<bucket>/<objectKey>.
	locationUri?: null | string @go(LocationURI,*string)

	// Name for the configuration profile. Must be between 1 and 64 characters in length.
	name?: null | string @go(Name,*string)

	// ARN of an IAM role with permission to access the configuration at the specified location_uri. A retrieval role ARN is not required for configurations stored in the AWS AppConfig hosted configuration store. It is required for all other sources that store your configuration.
	retrievalRoleArn?: null | string @go(RetrievalRoleArn,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Type of configurations contained in the profile. Valid values: AWS.AppConfig.FeatureFlags and AWS.Freeform.  Default: AWS.Freeform.
	type?: null | string @go(Type,*string)

	// Set of methods for validating the configuration. Maximum of 2. See Validator below for more details.
	validator?: [...#ValidatorObservation] @go(Validator,[]ValidatorObservation)
}

#ConfigurationProfileParameters: {
	// Application ID. Must be between 4 and 7 characters in length.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/appconfig/v1beta1.Application
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	applicationId?: null | string @go(ApplicationID,*string)

	// Reference to a Application in appconfig to populate applicationId.
	// +kubebuilder:validation:Optional
	applicationIdRef?: null | v1.#Reference @go(ApplicationIDRef,*v1.Reference)

	// Selector for a Application in appconfig to populate applicationId.
	// +kubebuilder:validation:Optional
	applicationIdSelector?: null | v1.#Selector @go(ApplicationIDSelector,*v1.Selector)

	// Description of the configuration profile. Can be at most 1024 characters.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// URI to locate the configuration. You can specify the AWS AppConfig hosted configuration store, Systems Manager (SSM) document, an SSM Parameter Store parameter, or an Amazon S3 object. For the hosted configuration store, specify hosted. For an SSM document, specify either the document name in the format ssm-document://<Document_name> or the ARN. For a parameter, specify either the parameter name in the format ssm-parameter://<Parameter_name> or the ARN. For an Amazon S3 object, specify the URI in the following format: s3://<bucket>/<objectKey>.
	// +kubebuilder:validation:Optional
	locationUri?: null | string @go(LocationURI,*string)

	// Name for the configuration profile. Must be between 1 and 64 characters in length.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// ARN of an IAM role with permission to access the configuration at the specified location_uri. A retrieval role ARN is not required for configurations stored in the AWS AppConfig hosted configuration store. It is required for all other sources that store your configuration.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	retrievalRoleArn?: null | string @go(RetrievalRoleArn,*string)

	// Reference to a Role in iam to populate retrievalRoleArn.
	// +kubebuilder:validation:Optional
	retrievalRoleArnRef?: null | v1.#Reference @go(RetrievalRoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate retrievalRoleArn.
	// +kubebuilder:validation:Optional
	retrievalRoleArnSelector?: null | v1.#Selector @go(RetrievalRoleArnSelector,*v1.Selector)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Type of configurations contained in the profile. Valid values: AWS.AppConfig.FeatureFlags and AWS.Freeform.  Default: AWS.Freeform.
	// +kubebuilder:validation:Optional
	type?: null | string @go(Type,*string)

	// Set of methods for validating the configuration. Maximum of 2. See Validator below for more details.
	// +kubebuilder:validation:Optional
	validator?: [...#ValidatorParameters] @go(Validator,[]ValidatorParameters)
}

#ValidatorInitParameters: {
	// Type of validator. Valid values: JSON_SCHEMA and LAMBDA.
	type?: null | string @go(Type,*string)
}

#ValidatorObservation: {
	// Type of validator. Valid values: JSON_SCHEMA and LAMBDA.
	type?: null | string @go(Type,*string)
}

#ValidatorParameters: {
	// Either the JSON Schema content or the ARN of an AWS Lambda function.
	// +kubebuilder:validation:Optional
	contentSecretRef?: null | v1.#SecretKeySelector @go(ContentSecretRef,*v1.SecretKeySelector)

	// Type of validator. Valid values: JSON_SCHEMA and LAMBDA.
	// +kubebuilder:validation:Optional
	type?: null | string @go(Type,*string)
}

// ConfigurationProfileSpec defines the desired state of ConfigurationProfile
#ConfigurationProfileSpec: {
	v1.#ResourceSpec
	forProvider: #ConfigurationProfileParameters @go(ForProvider)

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
	initProvider?: #ConfigurationProfileInitParameters @go(InitProvider)
}

// ConfigurationProfileStatus defines the observed state of ConfigurationProfile.
#ConfigurationProfileStatus: {
	v1.#ResourceStatus
	atProvider?: #ConfigurationProfileObservation @go(AtProvider)
}

// ConfigurationProfile is the Schema for the ConfigurationProfiles API. Provides an AppConfig Configuration Profile resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ConfigurationProfile: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.locationUri) || (has(self.initProvider) && has(self.initProvider.locationUri))",message="spec.forProvider.locationUri is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #ConfigurationProfileSpec   @go(Spec)
	status?: #ConfigurationProfileStatus @go(Status)
}

// ConfigurationProfileList contains a list of ConfigurationProfiles
#ConfigurationProfileList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ConfigurationProfile] @go(Items,[]ConfigurationProfile)
}
