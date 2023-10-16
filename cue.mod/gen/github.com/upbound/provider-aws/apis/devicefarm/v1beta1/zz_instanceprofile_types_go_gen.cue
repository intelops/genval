// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/devicefarm/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#InstanceProfileInitParameters: {
	// The description of the instance profile.
	description?: null | string @go(Description,*string)

	// An array of strings that specifies the list of app packages that should not be cleaned up from the device after a test run.
	excludeAppPackagesFromCleanup?: [...null | string] @go(ExcludeAppPackagesFromCleanup,[]*string)

	// The name for the instance profile.
	name?: null | string @go(Name,*string)

	// When set to true, Device Farm removes app packages after a test run. The default value is false for private devices.
	packageCleanup?: null | bool @go(PackageCleanup,*bool)

	// When set to true, Device Farm reboots the instance after a test run. The default value is true.
	rebootAfterUse?: null | bool @go(RebootAfterUse,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#InstanceProfileObservation: {
	// The Amazon Resource Name of this instance profile.
	arn?: null | string @go(Arn,*string)

	// The description of the instance profile.
	description?: null | string @go(Description,*string)

	// An array of strings that specifies the list of app packages that should not be cleaned up from the device after a test run.
	excludeAppPackagesFromCleanup?: [...null | string] @go(ExcludeAppPackagesFromCleanup,[]*string)
	id?: null | string @go(ID,*string)

	// The name for the instance profile.
	name?: null | string @go(Name,*string)

	// When set to true, Device Farm removes app packages after a test run. The default value is false for private devices.
	packageCleanup?: null | bool @go(PackageCleanup,*bool)

	// When set to true, Device Farm reboots the instance after a test run. The default value is true.
	rebootAfterUse?: null | bool @go(RebootAfterUse,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#InstanceProfileParameters: {
	// The description of the instance profile.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// An array of strings that specifies the list of app packages that should not be cleaned up from the device after a test run.
	// +kubebuilder:validation:Optional
	excludeAppPackagesFromCleanup?: [...null | string] @go(ExcludeAppPackagesFromCleanup,[]*string)

	// The name for the instance profile.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// When set to true, Device Farm removes app packages after a test run. The default value is false for private devices.
	// +kubebuilder:validation:Optional
	packageCleanup?: null | bool @go(PackageCleanup,*bool)

	// When set to true, Device Farm reboots the instance after a test run. The default value is true.
	// +kubebuilder:validation:Optional
	rebootAfterUse?: null | bool @go(RebootAfterUse,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// InstanceProfileSpec defines the desired state of InstanceProfile
#InstanceProfileSpec: {
	v1.#ResourceSpec
	forProvider: #InstanceProfileParameters @go(ForProvider)

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
	initProvider?: #InstanceProfileInitParameters @go(InitProvider)
}

// InstanceProfileStatus defines the observed state of InstanceProfile.
#InstanceProfileStatus: {
	v1.#ResourceStatus
	atProvider?: #InstanceProfileObservation @go(AtProvider)
}

// InstanceProfile is the Schema for the InstanceProfiles API. Provides a Devicefarm instance profile
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#InstanceProfile: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #InstanceProfileSpec   @go(Spec)
	status?: #InstanceProfileStatus @go(Status)
}

// InstanceProfileList contains a list of InstanceProfiles
#InstanceProfileList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#InstanceProfile] @go(Items,[]InstanceProfile)
}
