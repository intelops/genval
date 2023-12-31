// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DestinationPortRangeInitParameters: {
	// Starting port of the range
	fromPort?: null | float64 @go(FromPort,*float64)

	// Ending port of the range
	toPort?: null | float64 @go(ToPort,*float64)
}

#DestinationPortRangeObservation: {
	// Starting port of the range
	fromPort?: null | float64 @go(FromPort,*float64)

	// Ending port of the range
	toPort?: null | float64 @go(ToPort,*float64)
}

#DestinationPortRangeParameters: {
	// Starting port of the range
	// +kubebuilder:validation:Optional
	fromPort?: null | float64 @go(FromPort,*float64)

	// Ending port of the range
	// +kubebuilder:validation:Optional
	toPort?: null | float64 @go(ToPort,*float64)
}

#SourcePortRangeInitParameters: {
	// Starting port of the range
	fromPort?: null | float64 @go(FromPort,*float64)

	// Ending port of the range
	toPort?: null | float64 @go(ToPort,*float64)
}

#SourcePortRangeObservation: {
	// Starting port of the range
	fromPort?: null | float64 @go(FromPort,*float64)

	// Ending port of the range
	toPort?: null | float64 @go(ToPort,*float64)
}

#SourcePortRangeParameters: {
	// Starting port of the range
	// +kubebuilder:validation:Optional
	fromPort?: null | float64 @go(FromPort,*float64)

	// Ending port of the range
	// +kubebuilder:validation:Optional
	toPort?: null | float64 @go(ToPort,*float64)
}

