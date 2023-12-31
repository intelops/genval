// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/cloudwatchevents/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#RuleInitParameters: {
	// The description of the rule.
	description?: null | string @go(Description,*string)

	// The event pattern described a JSON object. At least one of schedule_expression or event_pattern is required. See full documentation of Events and Event Patterns in EventBridge for details.
	eventPattern?: null | string @go(EventPattern,*string)

	// Whether the rule should be enabled (defaults to true).
	isEnabled?: null | bool @go(IsEnabled,*bool)

	// The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus. For more information, refer to the AWS documentation Schedule Expressions for Rules.
	scheduleExpression?: null | string @go(ScheduleExpression,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RuleObservation: {
	// The Amazon Resource Name (ARN) of the rule.
	arn?: null | string @go(Arn,*string)

	// The description of the rule.
	description?: null | string @go(Description,*string)

	// The name or ARN of the event bus to associate with this rule.
	// If you omit this, the default event bus is used.
	eventBusName?: null | string @go(EventBusName,*string)

	// The event pattern described a JSON object. At least one of schedule_expression or event_pattern is required. See full documentation of Events and Event Patterns in EventBridge for details.
	eventPattern?: null | string @go(EventPattern,*string)

	// The name of the rule.
	id?: null | string @go(ID,*string)

	// Whether the rule should be enabled (defaults to true).
	isEnabled?: null | bool @go(IsEnabled,*bool)

	// The Amazon Resource Name (ARN) associated with the role that is used for target invocation.
	roleArn?: null | string @go(RoleArn,*string)

	// The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus. For more information, refer to the AWS documentation Schedule Expressions for Rules.
	scheduleExpression?: null | string @go(ScheduleExpression,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#RuleParameters: {
	// The description of the rule.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// The name or ARN of the event bus to associate with this rule.
	// If you omit this, the default event bus is used.
	// +crossplane:generate:reference:type=Bus
	// +kubebuilder:validation:Optional
	eventBusName?: null | string @go(EventBusName,*string)

	// Reference to a Bus to populate eventBusName.
	// +kubebuilder:validation:Optional
	eventBusNameRef?: null | v1.#Reference @go(EventBusNameRef,*v1.Reference)

	// Selector for a Bus to populate eventBusName.
	// +kubebuilder:validation:Optional
	eventBusNameSelector?: null | v1.#Selector @go(EventBusNameSelector,*v1.Selector)

	// The event pattern described a JSON object. At least one of schedule_expression or event_pattern is required. See full documentation of Events and Event Patterns in EventBridge for details.
	// +kubebuilder:validation:Optional
	eventPattern?: null | string @go(EventPattern,*string)

	// Whether the rule should be enabled (defaults to true).
	// +kubebuilder:validation:Optional
	isEnabled?: null | bool @go(IsEnabled,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The Amazon Resource Name (ARN) associated with the role that is used for target invocation.
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

	// The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus. For more information, refer to the AWS documentation Schedule Expressions for Rules.
	// +kubebuilder:validation:Optional
	scheduleExpression?: null | string @go(ScheduleExpression,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// RuleSpec defines the desired state of Rule
#RuleSpec: {
	v1.#ResourceSpec
	forProvider: #RuleParameters @go(ForProvider)

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
	initProvider?: #RuleInitParameters @go(InitProvider)
}

// RuleStatus defines the observed state of Rule.
#RuleStatus: {
	v1.#ResourceStatus
	atProvider?: #RuleObservation @go(AtProvider)
}

// Rule is the Schema for the Rules API. Provides an EventBridge Rule resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Rule: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #RuleSpec          @go(Spec)
	status?:   #RuleStatus        @go(Status)
}

// RuleList contains a list of Rules
#RuleList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Rule] @go(Items,[]Rule)
}
