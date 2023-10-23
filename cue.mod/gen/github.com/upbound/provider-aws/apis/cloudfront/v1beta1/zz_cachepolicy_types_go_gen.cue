// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/cloudfront/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#CachePolicyInitParameters: {
	// A comment to describe the cache policy.
	comment?: null | string @go(Comment,*string)

	// The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
	defaultTtl?: null | float64 @go(DefaultTTL,*float64)

	// The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
	maxTtl?: null | float64 @go(MaxTTL,*float64)

	// The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
	minTtl?: null | float64 @go(MinTTL,*float64)

	// A unique name to identify the cache policy.
	name?: null | string @go(Name,*string)

	// The HTTP headers, cookies, and URL query strings to include in the cache key. See Parameters In Cache Key And Forwarded To Origin for more information.
	parametersInCacheKeyAndForwardedToOrigin?: [...#ParametersInCacheKeyAndForwardedToOriginInitParameters] @go(ParametersInCacheKeyAndForwardedToOrigin,[]ParametersInCacheKeyAndForwardedToOriginInitParameters)
}

#CachePolicyObservation: {
	// A comment to describe the cache policy.
	comment?: null | string @go(Comment,*string)

	// The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
	defaultTtl?: null | float64 @go(DefaultTTL,*float64)

	// The current version of the cache policy.
	etag?: null | string @go(Etag,*string)

	// The identifier for the cache policy.
	id?: null | string @go(ID,*string)

	// The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
	maxTtl?: null | float64 @go(MaxTTL,*float64)

	// The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
	minTtl?: null | float64 @go(MinTTL,*float64)

	// A unique name to identify the cache policy.
	name?: null | string @go(Name,*string)

	// The HTTP headers, cookies, and URL query strings to include in the cache key. See Parameters In Cache Key And Forwarded To Origin for more information.
	parametersInCacheKeyAndForwardedToOrigin?: [...#ParametersInCacheKeyAndForwardedToOriginObservation] @go(ParametersInCacheKeyAndForwardedToOrigin,[]ParametersInCacheKeyAndForwardedToOriginObservation)
}

#CachePolicyParameters: {
	// A comment to describe the cache policy.
	// +kubebuilder:validation:Optional
	comment?: null | string @go(Comment,*string)

	// The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
	// +kubebuilder:validation:Optional
	defaultTtl?: null | float64 @go(DefaultTTL,*float64)

	// The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
	// +kubebuilder:validation:Optional
	maxTtl?: null | float64 @go(MaxTTL,*float64)

	// The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
	// +kubebuilder:validation:Optional
	minTtl?: null | float64 @go(MinTTL,*float64)

	// A unique name to identify the cache policy.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// The HTTP headers, cookies, and URL query strings to include in the cache key. See Parameters In Cache Key And Forwarded To Origin for more information.
	// +kubebuilder:validation:Optional
	parametersInCacheKeyAndForwardedToOrigin?: [...#ParametersInCacheKeyAndForwardedToOriginParameters] @go(ParametersInCacheKeyAndForwardedToOrigin,[]ParametersInCacheKeyAndForwardedToOriginParameters)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

#CookiesConfigInitParameters: {
	// Determines whether any cookies in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
	cookieBehavior?: null | string @go(CookieBehavior,*string)

	// Object that contains a list of cookie names. See Items for more information.
	cookies?: [...#CookiesInitParameters] @go(Cookies,[]CookiesInitParameters)
}

#CookiesConfigObservation: {
	// Determines whether any cookies in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
	cookieBehavior?: null | string @go(CookieBehavior,*string)

	// Object that contains a list of cookie names. See Items for more information.
	cookies?: [...#CookiesObservation] @go(Cookies,[]CookiesObservation)
}

#CookiesConfigParameters: {
	// Determines whether any cookies in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
	// +kubebuilder:validation:Optional
	cookieBehavior?: null | string @go(CookieBehavior,*string)

	// Object that contains a list of cookie names. See Items for more information.
	// +kubebuilder:validation:Optional
	cookies?: [...#CookiesParameters] @go(Cookies,[]CookiesParameters)
}

#CookiesInitParameters: {
	// A list of item names (cookies, headers, or query strings).
	items?: [...null | string] @go(Items,[]*string)
}

