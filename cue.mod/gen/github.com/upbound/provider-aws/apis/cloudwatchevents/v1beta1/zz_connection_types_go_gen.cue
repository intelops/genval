// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/cloudwatchevents/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#APIKeyInitParameters: {
	// Header Name.
	key?: null | string @go(Key,*string)
}

#APIKeyObservation: {
	// Header Name.
	key?: null | string @go(Key,*string)
}

#APIKeyParameters: {
	// Header Name.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Header Value. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Required
	valueSecretRef: v1.#SecretKeySelector @go(ValueSecretRef)
}

#AuthParametersInitParameters: {
	// Parameters used for API_KEY authorization. An API key to include in the header for each authentication request. A maximum of 1 are allowed. Conflicts with basic and oauth. Documented below.
	apiKey?: [...#APIKeyInitParameters] @go(APIKey,[]APIKeyInitParameters)

	// Parameters used for BASIC authorization. A maximum of 1 are allowed. Conflicts with api_key and oauth. Documented below.
	basic?: [...#BasicInitParameters] @go(Basic,[]BasicInitParameters)

	// Invocation Http Parameters are additional credentials used to sign each Invocation of the ApiDestination created from this Connection. If the ApiDestination Rule Target has additional HttpParameters, the values will be merged together, with the Connection Invocation Http Parameters taking precedence. Secret values are stored and managed by AWS Secrets Manager. A maximum of 1 are allowed. Documented below.
	invocationHttpParameters?: [...#InvocationHTTPParametersInitParameters] @go(InvocationHTTPParameters,[]InvocationHTTPParametersInitParameters)

	// Parameters used for OAUTH_CLIENT_CREDENTIALS authorization. A maximum of 1 are allowed. Conflicts with basic and api_key. Documented below.
	oauth?: [...#OauthInitParameters] @go(Oauth,[]OauthInitParameters)
}

#AuthParametersObservation: {
	// Parameters used for API_KEY authorization. An API key to include in the header for each authentication request. A maximum of 1 are allowed. Conflicts with basic and oauth. Documented below.
	apiKey?: [...#APIKeyObservation] @go(APIKey,[]APIKeyObservation)

	// Parameters used for BASIC authorization. A maximum of 1 are allowed. Conflicts with api_key and oauth. Documented below.
	basic?: [...#BasicObservation] @go(Basic,[]BasicObservation)

	// Invocation Http Parameters are additional credentials used to sign each Invocation of the ApiDestination created from this Connection. If the ApiDestination Rule Target has additional HttpParameters, the values will be merged together, with the Connection Invocation Http Parameters taking precedence. Secret values are stored and managed by AWS Secrets Manager. A maximum of 1 are allowed. Documented below.
	invocationHttpParameters?: [...#InvocationHTTPParametersObservation] @go(InvocationHTTPParameters,[]InvocationHTTPParametersObservation)

	// Parameters used for OAUTH_CLIENT_CREDENTIALS authorization. A maximum of 1 are allowed. Conflicts with basic and api_key. Documented below.
	oauth?: [...#OauthObservation] @go(Oauth,[]OauthObservation)
}

#AuthParametersParameters: {
	// Parameters used for API_KEY authorization. An API key to include in the header for each authentication request. A maximum of 1 are allowed. Conflicts with basic and oauth. Documented below.
	// +kubebuilder:validation:Optional
	apiKey?: [...#APIKeyParameters] @go(APIKey,[]APIKeyParameters)

	// Parameters used for BASIC authorization. A maximum of 1 are allowed. Conflicts with api_key and oauth. Documented below.
	// +kubebuilder:validation:Optional
	basic?: [...#BasicParameters] @go(Basic,[]BasicParameters)

	// Invocation Http Parameters are additional credentials used to sign each Invocation of the ApiDestination created from this Connection. If the ApiDestination Rule Target has additional HttpParameters, the values will be merged together, with the Connection Invocation Http Parameters taking precedence. Secret values are stored and managed by AWS Secrets Manager. A maximum of 1 are allowed. Documented below.
	// +kubebuilder:validation:Optional
	invocationHttpParameters?: [...#InvocationHTTPParametersParameters] @go(InvocationHTTPParameters,[]InvocationHTTPParametersParameters)

	// Parameters used for OAUTH_CLIENT_CREDENTIALS authorization. A maximum of 1 are allowed. Conflicts with basic and api_key. Documented below.
	// +kubebuilder:validation:Optional
	oauth?: [...#OauthParameters] @go(Oauth,[]OauthParameters)
}

#BasicInitParameters: {
	// A username for the authorization.
	username?: null | string @go(Username,*string)
}

#BasicObservation: {
	// A username for the authorization.
	username?: null | string @go(Username,*string)
}

#BasicParameters: {
	// A password for the authorization. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Required
	passwordSecretRef: v1.#SecretKeySelector @go(PasswordSecretRef)

	// A username for the authorization.
	// +kubebuilder:validation:Optional
	username?: null | string @go(Username,*string)
}

#BodyInitParameters: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#BodyObservation: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#BodyParameters: {
	// Specified whether the value is secret.
	// +kubebuilder:validation:Optional
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Header Value. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Optional
	valueSecretRef?: null | v1.#SecretKeySelector @go(ValueSecretRef,*v1.SecretKeySelector)
}

#ClientParametersInitParameters: {
	// The client ID for the credentials to use for authorization. Created and stored in AWS Secrets Manager.
	clientId?: null | string @go(ClientID,*string)
}

#ClientParametersObservation: {
	// The client ID for the credentials to use for authorization. Created and stored in AWS Secrets Manager.
	clientId?: null | string @go(ClientID,*string)
}

#ClientParametersParameters: {
	// The client ID for the credentials to use for authorization. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Optional
	clientId?: null | string @go(ClientID,*string)

	// The client secret for the credentials to use for authorization. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Required
	clientSecretSecretRef: v1.#SecretKeySelector @go(ClientSecretSecretRef)
}

#ConnectionInitParameters: {
	// Parameters used for authorization. A maximum of 1 are allowed. Documented below.
	authParameters?: [...#AuthParametersInitParameters] @go(AuthParameters,[]AuthParametersInitParameters)

	// Choose the type of authorization to use for the connection. One of API_KEY,BASIC,OAUTH_CLIENT_CREDENTIALS.
	authorizationType?: null | string @go(AuthorizationType,*string)

	// Enter a description for the connection. Maximum of 512 characters.
	description?: null | string @go(Description,*string)
}

#ConnectionObservation: {
	// The Amazon Resource Name (ARN) of the connection.
	arn?: null | string @go(Arn,*string)

	// Parameters used for authorization. A maximum of 1 are allowed. Documented below.
	authParameters?: [...#AuthParametersObservation] @go(AuthParameters,[]AuthParametersObservation)

	// Choose the type of authorization to use for the connection. One of API_KEY,BASIC,OAUTH_CLIENT_CREDENTIALS.
	authorizationType?: null | string @go(AuthorizationType,*string)

	// Enter a description for the connection. Maximum of 512 characters.
	description?: null | string @go(Description,*string)
	id?:          null | string @go(ID,*string)

	// The Amazon Resource Name (ARN) of the secret created from the authorization parameters specified for the connection.
	secretArn?: null | string @go(SecretArn,*string)
}

#ConnectionParameters: {
	// Parameters used for authorization. A maximum of 1 are allowed. Documented below.
	// +kubebuilder:validation:Optional
	authParameters?: [...#AuthParametersParameters] @go(AuthParameters,[]AuthParametersParameters)

	// Choose the type of authorization to use for the connection. One of API_KEY,BASIC,OAUTH_CLIENT_CREDENTIALS.
	// +kubebuilder:validation:Optional
	authorizationType?: null | string @go(AuthorizationType,*string)

	// Enter a description for the connection. Maximum of 512 characters.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

#HeaderInitParameters: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#HeaderObservation: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#HeaderParameters: {
	// Specified whether the value is secret.
	// +kubebuilder:validation:Optional
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Header Value. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Optional
	valueSecretRef?: null | v1.#SecretKeySelector @go(ValueSecretRef,*v1.SecretKeySelector)
}

#InvocationHTTPParametersInitParameters: {
	// Contains additional body string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	body?: [...#BodyInitParameters] @go(Body,[]BodyInitParameters)

	// Contains additional header parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	header?: [...#HeaderInitParameters] @go(Header,[]HeaderInitParameters)

	// Contains additional query string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	queryString?: [...#QueryStringInitParameters] @go(QueryString,[]QueryStringInitParameters)
}

#InvocationHTTPParametersObservation: {
	// Contains additional body string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	body?: [...#BodyObservation] @go(Body,[]BodyObservation)

	// Contains additional header parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	header?: [...#HeaderObservation] @go(Header,[]HeaderObservation)

	// Contains additional query string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	queryString?: [...#QueryStringObservation] @go(QueryString,[]QueryStringObservation)
}

