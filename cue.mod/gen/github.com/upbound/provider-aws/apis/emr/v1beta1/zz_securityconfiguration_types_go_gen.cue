// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/emr/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#SecurityConfigurationInitParameters: {
	// A JSON formatted Security Configuration
	configuration?: null | string @go(Configuration,*string)
}

#SecurityConfigurationObservation: {
	// A JSON formatted Security Configuration
	configuration?: null | string @go(Configuration,*string)

	// Date the Security Configuration was created
	creationDate?: null | string @go(CreationDate,*string)

	// The ID of the EMR Security Configuration (Same as the name)
	id?: null | string @go(ID,*string)
}

#SecurityConfigurationParameters: {
	// A JSON formatted Security Configuration
	// +kubebuilder:validation:Optional
	configuration?: null | string @go(Configuration,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// SecurityConfigurationSpec defines the desired state of SecurityConfiguration
#SecurityConfigurationSpec: {
	v1.#ResourceSpec
	forProvider: #SecurityConfigurationParameters @go(ForProvider)

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
	initProvider?: #SecurityConfigurationInitParameters @go(InitProvider)
}

// SecurityConfigurationStatus defines the observed state of SecurityConfiguration.
#SecurityConfigurationStatus: {
	v1.#ResourceStatus
	atProvider?: #SecurityConfigurationObservation @go(AtProvider)
}

// SecurityConfiguration is the Schema for the SecurityConfigurations API. Provides a resource to manage AWS EMR Security Configurations
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#SecurityConfiguration: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.configuration) || (has(self.initProvider) && has(self.initProvider.configuration))",message="spec.forProvider.configuration is a required parameter"
	spec:    #SecurityConfigurationSpec   @go(Spec)
	status?: #SecurityConfigurationStatus @go(Status)
}

// SecurityConfigurationList contains a list of SecurityConfigurations
#SecurityConfigurationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#SecurityConfiguration] @go(Items,[]SecurityConfiguration)
}
