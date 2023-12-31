// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/chime/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#RouteInitParameters: {
	// The FQDN or IP address to contact for origination traffic.
	host?: null | string @go(Host,*string)

	// The designated origination route port. Defaults to 5060.
	port?: null | float64 @go(Port,*float64)

	// The priority associated with the host, with 1 being the highest priority. Higher priority hosts are attempted first.
	priority?: null | float64 @go(Priority,*float64)

	// The protocol to use for the origination route. Encryption-enabled Amazon Chime Voice Connectors use TCP protocol by default.
	protocol?: null | string @go(Protocol,*string)

	// The weight associated with the host. If hosts are equal in priority, calls are redistributed among them based on their relative weight.
	weight?: null | float64 @go(Weight,*float64)
}

#RouteObservation: {
	// The FQDN or IP address to contact for origination traffic.
	host?: null | string @go(Host,*string)

	// The designated origination route port. Defaults to 5060.
	port?: null | float64 @go(Port,*float64)

	// The priority associated with the host, with 1 being the highest priority. Higher priority hosts are attempted first.
	priority?: null | float64 @go(Priority,*float64)

	// The protocol to use for the origination route. Encryption-enabled Amazon Chime Voice Connectors use TCP protocol by default.
	protocol?: null | string @go(Protocol,*string)

	// The weight associated with the host. If hosts are equal in priority, calls are redistributed among them based on their relative weight.
	weight?: null | float64 @go(Weight,*float64)
}

#RouteParameters: {
	// The FQDN or IP address to contact for origination traffic.
	// +kubebuilder:validation:Optional
	host?: null | string @go(Host,*string)

	// The designated origination route port. Defaults to 5060.
	// +kubebuilder:validation:Optional
	port?: null | float64 @go(Port,*float64)

	// The priority associated with the host, with 1 being the highest priority. Higher priority hosts are attempted first.
	// +kubebuilder:validation:Optional
	priority?: null | float64 @go(Priority,*float64)

	// The protocol to use for the origination route. Encryption-enabled Amazon Chime Voice Connectors use TCP protocol by default.
	// +kubebuilder:validation:Optional
	protocol?: null | string @go(Protocol,*string)

	// The weight associated with the host. If hosts are equal in priority, calls are redistributed among them based on their relative weight.
	// +kubebuilder:validation:Optional
	weight?: null | float64 @go(Weight,*float64)
}

#VoiceConnectorOriginationInitParameters: {
	// When origination settings are disabled, inbound calls are not enabled for your Amazon Chime Voice Connector.
	disabled?: null | bool @go(Disabled,*bool)

	// Set of call distribution properties defined for your SIP hosts. See route below for more details. Minimum of 1. Maximum of 20.
	route?: [...#RouteInitParameters] @go(Route,[]RouteInitParameters)
}

#VoiceConnectorOriginationObservation: {
	// When origination settings are disabled, inbound calls are not enabled for your Amazon Chime Voice Connector.
	disabled?: null | bool @go(Disabled,*bool)

	// The Amazon Chime Voice Connector ID.
	id?: null | string @go(ID,*string)

	// Set of call distribution properties defined for your SIP hosts. See route below for more details. Minimum of 1. Maximum of 20.
	route?: [...#RouteObservation] @go(Route,[]RouteObservation)

	// The Amazon Chime Voice Connector ID.
	voiceConnectorId?: null | string @go(VoiceConnectorID,*string)
}

#VoiceConnectorOriginationParameters: {
	// When origination settings are disabled, inbound calls are not enabled for your Amazon Chime Voice Connector.
	// +kubebuilder:validation:Optional
	disabled?: null | bool @go(Disabled,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Set of call distribution properties defined for your SIP hosts. See route below for more details. Minimum of 1. Maximum of 20.
	// +kubebuilder:validation:Optional
	route?: [...#RouteParameters] @go(Route,[]RouteParameters)

	// The Amazon Chime Voice Connector ID.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/chime/v1beta1.VoiceConnector
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	voiceConnectorId?: null | string @go(VoiceConnectorID,*string)

	// Reference to a VoiceConnector in chime to populate voiceConnectorId.
	// +kubebuilder:validation:Optional
	voiceConnectorIdRef?: null | v1.#Reference @go(VoiceConnectorIDRef,*v1.Reference)

	// Selector for a VoiceConnector in chime to populate voiceConnectorId.
	// +kubebuilder:validation:Optional
	voiceConnectorIdSelector?: null | v1.#Selector @go(VoiceConnectorIDSelector,*v1.Selector)
}

// VoiceConnectorOriginationSpec defines the desired state of VoiceConnectorOrigination
#VoiceConnectorOriginationSpec: {
	v1.#ResourceSpec
	forProvider: #VoiceConnectorOriginationParameters @go(ForProvider)

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
	initProvider?: #VoiceConnectorOriginationInitParameters @go(InitProvider)
}

// VoiceConnectorOriginationStatus defines the observed state of VoiceConnectorOrigination.
#VoiceConnectorOriginationStatus: {
	v1.#ResourceStatus
	atProvider?: #VoiceConnectorOriginationObservation @go(AtProvider)
}

// VoiceConnectorOrigination is the Schema for the VoiceConnectorOriginations API. Enable origination settings to control inbound calling to your SIP infrastructure.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#VoiceConnectorOrigination: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.route) || (has(self.initProvider) && has(self.initProvider.route))",message="spec.forProvider.route is a required parameter"
	spec:    #VoiceConnectorOriginationSpec   @go(Spec)
	status?: #VoiceConnectorOriginationStatus @go(Status)
}

// VoiceConnectorOriginationList contains a list of VoiceConnectorOriginations
#VoiceConnectorOriginationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VoiceConnectorOrigination] @go(Items,[]VoiceConnectorOrigination)
}
