// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/directconnect/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#HostedPrivateVirtualInterfaceAccepterInitParameters: {
	// The ID of the Direct Connect gateway to which to connect the virtual interface.
	dxGatewayId?: null | string @go(DxGatewayID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#HostedPrivateVirtualInterfaceAccepterObservation: {
	// The ARN of the virtual interface.
	arn?: null | string @go(Arn,*string)

	// The ID of the Direct Connect gateway to which to connect the virtual interface.
	dxGatewayId?: null | string @go(DxGatewayID,*string)

	// The ID of the virtual interface.
	id?: null | string @go(ID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The ID of the virtual private gateway to which to connect the virtual interface.
	vpnGatewayId?: null | string @go(VPNGatewayID,*string)

	// The ID of the Direct Connect virtual interface to accept.
	virtualInterfaceId?: null | string @go(VirtualInterfaceID,*string)
}

#HostedPrivateVirtualInterfaceAccepterParameters: {
	// The ID of the Direct Connect gateway to which to connect the virtual interface.
	// +kubebuilder:validation:Optional
	dxGatewayId?: null | string @go(DxGatewayID,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The ID of the virtual private gateway to which to connect the virtual interface.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPNGateway
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	vpnGatewayId?: null | string @go(VPNGatewayID,*string)

	// Reference to a VPNGateway in ec2 to populate vpnGatewayId.
	// +kubebuilder:validation:Optional
	vpnGatewayIdRef?: null | v1.#Reference @go(VPNGatewayIDRef,*v1.Reference)

	// Selector for a VPNGateway in ec2 to populate vpnGatewayId.
	// +kubebuilder:validation:Optional
	vpnGatewayIdSelector?: null | v1.#Selector @go(VPNGatewayIDSelector,*v1.Selector)

	// The ID of the Direct Connect virtual interface to accept.
	// +crossplane:generate:reference:type=HostedPrivateVirtualInterface
	// +kubebuilder:validation:Optional
	virtualInterfaceId?: null | string @go(VirtualInterfaceID,*string)

	// Reference to a HostedPrivateVirtualInterface to populate virtualInterfaceId.
	// +kubebuilder:validation:Optional
	virtualInterfaceIdRef?: null | v1.#Reference @go(VirtualInterfaceIDRef,*v1.Reference)

	// Selector for a HostedPrivateVirtualInterface to populate virtualInterfaceId.
	// +kubebuilder:validation:Optional
	virtualInterfaceIdSelector?: null | v1.#Selector @go(VirtualInterfaceIDSelector,*v1.Selector)
}

// HostedPrivateVirtualInterfaceAccepterSpec defines the desired state of HostedPrivateVirtualInterfaceAccepter
#HostedPrivateVirtualInterfaceAccepterSpec: {
	v1.#ResourceSpec
	forProvider: #HostedPrivateVirtualInterfaceAccepterParameters @go(ForProvider)

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
	initProvider?: #HostedPrivateVirtualInterfaceAccepterInitParameters @go(InitProvider)
}

// HostedPrivateVirtualInterfaceAccepterStatus defines the observed state of HostedPrivateVirtualInterfaceAccepter.
#HostedPrivateVirtualInterfaceAccepterStatus: {
	v1.#ResourceStatus
	atProvider?: #HostedPrivateVirtualInterfaceAccepterObservation @go(AtProvider)
}

// HostedPrivateVirtualInterfaceAccepter is the Schema for the HostedPrivateVirtualInterfaceAccepters API. Provides a resource to manage the accepter's side of a Direct Connect hosted private virtual interface.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#HostedPrivateVirtualInterfaceAccepter: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta                           @go(ObjectMeta)
	spec:      #HostedPrivateVirtualInterfaceAccepterSpec   @go(Spec)
	status?:   #HostedPrivateVirtualInterfaceAccepterStatus @go(Status)
}

// HostedPrivateVirtualInterfaceAccepterList contains a list of HostedPrivateVirtualInterfaceAccepters
#HostedPrivateVirtualInterfaceAccepterList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#HostedPrivateVirtualInterfaceAccepter] @go(Items,[]HostedPrivateVirtualInterfaceAccepter)
}
