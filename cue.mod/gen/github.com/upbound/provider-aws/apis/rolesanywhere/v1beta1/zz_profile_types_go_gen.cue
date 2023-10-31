// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/rolesanywhere/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ProfileInitParameters: {
	// The number of seconds the vended session credentials are valid for. Defaults to 3600.
	durationSeconds?: null | float64 @go(DurationSeconds,*float64)

	// Whether or not the Profile is enabled.
	enabled?: null | bool @go(Enabled,*bool)

	// A list of managed policy ARNs that apply to the vended session credentials.
	managedPolicyArns?: [...null | string] @go(ManagedPolicyArns,[]*string)

	// The name of the Profile.
	name?: null | string @go(Name,*string)

	// Specifies whether instance properties are required in CreateSession requests with this profile.
	requireInstanceProperties?: null | bool @go(RequireInstanceProperties,*bool)

	// A session policy that applies to the trust boundary of the vended session credentials.
	sessionPolicy?: null | string @go(SessionPolicy,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#ProfileObservation: {
	// Amazon Resource Name (ARN) of the Profile
	arn?: null | string @go(Arn,*string)

	// The number of seconds the vended session credentials are valid for. Defaults to 3600.
	durationSeconds?: null | float64 @go(DurationSeconds,*float64)

	// Whether or not the Profile is enabled.
	enabled?: null | bool @go(Enabled,*bool)

	// The Profile ID.
	id?: null | string @go(ID,*string)

	// A list of managed policy ARNs that apply to the vended session credentials.
	managedPolicyArns?: [...null | string] @go(ManagedPolicyArns,[]*string)

	// The name of the Profile.
	name?: null | string @go(Name,*string)

	// Specifies whether instance properties are required in CreateSession requests with this profile.
	requireInstanceProperties?: null | bool @go(RequireInstanceProperties,*bool)

	// A list of IAM roles that this profile can assume
	roleArns?: [...null | string] @go(RoleArns,[]*string)

	// A session policy that applies to the trust boundary of the vended session credentials.
	sessionPolicy?: null | string @go(SessionPolicy,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#ProfileParameters: {
	// The number of seconds the vended session credentials are valid for. Defaults to 3600.
	// +kubebuilder:validation:Optional
	durationSeconds?: null | float64 @go(DurationSeconds,*float64)

	// Whether or not the Profile is enabled.
	// +kubebuilder:validation:Optional
	enabled?: null | bool @go(Enabled,*bool)

	// A list of managed policy ARNs that apply to the vended session credentials.
	// +kubebuilder:validation:Optional
	managedPolicyArns?: [...null | string] @go(ManagedPolicyArns,[]*string)

	// The name of the Profile.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Specifies whether instance properties are required in CreateSession requests with this profile.
	// +kubebuilder:validation:Optional
	requireInstanceProperties?: null | bool @go(RequireInstanceProperties,*bool)

	// A list of IAM roles that this profile can assume
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	roleArns?: [...null | string] @go(RoleArns,[]*string)

	// References to Role in iam to populate roleArns.
	// +kubebuilder:validation:Optional
	roleArnsRefs?: [...v1.#Reference] @go(RoleArnsRefs,[]v1.Reference)

	// Selector for a list of Role in iam to populate roleArns.
	// +kubebuilder:validation:Optional
	roleArnsSelector?: null | v1.#Selector @go(RoleArnsSelector,*v1.Selector)

	// A session policy that applies to the trust boundary of the vended session credentials.
	// +kubebuilder:validation:Optional
	sessionPolicy?: null | string @go(SessionPolicy,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// ProfileSpec defines the desired state of Profile
#ProfileSpec: {
	v1.#ResourceSpec
	forProvider: #ProfileParameters @go(ForProvider)

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
	initProvider?: #ProfileInitParameters @go(InitProvider)
}

// ProfileStatus defines the observed state of Profile.
#ProfileStatus: {
	v1.#ResourceStatus
	atProvider?: #ProfileObservation @go(AtProvider)
}

// Profile is the Schema for the Profiles API. Provides a Roles Anywhere Profile resource
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Profile: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #ProfileSpec   @go(Spec)
	status?: #ProfileStatus @go(Status)
}

// ProfileList contains a list of Profiles
#ProfileList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Profile] @go(Items,[]Profile)
}
