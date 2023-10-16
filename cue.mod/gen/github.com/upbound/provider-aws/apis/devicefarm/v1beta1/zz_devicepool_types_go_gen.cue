// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/devicefarm/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DevicePoolInitParameters: {
	// The device pool's description.
	description?: null | string @go(Description,*string)

	// The number of devices that Device Farm can add to your device pool.
	maxDevices?: null | float64 @go(MaxDevices,*float64)

	// The name of the Device Pool
	name?: null | string @go(Name,*string)

	// The device pool's rules. See Rule.
	rule?: [...#RuleInitParameters] @go(Rule,[]RuleInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#DevicePoolObservation: {
	// The Amazon Resource Name of this Device Pool
	arn?: null | string @go(Arn,*string)

	// The device pool's description.
	description?: null | string @go(Description,*string)
	id?:          null | string @go(ID,*string)

	// The number of devices that Device Farm can add to your device pool.
	maxDevices?: null | float64 @go(MaxDevices,*float64)

	// The name of the Device Pool
	name?: null | string @go(Name,*string)

	// The ARN of the project for the device pool.
	projectArn?: null | string @go(ProjectArn,*string)

	// The device pool's rules. See Rule.
	rule?: [...#RuleObservation] @go(Rule,[]RuleObservation)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
	type?: null | string @go(Type,*string)
}

#DevicePoolParameters: {
	// The device pool's description.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// The number of devices that Device Farm can add to your device pool.
	// +kubebuilder:validation:Optional
	maxDevices?: null | float64 @go(MaxDevices,*float64)

	// The name of the Device Pool
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// The ARN of the project for the device pool.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/devicefarm/v1beta1.Project
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	projectArn?: null | string @go(ProjectArn,*string)

	// Reference to a Project in devicefarm to populate projectArn.
	// +kubebuilder:validation:Optional
	projectArnRef?: null | v1.#Reference @go(ProjectArnRef,*v1.Reference)

	// Selector for a Project in devicefarm to populate projectArn.
	// +kubebuilder:validation:Optional
	projectArnSelector?: null | v1.#Selector @go(ProjectArnSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The device pool's rules. See Rule.
	// +kubebuilder:validation:Optional
	rule?: [...#RuleParameters] @go(Rule,[]RuleParameters)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RuleInitParameters: {
	// The rule's stringified attribute. Valid values are: APPIUM_VERSION, ARN, AVAILABILITY, FLEET_TYPE, FORM_FACTOR, INSTANCE_ARN, INSTANCE_LABELS, MANUFACTURER, MODEL, OS_VERSION, PLATFORM, REMOTE_ACCESS_ENABLED, REMOTE_DEBUG_ENABLED.
	attribute?: null | string @go(Attribute,*string)

	// Specifies how Device Farm compares the rule's attribute to the value. For the operators that are supported by each attribute. Valid values are: EQUALS, NOT_IN, IN, GREATER_THAN, GREATER_THAN_OR_EQUALS, LESS_THAN, LESS_THAN_OR_EQUALS, CONTAINS.
	operator?: null | string @go(Operator,*string)

	// The rule's value.
	value?: null | string @go(Value,*string)
}

#RuleObservation: {
	// The rule's stringified attribute. Valid values are: APPIUM_VERSION, ARN, AVAILABILITY, FLEET_TYPE, FORM_FACTOR, INSTANCE_ARN, INSTANCE_LABELS, MANUFACTURER, MODEL, OS_VERSION, PLATFORM, REMOTE_ACCESS_ENABLED, REMOTE_DEBUG_ENABLED.
	attribute?: null | string @go(Attribute,*string)

	// Specifies how Device Farm compares the rule's attribute to the value. For the operators that are supported by each attribute. Valid values are: EQUALS, NOT_IN, IN, GREATER_THAN, GREATER_THAN_OR_EQUALS, LESS_THAN, LESS_THAN_OR_EQUALS, CONTAINS.
	operator?: null | string @go(Operator,*string)

	// The rule's value.
	value?: null | string @go(Value,*string)
}

#RuleParameters: {
	// The rule's stringified attribute. Valid values are: APPIUM_VERSION, ARN, AVAILABILITY, FLEET_TYPE, FORM_FACTOR, INSTANCE_ARN, INSTANCE_LABELS, MANUFACTURER, MODEL, OS_VERSION, PLATFORM, REMOTE_ACCESS_ENABLED, REMOTE_DEBUG_ENABLED.
	// +kubebuilder:validation:Optional
	attribute?: null | string @go(Attribute,*string)

	// Specifies how Device Farm compares the rule's attribute to the value. For the operators that are supported by each attribute. Valid values are: EQUALS, NOT_IN, IN, GREATER_THAN, GREATER_THAN_OR_EQUALS, LESS_THAN, LESS_THAN_OR_EQUALS, CONTAINS.
	// +kubebuilder:validation:Optional
	operator?: null | string @go(Operator,*string)

	// The rule's value.
	// +kubebuilder:validation:Optional
	value?: null | string @go(Value,*string)
}

// DevicePoolSpec defines the desired state of DevicePool
#DevicePoolSpec: {
	v1.#ResourceSpec
	forProvider: #DevicePoolParameters @go(ForProvider)

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
	initProvider?: #DevicePoolInitParameters @go(InitProvider)
}

// DevicePoolStatus defines the observed state of DevicePool.
#DevicePoolStatus: {
	v1.#ResourceStatus
	atProvider?: #DevicePoolObservation @go(AtProvider)
}

// DevicePool is the Schema for the DevicePools API. Provides a Devicefarm device_pool
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#DevicePool: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.rule) || (has(self.initProvider) && has(self.initProvider.rule))",message="spec.forProvider.rule is a required parameter"
	spec:    #DevicePoolSpec   @go(Spec)
	status?: #DevicePoolStatus @go(Status)
}

// DevicePoolList contains a list of DevicePools
#DevicePoolList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#DevicePool] @go(Items,[]DevicePool)
}