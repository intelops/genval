// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#CidrAuthorizationContextInitParameters: {
	// The plain-text authorization message for the prefix and account.
	message?: null | string @go(Message,*string)

	// The signed authorization message for the prefix and account.
	signature?: null | string @go(Signature,*string)
}

#CidrAuthorizationContextObservation: {
	// The plain-text authorization message for the prefix and account.
	message?: null | string @go(Message,*string)

	// The signed authorization message for the prefix and account.
	signature?: null | string @go(Signature,*string)
}

#CidrAuthorizationContextParameters: {
	// The plain-text authorization message for the prefix and account.
	// +kubebuilder:validation:Optional
	message?: null | string @go(Message,*string)

	// The signed authorization message for the prefix and account.
	// +kubebuilder:validation:Optional
	signature?: null | string @go(Signature,*string)
}

#VPCIpamPoolCidrInitParameters: {
	// The CIDR you want to assign to the pool. Conflicts with netmask_length.
	cidr?: null | string @go(Cidr,*string)

	// A signed document that proves that you are authorized to bring the specified IP address range to Amazon using BYOIP. This is not stored in the state file. See cidr_authorization_context for more information.
	cidrAuthorizationContext?: [...#CidrAuthorizationContextInitParameters] @go(CidrAuthorizationContext,[]CidrAuthorizationContextInitParameters)

	// If provided, the cidr provisioned into the specified pool will be the next available cidr given this declared netmask length. Conflicts with cidr.
	netmaskLength?: null | float64 @go(NetmaskLength,*float64)
}

#VPCIpamPoolCidrObservation: {
	// The CIDR you want to assign to the pool. Conflicts with netmask_length.
	cidr?: null | string @go(Cidr,*string)

	// A signed document that proves that you are authorized to bring the specified IP address range to Amazon using BYOIP. This is not stored in the state file. See cidr_authorization_context for more information.
	cidrAuthorizationContext?: [...#CidrAuthorizationContextObservation] @go(CidrAuthorizationContext,[]CidrAuthorizationContextObservation)

	// The ID of the IPAM Pool Cidr concatenated with the IPAM Pool ID.
	id?: null | string @go(ID,*string)

	// The unique ID generated by AWS for the pool cidr.
	ipamPoolCidrId?: null | string @go(IpamPoolCidrID,*string)

	// The ID of the pool to which you want to assign a CIDR.
	ipamPoolId?: null | string @go(IpamPoolID,*string)

	// If provided, the cidr provisioned into the specified pool will be the next available cidr given this declared netmask length. Conflicts with cidr.
	netmaskLength?: null | float64 @go(NetmaskLength,*float64)
}

#VPCIpamPoolCidrParameters: {
	// The CIDR you want to assign to the pool. Conflicts with netmask_length.
	// +kubebuilder:validation:Optional
	cidr?: null | string @go(Cidr,*string)

	// A signed document that proves that you are authorized to bring the specified IP address range to Amazon using BYOIP. This is not stored in the state file. See cidr_authorization_context for more information.
	// +kubebuilder:validation:Optional
	cidrAuthorizationContext?: [...#CidrAuthorizationContextParameters] @go(CidrAuthorizationContext,[]CidrAuthorizationContextParameters)

	// The ID of the pool to which you want to assign a CIDR.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPCIpamPool
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	ipamPoolId?: null | string @go(IpamPoolID,*string)

	// Reference to a VPCIpamPool in ec2 to populate ipamPoolId.
	// +kubebuilder:validation:Optional
	ipamPoolIdRef?: null | v1.#Reference @go(IpamPoolIDRef,*v1.Reference)

	// Selector for a VPCIpamPool in ec2 to populate ipamPoolId.
	// +kubebuilder:validation:Optional
	ipamPoolIdSelector?: null | v1.#Selector @go(IpamPoolIDSelector,*v1.Selector)

	// If provided, the cidr provisioned into the specified pool will be the next available cidr given this declared netmask length. Conflicts with cidr.
	// +kubebuilder:validation:Optional
	netmaskLength?: null | float64 @go(NetmaskLength,*float64)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// VPCIpamPoolCidrSpec defines the desired state of VPCIpamPoolCidr
#VPCIpamPoolCidrSpec: {
	v1.#ResourceSpec
	forProvider: #VPCIpamPoolCidrParameters @go(ForProvider)

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
	initProvider?: #VPCIpamPoolCidrInitParameters @go(InitProvider)
}

// VPCIpamPoolCidrStatus defines the observed state of VPCIpamPoolCidr.
#VPCIpamPoolCidrStatus: {
	v1.#ResourceStatus
	atProvider?: #VPCIpamPoolCidrObservation @go(AtProvider)
}

// VPCIpamPoolCidr is the Schema for the VPCIpamPoolCidrs API. Provisions a CIDR from an IPAM address pool.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#VPCIpamPoolCidr: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta     @go(ObjectMeta)
	spec:      #VPCIpamPoolCidrSpec   @go(Spec)
	status?:   #VPCIpamPoolCidrStatus @go(Status)
}

// VPCIpamPoolCidrList contains a list of VPCIpamPoolCidrs
#VPCIpamPoolCidrList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VPCIpamPoolCidr] @go(Items,[]VPCIpamPoolCidr)
}