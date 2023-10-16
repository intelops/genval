// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/apigateway/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#RestAPIEndpointConfigurationInitParameters: {
	// List of endpoint types. This resource currently only supports managing a single value. Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. If set to PRIVATE recommend to set put_rest_api_mode = merge to not cause the endpoints and associated Route53 records to be deleted. Refer to the documentation for more information on the difference between edge-optimized and regional APIs.
	types?: [...null | string] @go(Types,[]*string)

	// Set of VPC Endpoint identifiers. It is only supported for PRIVATE endpoint type. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-endpoint-configuration extension vpcEndpointIds property. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	vpcEndpointIds?: [...null | string] @go(VPCEndpointIds,[]*string)
}

#RestAPIEndpointConfigurationObservation: {
	// List of endpoint types. This resource currently only supports managing a single value. Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. If set to PRIVATE recommend to set put_rest_api_mode = merge to not cause the endpoints and associated Route53 records to be deleted. Refer to the documentation for more information on the difference between edge-optimized and regional APIs.
	types?: [...null | string] @go(Types,[]*string)

	// Set of VPC Endpoint identifiers. It is only supported for PRIVATE endpoint type. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-endpoint-configuration extension vpcEndpointIds property. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	vpcEndpointIds?: [...null | string] @go(VPCEndpointIds,[]*string)
}

#RestAPIEndpointConfigurationParameters: {
	// List of endpoint types. This resource currently only supports managing a single value. Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. If set to PRIVATE recommend to set put_rest_api_mode = merge to not cause the endpoints and associated Route53 records to be deleted. Refer to the documentation for more information on the difference between edge-optimized and regional APIs.
	// +kubebuilder:validation:Optional
	types: [...null | string] @go(Types,[]*string)

	// Set of VPC Endpoint identifiers. It is only supported for PRIVATE endpoint type. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-endpoint-configuration extension vpcEndpointIds property. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	// +kubebuilder:validation:Optional
	vpcEndpointIds?: [...null | string] @go(VPCEndpointIds,[]*string)
}

