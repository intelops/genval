// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/appconfig/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DeploymentStrategyInitParameters: {
	// Total amount of time for a deployment to last. Minimum value of 0, maximum value of 1440.
	deploymentDurationInMinutes?: null | float64 @go(DeploymentDurationInMinutes,*float64)

	// Description of the deployment strategy. Can be at most 1024 characters.
	description?: null | string @go(Description,*string)

	// Amount of time AWS AppConfig monitors for alarms before considering the deployment to be complete and no longer eligible for automatic roll back. Minimum value of 0, maximum value of 1440.
	finalBakeTimeInMinutes?: null | float64 @go(FinalBakeTimeInMinutes,*float64)

	// Percentage of targets to receive a deployed configuration during each interval. Minimum value of 1.0, maximum value of 100.0.
	growthFactor?: null | float64 @go(GrowthFactor,*float64)

	// Algorithm used to define how percentage grows over time. Valid value: LINEAR and EXPONENTIAL. Defaults to LINEAR.
	growthType?: null | string @go(GrowthType,*string)

	// Name for the deployment strategy. Must be between 1 and 64 characters in length.
	name?: null | string @go(Name,*string)

	// Where to save the deployment strategy. Valid values: NONE and SSM_DOCUMENT.
	replicateTo?: null | string @go(ReplicateTo,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#DeploymentStrategyObservation: {
	// ARN of the AppConfig Deployment Strategy.
	arn?: null | string @go(Arn,*string)

	// Total amount of time for a deployment to last. Minimum value of 0, maximum value of 1440.
	deploymentDurationInMinutes?: null | float64 @go(DeploymentDurationInMinutes,*float64)

	// Description of the deployment strategy. Can be at most 1024 characters.
	description?: null | string @go(Description,*string)

	// Amount of time AWS AppConfig monitors for alarms before considering the deployment to be complete and no longer eligible for automatic roll back. Minimum value of 0, maximum value of 1440.
	finalBakeTimeInMinutes?: null | float64 @go(FinalBakeTimeInMinutes,*float64)

	// Percentage of targets to receive a deployed configuration during each interval. Minimum value of 1.0, maximum value of 100.0.
	growthFactor?: null | float64 @go(GrowthFactor,*float64)

	// Algorithm used to define how percentage grows over time. Valid value: LINEAR and EXPONENTIAL. Defaults to LINEAR.
	growthType?: null | string @go(GrowthType,*string)

	// AppConfig deployment strategy ID.
	id?: null | string @go(ID,*string)

	// Name for the deployment strategy. Must be between 1 and 64 characters in length.
	name?: null | string @go(Name,*string)

	// Where to save the deployment strategy. Valid values: NONE and SSM_DOCUMENT.
	replicateTo?: null | string @go(ReplicateTo,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#DeploymentStrategyParameters: {
	// Total amount of time for a deployment to last. Minimum value of 0, maximum value of 1440.
	// +kubebuilder:validation:Optional
	deploymentDurationInMinutes?: null | float64 @go(DeploymentDurationInMinutes,*float64)

	// Description of the deployment strategy. Can be at most 1024 characters.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Amount of time AWS AppConfig monitors for alarms before considering the deployment to be complete and no longer eligible for automatic roll back. Minimum value of 0, maximum value of 1440.
	// +kubebuilder:validation:Optional
	finalBakeTimeInMinutes?: null | float64 @go(FinalBakeTimeInMinutes,*float64)

	// Percentage of targets to receive a deployed configuration during each interval. Minimum value of 1.0, maximum value of 100.0.
	// +kubebuilder:validation:Optional
	growthFactor?: null | float64 @go(GrowthFactor,*float64)

	// Algorithm used to define how percentage grows over time. Valid value: LINEAR and EXPONENTIAL. Defaults to LINEAR.
	// +kubebuilder:validation:Optional
	growthType?: null | string @go(GrowthType,*string)

	// Name for the deployment strategy. Must be between 1 and 64 characters in length.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Where to save the deployment strategy. Valid values: NONE and SSM_DOCUMENT.
	// +kubebuilder:validation:Optional
	replicateTo?: null | string @go(ReplicateTo,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// DeploymentStrategySpec defines the desired state of DeploymentStrategy
#DeploymentStrategySpec: {
	v1.#ResourceSpec
	forProvider: #DeploymentStrategyParameters @go(ForProvider)

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
	initProvider?: #DeploymentStrategyInitParameters @go(InitProvider)
}

// DeploymentStrategyStatus defines the observed state of DeploymentStrategy.
#DeploymentStrategyStatus: {
	v1.#ResourceStatus
	atProvider?: #DeploymentStrategyObservation @go(AtProvider)
}

// DeploymentStrategy is the Schema for the DeploymentStrategys API. Provides an AppConfig Deployment Strategy resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#DeploymentStrategy: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.deploymentDurationInMinutes) || (has(self.initProvider) && has(self.initProvider.deploymentDurationInMinutes))",message="spec.forProvider.deploymentDurationInMinutes is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.growthFactor) || (has(self.initProvider) && has(self.initProvider.growthFactor))",message="spec.forProvider.growthFactor is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.replicateTo) || (has(self.initProvider) && has(self.initProvider.replicateTo))",message="spec.forProvider.replicateTo is a required parameter"
	spec:    #DeploymentStrategySpec   @go(Spec)
	status?: #DeploymentStrategyStatus @go(Status)
}

// DeploymentStrategyList contains a list of DeploymentStrategys
#DeploymentStrategyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#DeploymentStrategy] @go(Items,[]DeploymentStrategy)
}
