// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/waf/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#PredicatesInitParameters: {
	// Set this to false if you want to allow, block, or count requests
	// based on the settings in the specified ByteMatchSet, IPSet, SqlInjectionMatchSet, XssMatchSet, or SizeConstraintSet.
	// For example, if an IPSet includes the IP address 192.0.2.44, AWS WAF will allow or block requests based on that IP address.
	// If set to true, AWS WAF will allow, block, or count requests based on all IP addresses except 192.0.2.44.
	negated?: null | bool @go(Negated,*bool)

	// The type of predicate in a rule. Valid values: ByteMatch, GeoMatch, IPMatch, RegexMatch, SizeConstraint, SqlInjectionMatch, or XssMatch.
	type?: null | string @go(Type,*string)
}

#PredicatesObservation: {
	// A unique identifier for a predicate in the rule, such as Byte Match Set ID or IPSet ID.
	dataId?: null | string @go(DataID,*string)

	// Set this to false if you want to allow, block, or count requests
	// based on the settings in the specified ByteMatchSet, IPSet, SqlInjectionMatchSet, XssMatchSet, or SizeConstraintSet.
	// For example, if an IPSet includes the IP address 192.0.2.44, AWS WAF will allow or block requests based on that IP address.
	// If set to true, AWS WAF will allow, block, or count requests based on all IP addresses except 192.0.2.44.
	negated?: null | bool @go(Negated,*bool)

	// The type of predicate in a rule. Valid values: ByteMatch, GeoMatch, IPMatch, RegexMatch, SizeConstraint, SqlInjectionMatch, or XssMatch.
	type?: null | string @go(Type,*string)
}

#PredicatesParameters: {
	// A unique identifier for a predicate in the rule, such as Byte Match Set ID or IPSet ID.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/waf/v1beta1.IPSet
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	dataId?: null | string @go(DataID,*string)

	// Reference to a IPSet in waf to populate dataId.
	// +kubebuilder:validation:Optional
	dataIdRef?: null | v1.#Reference @go(DataIDRef,*v1.Reference)

	// Selector for a IPSet in waf to populate dataId.
	// +kubebuilder:validation:Optional
	dataIdSelector?: null | v1.#Selector @go(DataIDSelector,*v1.Selector)

	// Set this to false if you want to allow, block, or count requests
	// based on the settings in the specified ByteMatchSet, IPSet, SqlInjectionMatchSet, XssMatchSet, or SizeConstraintSet.
	// For example, if an IPSet includes the IP address 192.0.2.44, AWS WAF will allow or block requests based on that IP address.
	// If set to true, AWS WAF will allow, block, or count requests based on all IP addresses except 192.0.2.44.
	// +kubebuilder:validation:Optional
	negated?: null | bool @go(Negated,*bool)

	// The type of predicate in a rule. Valid values: ByteMatch, GeoMatch, IPMatch, RegexMatch, SizeConstraint, SqlInjectionMatch, or XssMatch.
	// +kubebuilder:validation:Optional
	type?: null | string @go(Type,*string)
}

#RateBasedRuleInitParameters: {
	// The name or description for the Amazon CloudWatch metric of this rule.
	metricName?: null | string @go(MetricName,*string)

	// The name or description of the rule.
	name?: null | string @go(Name,*string)

	// The objects to include in a rule (documented below).
	predicates?: [...#PredicatesInitParameters] @go(Predicates,[]PredicatesInitParameters)

	// Valid value is IP.
	rateKey?: null | string @go(RateKey,*string)

	// The maximum number of requests, which have an identical value in the field specified by the RateKey, allowed in a five-minute period. Minimum value is 100.
	rateLimit?: null | float64 @go(RateLimit,*float64)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RateBasedRuleObservation: {
	// Amazon Resource Name (ARN)
	arn?: null | string @go(Arn,*string)

	// The ID of the WAF rule.
	id?: null | string @go(ID,*string)

	// The name or description for the Amazon CloudWatch metric of this rule.
	metricName?: null | string @go(MetricName,*string)

	// The name or description of the rule.
	name?: null | string @go(Name,*string)

	// The objects to include in a rule (documented below).
	predicates?: [...#PredicatesObservation] @go(Predicates,[]PredicatesObservation)

	// Valid value is IP.
	rateKey?: null | string @go(RateKey,*string)

	// The maximum number of requests, which have an identical value in the field specified by the RateKey, allowed in a five-minute period. Minimum value is 100.
	rateLimit?: null | float64 @go(RateLimit,*float64)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#RateBasedRuleParameters: {
	// The name or description for the Amazon CloudWatch metric of this rule.
	// +kubebuilder:validation:Optional
	metricName?: null | string @go(MetricName,*string)

	// The name or description of the rule.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// The objects to include in a rule (documented below).
	// +kubebuilder:validation:Optional
	predicates?: [...#PredicatesParameters] @go(Predicates,[]PredicatesParameters)

	// Valid value is IP.
	// +kubebuilder:validation:Optional
	rateKey?: null | string @go(RateKey,*string)

	// The maximum number of requests, which have an identical value in the field specified by the RateKey, allowed in a five-minute period. Minimum value is 100.
	// +kubebuilder:validation:Optional
	rateLimit?: null | float64 @go(RateLimit,*float64)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// RateBasedRuleSpec defines the desired state of RateBasedRule
#RateBasedRuleSpec: {
	v1.#ResourceSpec
	forProvider: #RateBasedRuleParameters @go(ForProvider)

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
	initProvider?: #RateBasedRuleInitParameters @go(InitProvider)
}

// RateBasedRuleStatus defines the observed state of RateBasedRule.
#RateBasedRuleStatus: {
	v1.#ResourceStatus
	atProvider?: #RateBasedRuleObservation @go(AtProvider)
}

// RateBasedRule is the Schema for the RateBasedRules API. Provides a AWS WAF rule resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#RateBasedRule: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.metricName) || (has(self.initProvider) && has(self.initProvider.metricName))",message="spec.forProvider.metricName is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.rateKey) || (has(self.initProvider) && has(self.initProvider.rateKey))",message="spec.forProvider.rateKey is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.rateLimit) || (has(self.initProvider) && has(self.initProvider.rateLimit))",message="spec.forProvider.rateLimit is a required parameter"
	spec:    #RateBasedRuleSpec   @go(Spec)
	status?: #RateBasedRuleStatus @go(Status)
}

// RateBasedRuleList contains a list of RateBasedRules
#RateBasedRuleList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#RateBasedRule] @go(Items,[]RateBasedRule)
}
