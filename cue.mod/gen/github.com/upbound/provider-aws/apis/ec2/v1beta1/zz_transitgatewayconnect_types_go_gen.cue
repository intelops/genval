// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#TransitGatewayConnectInitParameters: {
	// The tunnel protocol. Valida values: gre. Default is gre.
	protocol?: null | string @go(Protocol,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Boolean whether the Connect should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	transitGatewayDefaultRouteTableAssociation?: null | bool @go(TransitGatewayDefaultRouteTableAssociation,*bool)

	// Boolean whether the Connect should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	transitGatewayDefaultRouteTablePropagation?: null | bool @go(TransitGatewayDefaultRouteTablePropagation,*bool)
}

#TransitGatewayConnectObservation: {
	// EC2 Transit Gateway Attachment identifier
	id?: null | string @go(ID,*string)

	// The tunnel protocol. Valida values: gre. Default is gre.
	protocol?: null | string @go(Protocol,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Boolean whether the Connect should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	transitGatewayDefaultRouteTableAssociation?: null | bool @go(TransitGatewayDefaultRouteTableAssociation,*bool)

	// Boolean whether the Connect should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	transitGatewayDefaultRouteTablePropagation?: null | bool @go(TransitGatewayDefaultRouteTablePropagation,*bool)

	// Identifier of EC2 Transit Gateway.
	transitGatewayId?: null | string @go(TransitGatewayID,*string)

	// The underlaying VPC attachment
	transportAttachmentId?: null | string @go(TransportAttachmentID,*string)
}

#TransitGatewayConnectParameters: {
	// The tunnel protocol. Valida values: gre. Default is gre.
	// +kubebuilder:validation:Optional
	protocol?: null | string @go(Protocol,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Boolean whether the Connect should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	// +kubebuilder:validation:Optional
	transitGatewayDefaultRouteTableAssociation?: null | bool @go(TransitGatewayDefaultRouteTableAssociation,*bool)

	// Boolean whether the Connect should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true.
	// +kubebuilder:validation:Optional
	transitGatewayDefaultRouteTablePropagation?: null | bool @go(TransitGatewayDefaultRouteTablePropagation,*bool)

	// Identifier of EC2 Transit Gateway.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.TransitGateway
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	transitGatewayId?: null | string @go(TransitGatewayID,*string)

	// Reference to a TransitGateway in ec2 to populate transitGatewayId.
	// +kubebuilder:validation:Optional
	transitGatewayIdRef?: null | v1.#Reference @go(TransitGatewayIDRef,*v1.Reference)

	// Selector for a TransitGateway in ec2 to populate transitGatewayId.
	// +kubebuilder:validation:Optional
	transitGatewayIdSelector?: null | v1.#Selector @go(TransitGatewayIDSelector,*v1.Selector)

	// The underlaying VPC attachment
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.TransitGatewayVPCAttachment
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	transportAttachmentId?: null | string @go(TransportAttachmentID,*string)

	// Reference to a TransitGatewayVPCAttachment in ec2 to populate transportAttachmentId.
	// +kubebuilder:validation:Optional
	transportAttachmentIdRef?: null | v1.#Reference @go(TransportAttachmentIDRef,*v1.Reference)

	// Selector for a TransitGatewayVPCAttachment in ec2 to populate transportAttachmentId.
	// +kubebuilder:validation:Optional
	transportAttachmentIdSelector?: null | v1.#Selector @go(TransportAttachmentIDSelector,*v1.Selector)
}

// TransitGatewayConnectSpec defines the desired state of TransitGatewayConnect
#TransitGatewayConnectSpec: {
	v1.#ResourceSpec
	forProvider: #TransitGatewayConnectParameters @go(ForProvider)

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
	initProvider?: #TransitGatewayConnectInitParameters @go(InitProvider)
}

// TransitGatewayConnectStatus defines the observed state of TransitGatewayConnect.
#TransitGatewayConnectStatus: {
	v1.#ResourceStatus
	atProvider?: #TransitGatewayConnectObservation @go(AtProvider)
}

// TransitGatewayConnect is the Schema for the TransitGatewayConnects API. Manages an EC2 Transit Gateway Connect
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#TransitGatewayConnect: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta           @go(ObjectMeta)
	spec:      #TransitGatewayConnectSpec   @go(Spec)
	status?:   #TransitGatewayConnectStatus @go(Status)
}

// TransitGatewayConnectList contains a list of TransitGatewayConnects
#TransitGatewayConnectList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#TransitGatewayConnect] @go(Items,[]TransitGatewayConnect)
}
