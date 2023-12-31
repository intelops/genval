// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/apigateway/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AccessLogSettingsInitParameters: {
	// ARN of the CloudWatch Logs log group or Kinesis Data Firehose delivery stream to receive access logs. If you specify a Kinesis Data Firehose delivery stream, the stream name must begin with amazon-apigateway-. Automatically removes trailing :* if present.
	destinationArn?: null | string @go(DestinationArn,*string)

	// Formatting and values recorded in the logs.
	// For more information on configuring the log format rules visit the AWS documentation
	format?: null | string @go(Format,*string)
}

#AccessLogSettingsObservation: {
	// ARN of the CloudWatch Logs log group or Kinesis Data Firehose delivery stream to receive access logs. If you specify a Kinesis Data Firehose delivery stream, the stream name must begin with amazon-apigateway-. Automatically removes trailing :* if present.
	destinationArn?: null | string @go(DestinationArn,*string)

	// Formatting and values recorded in the logs.
	// For more information on configuring the log format rules visit the AWS documentation
	format?: null | string @go(Format,*string)
}

#AccessLogSettingsParameters: {
	// ARN of the CloudWatch Logs log group or Kinesis Data Firehose delivery stream to receive access logs. If you specify a Kinesis Data Firehose delivery stream, the stream name must begin with amazon-apigateway-. Automatically removes trailing :* if present.
	// +kubebuilder:validation:Optional
	destinationArn?: null | string @go(DestinationArn,*string)

	// Formatting and values recorded in the logs.
	// For more information on configuring the log format rules visit the AWS documentation
	// +kubebuilder:validation:Optional
	format?: null | string @go(Format,*string)
}

#CanarySettingsInitParameters: {
	// Percent 0.0 - 100.0 of traffic to divert to the canary deployment.
	percentTraffic?: null | float64 @go(PercentTraffic,*float64)

	// Map of overridden stage variables (including new variables) for the canary deployment.
	stageVariableOverrides?: {[string]: null | string} @go(StageVariableOverrides,map[string]*string)

	// Whether the canary deployment uses the stage cache. Defaults to false.
	useStageCache?: null | bool @go(UseStageCache,*bool)
}

#CanarySettingsObservation: {
	// Percent 0.0 - 100.0 of traffic to divert to the canary deployment.
	percentTraffic?: null | float64 @go(PercentTraffic,*float64)

	// Map of overridden stage variables (including new variables) for the canary deployment.
	stageVariableOverrides?: {[string]: null | string} @go(StageVariableOverrides,map[string]*string)

	// Whether the canary deployment uses the stage cache. Defaults to false.
	useStageCache?: null | bool @go(UseStageCache,*bool)
}

#CanarySettingsParameters: {
	// Percent 0.0 - 100.0 of traffic to divert to the canary deployment.
	// +kubebuilder:validation:Optional
	percentTraffic?: null | float64 @go(PercentTraffic,*float64)

	// Map of overridden stage variables (including new variables) for the canary deployment.
	// +kubebuilder:validation:Optional
	stageVariableOverrides?: {[string]: null | string} @go(StageVariableOverrides,map[string]*string)

	// Whether the canary deployment uses the stage cache. Defaults to false.
	// +kubebuilder:validation:Optional
	useStageCache?: null | bool @go(UseStageCache,*bool)
}

