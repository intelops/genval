// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/cloudwatchevents/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#APIDestinationInitParameters: {
	// The description of the new API Destination. Maximum of 512 characters.
	description?: null | string @go(Description,*string)

	// Select the HTTP method used for the invocation endpoint, such as GET, POST, PUT, etc.
	httpMethod?: null | string @go(HTTPMethod,*string)

	// URL endpoint to invoke as a target. This could be a valid endpoint generated by a partner service. You can include "*" as path parameters wildcards to be set from the Target HttpParameters.
	invocationEndpoint?: null | string @go(InvocationEndpoint,*string)

	// Enter the maximum number of invocations per second to allow for this destination. Enter a value greater than 0 (default 300).
	invocationRateLimitPerSecond?: null | float64 @go(InvocationRateLimitPerSecond,*float64)
}

#APIDestinationObservation: {
	// The Amazon Resource Name (ARN) of the event API Destination.
	arn?: null | string @go(Arn,*string)

	// ARN of the EventBridge Connection to use for the API Destination.
	connectionArn?: null | string @go(ConnectionArn,*string)

	// The description of the new API Destination. Maximum of 512 characters.
	description?: null | string @go(Description,*string)

	// Select the HTTP method used for the invocation endpoint, such as GET, POST, PUT, etc.
	httpMethod?: null | string @go(HTTPMethod,*string)
	id?:         null | string @go(ID,*string)

	// URL endpoint to invoke as a target. This could be a valid endpoint generated by a partner service. You can include "*" as path parameters wildcards to be set from the Target HttpParameters.
	invocationEndpoint?: null | string @go(InvocationEndpoint,*string)

	// Enter the maximum number of invocations per second to allow for this destination. Enter a value greater than 0 (default 300).
	invocationRateLimitPerSecond?: null | float64 @go(InvocationRateLimitPerSecond,*float64)
}

#APIDestinationParameters: {
	// ARN of the EventBridge Connection to use for the API Destination.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/cloudwatchevents/v1beta1.Connection
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	connectionArn?: null | string @go(ConnectionArn,*string)

	// Reference to a Connection in cloudwatchevents to populate connectionArn.
	// +kubebuilder:validation:Optional
	connectionArnRef?: null | v1.#Reference @go(ConnectionArnRef,*v1.Reference)

	// Selector for a Connection in cloudwatchevents to populate connectionArn.
	// +kubebuilder:validation:Optional
	connectionArnSelector?: null | v1.#Selector @go(ConnectionArnSelector,*v1.Selector)

	// The description of the new API Destination. Maximum of 512 characters.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Select the HTTP method used for the invocation endpoint, such as GET, POST, PUT, etc.
	// +kubebuilder:validation:Optional
	httpMethod?: null | string @go(HTTPMethod,*string)

	// URL endpoint to invoke as a target. This could be a valid endpoint generated by a partner service. You can include "*" as path parameters wildcards to be set from the Target HttpParameters.
	// +kubebuilder:validation:Optional
	invocationEndpoint?: null | string @go(InvocationEndpoint,*string)

	// Enter the maximum number of invocations per second to allow for this destination. Enter a value greater than 0 (default 300).
	// +kubebuilder:validation:Optional
	invocationRateLimitPerSecond?: null | float64 @go(InvocationRateLimitPerSecond,*float64)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// APIDestinationSpec defines the desired state of APIDestination
#APIDestinationSpec: {
	v1.#ResourceSpec
	forProvider: #APIDestinationParameters @go(ForProvider)

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
	initProvider?: #APIDestinationInitParameters @go(InitProvider)
}

// APIDestinationStatus defines the observed state of APIDestination.
#APIDestinationStatus: {
	v1.#ResourceStatus
	atProvider?: #APIDestinationObservation @go(AtProvider)
}

// APIDestination is the Schema for the APIDestinations API. Provides an EventBridge event API Destination resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#APIDestination: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.httpMethod) || (has(self.initProvider) && has(self.initProvider.httpMethod))",message="spec.forProvider.httpMethod is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.invocationEndpoint) || (has(self.initProvider) && has(self.initProvider.invocationEndpoint))",message="spec.forProvider.invocationEndpoint is a required parameter"
	spec:    #APIDestinationSpec   @go(Spec)
	status?: #APIDestinationStatus @go(Status)
}

// APIDestinationList contains a list of APIDestinations
#APIDestinationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#APIDestination] @go(Items,[]APIDestination)
}
