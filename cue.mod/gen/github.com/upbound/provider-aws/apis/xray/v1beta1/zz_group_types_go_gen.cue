// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/xray/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#GroupInitParameters: {
	// The filter expression defining criteria by which to group traces. more info can be found in official docs.
	filterExpression?: null | string @go(FilterExpression,*string)

	// The name of the group.
	groupName?: null | string @go(GroupName,*string)

	// Configuration options for enabling insights.
	insightsConfiguration?: [...#InsightsConfigurationInitParameters] @go(InsightsConfiguration,[]InsightsConfigurationInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#GroupObservation: {
	// The ARN of the Group.
	arn?: null | string @go(Arn,*string)

	// The filter expression defining criteria by which to group traces. more info can be found in official docs.
	filterExpression?: null | string @go(FilterExpression,*string)

	// The name of the group.
	groupName?: null | string @go(GroupName,*string)

	// The ARN of the Group.
	id?: null | string @go(ID,*string)

	// Configuration options for enabling insights.
	insightsConfiguration?: [...#InsightsConfigurationObservation] @go(InsightsConfiguration,[]InsightsConfigurationObservation)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#GroupParameters: {
	// The filter expression defining criteria by which to group traces. more info can be found in official docs.
	// +kubebuilder:validation:Optional
	filterExpression?: null | string @go(FilterExpression,*string)

	// The name of the group.
	// +kubebuilder:validation:Optional
	groupName?: null | string @go(GroupName,*string)

	// Configuration options for enabling insights.
	// +kubebuilder:validation:Optional
	insightsConfiguration?: [...#InsightsConfigurationParameters] @go(InsightsConfiguration,[]InsightsConfigurationParameters)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#InsightsConfigurationInitParameters: {
	// Specifies whether insights are enabled.
	insightsEnabled?: null | bool @go(InsightsEnabled,*bool)

	// Specifies whether insight notifications are enabled.
	notificationsEnabled?: null | bool @go(NotificationsEnabled,*bool)
}

#InsightsConfigurationObservation: {
	// Specifies whether insights are enabled.
	insightsEnabled?: null | bool @go(InsightsEnabled,*bool)

	// Specifies whether insight notifications are enabled.
	notificationsEnabled?: null | bool @go(NotificationsEnabled,*bool)
}

#InsightsConfigurationParameters: {
	// Specifies whether insights are enabled.
	// +kubebuilder:validation:Optional
	insightsEnabled?: null | bool @go(InsightsEnabled,*bool)

	// Specifies whether insight notifications are enabled.
	// +kubebuilder:validation:Optional
	notificationsEnabled?: null | bool @go(NotificationsEnabled,*bool)
}

// GroupSpec defines the desired state of Group
#GroupSpec: {
	v1.#ResourceSpec
	forProvider: #GroupParameters @go(ForProvider)

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
	initProvider?: #GroupInitParameters @go(InitProvider)
}

// GroupStatus defines the observed state of Group.
#GroupStatus: {
	v1.#ResourceStatus
	atProvider?: #GroupObservation @go(AtProvider)
}

// Group is the Schema for the Groups API. Creates and manages an AWS XRay Group.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Group: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.filterExpression) || (has(self.initProvider) && has(self.initProvider.filterExpression))",message="spec.forProvider.filterExpression is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.groupName) || (has(self.initProvider) && has(self.initProvider.groupName))",message="spec.forProvider.groupName is a required parameter"
	spec:    #GroupSpec   @go(Spec)
	status?: #GroupStatus @go(Status)
}

// GroupList contains a list of Groups
#GroupList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Group] @go(Items,[]Group)
}
