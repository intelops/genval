// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/apigatewayv2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#APIInitParameters: {
	// An API key selection expression.
	// Valid values: $context.authorizer.usageIdentifierKey, $request.header.x-api-key. Defaults to $request.header.x-api-key.
	// Applicable for WebSocket APIs.
	apiKeySelectionExpression?: null | string @go(APIKeySelectionExpression,*string)

	// An OpenAPI specification that defines the set of routes and integrations to create as part of the HTTP APIs. Supported only for HTTP APIs.
	body?: null | string @go(Body,*string)

	// Cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs.
	corsConfiguration?: [...#CorsConfigurationInitParameters] @go(CorsConfiguration,[]CorsConfigurationInitParameters)

	// Part of quick create. Specifies any credentials required for the integration. Applicable for HTTP APIs.
	credentialsArn?: null | string @go(CredentialsArn,*string)

	// Description of the API. Must be less than or equal to 1024 characters in length.
	description?: null | string @go(Description,*string)

	// Whether clients can invoke the API by using the default execute-api endpoint.
	// By default, clients can invoke the API with the default {api_id}.execute-api.{region}.amazonaws.com endpoint.
	// To require that clients use a custom domain name to invoke the API, disable the default endpoint.
	disableExecuteApiEndpoint?: null | bool @go(DisableExecuteAPIEndpoint,*bool)

	// Whether warnings should return an error while API Gateway is creating or updating the resource using an OpenAPI specification. Defaults to false. Applicable for HTTP APIs.
	failOnWarnings?: null | bool @go(FailOnWarnings,*bool)

	// Name of the API. Must be less than or equal to 128 characters in length.
	name?: null | string @go(Name,*string)

	// API protocol. Valid values: HTTP, WEBSOCKET.
	protocolType?: null | string @go(ProtocolType,*string)

	// Part of quick create. Specifies any route key. Applicable for HTTP APIs.
	routeKey?: null | string @go(RouteKey,*string)

	// The route selection expression for the API.
	// Defaults to $request.method $request.path.
	routeSelectionExpression?: null | string @go(RouteSelectionExpression,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes.
	// For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN.
	// The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. Applicable for HTTP APIs.
	target?: null | string @go(Target,*string)

	// Version identifier for the API. Must be between 1 and 64 characters in length.
	version?: null | string @go(Version,*string)
}

#APIObservation: {
	// URI of the API, of the form https://{api-id}.execute-api.{region}.amazonaws.com for HTTP APIs and wss://{api-id}.execute-api.{region}.amazonaws.com for WebSocket APIs.
	apiEndpoint?: null | string @go(APIEndpoint,*string)

	// An API key selection expression.
	// Valid values: $context.authorizer.usageIdentifierKey, $request.header.x-api-key. Defaults to $request.header.x-api-key.
	// Applicable for WebSocket APIs.
	apiKeySelectionExpression?: null | string @go(APIKeySelectionExpression,*string)

	// ARN of the API.
	arn?: null | string @go(Arn,*string)

	// An OpenAPI specification that defines the set of routes and integrations to create as part of the HTTP APIs. Supported only for HTTP APIs.
	body?: null | string @go(Body,*string)

	// Cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs.
	corsConfiguration?: [...#CorsConfigurationObservation] @go(CorsConfiguration,[]CorsConfigurationObservation)

	// Part of quick create. Specifies any credentials required for the integration. Applicable for HTTP APIs.
	credentialsArn?: null | string @go(CredentialsArn,*string)

	// Description of the API. Must be less than or equal to 1024 characters in length.
	description?: null | string @go(Description,*string)

	// Whether clients can invoke the API by using the default execute-api endpoint.
	// By default, clients can invoke the API with the default {api_id}.execute-api.{region}.amazonaws.com endpoint.
	// To require that clients use a custom domain name to invoke the API, disable the default endpoint.
	disableExecuteApiEndpoint?: null | bool @go(DisableExecuteAPIEndpoint,*bool)

	// ARN prefix to be used in an aws_lambda_permission's source_arn attribute
	// or in an aws_iam_policy to authorize access to the @connections API.
	// See the Amazon API Gateway Developer Guide for details.
	executionArn?: null | string @go(ExecutionArn,*string)

	// Whether warnings should return an error while API Gateway is creating or updating the resource using an OpenAPI specification. Defaults to false. Applicable for HTTP APIs.
	failOnWarnings?: null | bool @go(FailOnWarnings,*bool)

	// API identifier.
	id?: null | string @go(ID,*string)

	// Name of the API. Must be less than or equal to 128 characters in length.
	name?: null | string @go(Name,*string)

	// API protocol. Valid values: HTTP, WEBSOCKET.
	protocolType?: null | string @go(ProtocolType,*string)

	// Part of quick create. Specifies any route key. Applicable for HTTP APIs.
	routeKey?: null | string @go(RouteKey,*string)

	// The route selection expression for the API.
	// Defaults to $request.method $request.path.
	routeSelectionExpression?: null | string @go(RouteSelectionExpression,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes.
	// For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN.
	// The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. Applicable for HTTP APIs.
	target?: null | string @go(Target,*string)

	// Version identifier for the API. Must be between 1 and 64 characters in length.
	version?: null | string @go(Version,*string)
}

#APIParameters: {
	// An API key selection expression.
	// Valid values: $context.authorizer.usageIdentifierKey, $request.header.x-api-key. Defaults to $request.header.x-api-key.
	// Applicable for WebSocket APIs.
	// +kubebuilder:validation:Optional
	apiKeySelectionExpression?: null | string @go(APIKeySelectionExpression,*string)

	// An OpenAPI specification that defines the set of routes and integrations to create as part of the HTTP APIs. Supported only for HTTP APIs.
	// +kubebuilder:validation:Optional
	body?: null | string @go(Body,*string)

	// Cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs.
	// +kubebuilder:validation:Optional
	corsConfiguration?: [...#CorsConfigurationParameters] @go(CorsConfiguration,[]CorsConfigurationParameters)

	// Part of quick create. Specifies any credentials required for the integration. Applicable for HTTP APIs.
	// +kubebuilder:validation:Optional
	credentialsArn?: null | string @go(CredentialsArn,*string)

	// Description of the API. Must be less than or equal to 1024 characters in length.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Whether clients can invoke the API by using the default execute-api endpoint.
	// By default, clients can invoke the API with the default {api_id}.execute-api.{region}.amazonaws.com endpoint.
	// To require that clients use a custom domain name to invoke the API, disable the default endpoint.
	// +kubebuilder:validation:Optional
	disableExecuteApiEndpoint?: null | bool @go(DisableExecuteAPIEndpoint,*bool)

	// Whether warnings should return an error while API Gateway is creating or updating the resource using an OpenAPI specification. Defaults to false. Applicable for HTTP APIs.
	// +kubebuilder:validation:Optional
	failOnWarnings?: null | bool @go(FailOnWarnings,*bool)

	// Name of the API. Must be less than or equal to 128 characters in length.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// API protocol. Valid values: HTTP, WEBSOCKET.
	// +kubebuilder:validation:Optional
	protocolType?: null | string @go(ProtocolType,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Part of quick create. Specifies any route key. Applicable for HTTP APIs.
	// +kubebuilder:validation:Optional
	routeKey?: null | string @go(RouteKey,*string)

	// The route selection expression for the API.
	// Defaults to $request.method $request.path.
	// +kubebuilder:validation:Optional
	routeSelectionExpression?: null | string @go(RouteSelectionExpression,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes.
	// For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN.
	// The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. Applicable for HTTP APIs.
	// +kubebuilder:validation:Optional
	target?: null | string @go(Target,*string)

	// Version identifier for the API. Must be between 1 and 64 characters in length.
	// +kubebuilder:validation:Optional
	version?: null | string @go(Version,*string)
}

#CorsConfigurationInitParameters: {
	// Whether credentials are included in the CORS request.
	allowCredentials?: null | bool @go(AllowCredentials,*bool)

	// Set of allowed HTTP headers.
	allowHeaders?: [...null | string] @go(AllowHeaders,[]*string)

	// Set of allowed HTTP methods.
	allowMethods?: [...null | string] @go(AllowMethods,[]*string)

	// Set of allowed origins.
	allowOrigins?: [...null | string] @go(AllowOrigins,[]*string)

	// Set of exposed HTTP headers.
	exposeHeaders?: [...null | string] @go(ExposeHeaders,[]*string)

	// Number of seconds that the browser should cache preflight request results.
	maxAge?: null | float64 @go(MaxAge,*float64)
}

#CorsConfigurationObservation: {
	// Whether credentials are included in the CORS request.
	allowCredentials?: null | bool @go(AllowCredentials,*bool)

	// Set of allowed HTTP headers.
	allowHeaders?: [...null | string] @go(AllowHeaders,[]*string)

	// Set of allowed HTTP methods.
	allowMethods?: [...null | string] @go(AllowMethods,[]*string)

	// Set of allowed origins.
	allowOrigins?: [...null | string] @go(AllowOrigins,[]*string)

	// Set of exposed HTTP headers.
	exposeHeaders?: [...null | string] @go(ExposeHeaders,[]*string)

	// Number of seconds that the browser should cache preflight request results.
	maxAge?: null | float64 @go(MaxAge,*float64)
}

#CorsConfigurationParameters: {
	// Whether credentials are included in the CORS request.
	// +kubebuilder:validation:Optional
	allowCredentials?: null | bool @go(AllowCredentials,*bool)

	// Set of allowed HTTP headers.
	// +kubebuilder:validation:Optional
	allowHeaders?: [...null | string] @go(AllowHeaders,[]*string)

	// Set of allowed HTTP methods.
	// +kubebuilder:validation:Optional
	allowMethods?: [...null | string] @go(AllowMethods,[]*string)

	// Set of allowed origins.
	// +kubebuilder:validation:Optional
	allowOrigins?: [...null | string] @go(AllowOrigins,[]*string)

	// Set of exposed HTTP headers.
	// +kubebuilder:validation:Optional
	exposeHeaders?: [...null | string] @go(ExposeHeaders,[]*string)

	// Number of seconds that the browser should cache preflight request results.
	// +kubebuilder:validation:Optional
	maxAge?: null | float64 @go(MaxAge,*float64)
}

// APISpec defines the desired state of API
#APISpec: {
	v1.#ResourceSpec
	forProvider: #APIParameters @go(ForProvider)

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
	initProvider?: #APIInitParameters @go(InitProvider)
}

// APIStatus defines the observed state of API.
#APIStatus: {
	v1.#ResourceStatus
	atProvider?: #APIObservation @go(AtProvider)
}

// API is the Schema for the APIs API. Manages an Amazon API Gateway Version 2 API.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#API: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.protocolType) || (has(self.initProvider) && has(self.initProvider.protocolType))",message="spec.forProvider.protocolType is a required parameter"
	spec:    #APISpec   @go(Spec)
	status?: #APIStatus @go(Status)
}

// APIList contains a list of APIs
#APIList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#API] @go(Items,[]API)
}
