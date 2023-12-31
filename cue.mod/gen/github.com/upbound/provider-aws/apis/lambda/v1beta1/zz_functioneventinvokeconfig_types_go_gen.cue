// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/lambda/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DestinationConfigOnFailureInitParameters: {
}

#DestinationConfigOnFailureObservation: {
	// Amazon Resource Name (ARN) of the destination resource. See the Lambda Developer Guide for acceptable resource types and associated IAM permissions.
	destination?: null | string @go(Destination,*string)
}

#DestinationConfigOnFailureParameters: {
	// Amazon Resource Name (ARN) of the destination resource. See the Lambda Developer Guide for acceptable resource types and associated IAM permissions.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/sqs/v1beta1.Queue
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	destination?: null | string @go(Destination,*string)

	// Reference to a Queue in sqs to populate destination.
	// +kubebuilder:validation:Optional
	destinationRef?: null | v1.#Reference @go(DestinationRef,*v1.Reference)

	// Selector for a Queue in sqs to populate destination.
	// +kubebuilder:validation:Optional
	destinationSelector?: null | v1.#Selector @go(DestinationSelector,*v1.Selector)
}

#FunctionEventInvokeConfigDestinationConfigInitParameters: {
	// Configuration block with destination configuration for failed asynchronous invocations. See below for details.
	onFailure?: [...#DestinationConfigOnFailureInitParameters] @go(OnFailure,[]DestinationConfigOnFailureInitParameters)

	// Configuration block with destination configuration for successful asynchronous invocations. See below for details.
	onSuccess?: [...#OnSuccessInitParameters] @go(OnSuccess,[]OnSuccessInitParameters)
}

#FunctionEventInvokeConfigDestinationConfigObservation: {
	// Configuration block with destination configuration for failed asynchronous invocations. See below for details.
	onFailure?: [...#DestinationConfigOnFailureObservation] @go(OnFailure,[]DestinationConfigOnFailureObservation)

	// Configuration block with destination configuration for successful asynchronous invocations. See below for details.
	onSuccess?: [...#OnSuccessObservation] @go(OnSuccess,[]OnSuccessObservation)
}

#FunctionEventInvokeConfigDestinationConfigParameters: {
	// Configuration block with destination configuration for failed asynchronous invocations. See below for details.
	// +kubebuilder:validation:Optional
	onFailure?: [...#DestinationConfigOnFailureParameters] @go(OnFailure,[]DestinationConfigOnFailureParameters)

	// Configuration block with destination configuration for successful asynchronous invocations. See below for details.
	// +kubebuilder:validation:Optional
	onSuccess?: [...#OnSuccessParameters] @go(OnSuccess,[]OnSuccessParameters)
}

#FunctionEventInvokeConfigInitParameters: {
	// Configuration block with destination configuration. See below for details.
	destinationConfig?: [...#FunctionEventInvokeConfigDestinationConfigInitParameters] @go(DestinationConfig,[]FunctionEventInvokeConfigDestinationConfigInitParameters)

	// Name or Amazon Resource Name (ARN) of the Lambda Function, omitting any version or alias qualifier.
	functionName?: null | string @go(FunctionName,*string)

	// Maximum age of a request that Lambda sends to a function for processing in seconds. Valid values between 60 and 21600.
	maximumEventAgeInSeconds?: null | float64 @go(MaximumEventAgeInSeconds,*float64)

	// Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2.
	maximumRetryAttempts?: null | float64 @go(MaximumRetryAttempts,*float64)

	// Lambda Function published version, $LATEST, or Lambda Alias name.
	qualifier?: null | string @go(Qualifier,*string)
}

#FunctionEventInvokeConfigObservation: {
	// Configuration block with destination configuration. See below for details.
	destinationConfig?: [...#FunctionEventInvokeConfigDestinationConfigObservation] @go(DestinationConfig,[]FunctionEventInvokeConfigDestinationConfigObservation)

	// Name or Amazon Resource Name (ARN) of the Lambda Function, omitting any version or alias qualifier.
	functionName?: null | string @go(FunctionName,*string)

	// Fully qualified Lambda Function name or Amazon Resource Name (ARN)
	id?: null | string @go(ID,*string)

	// Maximum age of a request that Lambda sends to a function for processing in seconds. Valid values between 60 and 21600.
	maximumEventAgeInSeconds?: null | float64 @go(MaximumEventAgeInSeconds,*float64)

	// Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2.
	maximumRetryAttempts?: null | float64 @go(MaximumRetryAttempts,*float64)

	// Lambda Function published version, $LATEST, or Lambda Alias name.
	qualifier?: null | string @go(Qualifier,*string)
}

#FunctionEventInvokeConfigParameters: {
	// Configuration block with destination configuration. See below for details.
	// +kubebuilder:validation:Optional
	destinationConfig?: [...#FunctionEventInvokeConfigDestinationConfigParameters] @go(DestinationConfig,[]FunctionEventInvokeConfigDestinationConfigParameters)

	// Name or Amazon Resource Name (ARN) of the Lambda Function, omitting any version or alias qualifier.
	// +kubebuilder:validation:Optional
	functionName?: null | string @go(FunctionName,*string)

	// Maximum age of a request that Lambda sends to a function for processing in seconds. Valid values between 60 and 21600.
	// +kubebuilder:validation:Optional
	maximumEventAgeInSeconds?: null | float64 @go(MaximumEventAgeInSeconds,*float64)

	// Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2.
	// +kubebuilder:validation:Optional
	maximumRetryAttempts?: null | float64 @go(MaximumRetryAttempts,*float64)

	// Lambda Function published version, $LATEST, or Lambda Alias name.
	// +kubebuilder:validation:Optional
	qualifier?: null | string @go(Qualifier,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

#OnSuccessInitParameters: {
}

#OnSuccessObservation: {
	// Amazon Resource Name (ARN) of the destination resource. See the Lambda Developer Guide for acceptable resource types and associated IAM permissions.
	destination?: null | string @go(Destination,*string)
}

#OnSuccessParameters: {
	// Amazon Resource Name (ARN) of the destination resource. See the Lambda Developer Guide for acceptable resource types and associated IAM permissions.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/sns/v1beta1.Topic
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	destination?: null | string @go(Destination,*string)

	// Reference to a Topic in sns to populate destination.
	// +kubebuilder:validation:Optional
	destinationRef?: null | v1.#Reference @go(DestinationRef,*v1.Reference)

	// Selector for a Topic in sns to populate destination.
	// +kubebuilder:validation:Optional
	destinationSelector?: null | v1.#Selector @go(DestinationSelector,*v1.Selector)
}

// FunctionEventInvokeConfigSpec defines the desired state of FunctionEventInvokeConfig
#FunctionEventInvokeConfigSpec: {
	v1.#ResourceSpec
	forProvider: #FunctionEventInvokeConfigParameters @go(ForProvider)

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
	initProvider?: #FunctionEventInvokeConfigInitParameters @go(InitProvider)
}

// FunctionEventInvokeConfigStatus defines the observed state of FunctionEventInvokeConfig.
#FunctionEventInvokeConfigStatus: {
	v1.#ResourceStatus
	atProvider?: #FunctionEventInvokeConfigObservation @go(AtProvider)
}

// FunctionEventInvokeConfig is the Schema for the FunctionEventInvokeConfigs API. Manages an asynchronous invocation configuration for a Lambda Function or Alias.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#FunctionEventInvokeConfig: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.functionName) || (has(self.initProvider) && has(self.initProvider.functionName))",message="spec.forProvider.functionName is a required parameter"
	spec:    #FunctionEventInvokeConfigSpec   @go(Spec)
	status?: #FunctionEventInvokeConfigStatus @go(Status)
}

// FunctionEventInvokeConfigList contains a list of FunctionEventInvokeConfigs
#FunctionEventInvokeConfigList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#FunctionEventInvokeConfig] @go(Items,[]FunctionEventInvokeConfig)
}
