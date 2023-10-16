// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/configservice/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AccountAggregationSourceInitParameters: {
	// List of 12-digit account IDs of the account(s) being aggregated.
	accountIds?: [...null | string] @go(AccountIds,[]*string)

	// If true, aggregate existing AWS Config regions and future regions.
	allRegions?: null | bool @go(AllRegions,*bool)

	// List of source regions being aggregated.
	regions?: [...null | string] @go(Regions,[]*string)
}

#AccountAggregationSourceObservation: {
	// List of 12-digit account IDs of the account(s) being aggregated.
	accountIds?: [...null | string] @go(AccountIds,[]*string)

	// If true, aggregate existing AWS Config regions and future regions.
	allRegions?: null | bool @go(AllRegions,*bool)

	// List of source regions being aggregated.
	regions?: [...null | string] @go(Regions,[]*string)
}

#AccountAggregationSourceParameters: {
	// List of 12-digit account IDs of the account(s) being aggregated.
	// +kubebuilder:validation:Optional
	accountIds: [...null | string] @go(AccountIds,[]*string)

	// If true, aggregate existing AWS Config regions and future regions.
	// +kubebuilder:validation:Optional
	allRegions?: null | bool @go(AllRegions,*bool)

	// List of source regions being aggregated.
	// +kubebuilder:validation:Optional
	regions?: [...null | string] @go(Regions,[]*string)
}

#ConfigurationAggregatorInitParameters: {
	// The account(s) to aggregate config data from as documented below.
	accountAggregationSource?: [...#AccountAggregationSourceInitParameters] @go(AccountAggregationSource,[]AccountAggregationSourceInitParameters)

	// The organization to aggregate config data from as documented below.
	organizationAggregationSource?: [...#OrganizationAggregationSourceInitParameters] @go(OrganizationAggregationSource,[]OrganizationAggregationSourceInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#ConfigurationAggregatorObservation: {
	// The account(s) to aggregate config data from as documented below.
	accountAggregationSource?: [...#AccountAggregationSourceObservation] @go(AccountAggregationSource,[]AccountAggregationSourceObservation)

	// The ARN of the aggregator
	arn?: null | string @go(Arn,*string)
	id?:  null | string @go(ID,*string)

	// The organization to aggregate config data from as documented below.
	organizationAggregationSource?: [...#OrganizationAggregationSourceObservation] @go(OrganizationAggregationSource,[]OrganizationAggregationSourceObservation)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#ConfigurationAggregatorParameters: {
	// The account(s) to aggregate config data from as documented below.
	// +kubebuilder:validation:Optional
	accountAggregationSource?: [...#AccountAggregationSourceParameters] @go(AccountAggregationSource,[]AccountAggregationSourceParameters)

	// The organization to aggregate config data from as documented below.
	// +kubebuilder:validation:Optional
	organizationAggregationSource?: [...#OrganizationAggregationSourceParameters] @go(OrganizationAggregationSource,[]OrganizationAggregationSourceParameters)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#OrganizationAggregationSourceInitParameters: {
	// If true, aggregate existing AWS Config regions and future regions.
	allRegions?: null | bool @go(AllRegions,*bool)

	// List of source regions being aggregated.
	regions?: [...null | string] @go(Regions,[]*string)
}

#OrganizationAggregationSourceObservation: {
	// If true, aggregate existing AWS Config regions and future regions.
	allRegions?: null | bool @go(AllRegions,*bool)

	// List of source regions being aggregated.
	regions?: [...null | string] @go(Regions,[]*string)

	// ARN of the IAM role used to retrieve AWS Organization details associated with the aggregator account.
	roleArn?: null | string @go(RoleArn,*string)
}

#OrganizationAggregationSourceParameters: {
	// If true, aggregate existing AWS Config regions and future regions.
	// +kubebuilder:validation:Optional
	allRegions?: null | bool @go(AllRegions,*bool)

	// List of source regions being aggregated.
	// +kubebuilder:validation:Optional
	regions?: [...null | string] @go(Regions,[]*string)

	// ARN of the IAM role used to retrieve AWS Organization details associated with the aggregator account.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	roleArn?: null | string @go(RoleArn,*string)

	// Reference to a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnRef?: null | v1.#Reference @go(RoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnSelector?: null | v1.#Selector @go(RoleArnSelector,*v1.Selector)
}

// ConfigurationAggregatorSpec defines the desired state of ConfigurationAggregator
#ConfigurationAggregatorSpec: {
	v1.#ResourceSpec
	forProvider: #ConfigurationAggregatorParameters @go(ForProvider)

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
	initProvider?: #ConfigurationAggregatorInitParameters @go(InitProvider)
}

// ConfigurationAggregatorStatus defines the observed state of ConfigurationAggregator.
#ConfigurationAggregatorStatus: {
	v1.#ResourceStatus
	atProvider?: #ConfigurationAggregatorObservation @go(AtProvider)
}

// ConfigurationAggregator is the Schema for the ConfigurationAggregators API. Manages an AWS Config Configuration Aggregator.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ConfigurationAggregator: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta             @go(ObjectMeta)
	spec:      #ConfigurationAggregatorSpec   @go(Spec)
	status?:   #ConfigurationAggregatorStatus @go(Status)
}

// ConfigurationAggregatorList contains a list of ConfigurationAggregators
#ConfigurationAggregatorList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ConfigurationAggregator] @go(Items,[]ConfigurationAggregator)
}
