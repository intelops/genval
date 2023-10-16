// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/fis/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ActionInitParameters: {
	// ID of the action. To find out what actions are supported see AWS FIS actions reference.
	actionId?: null | string @go(ActionID,*string)

	// Description of the action.
	description?: null | string @go(Description,*string)

	// Friendly name of the action.
	name?: null | string @go(Name,*string)

	// Parameter(s) for the action, if applicable. See below.
	parameter?: [...#ParameterInitParameters] @go(Parameter,[]ParameterInitParameters)

	// Set of action names that must complete before this action can be executed.
	startAfter?: [...null | string] @go(StartAfter,[]*string)

	// Action's target, if applicable. See below.
	target?: [...#TargetInitParameters] @go(Target,[]TargetInitParameters)
}

#ActionObservation: {
	// ID of the action. To find out what actions are supported see AWS FIS actions reference.
	actionId?: null | string @go(ActionID,*string)

	// Description of the action.
	description?: null | string @go(Description,*string)

	// Friendly name of the action.
	name?: null | string @go(Name,*string)

	// Parameter(s) for the action, if applicable. See below.
	parameter?: [...#ParameterObservation] @go(Parameter,[]ParameterObservation)

	// Set of action names that must complete before this action can be executed.
	startAfter?: [...null | string] @go(StartAfter,[]*string)

	// Action's target, if applicable. See below.
	target?: [...#TargetObservation] @go(Target,[]TargetObservation)
}

#ActionParameters: {
	// ID of the action. To find out what actions are supported see AWS FIS actions reference.
	// +kubebuilder:validation:Optional
	actionId?: null | string @go(ActionID,*string)

	// Description of the action.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Friendly name of the action.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Parameter(s) for the action, if applicable. See below.
	// +kubebuilder:validation:Optional
	parameter?: [...#ParameterParameters] @go(Parameter,[]ParameterParameters)

	// Set of action names that must complete before this action can be executed.
	// +kubebuilder:validation:Optional
	startAfter?: [...null | string] @go(StartAfter,[]*string)

	// Action's target, if applicable. See below.
	// +kubebuilder:validation:Optional
	target?: [...#TargetParameters] @go(Target,[]TargetParameters)
}

#ExperimentTemplateInitParameters: {
	// Action to be performed during an experiment. See below.
	action?: [...#ActionInitParameters] @go(Action,[]ActionInitParameters)

	// Description for the experiment template.
	description?: null | string @go(Description,*string)

	// When an ongoing experiment should be stopped. See below.
	stopCondition?: [...#StopConditionInitParameters] @go(StopCondition,[]StopConditionInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Target of an action. See below.
	target?: [...#ExperimentTemplateTargetInitParameters] @go(Target,[]ExperimentTemplateTargetInitParameters)
}

#ExperimentTemplateObservation: {
	// Action to be performed during an experiment. See below.
	action?: [...#ActionObservation] @go(Action,[]ActionObservation)

	// Description for the experiment template.
	description?: null | string @go(Description,*string)

	// Experiment Template ID.
	id?: null | string @go(ID,*string)

	// ARN of an IAM role that grants the AWS FIS service permission to perform service actions on your behalf.
	roleArn?: null | string @go(RoleArn,*string)

	// When an ongoing experiment should be stopped. See below.
	stopCondition?: [...#StopConditionObservation] @go(StopCondition,[]StopConditionObservation)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Target of an action. See below.
	target?: [...#ExperimentTemplateTargetObservation] @go(Target,[]ExperimentTemplateTargetObservation)
}

#ExperimentTemplateParameters: {
	// Action to be performed during an experiment. See below.
	// +kubebuilder:validation:Optional
	action?: [...#ActionParameters] @go(Action,[]ActionParameters)

	// Description for the experiment template.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// ARN of an IAM role that grants the AWS FIS service permission to perform service actions on your behalf.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	roleArn?: null | string @go(RoleArn,*string)

	// Reference to a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnRef?: null | v1.#Reference @go(RoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnSelector?: null | v1.#Selector @go(RoleArnSelector,*v1.Selector)

	// When an ongoing experiment should be stopped. See below.
	// +kubebuilder:validation:Optional
	stopCondition?: [...#StopConditionParameters] @go(StopCondition,[]StopConditionParameters)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Target of an action. See below.
	// +kubebuilder:validation:Optional
	target?: [...#ExperimentTemplateTargetParameters] @go(Target,[]ExperimentTemplateTargetParameters)
}

#ExperimentTemplateTargetInitParameters: {
	// Filter(s) for the target. Filters can be used to select resources based on specific attributes returned by the respective describe action of the resource type. For more information, see Targets for AWS FIS. See below.
	filter?: [...#FilterInitParameters] @go(Filter,[]FilterInitParameters)

	// Friendly name given to the target.
	name?: null | string @go(Name,*string)

	// Set of ARNs of the resources to target with an action. Conflicts with resource_tag.
	resourceArns?: [...null | string] @go(ResourceArns,[]*string)

	// Tag(s) the resources need to have to be considered a valid target for an action. Conflicts with resource_arns. See below.
	resourceTag?: [...#ResourceTagInitParameters] @go(ResourceTag,[]ResourceTagInitParameters)

	// AWS resource type. The resource type must be supported for the specified action. To find out what resource types are supported, see Targets for AWS FIS.
	resourceType?: null | string @go(ResourceType,*string)

	// Scopes the identified resources. Valid values are ALL (all identified resources), COUNT(n) (randomly select n of the identified resources), PERCENT(n) (randomly select n percent of the identified resources).
	selectionMode?: null | string @go(SelectionMode,*string)
}

#ExperimentTemplateTargetObservation: {
	// Filter(s) for the target. Filters can be used to select resources based on specific attributes returned by the respective describe action of the resource type. For more information, see Targets for AWS FIS. See below.
	filter?: [...#FilterObservation] @go(Filter,[]FilterObservation)

	// Friendly name given to the target.
	name?: null | string @go(Name,*string)

	// Set of ARNs of the resources to target with an action. Conflicts with resource_tag.
	resourceArns?: [...null | string] @go(ResourceArns,[]*string)

	// Tag(s) the resources need to have to be considered a valid target for an action. Conflicts with resource_arns. See below.
	resourceTag?: [...#ResourceTagObservation] @go(ResourceTag,[]ResourceTagObservation)

	// AWS resource type. The resource type must be supported for the specified action. To find out what resource types are supported, see Targets for AWS FIS.
	resourceType?: null | string @go(ResourceType,*string)

	// Scopes the identified resources. Valid values are ALL (all identified resources), COUNT(n) (randomly select n of the identified resources), PERCENT(n) (randomly select n percent of the identified resources).
	selectionMode?: null | string @go(SelectionMode,*string)
}

#ExperimentTemplateTargetParameters: {
	// Filter(s) for the target. Filters can be used to select resources based on specific attributes returned by the respective describe action of the resource type. For more information, see Targets for AWS FIS. See below.
	// +kubebuilder:validation:Optional
	filter?: [...#FilterParameters] @go(Filter,[]FilterParameters)

	// Friendly name given to the target.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Set of ARNs of the resources to target with an action. Conflicts with resource_tag.
	// +kubebuilder:validation:Optional
	resourceArns?: [...null | string] @go(ResourceArns,[]*string)

	// Tag(s) the resources need to have to be considered a valid target for an action. Conflicts with resource_arns. See below.
	// +kubebuilder:validation:Optional
	resourceTag?: [...#ResourceTagParameters] @go(ResourceTag,[]ResourceTagParameters)

	// AWS resource type. The resource type must be supported for the specified action. To find out what resource types are supported, see Targets for AWS FIS.
	// +kubebuilder:validation:Optional
	resourceType?: null | string @go(ResourceType,*string)

	// Scopes the identified resources. Valid values are ALL (all identified resources), COUNT(n) (randomly select n of the identified resources), PERCENT(n) (randomly select n percent of the identified resources).
	// +kubebuilder:validation:Optional
	selectionMode?: null | string @go(SelectionMode,*string)
}

#FilterInitParameters: {
	// Attribute path for the filter.
	path?: null | string @go(Path,*string)

	// Set of attribute values for the filter.
	values?: [...null | string] @go(Values,[]*string)
}

#FilterObservation: {
	// Attribute path for the filter.
	path?: null | string @go(Path,*string)

	// Set of attribute values for the filter.
	values?: [...null | string] @go(Values,[]*string)
}

#FilterParameters: {
	// Attribute path for the filter.
	// +kubebuilder:validation:Optional
	path?: null | string @go(Path,*string)

	// Set of attribute values for the filter.
	// +kubebuilder:validation:Optional
	values: [...null | string] @go(Values,[]*string)
}

#ParameterInitParameters: {
	// Parameter name.
	key?: null | string @go(Key,*string)

	// Parameter value.
	value?: null | string @go(Value,*string)
}

#ParameterObservation: {
	// Parameter name.
	key?: null | string @go(Key,*string)

	// Parameter value.
	value?: null | string @go(Value,*string)
}

#ParameterParameters: {
	// Parameter name.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Parameter value.
	// +kubebuilder:validation:Optional
	value?: null | string @go(Value,*string)
}

#ResourceTagInitParameters: {
	// Tag key.
	key?: null | string @go(Key,*string)

	// Tag value.
	value?: null | string @go(Value,*string)
}

#ResourceTagObservation: {
	// Tag key.
	key?: null | string @go(Key,*string)

	// Tag value.
	value?: null | string @go(Value,*string)
}

#ResourceTagParameters: {
	// Tag key.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Tag value.
	// +kubebuilder:validation:Optional
	value?: null | string @go(Value,*string)
}

#StopConditionInitParameters: {
	// Source of the condition. One of none, aws:cloudwatch:alarm.
	source?: null | string @go(Source,*string)

	// ARN of the CloudWatch alarm. Required if the source is a CloudWatch alarm.
	value?: null | string @go(Value,*string)
}

#StopConditionObservation: {
	// Source of the condition. One of none, aws:cloudwatch:alarm.
	source?: null | string @go(Source,*string)

	// ARN of the CloudWatch alarm. Required if the source is a CloudWatch alarm.
	value?: null | string @go(Value,*string)
}

#StopConditionParameters: {
	// Source of the condition. One of none, aws:cloudwatch:alarm.
	// +kubebuilder:validation:Optional
	source?: null | string @go(Source,*string)

	// ARN of the CloudWatch alarm. Required if the source is a CloudWatch alarm.
	// +kubebuilder:validation:Optional
	value?: null | string @go(Value,*string)
}

