// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/networkmanager/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#VPCAttachmentInitParameters: {
	// Options for the VPC attachment.
	options?: [...#VPCAttachmentOptionsInitParameters] @go(Options,[]VPCAttachmentOptionsInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#VPCAttachmentObservation: {
	// The ARN of the attachment.
	arn?: null | string @go(Arn,*string)

	// The policy rule number associated with the attachment.
	attachmentPolicyRuleNumber?: null | float64 @go(AttachmentPolicyRuleNumber,*float64)

	// The type of attachment.
	attachmentType?: null | string @go(AttachmentType,*string)

	// The ARN of a core network.
	coreNetworkArn?: null | string @go(CoreNetworkArn,*string)

	// The ID of a core network for the VPC attachment.
	coreNetworkId?: null | string @go(CoreNetworkID,*string)

	// The Region where the edge is located.
	edgeLocation?: null | string @go(EdgeLocation,*string)

	// The ID of the attachment.
	id?: null | string @go(ID,*string)

	// Options for the VPC attachment.
	options?: [...#VPCAttachmentOptionsObservation] @go(Options,[]VPCAttachmentOptionsObservation)

	// The ID of the attachment account owner.
	ownerAccountId?: null | string @go(OwnerAccountID,*string)

	// The attachment resource ARN.
	resourceArn?: null | string @go(ResourceArn,*string)

	// The name of the segment attachment.
	segmentName?: null | string @go(SegmentName,*string)

	// The state of the attachment.
	state?: null | string @go(State,*string)

	// The subnet ARN of the VPC attachment.
	subnetArns?: [...null | string] @go(SubnetArns,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The ARN of the VPC.
	vpcArn?: null | string @go(VPCArn,*string)
}

#VPCAttachmentOptionsInitParameters: {
	// Indicates whether appliance mode is supported. If enabled, traffic flow between a source and destination use the same Availability Zone for the VPC attachment for the lifetime of that flow.
	applianceModeSupport?: null | bool @go(ApplianceModeSupport,*bool)

	// Indicates whether IPv6 is supported.
	ipv6Support?: null | bool @go(IPv6Support,*bool)
}

#VPCAttachmentOptionsObservation: {
	// Indicates whether appliance mode is supported. If enabled, traffic flow between a source and destination use the same Availability Zone for the VPC attachment for the lifetime of that flow.
	applianceModeSupport?: null | bool @go(ApplianceModeSupport,*bool)

	// Indicates whether IPv6 is supported.
	ipv6Support?: null | bool @go(IPv6Support,*bool)
}

#VPCAttachmentOptionsParameters: {
	// Indicates whether appliance mode is supported. If enabled, traffic flow between a source and destination use the same Availability Zone for the VPC attachment for the lifetime of that flow.
	// +kubebuilder:validation:Optional
	applianceModeSupport?: null | bool @go(ApplianceModeSupport,*bool)

	// Indicates whether IPv6 is supported.
	// +kubebuilder:validation:Optional
	ipv6Support?: null | bool @go(IPv6Support,*bool)
}

#VPCAttachmentParameters: {
	// The ID of a core network for the VPC attachment.
	// +crossplane:generate:reference:type=CoreNetwork
	// +kubebuilder:validation:Optional
	coreNetworkId?: null | string @go(CoreNetworkID,*string)

	// Reference to a CoreNetwork to populate coreNetworkId.
	// +kubebuilder:validation:Optional
	coreNetworkIdRef?: null | v1.#Reference @go(CoreNetworkIDRef,*v1.Reference)

	// Selector for a CoreNetwork to populate coreNetworkId.
	// +kubebuilder:validation:Optional
	coreNetworkIdSelector?: null | v1.#Selector @go(CoreNetworkIDSelector,*v1.Selector)

	// Options for the VPC attachment.
	// +kubebuilder:validation:Optional
	options?: [...#VPCAttachmentOptionsParameters] @go(Options,[]VPCAttachmentOptionsParameters)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The subnet ARN of the VPC attachment.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.Subnet
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	subnetArns?: [...null | string] @go(SubnetArns,[]*string)

	// References to Subnet in ec2 to populate subnetArns.
	// +kubebuilder:validation:Optional
	subnetArnsRefs?: [...v1.#Reference] @go(SubnetArnsRefs,[]v1.Reference)

	// Selector for a list of Subnet in ec2 to populate subnetArns.
	// +kubebuilder:validation:Optional
	subnetArnsSelector?: null | v1.#Selector @go(SubnetArnsSelector,*v1.Selector)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The ARN of the VPC.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPC
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	vpcArn?: null | string @go(VPCArn,*string)

	// Reference to a VPC in ec2 to populate vpcArn.
	// +kubebuilder:validation:Optional
	vpcArnRef?: null | v1.#Reference @go(VPCArnRef,*v1.Reference)

	// Selector for a VPC in ec2 to populate vpcArn.
	// +kubebuilder:validation:Optional
	vpcArnSelector?: null | v1.#Selector @go(VPCArnSelector,*v1.Selector)
}

// VPCAttachmentSpec defines the desired state of VPCAttachment
#VPCAttachmentSpec: {
	v1.#ResourceSpec
	forProvider: #VPCAttachmentParameters @go(ForProvider)

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
	initProvider?: #VPCAttachmentInitParameters @go(InitProvider)
}

// VPCAttachmentStatus defines the observed state of VPCAttachment.
#VPCAttachmentStatus: {
	v1.#ResourceStatus
	atProvider?: #VPCAttachmentObservation @go(AtProvider)
}

// VPCAttachment is the Schema for the VPCAttachments API.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#VPCAttachment: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta   @go(ObjectMeta)
	spec:      #VPCAttachmentSpec   @go(Spec)
	status?:   #VPCAttachmentStatus @go(Status)
}

// VPCAttachmentList contains a list of VPCAttachments
#VPCAttachmentList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VPCAttachment] @go(Items,[]VPCAttachment)
}
