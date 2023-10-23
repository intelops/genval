// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/apigateway/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ResourceInitParameters: {
	// Last path segment of this API resource.
	pathPart?: null | string @go(PathPart,*string)
}

#ResourceObservation: {
	// Resource's identifier.
	id?: null | string @go(ID,*string)

	// ID of the parent API resource
	parentId?: null | string @go(ParentID,*string)

	// Complete path for this API resource, including all parent paths.
	path?: null | string @go(Path,*string)

	// Last path segment of this API resource.
	pathPart?: null | string @go(PathPart,*string)

	// ID of the associated REST API
	restApiId?: null | string @go(RestAPIID,*string)
}

#ResourceParameters: {
	// ID of the parent API resource
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/apigateway/v1beta1.RestAPI
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("root_resource_id",true)
	// +kubebuilder:validation:Optional
	parentId?: null | string @go(ParentID,*string)

	// Reference to a RestAPI in apigateway to populate parentId.
	// +kubebuilder:validation:Optional
	parentIdRef?: null | v1.#Reference @go(ParentIDRef,*v1.Reference)

	// Selector for a RestAPI in apigateway to populate parentId.
	// +kubebuilder:validation:Optional
	parentIdSelector?: null | v1.#Selector @go(ParentIDSelector,*v1.Selector)

	// Last path segment of this API resource.
	// +kubebuilder:validation:Optional
	pathPart?: null | string @go(PathPart,*string)

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
}

// ResourceSpec defines the desired state of Resource
#ResourceSpec: {
	v1.#ResourceSpec
	forProvider: #ResourceParameters @go(ForProvider)

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
	initProvider?: #ResourceInitParameters @go(InitProvider)
}

// ResourceStatus defines the observed state of Resource.
#ResourceStatus: {
	v1.#ResourceStatus
	atProvider?: #ResourceObservation @go(AtProvider)
}

// Resource is the Schema for the Resources API. Provides an API Gateway Resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Resource: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.pathPart) || (has(self.initProvider) && has(self.initProvider.pathPart))",message="spec.forProvider.pathPart is a required parameter"
	spec:    #ResourceSpec   @go(Spec)
	status?: #ResourceStatus @go(Status)
}

// ResourceList contains a list of Resources
#ResourceList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Resource] @go(Items,[]Resource)
}