#TrafficMirrorFilterRuleInitParameters: {
	// Description of the traffic mirror filter rule.
	description?: null | string @go(Description,*string)

	// Destination CIDR block to assign to the Traffic Mirror rule.
	destinationCidrBlock?: null | string @go(DestinationCidrBlock,*string)

	// Destination port range. Supported only when the protocol is set to TCP(6) or UDP(17). See Traffic mirror port range documented below
	destinationPortRange?: [...#DestinationPortRangeInitParameters] @go(DestinationPortRange,[]DestinationPortRangeInitParameters)

	// Protocol number, for example 17 (UDP), to assign to the Traffic Mirror rule. For information about the protocol value, see Protocol Numbers on the Internet Assigned Numbers Authority (IANA) website.
	protocol?: null | float64 @go(Protocol,*float64)

	// Action to take (accept | reject) on the filtered traffic. Valid values are accept and reject
	ruleAction?: null | string @go(RuleAction,*string)

	// Number of the Traffic Mirror rule. This number must be unique for each Traffic Mirror rule in a given direction. The rules are processed in ascending order by rule number.
	ruleNumber?: null | float64 @go(RuleNumber,*float64)

	// Source CIDR block to assign to the Traffic Mirror rule.
	sourceCidrBlock?: null | string @go(SourceCidrBlock,*string)

	// Source port range. Supported only when the protocol is set to TCP(6) or UDP(17). See Traffic mirror port range documented below
	sourcePortRange?: [...#SourcePortRangeInitParameters] @go(SourcePortRange,[]SourcePortRangeInitParameters)

	// Direction of traffic to be captured. Valid values are ingress and egress
	trafficDirection?: null | string @go(TrafficDirection,*string)
}

#TrafficMirrorFilterRuleObservation: {
	// ARN of the traffic mirror filter rule.
	arn?: null | string @go(Arn,*string)

	// Description of the traffic mirror filter rule.
	description?: null | string @go(Description,*string)

	// Destination CIDR block to assign to the Traffic Mirror rule.
	destinationCidrBlock?: null | string @go(DestinationCidrBlock,*string)

	// Destination port range. Supported only when the protocol is set to TCP(6) or UDP(17). See Traffic mirror port range documented below
	destinationPortRange?: [...#DestinationPortRangeObservation] @go(DestinationPortRange,[]DestinationPortRangeObservation)

	// Name of the traffic mirror filter rule.
	id?: null | string @go(ID,*string)

	// Protocol number, for example 17 (UDP), to assign to the Traffic Mirror rule. For information about the protocol value, see Protocol Numbers on the Internet Assigned Numbers Authority (IANA) website.
	protocol?: null | float64 @go(Protocol,*float64)

	// Action to take (accept | reject) on the filtered traffic. Valid values are accept and reject
	ruleAction?: null | string @go(RuleAction,*string)

	// Number of the Traffic Mirror rule. This number must be unique for each Traffic Mirror rule in a given direction. The rules are processed in ascending order by rule number.
	ruleNumber?: null | float64 @go(RuleNumber,*float64)

	// Source CIDR block to assign to the Traffic Mirror rule.
	sourceCidrBlock?: null | string @go(SourceCidrBlock,*string)

	// Source port range. Supported only when the protocol is set to TCP(6) or UDP(17). See Traffic mirror port range documented below
	sourcePortRange?: [...#SourcePortRangeObservation] @go(SourcePortRange,[]SourcePortRangeObservation)

	// Direction of traffic to be captured. Valid values are ingress and egress
	trafficDirection?: null | string @go(TrafficDirection,*string)

	// ID of the traffic mirror filter to which this rule should be added
	trafficMirrorFilterId?: null | string @go(TrafficMirrorFilterID,*string)
}

#TrafficMirrorFilterRuleParameters: {
	// Description of the traffic mirror filter rule.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Destination CIDR block to assign to the Traffic Mirror rule.
	// +kubebuilder:validation:Optional
	destinationCidrBlock?: null | string @go(DestinationCidrBlock,*string)

	// Destination port range. Supported only when the protocol is set to TCP(6) or UDP(17). See Traffic mirror port range documented below
	// +kubebuilder:validation:Optional
	destinationPortRange?: [...#DestinationPortRangeParameters] @go(DestinationPortRange,[]DestinationPortRangeParameters)

	// Protocol number, for example 17 (UDP), to assign to the Traffic Mirror rule. For information about the protocol value, see Protocol Numbers on the Internet Assigned Numbers Authority (IANA) website.
	// +kubebuilder:validation:Optional
	protocol?: null | float64 @go(Protocol,*float64)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Action to take (accept | reject) on the filtered traffic. Valid values are accept and reject
	// +kubebuilder:validation:Optional
	ruleAction?: null | string @go(RuleAction,*string)

	// Number of the Traffic Mirror rule. This number must be unique for each Traffic Mirror rule in a given direction. The rules are processed in ascending order by rule number.
	// +kubebuilder:validation:Optional
	ruleNumber?: null | float64 @go(RuleNumber,*float64)

	// Source CIDR block to assign to the Traffic Mirror rule.
	// +kubebuilder:validation:Optional
	sourceCidrBlock?: null | string @go(SourceCidrBlock,*string)

	// Source port range. Supported only when the protocol is set to TCP(6) or UDP(17). See Traffic mirror port range documented below
	// +kubebuilder:validation:Optional
	sourcePortRange?: [...#SourcePortRangeParameters] @go(SourcePortRange,[]SourcePortRangeParameters)

	// Direction of traffic to be captured. Valid values are ingress and egress
	// +kubebuilder:validation:Optional
	trafficDirection?: null | string @go(TrafficDirection,*string)

	// ID of the traffic mirror filter to which this rule should be added
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.TrafficMirrorFilter
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	trafficMirrorFilterId?: null | string @go(TrafficMirrorFilterID,*string)

	// Reference to a TrafficMirrorFilter in ec2 to populate trafficMirrorFilterId.
	// +kubebuilder:validation:Optional
	trafficMirrorFilterIdRef?: null | v1.#Reference @go(TrafficMirrorFilterIDRef,*v1.Reference)

	// Selector for a TrafficMirrorFilter in ec2 to populate trafficMirrorFilterId.
	// +kubebuilder:validation:Optional
	trafficMirrorFilterIdSelector?: null | v1.#Selector @go(TrafficMirrorFilterIDSelector,*v1.Selector)
}

// TrafficMirrorFilterRuleSpec defines the desired state of TrafficMirrorFilterRule
#TrafficMirrorFilterRuleSpec: {
	v1.#ResourceSpec
	forProvider: #TrafficMirrorFilterRuleParameters @go(ForProvider)

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
	initProvider?: #TrafficMirrorFilterRuleInitParameters @go(InitProvider)
}

// TrafficMirrorFilterRuleStatus defines the observed state of TrafficMirrorFilterRule.
#TrafficMirrorFilterRuleStatus: {
	v1.#ResourceStatus
	atProvider?: #TrafficMirrorFilterRuleObservation @go(AtProvider)
}

// TrafficMirrorFilterRule is the Schema for the TrafficMirrorFilterRules API. Provides an Traffic mirror filter rule
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#TrafficMirrorFilterRule: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.destinationCidrBlock) || (has(self.initProvider) && has(self.initProvider.destinationCidrBlock))",message="spec.forProvider.destinationCidrBlock is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.ruleAction) || (has(self.initProvider) && has(self.initProvider.ruleAction))",message="spec.forProvider.ruleAction is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.ruleNumber) || (has(self.initProvider) && has(self.initProvider.ruleNumber))",message="spec.forProvider.ruleNumber is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.sourceCidrBlock) || (has(self.initProvider) && has(self.initProvider.sourceCidrBlock))",message="spec.forProvider.sourceCidrBlock is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.trafficDirection) || (has(self.initProvider) && has(self.initProvider.trafficDirection))",message="spec.forProvider.trafficDirection is a required parameter"
	spec:    #TrafficMirrorFilterRuleSpec   @go(Spec)
	status?: #TrafficMirrorFilterRuleStatus @go(Status)
}

// TrafficMirrorFilterRuleList contains a list of TrafficMirrorFilterRules
#TrafficMirrorFilterRuleList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#TrafficMirrorFilterRule] @go(Items,[]TrafficMirrorFilterRule)
}
