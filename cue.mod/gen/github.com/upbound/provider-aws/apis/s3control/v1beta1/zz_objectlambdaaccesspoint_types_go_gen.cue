// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/s3control/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AwsLambdaInitParameters: {
	// Additional JSON that provides supplemental data to the Lambda function used to transform objects.
	functionPayload?: null | string @go(FunctionPayload,*string)
}

#AwsLambdaObservation: {
	// The Amazon Resource Name (ARN) of the AWS Lambda function.
	functionArn?: null | string @go(FunctionArn,*string)

	// Additional JSON that provides supplemental data to the Lambda function used to transform objects.
	functionPayload?: null | string @go(FunctionPayload,*string)
}

#AwsLambdaParameters: {
	// The Amazon Resource Name (ARN) of the AWS Lambda function.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/lambda/v1beta1.Function
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	functionArn?: null | string @go(FunctionArn,*string)

	// Reference to a Function in lambda to populate functionArn.
	// +kubebuilder:validation:Optional
	functionArnRef?: null | v1.#Reference @go(FunctionArnRef,*v1.Reference)

	// Selector for a Function in lambda to populate functionArn.
	// +kubebuilder:validation:Optional
	functionArnSelector?: null | v1.#Selector @go(FunctionArnSelector,*v1.Selector)

	// Additional JSON that provides supplemental data to the Lambda function used to transform objects.
	// +kubebuilder:validation:Optional
	functionPayload?: null | string @go(FunctionPayload,*string)
}

#ConfigurationInitParameters: {
	// Allowed features. Valid values: GetObject-Range, GetObject-PartNumber.
	allowedFeatures?: [...null | string] @go(AllowedFeatures,[]*string)

	// Whether or not the CloudWatch metrics configuration is enabled.
	cloudWatchMetricsEnabled?: null | bool @go(CloudWatchMetricsEnabled,*bool)

	// List of transformation configurations for the Object Lambda Access Point. See Transformation Configuration below for more details.
	transformationConfiguration?: [...#TransformationConfigurationInitParameters] @go(TransformationConfiguration,[]TransformationConfigurationInitParameters)
}

#ConfigurationObservation: {
	// Allowed features. Valid values: GetObject-Range, GetObject-PartNumber.
	allowedFeatures?: [...null | string] @go(AllowedFeatures,[]*string)

	// Whether or not the CloudWatch metrics configuration is enabled.
	cloudWatchMetricsEnabled?: null | bool @go(CloudWatchMetricsEnabled,*bool)

	// Standard access point associated with the Object Lambda Access Point.
	supportingAccessPoint?: null | string @go(SupportingAccessPoint,*string)

	// List of transformation configurations for the Object Lambda Access Point. See Transformation Configuration below for more details.
	transformationConfiguration?: [...#TransformationConfigurationObservation] @go(TransformationConfiguration,[]TransformationConfigurationObservation)
}

#ConfigurationParameters: {
	// Allowed features. Valid values: GetObject-Range, GetObject-PartNumber.
	// +kubebuilder:validation:Optional
	allowedFeatures?: [...null | string] @go(AllowedFeatures,[]*string)

	// Whether or not the CloudWatch metrics configuration is enabled.
	// +kubebuilder:validation:Optional
	cloudWatchMetricsEnabled?: null | bool @go(CloudWatchMetricsEnabled,*bool)

	// Standard access point associated with the Object Lambda Access Point.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/s3control/v1beta1.AccessPoint
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	supportingAccessPoint?: null | string @go(SupportingAccessPoint,*string)

	// Reference to a AccessPoint in s3control to populate supportingAccessPoint.
	// +kubebuilder:validation:Optional
	supportingAccessPointRef?: null | v1.#Reference @go(SupportingAccessPointRef,*v1.Reference)

	// Selector for a AccessPoint in s3control to populate supportingAccessPoint.
	// +kubebuilder:validation:Optional
	supportingAccessPointSelector?: null | v1.#Selector @go(SupportingAccessPointSelector,*v1.Selector)

	// List of transformation configurations for the Object Lambda Access Point. See Transformation Configuration below for more details.
	// +kubebuilder:validation:Optional
	transformationConfiguration: [...#TransformationConfigurationParameters] @go(TransformationConfiguration,[]TransformationConfigurationParameters)
}

#ContentTransformationInitParameters: {
	// Configuration for an AWS Lambda function. See AWS Lambda below for more details.
	awsLambda?: [...#AwsLambdaInitParameters] @go(AwsLambda,[]AwsLambdaInitParameters)
}

#ContentTransformationObservation: {
	// Configuration for an AWS Lambda function. See AWS Lambda below for more details.
	awsLambda?: [...#AwsLambdaObservation] @go(AwsLambda,[]AwsLambdaObservation)
}

