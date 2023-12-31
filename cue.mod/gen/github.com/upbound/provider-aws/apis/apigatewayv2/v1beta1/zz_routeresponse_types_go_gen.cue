// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/apigatewayv2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#RouteResponseInitParameters: {
	// The model selection expression for the route response.
	modelSelectionExpression?: null | string @go(ModelSelectionExpression,*string)

	// Response models for the route response.
	responseModels?: {[string]: null | string} @go(ResponseModels,map[string]*string)

	// Route response key.
	routeResponseKey?: null | string @go(RouteResponseKey,*string)
}

#RouteResponseObservation: {
	// API identifier.
	apiId?: null | string @go(APIID,*string)

	// Route response identifier.
	id?: null | string @go(ID,*string)

	// The model selection expression for the route response.
	modelSelectionExpression?: null | string @go(ModelSelectionExpression,*string)

	// Response models for the route response.
	responseModels?: {[string]: null | string} @go(ResponseModels,map[string]*string)

	// Identifier of the aws_apigatewayv2_route.
	routeId?: null | string @go(RouteID,*string)

	// Route response key.
	routeResponseKey?: null | string @go(RouteResponseKey,*string)
}

#RouteResponseParameters: {
	// API identifier.
	// +crossplane:generate:reference:type=API
	// +kubebuilder:validation:Optional
	apiId?: null | string @go(APIID,*string)

	// Reference to a API to populate apiId.
	// +kubebuilder:validation:Optional
	apiIdRef?: null | v1.#Reference @go(APIIDRef,*v1.Reference)

	// Selector for a API to populate apiId.
	// +kubebuilder:validation:Optional
	apiIdSelector?: null | v1.#Selector @go(APIIDSelector,*v1.Selector)

	// The model selection expression for the route response.
	// +kubebuilder:validation:Optional
	modelSelectionExpression?: null | string @go(ModelSelectionExpression,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Response models for the route response.
	// +kubebuilder:validation:Optional
	responseModels?: {[string]: null | string} @go(ResponseModels,map[string]*string)

	// Identifier of the aws_apigatewayv2_route.
	// +crossplane:generate:reference:type=Route
	// +kubebuilder:validation:Optional
	routeId?: null | string @go(RouteID,*string)

	// Reference to a Route to populate routeId.
	// +kubebuilder:validation:Optional
	routeIdRef?: null | v1.#Reference @go(RouteIDRef,*v1.Reference)

	// Selector for a Route to populate routeId.
	// +kubebuilder:validation:Optional
	routeIdSelector?: null | v1.#Selector @go(RouteIDSelector,*v1.Selector)

	// Route response key.
	// +kubebuilder:validation:Optional
	routeResponseKey?: null | string @go(RouteResponseKey,*string)
}

// RouteResponseSpec defines the desired state of RouteResponse
#RouteResponseSpec: {
	v1.#ResourceSpec
	forProvider: #RouteResponseParameters @go(ForProvider)

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
	initProvider?: #RouteResponseInitParameters @go(InitProvider)
}

// RouteResponseStatus defines the observed state of RouteResponse.
#RouteResponseStatus: {
	v1.#ResourceStatus
	atProvider?: #RouteResponseObservation @go(AtProvider)
}

// RouteResponse is the Schema for the RouteResponses API. Manages an Amazon API Gateway Version 2 route response.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#RouteResponse: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.routeResponseKey) || (has(self.initProvider) && has(self.initProvider.routeResponseKey))",message="spec.forProvider.routeResponseKey is a required parameter"
	spec:    #RouteResponseSpec   @go(Spec)
	status?: #RouteResponseStatus @go(Status)
}

// RouteResponseList contains a list of RouteResponses
#RouteResponseList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#RouteResponse] @go(Items,[]RouteResponse)
}
