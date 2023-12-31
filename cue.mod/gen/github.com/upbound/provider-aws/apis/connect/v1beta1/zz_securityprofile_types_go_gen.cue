// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/connect/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#SecurityProfileInitParameters: {
	// Specifies the description of the Security Profile.
	description?: null | string @go(Description,*string)

	// Specifies the name of the Security Profile.
	name?: null | string @go(Name,*string)

	// Specifies a list of permissions assigned to the security profile.
	permissions?: [...null | string] @go(Permissions,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#SecurityProfileObservation: {
	// The Amazon Resource Name (ARN) of the Security Profile.
	arn?: null | string @go(Arn,*string)

	// Specifies the description of the Security Profile.
	description?: null | string @go(Description,*string)

	// The identifier of the hosting Amazon Connect Instance and identifier of the Security Profile separated by a colon (:).
	id?: null | string @go(ID,*string)

	// Specifies the identifier of the hosting Amazon Connect Instance.
	instanceId?: null | string @go(InstanceID,*string)

	// Specifies the name of the Security Profile.
	name?: null | string @go(Name,*string)

	// The organization resource identifier for the security profile.
	organizationResourceId?: null | string @go(OrganizationResourceID,*string)

	// Specifies a list of permissions assigned to the security profile.
	permissions?: [...null | string] @go(Permissions,[]*string)

	// The identifier for the Security Profile.
	securityProfileId?: null | string @go(SecurityProfileID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#SecurityProfileParameters: {
	// Specifies the description of the Security Profile.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Specifies the identifier of the hosting Amazon Connect Instance.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/connect/v1beta1.Instance
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	instanceId?: null | string @go(InstanceID,*string)

	// Reference to a Instance in connect to populate instanceId.
	// +kubebuilder:validation:Optional
	instanceIdRef?: null | v1.#Reference @go(InstanceIDRef,*v1.Reference)

	// Selector for a Instance in connect to populate instanceId.
	// +kubebuilder:validation:Optional
	instanceIdSelector?: null | v1.#Selector @go(InstanceIDSelector,*v1.Selector)

	// Specifies the name of the Security Profile.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Specifies a list of permissions assigned to the security profile.
	// +kubebuilder:validation:Optional
	permissions?: [...null | string] @go(Permissions,[]*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// SecurityProfileSpec defines the desired state of SecurityProfile
#SecurityProfileSpec: {
	v1.#ResourceSpec
	forProvider: #SecurityProfileParameters @go(ForProvider)

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
	initProvider?: #SecurityProfileInitParameters @go(InitProvider)
}

// SecurityProfileStatus defines the observed state of SecurityProfile.
#SecurityProfileStatus: {
	v1.#ResourceStatus
	atProvider?: #SecurityProfileObservation @go(AtProvider)
}

// SecurityProfile is the Schema for the SecurityProfiles API. Provides details about a specific Amazon Connect Security Profile.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#SecurityProfile: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #SecurityProfileSpec   @go(Spec)
	status?: #SecurityProfileStatus @go(Status)
}

// SecurityProfileList contains a list of SecurityProfiles
#SecurityProfileList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#SecurityProfile] @go(Items,[]SecurityProfile)
}
