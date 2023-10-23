// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/connect/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#InstanceInitParameters: {
	// Specifies whether auto resolve best voices is enabled. Defaults to true.
	autoResolveBestVoicesEnabled?: null | bool @go(AutoResolveBestVoicesEnabled,*bool)

	// Specifies whether contact flow logs are enabled. Defaults to false.
	contactFlowLogsEnabled?: null | bool @go(ContactFlowLogsEnabled,*bool)

	// Specifies whether contact lens is enabled. Defaults to true.
	contactLensEnabled?: null | bool @go(ContactLensEnabled,*bool)

	// Specifies whether early media for outbound calls is enabled . Defaults to true if outbound calls is enabled.
	earlyMediaEnabled?: null | bool @go(EarlyMediaEnabled,*bool)

	// Specifies the identity management type attached to the instance. Allowed Values are: SAML, CONNECT_MANAGED, EXISTING_DIRECTORY.
	identityManagementType?: null | string @go(IdentityManagementType,*string)

	// Specifies whether inbound calls are enabled.
	inboundCallsEnabled?: null | bool @go(InboundCallsEnabled,*bool)

	// Specifies the name of the instance. Required if directory_id not specified.
	instanceAlias?: null | string @go(InstanceAlias,*string)

	// Specifies whether multi-party calls/conference is enabled. Defaults to false.
	multiPartyConferenceEnabled?: null | bool @go(MultiPartyConferenceEnabled,*bool)

	// Specifies whether outbound calls are enabled.
	outboundCallsEnabled?: null | bool @go(OutboundCallsEnabled,*bool)
}

#InstanceObservation: {
	// Amazon Resource Name (ARN) of the instance.
	arn?: null | string @go(Arn,*string)

	// Specifies whether auto resolve best voices is enabled. Defaults to true.
	autoResolveBestVoicesEnabled?: null | bool @go(AutoResolveBestVoicesEnabled,*bool)

	// Specifies whether contact flow logs are enabled. Defaults to false.
	contactFlowLogsEnabled?: null | bool @go(ContactFlowLogsEnabled,*bool)

	// Specifies whether contact lens is enabled. Defaults to true.
	contactLensEnabled?: null | bool @go(ContactLensEnabled,*bool)

	// When the instance was created.
	createdTime?: null | string @go(CreatedTime,*string)

	// The identifier for the directory if identity_management_type is EXISTING_DIRECTORY.
	directoryId?: null | string @go(DirectoryID,*string)

	// Specifies whether early media for outbound calls is enabled . Defaults to true if outbound calls is enabled.
	earlyMediaEnabled?: null | bool @go(EarlyMediaEnabled,*bool)

	// The identifier of the instance.
	id?: null | string @go(ID,*string)

	// Specifies the identity management type attached to the instance. Allowed Values are: SAML, CONNECT_MANAGED, EXISTING_DIRECTORY.
	identityManagementType?: null | string @go(IdentityManagementType,*string)

	// Specifies whether inbound calls are enabled.
	inboundCallsEnabled?: null | bool @go(InboundCallsEnabled,*bool)

	// Specifies the name of the instance. Required if directory_id not specified.
	instanceAlias?: null | string @go(InstanceAlias,*string)

	// Specifies whether multi-party calls/conference is enabled. Defaults to false.
	multiPartyConferenceEnabled?: null | bool @go(MultiPartyConferenceEnabled,*bool)

	// Specifies whether outbound calls are enabled.
	outboundCallsEnabled?: null | bool @go(OutboundCallsEnabled,*bool)

	// The service role of the instance.
	serviceRole?: null | string @go(ServiceRole,*string)

	// The state of the instance.
	status?: null | string @go(Status,*string)
}

#InstanceParameters: {
	// Specifies whether auto resolve best voices is enabled. Defaults to true.
	// +kubebuilder:validation:Optional
	autoResolveBestVoicesEnabled?: null | bool @go(AutoResolveBestVoicesEnabled,*bool)

	// Specifies whether contact flow logs are enabled. Defaults to false.
	// +kubebuilder:validation:Optional
	contactFlowLogsEnabled?: null | bool @go(ContactFlowLogsEnabled,*bool)

	// Specifies whether contact lens is enabled. Defaults to true.
	// +kubebuilder:validation:Optional
	contactLensEnabled?: null | bool @go(ContactLensEnabled,*bool)

	// The identifier for the directory if identity_management_type is EXISTING_DIRECTORY.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ds/v1beta1.Directory
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	directoryId?: null | string @go(DirectoryID,*string)

	// Reference to a Directory in ds to populate directoryId.
	// +kubebuilder:validation:Optional
	directoryIdRef?: null | v1.#Reference @go(DirectoryIDRef,*v1.Reference)

	// Selector for a Directory in ds to populate directoryId.
	// +kubebuilder:validation:Optional
	directoryIdSelector?: null | v1.#Selector @go(DirectoryIDSelector,*v1.Selector)

	// Specifies whether early media for outbound calls is enabled . Defaults to true if outbound calls is enabled.
	// +kubebuilder:validation:Optional
	earlyMediaEnabled?: null | bool @go(EarlyMediaEnabled,*bool)

	// Specifies the identity management type attached to the instance. Allowed Values are: SAML, CONNECT_MANAGED, EXISTING_DIRECTORY.
	// +kubebuilder:validation:Optional
	identityManagementType?: null | string @go(IdentityManagementType,*string)

	// Specifies whether inbound calls are enabled.
	// +kubebuilder:validation:Optional
	inboundCallsEnabled?: null | bool @go(InboundCallsEnabled,*bool)

	// Specifies the name of the instance. Required if directory_id not specified.
	// +kubebuilder:validation:Optional
	instanceAlias?: null | string @go(InstanceAlias,*string)

	// Specifies whether multi-party calls/conference is enabled. Defaults to false.
	// +kubebuilder:validation:Optional
	multiPartyConferenceEnabled?: null | bool @go(MultiPartyConferenceEnabled,*bool)

	// Specifies whether outbound calls are enabled.
	// +kubebuilder:validation:Optional
	outboundCallsEnabled?: null | bool @go(OutboundCallsEnabled,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// InstanceSpec defines the desired state of Instance
#InstanceSpec: {
	v1.#ResourceSpec
	forProvider: #InstanceParameters @go(ForProvider)

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
	initProvider?: #InstanceInitParameters @go(InitProvider)
}

// InstanceStatus defines the observed state of Instance.
#InstanceStatus: {
	v1.#ResourceStatus
	atProvider?: #InstanceObservation @go(AtProvider)
}

// Instance is the Schema for the Instances API. Provides details about a specific Connect Instance.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Instance: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.identityManagementType) || (has(self.initProvider) && has(self.initProvider.identityManagementType))",message="spec.forProvider.identityManagementType is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.inboundCallsEnabled) || (has(self.initProvider) && has(self.initProvider.inboundCallsEnabled))",message="spec.forProvider.inboundCallsEnabled is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.outboundCallsEnabled) || (has(self.initProvider) && has(self.initProvider.outboundCallsEnabled))",message="spec.forProvider.outboundCallsEnabled is a required parameter"
	spec:    #InstanceSpec   @go(Spec)
	status?: #InstanceStatus @go(Status)
}

// InstanceList contains a list of Instances
#InstanceList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Instance] @go(Items,[]Instance)
}
