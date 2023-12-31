// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/iot/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AttributePayloadInitParameters: {
	// Key-value map.
	attributes?: {[string]: null | string} @go(Attributes,map[string]*string)
}

#AttributePayloadObservation: {
	// Key-value map.
	attributes?: {[string]: null | string} @go(Attributes,map[string]*string)
}

#AttributePayloadParameters: {
	// Key-value map.
	// +kubebuilder:validation:Optional
	attributes?: {[string]: null | string} @go(Attributes,map[string]*string)
}

#MetadataInitParameters: {
}

#MetadataObservation: {
	creationDate?: null | string @go(CreationDate,*string)

	// The name of the parent Thing Group.
	parentGroupName?: null | string @go(ParentGroupName,*string)
	rootToParentGroups?: [...#RootToParentGroupsObservation] @go(RootToParentGroups,[]RootToParentGroupsObservation)
}

#MetadataParameters: {
}

#PropertiesInitParameters: {
	// The Thing Group attributes. Defined below.
	attributePayload?: [...#AttributePayloadInitParameters] @go(AttributePayload,[]AttributePayloadInitParameters)

	// A description of the Thing Group.
	description?: null | string @go(Description,*string)
}

#PropertiesObservation: {
	// The Thing Group attributes. Defined below.
	attributePayload?: [...#AttributePayloadObservation] @go(AttributePayload,[]AttributePayloadObservation)

	// A description of the Thing Group.
	description?: null | string @go(Description,*string)
}

#PropertiesParameters: {
	// The Thing Group attributes. Defined below.
	// +kubebuilder:validation:Optional
	attributePayload?: [...#AttributePayloadParameters] @go(AttributePayload,[]AttributePayloadParameters)

	// A description of the Thing Group.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)
}

#RootToParentGroupsInitParameters: {
}

#RootToParentGroupsObservation: {
	// The ARN of the Thing Group.
	groupArn?: null | string @go(GroupArn,*string)

	// The name of the Thing Group.
	groupName?: null | string @go(GroupName,*string)
}

#RootToParentGroupsParameters: {
}

#ThingGroupInitParameters: {
	// The Thing Group properties. Defined below.
	properties?: [...#PropertiesInitParameters] @go(Properties,[]PropertiesInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#ThingGroupObservation: {
	// The ARN of the Thing Group.
	arn?: null | string @go(Arn,*string)

	// The Thing Group ID.
	id?: null | string @go(ID,*string)
	metadata?: [...#MetadataObservation] @go(Metadata,[]MetadataObservation)

	// The name of the parent Thing Group.
	parentGroupName?: null | string @go(ParentGroupName,*string)

	// The Thing Group properties. Defined below.
	properties?: [...#PropertiesObservation] @go(Properties,[]PropertiesObservation)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The current version of the Thing Group record in the registry.
	version?: null | float64 @go(Version,*float64)
}

#ThingGroupParameters: {
	// The name of the parent Thing Group.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iot/v1beta1.ThingGroup
	// +kubebuilder:validation:Optional
	parentGroupName?: null | string @go(ParentGroupName,*string)

	// Reference to a ThingGroup in iot to populate parentGroupName.
	// +kubebuilder:validation:Optional
	parentGroupNameRef?: null | v1.#Reference @go(ParentGroupNameRef,*v1.Reference)

	// Selector for a ThingGroup in iot to populate parentGroupName.
	// +kubebuilder:validation:Optional
	parentGroupNameSelector?: null | v1.#Selector @go(ParentGroupNameSelector,*v1.Selector)

	// The Thing Group properties. Defined below.
	// +kubebuilder:validation:Optional
	properties?: [...#PropertiesParameters] @go(Properties,[]PropertiesParameters)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// ThingGroupSpec defines the desired state of ThingGroup
#ThingGroupSpec: {
	v1.#ResourceSpec
	forProvider: #ThingGroupParameters @go(ForProvider)

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
	initProvider?: #ThingGroupInitParameters @go(InitProvider)
}

// ThingGroupStatus defines the observed state of ThingGroup.
#ThingGroupStatus: {
	v1.#ResourceStatus
	atProvider?: #ThingGroupObservation @go(AtProvider)
}

// ThingGroup is the Schema for the ThingGroups API. Manages an AWS IoT Thing Group.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ThingGroup: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #ThingGroupSpec    @go(Spec)
	status?:   #ThingGroupStatus  @go(Status)
}

// ThingGroupList contains a list of ThingGroups
#ThingGroupList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ThingGroup] @go(Items,[]ThingGroup)
}
