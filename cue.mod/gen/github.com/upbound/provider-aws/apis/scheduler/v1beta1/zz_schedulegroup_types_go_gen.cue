// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/scheduler/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ScheduleGroupInitParameters: {
	// Name of the schedule group. Conflicts with name_prefix.
	name?: null | string @go(Name,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#ScheduleGroupObservation: {
	// ARN of the schedule group.
	arn?: null | string @go(Arn,*string)

	// Time at which the schedule group was created.
	creationDate?: null | string @go(CreationDate,*string)

	// Name of the schedule group.
	id?: null | string @go(ID,*string)

	// Time at which the schedule group was last modified.
	lastModificationDate?: null | string @go(LastModificationDate,*string)

	// Name of the schedule group. Conflicts with name_prefix.
	name?: null | string @go(Name,*string)

	// State of the schedule group. Can be ACTIVE or DELETING.
	state?: null | string @go(State,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#ScheduleGroupParameters: {
	// Name of the schedule group. Conflicts with name_prefix.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// ScheduleGroupSpec defines the desired state of ScheduleGroup
#ScheduleGroupSpec: {
	v1.#ResourceSpec
	forProvider: #ScheduleGroupParameters @go(ForProvider)

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
	initProvider?: #ScheduleGroupInitParameters @go(InitProvider)
}

// ScheduleGroupStatus defines the observed state of ScheduleGroup.
#ScheduleGroupStatus: {
	v1.#ResourceStatus
	atProvider?: #ScheduleGroupObservation @go(AtProvider)
}

// ScheduleGroup is the Schema for the ScheduleGroups API. Provides an EventBridge Scheduler Schedule Group resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ScheduleGroup: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta   @go(ObjectMeta)
	spec:      #ScheduleGroupSpec   @go(Spec)
	status?:   #ScheduleGroupStatus @go(Status)
}

// ScheduleGroupList contains a list of ScheduleGroups
#ScheduleGroupList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ScheduleGroup] @go(Items,[]ScheduleGroup)
}
