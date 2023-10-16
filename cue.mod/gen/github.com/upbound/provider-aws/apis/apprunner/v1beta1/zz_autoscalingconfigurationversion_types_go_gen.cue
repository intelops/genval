// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/apprunner/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AutoScalingConfigurationVersionInitParameters: {
	// Name of the auto scaling configuration.
	autoScalingConfigurationName?: null | string @go(AutoScalingConfigurationName,*string)

	// Maximal number of concurrent requests that you want an instance to process. When the number of concurrent requests goes over this limit, App Runner scales up your service.
	maxConcurrency?: null | float64 @go(MaxConcurrency,*float64)

	// Maximal number of instances that App Runner provisions for your service.
	maxSize?: null | float64 @go(MaxSize,*float64)

	// Minimal number of instances that App Runner provisions for your service.
	minSize?: null | float64 @go(MinSize,*float64)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#AutoScalingConfigurationVersionObservation: {
	// ARN of this auto scaling configuration version.
	arn?: null | string @go(Arn,*string)

	// Name of the auto scaling configuration.
	autoScalingConfigurationName?: null | string @go(AutoScalingConfigurationName,*string)

	// The revision of this auto scaling configuration.
	autoScalingConfigurationRevision?: null | float64 @go(AutoScalingConfigurationRevision,*float64)
	id?:                               null | string  @go(ID,*string)

	// Whether the auto scaling configuration has the highest auto_scaling_configuration_revision among all configurations that share the same auto_scaling_configuration_name.
	latest?: null | bool @go(Latest,*bool)

	// Maximal number of concurrent requests that you want an instance to process. When the number of concurrent requests goes over this limit, App Runner scales up your service.
	maxConcurrency?: null | float64 @go(MaxConcurrency,*float64)

	// Maximal number of instances that App Runner provisions for your service.
	maxSize?: null | float64 @go(MaxSize,*float64)

	// Minimal number of instances that App Runner provisions for your service.
	minSize?: null | float64 @go(MinSize,*float64)

	// Current state of the auto scaling configuration. An INACTIVE configuration revision has been deleted and can't be used. It is permanently removed some time after deletion.
	status?: null | string @go(Status,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#AutoScalingConfigurationVersionParameters: {
	// Name of the auto scaling configuration.
	// +kubebuilder:validation:Optional
	autoScalingConfigurationName?: null | string @go(AutoScalingConfigurationName,*string)

	// Maximal number of concurrent requests that you want an instance to process. When the number of concurrent requests goes over this limit, App Runner scales up your service.
	// +kubebuilder:validation:Optional
	maxConcurrency?: null | float64 @go(MaxConcurrency,*float64)

	// Maximal number of instances that App Runner provisions for your service.
	// +kubebuilder:validation:Optional
	maxSize?: null | float64 @go(MaxSize,*float64)

	// Minimal number of instances that App Runner provisions for your service.
	// +kubebuilder:validation:Optional
	minSize?: null | float64 @go(MinSize,*float64)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// AutoScalingConfigurationVersionSpec defines the desired state of AutoScalingConfigurationVersion
#AutoScalingConfigurationVersionSpec: {
	v1.#ResourceSpec
	forProvider: #AutoScalingConfigurationVersionParameters @go(ForProvider)

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
	initProvider?: #AutoScalingConfigurationVersionInitParameters @go(InitProvider)
}

// AutoScalingConfigurationVersionStatus defines the observed state of AutoScalingConfigurationVersion.
#AutoScalingConfigurationVersionStatus: {
	v1.#ResourceStatus
	atProvider?: #AutoScalingConfigurationVersionObservation @go(AtProvider)
}

// AutoScalingConfigurationVersion is the Schema for the AutoScalingConfigurationVersions API. Manages an App Runner AutoScaling Configuration Version.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#AutoScalingConfigurationVersion: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.autoScalingConfigurationName) || (has(self.initProvider) && has(self.initProvider.autoScalingConfigurationName))",message="spec.forProvider.autoScalingConfigurationName is a required parameter"
	spec:    #AutoScalingConfigurationVersionSpec   @go(Spec)
	status?: #AutoScalingConfigurationVersionStatus @go(Status)
}

// AutoScalingConfigurationVersionList contains a list of AutoScalingConfigurationVersions
#AutoScalingConfigurationVersionList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#AutoScalingConfigurationVersion] @go(Items,[]AutoScalingConfigurationVersion)
}