#TargetInitParameters: {
	// Tag key.
	key?: null | string @go(Key,*string)

	// Target name, referencing a corresponding target.
	value?: null | string @go(Value,*string)
}

#TargetObservation: {
	// Tag key.
	key?: null | string @go(Key,*string)

	// Target name, referencing a corresponding target.
	value?: null | string @go(Value,*string)
}

#TargetParameters: {
	// Tag key.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Target name, referencing a corresponding target.
	// +kubebuilder:validation:Optional
	value?: null | string @go(Value,*string)
}

// ExperimentTemplateSpec defines the desired state of ExperimentTemplate
#ExperimentTemplateSpec: {
	v1.#ResourceSpec
	forProvider: #ExperimentTemplateParameters @go(ForProvider)

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
	initProvider?: #ExperimentTemplateInitParameters @go(InitProvider)
}

// ExperimentTemplateStatus defines the observed state of ExperimentTemplate.
#ExperimentTemplateStatus: {
	v1.#ResourceStatus
	atProvider?: #ExperimentTemplateObservation @go(AtProvider)
}

// ExperimentTemplate is the Schema for the ExperimentTemplates API. Provides an FIS Experiment Template.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ExperimentTemplate: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.action) || (has(self.initProvider) && has(self.initProvider.action))",message="spec.forProvider.action is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.description) || (has(self.initProvider) && has(self.initProvider.description))",message="spec.forProvider.description is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.stopCondition) || (has(self.initProvider) && has(self.initProvider.stopCondition))",message="spec.forProvider.stopCondition is a required parameter"
	spec:    #ExperimentTemplateSpec   @go(Spec)
	status?: #ExperimentTemplateStatus @go(Status)
}

// ExperimentTemplateList contains a list of ExperimentTemplates
#ExperimentTemplateList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ExperimentTemplate] @go(Items,[]ExperimentTemplate)
}
