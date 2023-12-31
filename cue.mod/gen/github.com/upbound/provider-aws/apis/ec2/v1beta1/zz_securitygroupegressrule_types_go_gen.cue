// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#SecurityGroupEgressRuleInitParameters: {
	// The destination IPv4 CIDR range.
	cidrIpv4?: null | string @go(CidrIPv4,*string)

	// The destination IPv6 CIDR range.
	cidrIpv6?: null | string @go(CidrIPv6,*string)

	// The security group rule description.
	description?: null | string @go(Description,*string)

	// The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.
	fromPort?: null | float64 @go(FromPort,*float64)

	// The IP protocol name or number. Use -1 to specify all protocols.
	ipProtocol?: null | string @go(IPProtocol,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code.
	toPort?: null | float64 @go(ToPort,*float64)
}

#SecurityGroupEgressRuleObservation: {
	// The Amazon Resource Name (ARN) of the security group rule.
	arn?: null | string @go(Arn,*string)

	// The destination IPv4 CIDR range.
	cidrIpv4?: null | string @go(CidrIPv4,*string)

	// The destination IPv6 CIDR range.
	cidrIpv6?: null | string @go(CidrIPv6,*string)

	// The security group rule description.
	description?: null | string @go(Description,*string)

	// The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.
	fromPort?: null | float64 @go(FromPort,*float64)
	id?:       null | string  @go(ID,*string)

	// The IP protocol name or number. Use -1 to specify all protocols.
	ipProtocol?: null | string @go(IPProtocol,*string)

	// The ID of the destination prefix list.
	prefixListId?: null | string @go(PrefixListID,*string)

	// The destination security group that is referenced in the rule.
	referencedSecurityGroupId?: null | string @go(ReferencedSecurityGroupID,*string)

	// The ID of the security group.
	securityGroupId?: null | string @go(SecurityGroupID,*string)

	// The ID of the security group rule.
	securityGroupRuleId?: null | string @go(SecurityGroupRuleID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code.
	toPort?: null | float64 @go(ToPort,*float64)
}

#SecurityGroupEgressRuleParameters: {
	// The destination IPv4 CIDR range.
	// +kubebuilder:validation:Optional
	cidrIpv4?: null | string @go(CidrIPv4,*string)

	// The destination IPv6 CIDR range.
	// +kubebuilder:validation:Optional
	cidrIpv6?: null | string @go(CidrIPv6,*string)

	// The security group rule description.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.
	// +kubebuilder:validation:Optional
	fromPort?: null | float64 @go(FromPort,*float64)

	// The IP protocol name or number. Use -1 to specify all protocols.
	// +kubebuilder:validation:Optional
	ipProtocol?: null | string @go(IPProtocol,*string)

	// The ID of the destination prefix list.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.ManagedPrefixList
	// +kubebuilder:validation:Optional
	prefixListId?: null | string @go(PrefixListID,*string)

	// Reference to a ManagedPrefixList in ec2 to populate prefixListId.
	// +kubebuilder:validation:Optional
	prefixListIdRef?: null | v1.#Reference @go(PrefixListIDRef,*v1.Reference)

	// Selector for a ManagedPrefixList in ec2 to populate prefixListId.
	// +kubebuilder:validation:Optional
	prefixListIdSelector?: null | v1.#Selector @go(PrefixListIDSelector,*v1.Selector)

	// The destination security group that is referenced in the rule.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.SecurityGroup
	// +kubebuilder:validation:Optional
	referencedSecurityGroupId?: null | string @go(ReferencedSecurityGroupID,*string)

	// Reference to a SecurityGroup in ec2 to populate referencedSecurityGroupId.
	// +kubebuilder:validation:Optional
	referencedSecurityGroupIdRef?: null | v1.#Reference @go(ReferencedSecurityGroupIDRef,*v1.Reference)

	// Selector for a SecurityGroup in ec2 to populate referencedSecurityGroupId.
	// +kubebuilder:validation:Optional
	referencedSecurityGroupIdSelector?: null | v1.#Selector @go(ReferencedSecurityGroupIDSelector,*v1.Selector)

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

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code.
	// +kubebuilder:validation:Optional
	toPort?: null | float64 @go(ToPort,*float64)
}

// SecurityGroupEgressRuleSpec defines the desired state of SecurityGroupEgressRule
#SecurityGroupEgressRuleSpec: {
	v1.#ResourceSpec
	forProvider: #SecurityGroupEgressRuleParameters @go(ForProvider)

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
	initProvider?: #SecurityGroupEgressRuleInitParameters @go(InitProvider)
}

// SecurityGroupEgressRuleStatus defines the observed state of SecurityGroupEgressRule.
#SecurityGroupEgressRuleStatus: {
	v1.#ResourceStatus
	atProvider?: #SecurityGroupEgressRuleObservation @go(AtProvider)
}

// SecurityGroupEgressRule is the Schema for the SecurityGroupEgressRules API. Provides a VPC security group egress rule resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#SecurityGroupEgressRule: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.ipProtocol) || (has(self.initProvider) && has(self.initProvider.ipProtocol))",message="spec.forProvider.ipProtocol is a required parameter"
	spec:    #SecurityGroupEgressRuleSpec   @go(Spec)
	status?: #SecurityGroupEgressRuleStatus @go(Status)
}

// SecurityGroupEgressRuleList contains a list of SecurityGroupEgressRules
#SecurityGroupEgressRuleList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#SecurityGroupEgressRule] @go(Items,[]SecurityGroupEgressRule)
}