#InvocationHTTPParametersParameters: {
	// Contains additional body string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	// +kubebuilder:validation:Optional
	body?: [...#BodyParameters] @go(Body,[]BodyParameters)

	// Contains additional header parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	// +kubebuilder:validation:Optional
	header?: [...#HeaderParameters] @go(Header,[]HeaderParameters)

	// Contains additional query string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	// +kubebuilder:validation:Optional
	queryString?: [...#QueryStringParameters] @go(QueryString,[]QueryStringParameters)
}

#OauthHTTPParametersBodyInitParameters: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#OauthHTTPParametersBodyObservation: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#OauthHTTPParametersBodyParameters: {
	// Specified whether the value is secret.
	// +kubebuilder:validation:Optional
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Header Value. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Optional
	valueSecretRef?: null | v1.#SecretKeySelector @go(ValueSecretRef,*v1.SecretKeySelector)
}

#OauthHTTPParametersHeaderInitParameters: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#OauthHTTPParametersHeaderObservation: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#OauthHTTPParametersHeaderParameters: {
	// Specified whether the value is secret.
	// +kubebuilder:validation:Optional
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Header Value. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Optional
	valueSecretRef?: null | v1.#SecretKeySelector @go(ValueSecretRef,*v1.SecretKeySelector)
}