#CookiesObservation: {
	// A list of item names (cookies, headers, or query strings).
	items?: [...null | string] @go(Items,[]*string)
}

#CookiesParameters: {
	// A list of item names (cookies, headers, or query strings).
	// +kubebuilder:validation:Optional
	items?: [...null | string] @go(Items,[]*string)
}

#HeadersConfigInitParameters: {
	// Determines whether any HTTP headers are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist.
	headerBehavior?: null | string @go(HeaderBehavior,*string)

	// Object that contains a list of header names. See Items for more information.
	headers?: [...#HeadersInitParameters] @go(Headers,[]HeadersInitParameters)
}

#HeadersConfigObservation: {
	// Determines whether any HTTP headers are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist.
	headerBehavior?: null | string @go(HeaderBehavior,*string)

	// Object that contains a list of header names. See Items for more information.
	headers?: [...#HeadersObservation] @go(Headers,[]HeadersObservation)
}

#HeadersConfigParameters: {
	// Determines whether any HTTP headers are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist.
	// +kubebuilder:validation:Optional
	headerBehavior?: null | string @go(HeaderBehavior,*string)

	// Object that contains a list of header names. See Items for more information.
	// +kubebuilder:validation:Optional
	headers?: [...#HeadersParameters] @go(Headers,[]HeadersParameters)
}

#HeadersInitParameters: {
	// A list of item names (cookies, headers, or query strings).
	items?: [...null | string] @go(Items,[]*string)
}

#HeadersObservation: {
	// A list of item names (cookies, headers, or query strings).
	items?: [...null | string] @go(Items,[]*string)
}

#HeadersParameters: {
	// A list of item names (cookies, headers, or query strings).
	// +kubebuilder:validation:Optional
	items?: [...null | string] @go(Items,[]*string)
}

