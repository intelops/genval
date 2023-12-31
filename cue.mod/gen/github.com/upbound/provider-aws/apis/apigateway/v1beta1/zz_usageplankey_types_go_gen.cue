// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/apigateway/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#UsagePlanKeyInitParameters: {
	// Type of the API key resource. Currently, the valid key type is API_KEY.
	keyType?: null | string @go(KeyType,*string)
}

#UsagePlanKeyObservation: {
	// ID of a usage plan key.
	id?: null | string @go(ID,*string)

	// Identifier of the API key resource.
	keyId?: null | string @go(KeyID,*string)

	// Type of the API key resource. Currently, the valid key type is API_KEY.
	keyType?: null | string @go(KeyType,*string)

	// Name of a usage plan key.
	name?: null | string @go(Name,*string)

	// Id of the usage plan resource representing to associate the key to.
	usagePlanId?: null | string @go(UsagePlanID,*string)

	// Value of a usage plan key.
	value?: null | string @go(Value,*string)
}

#UsagePlanKeyParameters: {
	// Identifier of the API key resource.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/apigateway/v1beta1.APIKey
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	keyId?: null | string @go(KeyID,*string)

	// Reference to a APIKey in apigateway to populate keyId.
	// +kubebuilder:validation:Optional
	keyIdRef?: null | v1.#Reference @go(KeyIDRef,*v1.Reference)

	// Selector for a APIKey in apigateway to populate keyId.
	// +kubebuilder:validation:Optional
	keyIdSelector?: null | v1.#Selector @go(KeyIDSelector,*v1.Selector)

	// Type of the API key resource. Currently, the valid key type is API_KEY.
	// +kubebuilder:validation:Optional
	keyType?: null | string @go(KeyType,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Id of the usage plan resource representing to associate the key to.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/apigateway/v1beta1.UsagePlan
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	usagePlanId?: null | string @go(UsagePlanID,*string)

	// Reference to a UsagePlan in apigateway to populate usagePlanId.
	// +kubebuilder:validation:Optional
	usagePlanIdRef?: null | v1.#Reference @go(UsagePlanIDRef,*v1.Reference)

	// Selector for a UsagePlan in apigateway to populate usagePlanId.
	// +kubebuilder:validation:Optional
	usagePlanIdSelector?: null | v1.#Selector @go(UsagePlanIDSelector,*v1.Selector)
}

// UsagePlanKeySpec defines the desired state of UsagePlanKey
#UsagePlanKeySpec: {
	v1.#ResourceSpec
	forProvider: #UsagePlanKeyParameters @go(ForProvider)

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
	initProvider?: #UsagePlanKeyInitParameters @go(InitProvider)
}

// UsagePlanKeyStatus defines the observed state of UsagePlanKey.
#UsagePlanKeyStatus: {
	v1.#ResourceStatus
	atProvider?: #UsagePlanKeyObservation @go(AtProvider)
}

// UsagePlanKey is the Schema for the UsagePlanKeys API. Provides an API Gateway Usage Plan Key.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#UsagePlanKey: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.keyType) || (has(self.initProvider) && has(self.initProvider.keyType))",message="spec.forProvider.keyType is a required parameter"
	spec:    #UsagePlanKeySpec   @go(Spec)
	status?: #UsagePlanKeyStatus @go(Status)
}

// UsagePlanKeyList contains a list of UsagePlanKeys
#UsagePlanKeyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#UsagePlanKey] @go(Items,[]UsagePlanKey)
}