#ContentTransformationParameters: {
	// Configuration for an AWS Lambda function. See AWS Lambda below for more details.
	// +kubebuilder:validation:Optional
	awsLambda: [...#AwsLambdaParameters] @go(AwsLambda,[]AwsLambdaParameters)
}

#ObjectLambdaAccessPointInitParameters: {
	// The AWS account ID for the owner of the bucket for which you want to create an Object Lambda Access Point.
	accountId?: null | string @go(AccountID,*string)

	// A configuration block containing details about the Object Lambda Access Point. See Configuration below for more details.
	configuration?: [...#ConfigurationInitParameters] @go(Configuration,[]ConfigurationInitParameters)

	// The name for this Object Lambda Access Point.
	name?: null | string @go(Name,*string)
}

#ObjectLambdaAccessPointObservation: {
	// The AWS account ID for the owner of the bucket for which you want to create an Object Lambda Access Point.
	accountId?: null | string @go(AccountID,*string)

	// Amazon Resource Name (ARN) of the Object Lambda Access Point.
	arn?: null | string @go(Arn,*string)

	// A configuration block containing details about the Object Lambda Access Point. See Configuration below for more details.
	configuration?: [...#ConfigurationObservation] @go(Configuration,[]ConfigurationObservation)

	// The AWS account ID and access point name separated by a colon (:).
	id?: null | string @go(ID,*string)

	// The name for this Object Lambda Access Point.
	name?: null | string @go(Name,*string)
}

#ObjectLambdaAccessPointParameters: {
	// The AWS account ID for the owner of the bucket for which you want to create an Object Lambda Access Point.
	// +kubebuilder:validation:Optional
	accountId?: null | string @go(AccountID,*string)

	// A configuration block containing details about the Object Lambda Access Point. See Configuration below for more details.
	// +kubebuilder:validation:Optional
	configuration?: [...#ConfigurationParameters] @go(Configuration,[]ConfigurationParameters)

	// The name for this Object Lambda Access Point.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

#TransformationConfigurationInitParameters: {
	// The actions of an Object Lambda Access Point configuration. Valid values: GetObject.
	actions?: [...null | string] @go(Actions,[]*string)

	// The content transformation of an Object Lambda Access Point configuration. See Content Transformation below for more details.
	contentTransformation?: [...#ContentTransformationInitParameters] @go(ContentTransformation,[]ContentTransformationInitParameters)
}

#TransformationConfigurationObservation: {
	// The actions of an Object Lambda Access Point configuration. Valid values: GetObject.
	actions?: [...null | string] @go(Actions,[]*string)

	// The content transformation of an Object Lambda Access Point configuration. See Content Transformation below for more details.
	contentTransformation?: [...#ContentTransformationObservation] @go(ContentTransformation,[]ContentTransformationObservation)
}

#TransformationConfigurationParameters: {
	// The actions of an Object Lambda Access Point configuration. Valid values: GetObject.
	// +kubebuilder:validation:Optional
	actions: [...null | string] @go(Actions,[]*string)

	// The content transformation of an Object Lambda Access Point configuration. See Content Transformation below for more details.
	// +kubebuilder:validation:Optional
	contentTransformation: [...#ContentTransformationParameters] @go(ContentTransformation,[]ContentTransformationParameters)
}

// ObjectLambdaAccessPointSpec defines the desired state of ObjectLambdaAccessPoint
#ObjectLambdaAccessPointSpec: {
	v1.#ResourceSpec
	forProvider: #ObjectLambdaAccessPointParameters @go(ForProvider)

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
	initProvider?: #ObjectLambdaAccessPointInitParameters @go(InitProvider)
}

// ObjectLambdaAccessPointStatus defines the observed state of ObjectLambdaAccessPoint.
#ObjectLambdaAccessPointStatus: {
	v1.#ResourceStatus
	atProvider?: #ObjectLambdaAccessPointObservation @go(AtProvider)
}

// ObjectLambdaAccessPoint is the Schema for the ObjectLambdaAccessPoints API. Provides a resource to manage an S3 Object Lambda Access Point.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ObjectLambdaAccessPoint: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.configuration) || (has(self.initProvider) && has(self.initProvider.configuration))",message="spec.forProvider.configuration is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #ObjectLambdaAccessPointSpec   @go(Spec)
	status?: #ObjectLambdaAccessPointStatus @go(Status)
}

// ObjectLambdaAccessPointList contains a list of ObjectLambdaAccessPoints
#ObjectLambdaAccessPointList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ObjectLambdaAccessPoint] @go(Items,[]ObjectLambdaAccessPoint)
}