#StageInitParameters: {
	// Enables access logs for the API stage. See Access Log Settings below.
	accessLogSettings?: [...#AccessLogSettingsInitParameters] @go(AccessLogSettings,[]AccessLogSettingsInitParameters)

	// Whether a cache cluster is enabled for the stage
	cacheClusterEnabled?: null | bool @go(CacheClusterEnabled,*bool)

	// Size of the cache cluster for the stage, if enabled. Allowed values include 0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118 and 237.
	cacheClusterSize?: null | string @go(CacheClusterSize,*string)

	// Configuration settings of a canary deployment. See Canary Settings below.
	canarySettings?: [...#CanarySettingsInitParameters] @go(CanarySettings,[]CanarySettingsInitParameters)

	// Identifier of a client certificate for the stage.
	clientCertificateId?: null | string @go(ClientCertificateID,*string)

	// Description of the stage.
	description?: null | string @go(Description,*string)

	// Version of the associated API documentation
	documentationVersion?: null | string @go(DocumentationVersion,*string)

	// Name of the stage
	stageName?: null | string @go(StageName,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map that defines the stage variables
	variables?: {[string]: null | string} @go(Variables,map[string]*string)

	// Whether active tracing with X-ray is enabled. Defaults to false.
	xrayTracingEnabled?: null | bool @go(XrayTracingEnabled,*bool)
}

#StageObservation: {
	// Enables access logs for the API stage. See Access Log Settings below.
	accessLogSettings?: [...#AccessLogSettingsObservation] @go(AccessLogSettings,[]AccessLogSettingsObservation)

	// ARN
	arn?: null | string @go(Arn,*string)

	// Whether a cache cluster is enabled for the stage
	cacheClusterEnabled?: null | bool @go(CacheClusterEnabled,*bool)

	// Size of the cache cluster for the stage, if enabled. Allowed values include 0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118 and 237.
	cacheClusterSize?: null | string @go(CacheClusterSize,*string)

	// Configuration settings of a canary deployment. See Canary Settings below.
	canarySettings?: [...#CanarySettingsObservation] @go(CanarySettings,[]CanarySettingsObservation)

	// Identifier of a client certificate for the stage.
	clientCertificateId?: null | string @go(ClientCertificateID,*string)

	// ID of the deployment that the stage points to
	deploymentId?: null | string @go(DeploymentID,*string)

	// Description of the stage.
	description?: null | string @go(Description,*string)

	// Version of the associated API documentation
	documentationVersion?: null | string @go(DocumentationVersion,*string)

	// Execution ARN to be used in lambda_permission's source_arn
	// when allowing API Gateway to invoke a Lambda function,
	// e.g., arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j/prod
	executionArn?: null | string @go(ExecutionArn,*string)

	// ID of the stage
	id?: null | string @go(ID,*string)

	// URL to invoke the API pointing to the stage,
	// e.g., https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod
	invokeUrl?: null | string @go(InvokeURL,*string)

	// ID of the associated REST API
	restApiId?: null | string @go(RestAPIID,*string)

	// Name of the stage
	stageName?: null | string @go(StageName,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Map that defines the stage variables
	variables?: {[string]: null | string} @go(Variables,map[string]*string)

	// ARN of the WebAcl associated with the Stage.
	webAclArn?: null | string @go(WebACLArn,*string)

	// Whether active tracing with X-ray is enabled. Defaults to false.
	xrayTracingEnabled?: null | bool @go(XrayTracingEnabled,*bool)
}

#StageParameters: {
	// Enables access logs for the API stage. See Access Log Settings below.
	// +kubebuilder:validation:Optional
	accessLogSettings?: [...#AccessLogSettingsParameters] @go(AccessLogSettings,[]AccessLogSettingsParameters)

	// Whether a cache cluster is enabled for the stage
	// +kubebuilder:validation:Optional
	cacheClusterEnabled?: null | bool @go(CacheClusterEnabled,*bool)

	// Size of the cache cluster for the stage, if enabled. Allowed values include 0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118 and 237.
	// +kubebuilder:validation:Optional
	cacheClusterSize?: null | string @go(CacheClusterSize,*string)

	// Configuration settings of a canary deployment. See Canary Settings below.
	// +kubebuilder:validation:Optional
	canarySettings?: [...#CanarySettingsParameters] @go(CanarySettings,[]CanarySettingsParameters)

	// Identifier of a client certificate for the stage.
	// +kubebuilder:validation:Optional
	clientCertificateId?: null | string @go(ClientCertificateID,*string)

	// ID of the deployment that the stage points to
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/apigateway/v1beta1.Deployment
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	deploymentId?: null | string @go(DeploymentID,*string)

	// Reference to a Deployment in apigateway to populate deploymentId.
	// +kubebuilder:validation:Optional
	deploymentIdRef?: null | v1.#Reference @go(DeploymentIDRef,*v1.Reference)

	// Selector for a Deployment in apigateway to populate deploymentId.
	// +kubebuilder:validation:Optional
	deploymentIdSelector?: null | v1.#Selector @go(DeploymentIDSelector,*v1.Selector)

	// Description of the stage.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Version of the associated API documentation
	// +kubebuilder:validation:Optional
	documentationVersion?: null | string @go(DocumentationVersion,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// ID of the associated REST API
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/apigateway/v1beta1.RestAPI
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	restApiId?: null | string @go(RestAPIID,*string)

	// Reference to a RestAPI in apigateway to populate restApiId.
	// +kubebuilder:validation:Optional
	restApiIdRef?: null | v1.#Reference @go(RestAPIIDRef,*v1.Reference)

	// Selector for a RestAPI in apigateway to populate restApiId.
	// +kubebuilder:validation:Optional
	restApiIdSelector?: null | v1.#Selector @go(RestAPIIDSelector,*v1.Selector)

	// Name of the stage
	// +kubebuilder:validation:Optional
	stageName?: null | string @go(StageName,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map that defines the stage variables
	// +kubebuilder:validation:Optional
	variables?: {[string]: null | string} @go(Variables,map[string]*string)

	// Whether active tracing with X-ray is enabled. Defaults to false.
	// +kubebuilder:validation:Optional
	xrayTracingEnabled?: null | bool @go(XrayTracingEnabled,*bool)
}

// StageSpec defines the desired state of Stage
#StageSpec: {
	v1.#ResourceSpec
	forProvider: #StageParameters @go(ForProvider)

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
	initProvider?: #StageInitParameters @go(InitProvider)
}

// StageStatus defines the observed state of Stage.
#StageStatus: {
	v1.#ResourceStatus
	atProvider?: #StageObservation @go(AtProvider)
}

// Stage is the Schema for the Stages API. Manages an API Gateway Stage.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Stage: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.stageName) || (has(self.initProvider) && has(self.initProvider.stageName))",message="spec.forProvider.stageName is a required parameter"
	spec:    #StageSpec   @go(Spec)
	status?: #StageStatus @go(Status)
}

// StageList contains a list of Stages
#StageList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Stage] @go(Items,[]Stage)
}
