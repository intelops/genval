// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/transcribe/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#InputDataConfigInitParameters: {
	// S3 URI where training data is located.
	s3Uri?: null | string @go(S3URI,*string)

	// S3 URI where tuning data is located.
	tuningDataS3Uri?: null | string @go(TuningDataS3URI,*string)
}

#InputDataConfigObservation: {
	// IAM role with access to S3 bucket.
	dataAccessRoleArn?: null | string @go(DataAccessRoleArn,*string)

	// S3 URI where training data is located.
	s3Uri?: null | string @go(S3URI,*string)

	// S3 URI where tuning data is located.
	tuningDataS3Uri?: null | string @go(TuningDataS3URI,*string)
}

#InputDataConfigParameters: {
	// IAM role with access to S3 bucket.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	dataAccessRoleArn?: null | string @go(DataAccessRoleArn,*string)

	// Reference to a Role in iam to populate dataAccessRoleArn.
	// +kubebuilder:validation:Optional
	dataAccessRoleArnRef?: null | v1.#Reference @go(DataAccessRoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate dataAccessRoleArn.
	// +kubebuilder:validation:Optional
	dataAccessRoleArnSelector?: null | v1.#Selector @go(DataAccessRoleArnSelector,*v1.Selector)

	// S3 URI where training data is located.
	// +kubebuilder:validation:Optional
	s3Uri?: null | string @go(S3URI,*string)

	// S3 URI where tuning data is located.
	// +kubebuilder:validation:Optional
	tuningDataS3Uri?: null | string @go(TuningDataS3URI,*string)
}

#LanguageModelInitParameters: {
	// Name of reference base model.
	baseModelName?: null | string @go(BaseModelName,*string)

	// The input data config for the LanguageModel. See Input Data Config for more details.
	inputDataConfig?: [...#InputDataConfigInitParameters] @go(InputDataConfig,[]InputDataConfigInitParameters)

	// The language code you selected for your language model. Refer to the supported languages page for accepted codes.
	languageCode?: null | string @go(LanguageCode,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#LanguageModelObservation: {
	// ARN of the LanguageModel.
	arn?: null | string @go(Arn,*string)

	// Name of reference base model.
	baseModelName?: null | string @go(BaseModelName,*string)

	// LanguageModel name.
	id?: null | string @go(ID,*string)

	// The input data config for the LanguageModel. See Input Data Config for more details.
	inputDataConfig?: [...#InputDataConfigObservation] @go(InputDataConfig,[]InputDataConfigObservation)

	// The language code you selected for your language model. Refer to the supported languages page for accepted codes.
	languageCode?: null | string @go(LanguageCode,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#LanguageModelParameters: {
	// Name of reference base model.
	// +kubebuilder:validation:Optional
	baseModelName?: null | string @go(BaseModelName,*string)

	// The input data config for the LanguageModel. See Input Data Config for more details.
	// +kubebuilder:validation:Optional
	inputDataConfig?: [...#InputDataConfigParameters] @go(InputDataConfig,[]InputDataConfigParameters)

	// The language code you selected for your language model. Refer to the supported languages page for accepted codes.
	// +kubebuilder:validation:Optional
	languageCode?: null | string @go(LanguageCode,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// LanguageModelSpec defines the desired state of LanguageModel
#LanguageModelSpec: {
	v1.#ResourceSpec
	forProvider: #LanguageModelParameters @go(ForProvider)

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
	initProvider?: #LanguageModelInitParameters @go(InitProvider)
}

// LanguageModelStatus defines the observed state of LanguageModel.
#LanguageModelStatus: {
	v1.#ResourceStatus
	atProvider?: #LanguageModelObservation @go(AtProvider)
}

// LanguageModel is the Schema for the LanguageModels API.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#LanguageModel: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.baseModelName) || (has(self.initProvider) && has(self.initProvider.baseModelName))",message="spec.forProvider.baseModelName is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.inputDataConfig) || (has(self.initProvider) && has(self.initProvider.inputDataConfig))",message="spec.forProvider.inputDataConfig is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.languageCode) || (has(self.initProvider) && has(self.initProvider.languageCode))",message="spec.forProvider.languageCode is a required parameter"
	spec:    #LanguageModelSpec   @go(Spec)
	status?: #LanguageModelStatus @go(Status)
}

// LanguageModelList contains a list of LanguageModels
#LanguageModelList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#LanguageModel] @go(Items,[]LanguageModel)
}
