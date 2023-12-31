// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/wafv2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#RegexPatternSetInitParameters: {
	// A friendly description of the regular expression pattern set.
	description?: null | string @go(Description,*string)

	// A friendly name of the regular expression pattern set.
	name?: null | string @go(Name,*string)

	// One or more blocks of regular expression patterns that you want AWS WAF to search for, such as B[a@]dB[o0]t. See Regular Expression below for details.
	regularExpression?: [...#RegularExpressionInitParameters] @go(RegularExpression,[]RegularExpressionInitParameters)

	// Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL. To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider.
	scope?: null | string @go(Scope,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RegexPatternSetObservation: {
	// The Amazon Resource Name (ARN) that identifies the cluster.
	arn?: null | string @go(Arn,*string)

	// A friendly description of the regular expression pattern set.
	description?: null | string @go(Description,*string)

	// A unique identifier for the set.
	id?:        null | string @go(ID,*string)
	lockToken?: null | string @go(LockToken,*string)

	// A friendly name of the regular expression pattern set.
	name?: null | string @go(Name,*string)

	// One or more blocks of regular expression patterns that you want AWS WAF to search for, such as B[a@]dB[o0]t. See Regular Expression below for details.
	regularExpression?: [...#RegularExpressionObservation] @go(RegularExpression,[]RegularExpressionObservation)

	// Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL. To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider.
	scope?: null | string @go(Scope,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#RegexPatternSetParameters: {
	// A friendly description of the regular expression pattern set.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// A friendly name of the regular expression pattern set.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// One or more blocks of regular expression patterns that you want AWS WAF to search for, such as B[a@]dB[o0]t. See Regular Expression below for details.
	// +kubebuilder:validation:Optional
	regularExpression?: [...#RegularExpressionParameters] @go(RegularExpression,[]RegularExpressionParameters)

	// Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL. To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider.
	// +kubebuilder:validation:Optional
	scope?: null | string @go(Scope,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RegularExpressionInitParameters: {
	// The string representing the regular expression, see the AWS WAF documentation for more information.
	regexString?: null | string @go(RegexString,*string)
}

#RegularExpressionObservation: {
	// The string representing the regular expression, see the AWS WAF documentation for more information.
	regexString?: null | string @go(RegexString,*string)
}

#RegularExpressionParameters: {
	// The string representing the regular expression, see the AWS WAF documentation for more information.
	// +kubebuilder:validation:Optional
	regexString?: null | string @go(RegexString,*string)
}

// RegexPatternSetSpec defines the desired state of RegexPatternSet
#RegexPatternSetSpec: {
	v1.#ResourceSpec
	forProvider: #RegexPatternSetParameters @go(ForProvider)

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
	initProvider?: #RegexPatternSetInitParameters @go(InitProvider)
}

// RegexPatternSetStatus defines the observed state of RegexPatternSet.
#RegexPatternSetStatus: {
	v1.#ResourceStatus
	atProvider?: #RegexPatternSetObservation @go(AtProvider)
}

// RegexPatternSet is the Schema for the RegexPatternSets API. Provides an AWS WAFv2 Regex Pattern Set resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#RegexPatternSet: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.scope) || (has(self.initProvider) && has(self.initProvider.scope))",message="spec.forProvider.scope is a required parameter"
	spec:    #RegexPatternSetSpec   @go(Spec)
	status?: #RegexPatternSetStatus @go(Status)
}

// RegexPatternSetList contains a list of RegexPatternSets
#RegexPatternSetList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#RegexPatternSet] @go(Items,[]RegexPatternSet)
}
