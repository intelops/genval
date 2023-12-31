// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#NetworkInterfaceSgAttachmentInitParameters: {
}

#NetworkInterfaceSgAttachmentObservation: {
	id?: null | string @go(ID,*string)

	// The ID of the network interface to attach to.
	networkInterfaceId?: null | string @go(NetworkInterfaceID,*string)

	// The ID of the security group.
	securityGroupId?: null | string @go(SecurityGroupID,*string)
}

#NetworkInterfaceSgAttachmentParameters: {
	// The ID of the network interface to attach to.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.Instance
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("primary_network_interface_id",true)
	// +kubebuilder:validation:Optional
	networkInterfaceId?: null | string @go(NetworkInterfaceID,*string)

	// Reference to a Instance in ec2 to populate networkInterfaceId.
	// +kubebuilder:validation:Optional
	networkInterfaceIdRef?: null | v1.#Reference @go(NetworkInterfaceIDRef,*v1.Reference)

	// Selector for a Instance in ec2 to populate networkInterfaceId.
	// +kubebuilder:validation:Optional
	networkInterfaceIdSelector?: null | v1.#Selector @go(NetworkInterfaceIDSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The ID of the security group.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.SecurityGroup
	// +kubebuilder:validation:Optional
	securityGroupId?: null | string @go(SecurityGroupID,*string)

	// Reference to a SecurityGroup in ec2 to populate securityGroupId.
	// +kubebuilder:validation:Optional
	securityGroupIdRef?: null | v1.#Reference @go(SecurityGroupIDRef,*v1.Reference)

	// Selector for a SecurityGroup in ec2 to populate securityGroupId.
	// +kubebuilder:validation:Optional
	securityGroupIdSelector?: null | v1.#Selector @go(SecurityGroupIDSelector,*v1.Selector)
}

// NetworkInterfaceSgAttachmentSpec defines the desired state of NetworkInterfaceSgAttachment
#NetworkInterfaceSgAttachmentSpec: {
	v1.#ResourceSpec
	forProvider: #NetworkInterfaceSgAttachmentParameters @go(ForProvider)

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
	initProvider?: #NetworkInterfaceSgAttachmentInitParameters @go(InitProvider)
}

// NetworkInterfaceSgAttachmentStatus defines the observed state of NetworkInterfaceSgAttachment.
#NetworkInterfaceSgAttachmentStatus: {
	v1.#ResourceStatus
	atProvider?: #NetworkInterfaceSgAttachmentObservation @go(AtProvider)
}

// NetworkInterfaceSgAttachment is the Schema for the NetworkInterfaceSgAttachments API. Associates a security group with a network interface.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#NetworkInterfaceSgAttachment: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta                  @go(ObjectMeta)
	spec:      #NetworkInterfaceSgAttachmentSpec   @go(Spec)
	status?:   #NetworkInterfaceSgAttachmentStatus @go(Status)
}

// NetworkInterfaceSgAttachmentList contains a list of NetworkInterfaceSgAttachments
#NetworkInterfaceSgAttachmentList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#NetworkInterfaceSgAttachment] @go(Items,[]NetworkInterfaceSgAttachment)
}
