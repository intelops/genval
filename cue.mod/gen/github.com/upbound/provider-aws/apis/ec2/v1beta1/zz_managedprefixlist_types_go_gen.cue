// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#EntryInitParameters: {
	// Description of this entry. Due to API limitations, updating only the description of an existing entry requires temporarily removing and re-adding the entry.
	description?: null | string @go(Description,*string)
}

#EntryObservation: {
	// CIDR block of this entry.
	cidr?: null | string @go(Cidr,*string)

	// Description of this entry. Due to API limitations, updating only the description of an existing entry requires temporarily removing and re-adding the entry.
	description?: null | string @go(Description,*string)
}

#EntryParameters: {
	// CIDR block of this entry.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPCIPv4CidrBlockAssociation
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("cidr_block",false)
	// +kubebuilder:validation:Optional
	cidr?: null | string @go(Cidr,*string)

	// Reference to a VPCIPv4CidrBlockAssociation in ec2 to populate cidr.
	// +kubebuilder:validation:Optional
	cidrRef?: null | v1.#Reference @go(CidrRef,*v1.Reference)

	// Selector for a VPCIPv4CidrBlockAssociation in ec2 to populate cidr.
	// +kubebuilder:validation:Optional
	cidrSelector?: null | v1.#Selector @go(CidrSelector,*v1.Selector)

	// Description of this entry. Due to API limitations, updating only the description of an existing entry requires temporarily removing and re-adding the entry.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)
}

#ManagedPrefixListInitParameters: {
	// Address family (IPv4 or IPv6) of this prefix list.
	addressFamily?: null | string @go(AddressFamily,*string)

	// Configuration block for prefix list entry. Detailed below. Different entries may have overlapping CIDR blocks, but a particular CIDR should not be duplicated.
	entry?: [...#EntryInitParameters] @go(Entry,[]EntryInitParameters)

	// Maximum number of entries that this prefix list can contain.
	maxEntries?: null | float64 @go(MaxEntries,*float64)

	// Name of this resource. The name must not start with com.amazonaws.
	name?: null | string @go(Name,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#ManagedPrefixListObservation: {
	// Address family (IPv4 or IPv6) of this prefix list.
	addressFamily?: null | string @go(AddressFamily,*string)

	// ARN of the prefix list.
	arn?: null | string @go(Arn,*string)

	// Configuration block for prefix list entry. Detailed below. Different entries may have overlapping CIDR blocks, but a particular CIDR should not be duplicated.
	entry?: [...#EntryObservation] @go(Entry,[]EntryObservation)

	// ID of the prefix list.
	id?: null | string @go(ID,*string)

	// Maximum number of entries that this prefix list can contain.
	maxEntries?: null | float64 @go(MaxEntries,*float64)

	// Name of this resource. The name must not start with com.amazonaws.
	name?: null | string @go(Name,*string)

	// ID of the AWS account that owns this prefix list.
	ownerId?: null | string @go(OwnerID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Latest version of this prefix list.
	version?: null | float64 @go(Version,*float64)
}

#ManagedPrefixListParameters: {
	// Address family (IPv4 or IPv6) of this prefix list.
	// +kubebuilder:validation:Optional
	addressFamily?: null | string @go(AddressFamily,*string)

	// Configuration block for prefix list entry. Detailed below. Different entries may have overlapping CIDR blocks, but a particular CIDR should not be duplicated.
	// +kubebuilder:validation:Optional
	entry?: [...#EntryParameters] @go(Entry,[]EntryParameters)

	// Maximum number of entries that this prefix list can contain.
	// +kubebuilder:validation:Optional
	maxEntries?: null | float64 @go(MaxEntries,*float64)

	// Name of this resource. The name must not start with com.amazonaws.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// ManagedPrefixListSpec defines the desired state of ManagedPrefixList
#ManagedPrefixListSpec: {
	v1.#ResourceSpec
	forProvider: #ManagedPrefixListParameters @go(ForProvider)

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
	initProvider?: #ManagedPrefixListInitParameters @go(InitProvider)
}

// ManagedPrefixListStatus defines the observed state of ManagedPrefixList.
#ManagedPrefixListStatus: {
	v1.#ResourceStatus
	atProvider?: #ManagedPrefixListObservation @go(AtProvider)
}

// ManagedPrefixList is the Schema for the ManagedPrefixLists API. Provides a managed prefix list resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ManagedPrefixList: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.addressFamily) || (has(self.initProvider) && has(self.initProvider.addressFamily))",message="spec.forProvider.addressFamily is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.maxEntries) || (has(self.initProvider) && has(self.initProvider.maxEntries))",message="spec.forProvider.maxEntries is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #ManagedPrefixListSpec   @go(Spec)
	status?: #ManagedPrefixListStatus @go(Status)
}

// ManagedPrefixListList contains a list of ManagedPrefixLists
#ManagedPrefixListList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ManagedPrefixList] @go(Items,[]ManagedPrefixList)
}
