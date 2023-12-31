// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/route53/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#VPCInitParameters: {
	// Region of the VPC to associate. Defaults to AWS provider region.
	vpcRegion?: null | string @go(VPCRegion,*string)
}

#VPCObservation: {
	// ID of the VPC to associate.
	vpcId?: null | string @go(VPCID,*string)

	// Region of the VPC to associate. Defaults to AWS provider region.
	vpcRegion?: null | string @go(VPCRegion,*string)
}

#VPCParameters: {
	// ID of the VPC to associate.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPC
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	vpcId?: null | string @go(VPCID,*string)

	// Reference to a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdRef?: null | v1.#Reference @go(VPCIDRef,*v1.Reference)

	// Selector for a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdSelector?: null | v1.#Selector @go(VPCIDSelector,*v1.Selector)

	// Region of the VPC to associate. Defaults to AWS provider region.
	// +kubebuilder:validation:Optional
	vpcRegion?: null | string @go(VPCRegion,*string)
}

#ZoneInitParameters: {
	// A comment for the hosted zone.
	comment?:      null | string @go(Comment,*string)
	forceDestroy?: null | bool   @go(ForceDestroy,*bool)

	// This is the name of the hosted zone.
	name?: null | string @go(Name,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation_set_id argument in this resource and any aws_route53_zone_association resource specifying the same zone ID. Detailed below.
	vpc?: [...#VPCInitParameters] @go(VPC,[]VPCInitParameters)
}

#ZoneObservation: {
	// The Amazon Resource Name (ARN) of the Hosted Zone.
	arn?: null | string @go(Arn,*string)

	// A comment for the hosted zone.
	comment?: null | string @go(Comment,*string)

	// The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones.
	delegationSetId?: null | string @go(DelegationSetID,*string)
	forceDestroy?:    null | bool   @go(ForceDestroy,*bool)
	id?:              null | string @go(ID,*string)

	// This is the name of the hosted zone.
	name?: null | string @go(Name,*string)

	// A list of name servers in associated (or default) delegation set.
	// Find more about delegation sets in AWS docs.
	nameServers?: [...null | string] @go(NameServers,[]*string)

	// The Route 53 name server that created the SOA record.
	primaryNameServer?: null | string @go(PrimaryNameServer,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation_set_id argument in this resource and any aws_route53_zone_association resource specifying the same zone ID. Detailed below.
	vpc?: [...#VPCObservation] @go(VPC,[]VPCObservation)

	// The Hosted Zone ID. This can be referenced by zone records.
	zoneId?: null | string @go(ZoneID,*string)
}

#ZoneParameters: {
	// A comment for the hosted zone.
	// +kubebuilder:validation:Optional
	comment?: null | string @go(Comment,*string)

	// The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones.
	// +crossplane:generate:reference:type=DelegationSet
	// +kubebuilder:validation:Optional
	delegationSetId?: null | string @go(DelegationSetID,*string)

	// Reference to a DelegationSet to populate delegationSetId.
	// +kubebuilder:validation:Optional
	delegationSetIdRef?: null | v1.#Reference @go(DelegationSetIDRef,*v1.Reference)

	// Selector for a DelegationSet to populate delegationSetId.
	// +kubebuilder:validation:Optional
	delegationSetIdSelector?: null | v1.#Selector @go(DelegationSetIDSelector,*v1.Selector)

	// +kubebuilder:validation:Optional
	forceDestroy?: null | bool @go(ForceDestroy,*bool)

	// This is the name of the hosted zone.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation_set_id argument in this resource and any aws_route53_zone_association resource specifying the same zone ID. Detailed below.
	// +kubebuilder:validation:Optional
	vpc?: [...#VPCParameters] @go(VPC,[]VPCParameters)
}

// ZoneSpec defines the desired state of Zone
#ZoneSpec: {
	v1.#ResourceSpec
	forProvider: #ZoneParameters @go(ForProvider)

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
	initProvider?: #ZoneInitParameters @go(InitProvider)
}

// ZoneStatus defines the observed state of Zone.
#ZoneStatus: {
	v1.#ResourceStatus
	atProvider?: #ZoneObservation @go(AtProvider)
}

// Zone is the Schema for the Zones API. Manages a Route53 Hosted Zone
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Zone: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #ZoneSpec   @go(Spec)
	status?: #ZoneStatus @go(Status)
}

// ZoneList contains a list of Zones
#ZoneList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Zone] @go(Items,[]Zone)
}