#OauthHTTPParametersInitParameters: {
	// Contains additional body string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	body?: [...#OauthHTTPParametersBodyInitParameters] @go(Body,[]OauthHTTPParametersBodyInitParameters)

	// Contains additional header parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	header?: [...#OauthHTTPParametersHeaderInitParameters] @go(Header,[]OauthHTTPParametersHeaderInitParameters)

	// Contains additional query string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	queryString?: [...#OauthHTTPParametersQueryStringInitParameters] @go(QueryString,[]OauthHTTPParametersQueryStringInitParameters)
}

#OauthHTTPParametersObservation: {
	// Contains additional body string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	body?: [...#OauthHTTPParametersBodyObservation] @go(Body,[]OauthHTTPParametersBodyObservation)

	// Contains additional header parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	header?: [...#OauthHTTPParametersHeaderObservation] @go(Header,[]OauthHTTPParametersHeaderObservation)

	// Contains additional query string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	queryString?: [...#OauthHTTPParametersQueryStringObservation] @go(QueryString,[]OauthHTTPParametersQueryStringObservation)
}

#OauthHTTPParametersParameters: {
	// Contains additional body string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	// +kubebuilder:validation:Optional
	body?: [...#OauthHTTPParametersBodyParameters] @go(Body,[]OauthHTTPParametersBodyParameters)

	// Contains additional header parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	// +kubebuilder:validation:Optional
	header?: [...#OauthHTTPParametersHeaderParameters] @go(Header,[]OauthHTTPParametersHeaderParameters)

	// Contains additional query string parameters for the connection. You can include up to 100 additional body string parameters per request. Each additional parameter counts towards the event payload size, which cannot exceed 64 KB. Each parameter can contain the following:
	// +kubebuilder:validation:Optional
	queryString?: [...#OauthHTTPParametersQueryStringParameters] @go(QueryString,[]OauthHTTPParametersQueryStringParameters)
}

#OauthHTTPParametersQueryStringInitParameters: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#OauthHTTPParametersQueryStringObservation: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#OauthHTTPParametersQueryStringParameters: {
	// Specified whether the value is secret.
	// +kubebuilder:validation:Optional
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Header Value. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Optional
	valueSecretRef?: null | v1.#SecretKeySelector @go(ValueSecretRef,*v1.SecretKeySelector)
}

#OauthInitParameters: {
	// The URL to the authorization endpoint.
	authorizationEndpoint?: null | string @go(AuthorizationEndpoint,*string)

	// Contains the client parameters for OAuth authorization. Contains the following two parameters.
	clientParameters?: [...#ClientParametersInitParameters] @go(ClientParameters,[]ClientParametersInitParameters)

	// A password for the authorization. Created and stored in AWS Secrets Manager.
	httpMethod?: null | string @go(HTTPMethod,*string)

	// OAuth Http Parameters are additional credentials used to sign the request to the authorization endpoint to exchange the OAuth Client information for an access token. Secret values are stored and managed by AWS Secrets Manager. A maximum of 1 are allowed. Documented below.
	oauthHttpParameters?: [...#OauthHTTPParametersInitParameters] @go(OauthHTTPParameters,[]OauthHTTPParametersInitParameters)
}

#OauthObservation: {
	// The URL to the authorization endpoint.
	authorizationEndpoint?: null | string @go(AuthorizationEndpoint,*string)

	// Contains the client parameters for OAuth authorization. Contains the following two parameters.
	clientParameters?: [...#ClientParametersObservation] @go(ClientParameters,[]ClientParametersObservation)

	// A password for the authorization. Created and stored in AWS Secrets Manager.
	httpMethod?: null | string @go(HTTPMethod,*string)

	// OAuth Http Parameters are additional credentials used to sign the request to the authorization endpoint to exchange the OAuth Client information for an access token. Secret values are stored and managed by AWS Secrets Manager. A maximum of 1 are allowed. Documented below.
	oauthHttpParameters?: [...#OauthHTTPParametersObservation] @go(OauthHTTPParameters,[]OauthHTTPParametersObservation)
}

#OauthParameters: {
	// The URL to the authorization endpoint.
	// +kubebuilder:validation:Optional
	authorizationEndpoint?: null | string @go(AuthorizationEndpoint,*string)

	// Contains the client parameters for OAuth authorization. Contains the following two parameters.
	// +kubebuilder:validation:Optional
	clientParameters?: [...#ClientParametersParameters] @go(ClientParameters,[]ClientParametersParameters)

	// A password for the authorization. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Optional
	httpMethod?: null | string @go(HTTPMethod,*string)

	// OAuth Http Parameters are additional credentials used to sign the request to the authorization endpoint to exchange the OAuth Client information for an access token. Secret values are stored and managed by AWS Secrets Manager. A maximum of 1 are allowed. Documented below.
	// +kubebuilder:validation:Optional
	oauthHttpParameters: [...#OauthHTTPParametersParameters] @go(OauthHTTPParameters,[]OauthHTTPParametersParameters)
}

#QueryStringInitParameters: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#QueryStringObservation: {
	// Specified whether the value is secret.
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	key?: null | string @go(Key,*string)
}

#QueryStringParameters: {
	// Specified whether the value is secret.
	// +kubebuilder:validation:Optional
	isValueSecret?: null | bool @go(IsValueSecret,*bool)

	// Header Name.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Header Value. Created and stored in AWS Secrets Manager.
	// +kubebuilder:validation:Optional
	valueSecretRef?: null | v1.#SecretKeySelector @go(ValueSecretRef,*v1.SecretKeySelector)
}

// ConnectionSpec defines the desired state of Connection
#ConnectionSpec: {
	v1.#ResourceSpec
	forProvider: #ConnectionParameters @go(ForProvider)

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
	initProvider?: #ConnectionInitParameters @go(InitProvider)
}

// ConnectionStatus defines the observed state of Connection.
#ConnectionStatus: {
	v1.#ResourceStatus
	atProvider?: #ConnectionObservation @go(AtProvider)
}

// Connection is the Schema for the Connections API. Provides an EventBridge connection resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Connection: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.authParameters) || (has(self.initProvider) && has(self.initProvider.authParameters))",message="spec.forProvider.authParameters is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.authorizationType) || (has(self.initProvider) && has(self.initProvider.authorizationType))",message="spec.forProvider.authorizationType is a required parameter"
	spec:    #ConnectionSpec   @go(Spec)
	status?: #ConnectionStatus @go(Status)
}

// ConnectionList contains a list of Connections
#ConnectionList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Connection] @go(Items,[]Connection)
}