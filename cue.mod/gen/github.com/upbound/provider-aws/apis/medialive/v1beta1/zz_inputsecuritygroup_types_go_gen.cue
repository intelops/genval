// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/medialive/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#InputSecurityGroupInitParameters: {
	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Whitelist rules. See Whitelist Rules for more details.
	whitelistRules?: [...#WhitelistRulesInitParameters] @go(WhitelistRules,[]WhitelistRulesInitParameters)
}

#InputSecurityGroupObservation: {
	// ARN of the InputSecurityGroup.
	arn?: null | string @go(Arn,*string)

	// InputSecurityGroup Id.
	id?: null | string @go(ID,*string)

	// The list of inputs currently using this InputSecurityGroup.
	inputs?: [...null | string] @go(Inputs,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Whitelist rules. See Whitelist Rules for more details.
	whitelistRules?: [...#WhitelistRulesObservation] @go(WhitelistRules,[]WhitelistRulesObservation)
}

#InputSecurityGroupParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Whitelist rules. See Whitelist Rules for more details.
	// +kubebuilder:validation:Optional
	whitelistRules?: [...#WhitelistRulesParameters] @go(WhitelistRules,[]WhitelistRulesParameters)
}

#WhitelistRulesInitParameters: {
	// The IPv4 CIDR that's whitelisted.
	cidr?: null | string @go(Cidr,*string)
}

#WhitelistRulesObservation: {
	// The IPv4 CIDR that's whitelisted.
	cidr?: null | string @go(Cidr,*string)
}

#WhitelistRulesParameters: {
	// The IPv4 CIDR that's whitelisted.
	// +kubebuilder:validation:Optional
	cidr?: null | string @go(Cidr,*string)
}

// InputSecurityGroupSpec defines the desired state of InputSecurityGroup
#InputSecurityGroupSpec: {
	v1.#ResourceSpec
	forProvider: #InputSecurityGroupParameters @go(ForProvider)

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
	initProvider?: #InputSecurityGroupInitParameters @go(InitProvider)
}

// InputSecurityGroupStatus defines the observed state of InputSecurityGroup.
#InputSecurityGroupStatus: {
	v1.#ResourceStatus
	atProvider?: #InputSecurityGroupObservation @go(AtProvider)
}

// InputSecurityGroup is the Schema for the InputSecurityGroups API.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#InputSecurityGroup: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.whitelistRules) || (has(self.initProvider) && has(self.initProvider.whitelistRules))",message="spec.forProvider.whitelistRules is a required parameter"
	spec:    #InputSecurityGroupSpec   @go(Spec)
	status?: #InputSecurityGroupStatus @go(Status)
}

// InputSecurityGroupList contains a list of InputSecurityGroups
#InputSecurityGroupList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#InputSecurityGroup] @go(Items,[]InputSecurityGroup)
}
