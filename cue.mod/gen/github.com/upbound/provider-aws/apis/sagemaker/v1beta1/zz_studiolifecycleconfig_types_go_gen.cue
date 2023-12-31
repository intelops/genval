// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sagemaker/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#StudioLifecycleConfigInitParameters: {
	// The App type that the Lifecycle Configuration is attached to. Valid values are JupyterServer and KernelGateway.
	studioLifecycleConfigAppType?: null | string @go(StudioLifecycleConfigAppType,*string)

	// The content of your Studio Lifecycle Configuration script. This content must be base64 encoded.
	studioLifecycleConfigContent?: null | string @go(StudioLifecycleConfigContent,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#StudioLifecycleConfigObservation: {
	// The Amazon Resource Name (ARN) assigned by AWS to this Studio Lifecycle Config.
	arn?: null | string @go(Arn,*string)

	// The name of the Studio Lifecycle Config.
	id?: null | string @go(ID,*string)

	// The App type that the Lifecycle Configuration is attached to. Valid values are JupyterServer and KernelGateway.
	studioLifecycleConfigAppType?: null | string @go(StudioLifecycleConfigAppType,*string)

	// The content of your Studio Lifecycle Configuration script. This content must be base64 encoded.
	studioLifecycleConfigContent?: null | string @go(StudioLifecycleConfigContent,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#StudioLifecycleConfigParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The App type that the Lifecycle Configuration is attached to. Valid values are JupyterServer and KernelGateway.
	// +kubebuilder:validation:Optional
	studioLifecycleConfigAppType?: null | string @go(StudioLifecycleConfigAppType,*string)

	// The content of your Studio Lifecycle Configuration script. This content must be base64 encoded.
	// +kubebuilder:validation:Optional
	studioLifecycleConfigContent?: null | string @go(StudioLifecycleConfigContent,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// StudioLifecycleConfigSpec defines the desired state of StudioLifecycleConfig
#StudioLifecycleConfigSpec: {
	v1.#ResourceSpec
	forProvider: #StudioLifecycleConfigParameters @go(ForProvider)

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
	initProvider?: #StudioLifecycleConfigInitParameters @go(InitProvider)
}

// StudioLifecycleConfigStatus defines the observed state of StudioLifecycleConfig.
#StudioLifecycleConfigStatus: {
	v1.#ResourceStatus
	atProvider?: #StudioLifecycleConfigObservation @go(AtProvider)
}

// StudioLifecycleConfig is the Schema for the StudioLifecycleConfigs API. Provides a SageMaker Studio Lifecycle Config resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#StudioLifecycleConfig: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.studioLifecycleConfigAppType) || (has(self.initProvider) && has(self.initProvider.studioLifecycleConfigAppType))",message="spec.forProvider.studioLifecycleConfigAppType is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.studioLifecycleConfigContent) || (has(self.initProvider) && has(self.initProvider.studioLifecycleConfigContent))",message="spec.forProvider.studioLifecycleConfigContent is a required parameter"
	spec:    #StudioLifecycleConfigSpec   @go(Spec)
	status?: #StudioLifecycleConfigStatus @go(Status)
}

// StudioLifecycleConfigList contains a list of StudioLifecycleConfigs
#StudioLifecycleConfigList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#StudioLifecycleConfig] @go(Items,[]StudioLifecycleConfig)
}
