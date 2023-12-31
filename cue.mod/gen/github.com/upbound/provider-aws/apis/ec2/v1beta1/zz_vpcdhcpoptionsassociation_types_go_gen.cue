// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#VPCDHCPOptionsAssociationInitParameters: {
}

#VPCDHCPOptionsAssociationObservation: {
	// The ID of the DHCP Options Set to associate to the VPC.
	dhcpOptionsId?: null | string @go(DHCPOptionsID,*string)

	// The ID of the DHCP Options Set Association.
	id?: null | string @go(ID,*string)

	// The ID of the VPC to which we would like to associate a DHCP Options Set.
	vpcId?: null | string @go(VPCID,*string)
}

#VPCDHCPOptionsAssociationParameters: {
	// The ID of the DHCP Options Set to associate to the VPC.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPCDHCPOptions
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	dhcpOptionsId?: null | string @go(DHCPOptionsID,*string)

	// Reference to a VPCDHCPOptions in ec2 to populate dhcpOptionsId.
	// +kubebuilder:validation:Optional
	dhcpOptionsIdRef?: null | v1.#Reference @go(DHCPOptionsIDRef,*v1.Reference)

	// Selector for a VPCDHCPOptions in ec2 to populate dhcpOptionsId.
	// +kubebuilder:validation:Optional
	dhcpOptionsIdSelector?: null | v1.#Selector @go(DHCPOptionsIDSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The ID of the VPC to which we would like to associate a DHCP Options Set.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPC
	// +kubebuilder:validation:Optional
	vpcId?: null | string @go(VPCID,*string)

	// Reference to a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdRef?: null | v1.#Reference @go(VPCIDRef,*v1.Reference)

	// Selector for a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdSelector?: null | v1.#Selector @go(VPCIDSelector,*v1.Selector)
}

// VPCDHCPOptionsAssociationSpec defines the desired state of VPCDHCPOptionsAssociation
#VPCDHCPOptionsAssociationSpec: {
	v1.#ResourceSpec
	forProvider: #VPCDHCPOptionsAssociationParameters @go(ForProvider)

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
	initProvider?: #VPCDHCPOptionsAssociationInitParameters @go(InitProvider)
}

// VPCDHCPOptionsAssociationStatus defines the observed state of VPCDHCPOptionsAssociation.
#VPCDHCPOptionsAssociationStatus: {
	v1.#ResourceStatus
	atProvider?: #VPCDHCPOptionsAssociationObservation @go(AtProvider)
}

// VPCDHCPOptionsAssociation is the Schema for the VPCDHCPOptionsAssociations API. Provides a VPC DHCP Options Association resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#VPCDHCPOptionsAssociation: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta               @go(ObjectMeta)
	spec:      #VPCDHCPOptionsAssociationSpec   @go(Spec)
	status?:   #VPCDHCPOptionsAssociationStatus @go(Status)
}

// VPCDHCPOptionsAssociationList contains a list of VPCDHCPOptionsAssociations
#VPCDHCPOptionsAssociationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VPCDHCPOptionsAssociation] @go(Items,[]VPCDHCPOptionsAssociation)
}