#RestAPIInitParameters: {
	// Source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-api-key-source extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	apiKeySource?: null | string @go(APIKeySource,*string)

	// List of binary media types supported by the REST API. By default, the REST API supports only UTF-8-encoded text payloads. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-binary-media-types extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	binaryMediaTypes?: [...null | string] @go(BinaryMediaTypes,[]*string)

	// OpenAPI specification that defines the set of routes and integrations to create as part of the REST API. This configuration, and any updates to it, will replace all REST API configuration except values overridden in this resource configuration and other resource updates applied after this resource but before any aws_api_gateway_deployment creation. More information about REST API OpenAPI support can be found in the API Gateway Developer Guide.
	body?: null | string @go(Body,*string)

	// Description of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.description field. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	description?: null | string @go(Description,*string)

	// Whether clients can invoke your API by using the default execute-api endpoint. By default, clients can invoke your API with the default https://{api_id}.execute-api.{region}.amazonaws.com endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint. Defaults to false. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-endpoint-configuration extension disableExecuteApiEndpoint property. If the argument value is true and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	disableExecuteApiEndpoint?: null | bool @go(DisableExecuteAPIEndpoint,*bool)

	// Configuration block defining API endpoint configuration including endpoint type. Defined below.
	endpointConfiguration?: [...#RestAPIEndpointConfigurationInitParameters] @go(EndpointConfiguration,[]RestAPIEndpointConfigurationInitParameters)

	// Whether warnings while API Gateway is creating or updating the resource should return an error or not. Defaults to false
	failOnWarnings?: null | bool @go(FailOnWarnings,*bool)

	// Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default). If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-minimum-compression-size extension. If the argument value (except -1) is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	minimumCompressionSize?: null | float64 @go(MinimumCompressionSize,*float64)

	// Name of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.title field. If the argument value is different than the OpenAPI value, the argument value will override the OpenAPI value.
	name?: null | string @go(Name,*string)

	// Map of customizations for importing the specification in the body argument. For example, to exclude DocumentationParts from an imported API, set ignore equal to documentation. Additional documentation, including other parameters such as basepath, can be found in the API Gateway Developer Guide.
	parameters?: {[string]: null | string} @go(Parameters,map[string]*string)

	// Mode of the PutRestApi operation when importing an OpenAPI specification via the body argument (create or update operation). Valid values are merge and overwrite. If unspecificed, defaults to overwrite (for backwards compatibility). This corresponds to the x-amazon-apigateway-put-integration-method extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	putRestApiMode?: null | string @go(PutRestAPIMode,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RestAPIObservation: {
	// Source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-api-key-source extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	apiKeySource?: null | string @go(APIKeySource,*string)

	// ARN
	arn?: null | string @go(Arn,*string)

	// List of binary media types supported by the REST API. By default, the REST API supports only UTF-8-encoded text payloads. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-binary-media-types extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	binaryMediaTypes?: [...null | string] @go(BinaryMediaTypes,[]*string)

	// OpenAPI specification that defines the set of routes and integrations to create as part of the REST API. This configuration, and any updates to it, will replace all REST API configuration except values overridden in this resource configuration and other resource updates applied after this resource but before any aws_api_gateway_deployment creation. More information about REST API OpenAPI support can be found in the API Gateway Developer Guide.
	body?: null | string @go(Body,*string)

	// Creation date of the REST API
	createdDate?: null | string @go(CreatedDate,*string)

	// Description of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.description field. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	description?: null | string @go(Description,*string)

	// Whether clients can invoke your API by using the default execute-api endpoint. By default, clients can invoke your API with the default https://{api_id}.execute-api.{region}.amazonaws.com endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint. Defaults to false. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-endpoint-configuration extension disableExecuteApiEndpoint property. If the argument value is true and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	disableExecuteApiEndpoint?: null | bool @go(DisableExecuteAPIEndpoint,*bool)

	// Configuration block defining API endpoint configuration including endpoint type. Defined below.
	endpointConfiguration?: [...#RestAPIEndpointConfigurationObservation] @go(EndpointConfiguration,[]RestAPIEndpointConfigurationObservation)

	// Execution ARN part to be used in lambda_permission's source_arn
	// when allowing API Gateway to invoke a Lambda function,
	// e.g., arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j, which can be concatenated with allowed stage, method and resource path.
	executionArn?: null | string @go(ExecutionArn,*string)

	// Whether warnings while API Gateway is creating or updating the resource should return an error or not. Defaults to false
	failOnWarnings?: null | bool @go(FailOnWarnings,*bool)

	// ID of the REST API
	id?: null | string @go(ID,*string)

	// Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default). If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-minimum-compression-size extension. If the argument value (except -1) is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	minimumCompressionSize?: null | float64 @go(MinimumCompressionSize,*float64)

	// Name of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.title field. If the argument value is different than the OpenAPI value, the argument value will override the OpenAPI value.
	name?: null | string @go(Name,*string)

	// Map of customizations for importing the specification in the body argument. For example, to exclude DocumentationParts from an imported API, set ignore equal to documentation. Additional documentation, including other parameters such as basepath, can be found in the API Gateway Developer Guide.
	parameters?: {[string]: null | string} @go(Parameters,map[string]*string)

	// JSON formatted policy document that controls access to the API Gateway. We recommend using the aws_api_gateway_rest_api_policy resource instead. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-policy extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	policy?: null | string @go(Policy,*string)

	// Mode of the PutRestApi operation when importing an OpenAPI specification via the body argument (create or update operation). Valid values are merge and overwrite. If unspecificed, defaults to overwrite (for backwards compatibility). This corresponds to the x-amazon-apigateway-put-integration-method extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	putRestApiMode?: null | string @go(PutRestAPIMode,*string)

	// Resource ID of the REST API's root
	rootResourceId?: null | string @go(RootResourceID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#RestAPIParameters: {
	// Source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-api-key-source extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	// +kubebuilder:validation:Optional
	apiKeySource?: null | string @go(APIKeySource,*string)

	// List of binary media types supported by the REST API. By default, the REST API supports only UTF-8-encoded text payloads. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-binary-media-types extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	// +kubebuilder:validation:Optional
	binaryMediaTypes?: [...null | string] @go(BinaryMediaTypes,[]*string)

	// OpenAPI specification that defines the set of routes and integrations to create as part of the REST API. This configuration, and any updates to it, will replace all REST API configuration except values overridden in this resource configuration and other resource updates applied after this resource but before any aws_api_gateway_deployment creation. More information about REST API OpenAPI support can be found in the API Gateway Developer Guide.
	// +kubebuilder:validation:Optional
	body?: null | string @go(Body,*string)

	// Description of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.description field. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Whether clients can invoke your API by using the default execute-api endpoint. By default, clients can invoke your API with the default https://{api_id}.execute-api.{region}.amazonaws.com endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint. Defaults to false. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-endpoint-configuration extension disableExecuteApiEndpoint property. If the argument value is true and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	// +kubebuilder:validation:Optional
	disableExecuteApiEndpoint?: null | bool @go(DisableExecuteAPIEndpoint,*bool)

	// Configuration block defining API endpoint configuration including endpoint type. Defined below.
	// +kubebuilder:validation:Optional
	endpointConfiguration?: [...#RestAPIEndpointConfigurationParameters] @go(EndpointConfiguration,[]RestAPIEndpointConfigurationParameters)

	// Whether warnings while API Gateway is creating or updating the resource should return an error or not. Defaults to false
	// +kubebuilder:validation:Optional
	failOnWarnings?: null | bool @go(FailOnWarnings,*bool)

	// Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default). If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-minimum-compression-size extension. If the argument value (except -1) is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	// +kubebuilder:validation:Optional
	minimumCompressionSize?: null | float64 @go(MinimumCompressionSize,*float64)

	// Name of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.title field. If the argument value is different than the OpenAPI value, the argument value will override the OpenAPI value.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Map of customizations for importing the specification in the body argument. For example, to exclude DocumentationParts from an imported API, set ignore equal to documentation. Additional documentation, including other parameters such as basepath, can be found in the API Gateway Developer Guide.
	// +kubebuilder:validation:Optional
	parameters?: {[string]: null | string} @go(Parameters,map[string]*string)

	// Mode of the PutRestApi operation when importing an OpenAPI specification via the body argument (create or update operation). Valid values are merge and overwrite. If unspecificed, defaults to overwrite (for backwards compatibility). This corresponds to the x-amazon-apigateway-put-integration-method extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value.
	// +kubebuilder:validation:Optional
	putRestApiMode?: null | string @go(PutRestAPIMode,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// RestAPISpec defines the desired state of RestAPI
#RestAPISpec: {
	v1.#ResourceSpec
	forProvider: #RestAPIParameters @go(ForProvider)

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
	initProvider?: #RestAPIInitParameters @go(InitProvider)
}

// RestAPIStatus defines the observed state of RestAPI.
#RestAPIStatus: {
	v1.#ResourceStatus
	atProvider?: #RestAPIObservation @go(AtProvider)
}

// RestAPI is the Schema for the RestAPIs API. Manages an API Gateway REST API.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#RestAPI: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #RestAPISpec   @go(Spec)
	status?: #RestAPIStatus @go(Status)
}

// RestAPIList contains a list of RestAPIs
#RestAPIList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#RestAPI] @go(Items,[]RestAPI)
}
