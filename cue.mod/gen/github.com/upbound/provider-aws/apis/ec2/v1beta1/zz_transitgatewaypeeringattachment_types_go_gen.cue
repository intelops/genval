// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#TransitGatewayPeeringAttachmentInitParameters: {
	// Account ID of EC2 Transit Gateway to peer with. Defaults to the account ID the AWS provider is currently connected to.
	peerAccountId?: null | string @go(PeerAccountID,*string)

	// Region of EC2 Transit Gateway to peer with.
	peerRegion?: null | string @go(PeerRegion,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#TransitGatewayPeeringAttachmentObservation: {
	// EC2 Transit Gateway Attachment identifier
	id?: null | string @go(ID,*string)

	// Account ID of EC2 Transit Gateway to peer with. Defaults to the account ID the AWS provider is currently connected to.
	peerAccountId?: null | string @go(PeerAccountID,*string)

	// Region of EC2 Transit Gateway to peer with.
	peerRegion?: null | string @go(PeerRegion,*string)

	// Identifier of EC2 Transit Gateway to peer with.
	peerTransitGatewayId?: null | string @go(PeerTransitGatewayID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Identifier of EC2 Transit Gateway.
	transitGatewayId?: null | string @go(TransitGatewayID,*string)
}

#TransitGatewayPeeringAttachmentParameters: {
	// Account ID of EC2 Transit Gateway to peer with. Defaults to the account ID the AWS provider is currently connected to.
	// +kubebuilder:validation:Optional
	peerAccountId?: null | string @go(PeerAccountID,*string)

	// Region of EC2 Transit Gateway to peer with.
	// +kubebuilder:validation:Optional
	peerRegion?: null | string @go(PeerRegion,*string)

	// Identifier of EC2 Transit Gateway to peer with.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.TransitGateway
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	peerTransitGatewayId?: null | string @go(PeerTransitGatewayID,*string)

	// Reference to a TransitGateway in ec2 to populate peerTransitGatewayId.
	// +kubebuilder:validation:Optional
	peerTransitGatewayIdRef?: null | v1.#Reference @go(PeerTransitGatewayIDRef,*v1.Reference)

	// Selector for a TransitGateway in ec2 to populate peerTransitGatewayId.
	// +kubebuilder:validation:Optional
	peerTransitGatewayIdSelector?: null | v1.#Selector @go(PeerTransitGatewayIDSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

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
}

// TransitGatewayPeeringAttachmentSpec defines the desired state of TransitGatewayPeeringAttachment
#TransitGatewayPeeringAttachmentSpec: {
	v1.#ResourceSpec
	forProvider: #TransitGatewayPeeringAttachmentParameters @go(ForProvider)

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
	initProvider?: #TransitGatewayPeeringAttachmentInitParameters @go(InitProvider)
}

// TransitGatewayPeeringAttachmentStatus defines the observed state of TransitGatewayPeeringAttachment.
#TransitGatewayPeeringAttachmentStatus: {
	v1.#ResourceStatus
	atProvider?: #TransitGatewayPeeringAttachmentObservation @go(AtProvider)
}

// TransitGatewayPeeringAttachment is the Schema for the TransitGatewayPeeringAttachments API. Manages an EC2 Transit Gateway Peering Attachment
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#TransitGatewayPeeringAttachment: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.peerRegion) || (has(self.initProvider) && has(self.initProvider.peerRegion))",message="spec.forProvider.peerRegion is a required parameter"
	spec:    #TransitGatewayPeeringAttachmentSpec   @go(Spec)
	status?: #TransitGatewayPeeringAttachmentStatus @go(Status)
}

// TransitGatewayPeeringAttachmentList contains a list of TransitGatewayPeeringAttachments
#TransitGatewayPeeringAttachmentList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#TransitGatewayPeeringAttachment] @go(Items,[]TransitGatewayPeeringAttachment)
}
