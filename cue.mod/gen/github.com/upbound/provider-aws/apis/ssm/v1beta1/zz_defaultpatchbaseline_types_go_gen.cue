// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ssm/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DefaultPatchBaselineInitParameters: {
}

#DefaultPatchBaselineObservation: {
	// ID of the patch baseline.
	// Can be an ID or an ARN.
	// When specifying an AWS-provided patch baseline, must be the ARN.
	baselineId?: null | string @go(BaselineID,*string)
	id?:         null | string @go(ID,*string)

	// The operating system the patch baseline applies to.
	// Valid values are
	// AMAZON_LINUX,
	// AMAZON_LINUX_2,
	// AMAZON_LINUX_2022,
	// CENTOS,
	// DEBIAN,
	// MACOS,
	// ORACLE_LINUX,
	// RASPBIAN,
	// REDHAT_ENTERPRISE_LINUX,
	// ROCKY_LINUX,
	// SUSE,
	// UBUNTU, and
	// WINDOWS.
	operatingSystem?: null | string @go(OperatingSystem,*string)
}

#DefaultPatchBaselineParameters: {
	// ID of the patch baseline.
	// Can be an ID or an ARN.
	// When specifying an AWS-provided patch baseline, must be the ARN.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ssm/v1beta1.PatchBaseline
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	baselineId?: null | string @go(BaselineID,*string)

	// Reference to a PatchBaseline in ssm to populate baselineId.
	// +kubebuilder:validation:Optional
	baselineIdRef?: null | v1.#Reference @go(BaselineIDRef,*v1.Reference)

	// Selector for a PatchBaseline in ssm to populate baselineId.
	// +kubebuilder:validation:Optional
	baselineIdSelector?: null | v1.#Selector @go(BaselineIDSelector,*v1.Selector)

	// The operating system the patch baseline applies to.
	// Valid values are
	// AMAZON_LINUX,
	// AMAZON_LINUX_2,
	// AMAZON_LINUX_2022,
	// CENTOS,
	// DEBIAN,
	// MACOS,
	// ORACLE_LINUX,
	// RASPBIAN,
	// REDHAT_ENTERPRISE_LINUX,
	// ROCKY_LINUX,
	// SUSE,
	// UBUNTU, and
	// WINDOWS.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ssm/v1beta1.PatchBaseline
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("operating_system",false)
	// +kubebuilder:validation:Optional
	operatingSystem?: null | string @go(OperatingSystem,*string)

	// Reference to a PatchBaseline in ssm to populate operatingSystem.
	// +kubebuilder:validation:Optional
	operatingSystemRef?: null | v1.#Reference @go(OperatingSystemRef,*v1.Reference)

	// Selector for a PatchBaseline in ssm to populate operatingSystem.
	// +kubebuilder:validation:Optional
	operatingSystemSelector?: null | v1.#Selector @go(OperatingSystemSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// DefaultPatchBaselineSpec defines the desired state of DefaultPatchBaseline
#DefaultPatchBaselineSpec: {
	v1.#ResourceSpec
	forProvider: #DefaultPatchBaselineParameters @go(ForProvider)

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
	initProvider?: #DefaultPatchBaselineInitParameters @go(InitProvider)
}

// DefaultPatchBaselineStatus defines the observed state of DefaultPatchBaseline.
#DefaultPatchBaselineStatus: {
	v1.#ResourceStatus
	atProvider?: #DefaultPatchBaselineObservation @go(AtProvider)
}

// DefaultPatchBaseline is the Schema for the DefaultPatchBaselines API.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#DefaultPatchBaseline: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta          @go(ObjectMeta)
	spec:      #DefaultPatchBaselineSpec   @go(Spec)
	status?:   #DefaultPatchBaselineStatus @go(Status)
}

// DefaultPatchBaselineList contains a list of DefaultPatchBaselines
#DefaultPatchBaselineList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#DefaultPatchBaseline] @go(Items,[]DefaultPatchBaseline)
}