#ParametersInCacheKeyAndForwardedToOriginInitParameters: {
	// Object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Cookies Config for more information.
	cookiesConfig?: [...#CookiesConfigInitParameters] @go(CookiesConfig,[]CookiesConfigInitParameters)

	// A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin.
	enableAcceptEncodingBrotli?: null | bool @go(EnableAcceptEncodingBrotli,*bool)

	// A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin.
	enableAcceptEncodingGzip?: null | bool @go(EnableAcceptEncodingGzip,*bool)

	// Object that determines whether any HTTP headers (and if so, which headers) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Headers Config for more information.
	headersConfig?: [...#HeadersConfigInitParameters] @go(HeadersConfig,[]HeadersConfigInitParameters)

	// Object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Query String Config for more information.
	queryStringsConfig?: [...#QueryStringsConfigInitParameters] @go(QueryStringsConfig,[]QueryStringsConfigInitParameters)
}

#ParametersInCacheKeyAndForwardedToOriginObservation: {
	// Object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Cookies Config for more information.
	cookiesConfig?: [...#CookiesConfigObservation] @go(CookiesConfig,[]CookiesConfigObservation)

	// A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin.
	enableAcceptEncodingBrotli?: null | bool @go(EnableAcceptEncodingBrotli,*bool)

	// A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin.
	enableAcceptEncodingGzip?: null | bool @go(EnableAcceptEncodingGzip,*bool)

	// Object that determines whether any HTTP headers (and if so, which headers) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Headers Config for more information.
	headersConfig?: [...#HeadersConfigObservation] @go(HeadersConfig,[]HeadersConfigObservation)

	// Object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Query String Config for more information.
	queryStringsConfig?: [...#QueryStringsConfigObservation] @go(QueryStringsConfig,[]QueryStringsConfigObservation)
}

#ParametersInCacheKeyAndForwardedToOriginParameters: {
	// Object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Cookies Config for more information.
	// +kubebuilder:validation:Optional
	cookiesConfig: [...#CookiesConfigParameters] @go(CookiesConfig,[]CookiesConfigParameters)

	// A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin.
	// +kubebuilder:validation:Optional
	enableAcceptEncodingBrotli?: null | bool @go(EnableAcceptEncodingBrotli,*bool)

	// A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin.
	// +kubebuilder:validation:Optional
	enableAcceptEncodingGzip?: null | bool @go(EnableAcceptEncodingGzip,*bool)

	// Object that determines whether any HTTP headers (and if so, which headers) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Headers Config for more information.
	// +kubebuilder:validation:Optional
	headersConfig: [...#HeadersConfigParameters] @go(HeadersConfig,[]HeadersConfigParameters)

	// Object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Query String Config for more information.
	// +kubebuilder:validation:Optional
	queryStringsConfig: [...#QueryStringsConfigParameters] @go(QueryStringsConfig,[]QueryStringsConfigParameters)
}

#QueryStringsConfigInitParameters: {
	// Determines whether any URL query strings in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
	queryStringBehavior?: null | string @go(QueryStringBehavior,*string)

	// Object that contains a list of query string names. See Items for more information.
	queryStrings?: [...#QueryStringsInitParameters] @go(QueryStrings,[]QueryStringsInitParameters)
}

#QueryStringsConfigObservation: {
	// Determines whether any URL query strings in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
	queryStringBehavior?: null | string @go(QueryStringBehavior,*string)

	// Object that contains a list of query string names. See Items for more information.
	queryStrings?: [...#QueryStringsObservation] @go(QueryStrings,[]QueryStringsObservation)
}

#QueryStringsConfigParameters: {
	// Determines whether any URL query strings in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
	// +kubebuilder:validation:Optional
	queryStringBehavior?: null | string @go(QueryStringBehavior,*string)

	// Object that contains a list of query string names. See Items for more information.
	// +kubebuilder:validation:Optional
	queryStrings?: [...#QueryStringsParameters] @go(QueryStrings,[]QueryStringsParameters)
}

#QueryStringsInitParameters: {
	// A list of item names (cookies, headers, or query strings).
	items?: [...null | string] @go(Items,[]*string)
}

#QueryStringsObservation: {
	// A list of item names (cookies, headers, or query strings).
	items?: [...null | string] @go(Items,[]*string)
}

#QueryStringsParameters: {
	// A list of item names (cookies, headers, or query strings).
	// +kubebuilder:validation:Optional
	items?: [...null | string] @go(Items,[]*string)
}

// CachePolicySpec defines the desired state of CachePolicy
#CachePolicySpec: {
	v1.#ResourceSpec
	forProvider: #CachePolicyParameters @go(ForProvider)

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
	initProvider?: #CachePolicyInitParameters @go(InitProvider)
}

// CachePolicyStatus defines the observed state of CachePolicy.
#CachePolicyStatus: {
	v1.#ResourceStatus
	atProvider?: #CachePolicyObservation @go(AtProvider)
}

// CachePolicy is the Schema for the CachePolicys API. Provides a cache policy for a CloudFront ditribution. When it’s attached to a cache behavior, the cache policy determines the values that CloudFront includes in the cache key. These values can include HTTP headers, cookies, and URL query strings. CloudFront uses the cache key to find an object in its cache that it can return to the viewer. It also determines the default, minimum, and maximum time to live (TTL) values that you want objects to stay in the CloudFront cache.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#CachePolicy: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.parametersInCacheKeyAndForwardedToOrigin) || (has(self.initProvider) && has(self.initProvider.parametersInCacheKeyAndForwardedToOrigin))",message="spec.forProvider.parametersInCacheKeyAndForwardedToOrigin is a required parameter"
	spec:    #CachePolicySpec   @go(Spec)
	status?: #CachePolicyStatus @go(Status)
}

// CachePolicyList contains a list of CachePolicys
#CachePolicyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#CachePolicy] @go(Items,[]CachePolicy)
}
