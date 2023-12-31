// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/connect/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#MediaConcurrenciesInitParameters: {
	// Specifies the channels that agents can handle in the Contact Control Panel (CCP). Valid values are VOICE, CHAT, TASK.
	channel?: null | string @go(Channel,*string)

	// Specifies the number of contacts an agent can have on a channel simultaneously. Valid Range for VOICE: Minimum value of 1. Maximum value of 1. Valid Range for CHAT: Minimum value of 1. Maximum value of 10. Valid Range for TASK: Minimum value of 1. Maximum value of 10.
	concurrency?: null | float64 @go(Concurrency,*float64)
}

#MediaConcurrenciesObservation: {
	// Specifies the channels that agents can handle in the Contact Control Panel (CCP). Valid values are VOICE, CHAT, TASK.
	channel?: null | string @go(Channel,*string)

	// Specifies the number of contacts an agent can have on a channel simultaneously. Valid Range for VOICE: Minimum value of 1. Maximum value of 1. Valid Range for CHAT: Minimum value of 1. Maximum value of 10. Valid Range for TASK: Minimum value of 1. Maximum value of 10.
	concurrency?: null | float64 @go(Concurrency,*float64)
}

#MediaConcurrenciesParameters: {
	// Specifies the channels that agents can handle in the Contact Control Panel (CCP). Valid values are VOICE, CHAT, TASK.
	// +kubebuilder:validation:Optional
	channel?: null | string @go(Channel,*string)

	// Specifies the number of contacts an agent can have on a channel simultaneously. Valid Range for VOICE: Minimum value of 1. Maximum value of 1. Valid Range for CHAT: Minimum value of 1. Maximum value of 10. Valid Range for TASK: Minimum value of 1. Maximum value of 10.
	// +kubebuilder:validation:Optional
	concurrency?: null | float64 @go(Concurrency,*float64)
}

#QueueConfigsAssociatedInitParameters: {
}

#QueueConfigsAssociatedObservation: {
	// Specifies the channels agents can handle in the Contact Control Panel (CCP) for this routing profile. Valid values are VOICE, CHAT, TASK.
	channel?: null | string @go(Channel,*string)

	// Specifies the delay, in seconds, that a contact should be in the queue before they are routed to an available agent
	delay?: null | float64 @go(Delay,*float64)

	// Specifies the order in which contacts are to be handled for the queue.
	priority?: null | float64 @go(Priority,*float64)

	// ARN for the queue.
	queueArn?: null | string @go(QueueArn,*string)

	// Specifies the identifier for the queue.
	queueId?: null | string @go(QueueID,*string)

	// Name for the queue.
	queueName?: null | string @go(QueueName,*string)
}

#QueueConfigsAssociatedParameters: {
}

#QueueConfigsInitParameters: {
	// Specifies the channels agents can handle in the Contact Control Panel (CCP) for this routing profile. Valid values are VOICE, CHAT, TASK.
	channel?: null | string @go(Channel,*string)

	// Specifies the delay, in seconds, that a contact should be in the queue before they are routed to an available agent
	delay?: null | float64 @go(Delay,*float64)

	// Specifies the order in which contacts are to be handled for the queue.
	priority?: null | float64 @go(Priority,*float64)

	// Specifies the identifier for the queue.
	queueId?: null | string @go(QueueID,*string)
}

#QueueConfigsObservation: {
	// Specifies the channels agents can handle in the Contact Control Panel (CCP) for this routing profile. Valid values are VOICE, CHAT, TASK.
	channel?: null | string @go(Channel,*string)

	// Specifies the delay, in seconds, that a contact should be in the queue before they are routed to an available agent
	delay?: null | float64 @go(Delay,*float64)

	// Specifies the order in which contacts are to be handled for the queue.
	priority?: null | float64 @go(Priority,*float64)

	// ARN for the queue.
	queueArn?: null | string @go(QueueArn,*string)

	// Specifies the identifier for the queue.
	queueId?: null | string @go(QueueID,*string)

	// Name for the queue.
	queueName?: null | string @go(QueueName,*string)
}

#QueueConfigsParameters: {
	// Specifies the channels agents can handle in the Contact Control Panel (CCP) for this routing profile. Valid values are VOICE, CHAT, TASK.
	// +kubebuilder:validation:Optional
	channel?: null | string @go(Channel,*string)

	// Specifies the delay, in seconds, that a contact should be in the queue before they are routed to an available agent
	// +kubebuilder:validation:Optional
	delay?: null | float64 @go(Delay,*float64)

	// Specifies the order in which contacts are to be handled for the queue.
	// +kubebuilder:validation:Optional
	priority?: null | float64 @go(Priority,*float64)

	// Specifies the identifier for the queue.
	// +kubebuilder:validation:Optional
	queueId?: null | string @go(QueueID,*string)
}

#RoutingProfileInitParameters: {
	// Specifies the description of the Routing Profile.
	description?: null | string @go(Description,*string)

	// One or more media_concurrencies blocks that specify the channels that agents can handle in the Contact Control Panel (CCP) for this Routing Profile. The media_concurrencies block is documented below.
	mediaConcurrencies?: [...#MediaConcurrenciesInitParameters] @go(MediaConcurrencies,[]MediaConcurrenciesInitParameters)

	// Specifies the name of the Routing Profile.
	name?: null | string @go(Name,*string)

	// One or more queue_configs blocks that specify the inbound queues associated with the routing profile. If no queue is added, the agent only can make outbound calls. The queue_configs block is documented below.
	queueConfigs?: [...#QueueConfigsInitParameters] @go(QueueConfigs,[]QueueConfigsInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RoutingProfileObservation: {
	// The Amazon Resource Name (ARN) of the Routing Profile.
	arn?: null | string @go(Arn,*string)

	// Specifies the default outbound queue for the Routing Profile.
	defaultOutboundQueueId?: null | string @go(DefaultOutboundQueueID,*string)

	// Specifies the description of the Routing Profile.
	description?: null | string @go(Description,*string)

	// The identifier of the hosting Amazon Connect Instance and identifier of the Routing Profile separated by a colon (:).
	id?: null | string @go(ID,*string)

	// Specifies the identifier of the hosting Amazon Connect Instance.
	instanceId?: null | string @go(InstanceID,*string)

	// One or more media_concurrencies blocks that specify the channels that agents can handle in the Contact Control Panel (CCP) for this Routing Profile. The media_concurrencies block is documented below.
	mediaConcurrencies?: [...#MediaConcurrenciesObservation] @go(MediaConcurrencies,[]MediaConcurrenciesObservation)

	// Specifies the name of the Routing Profile.
	name?: null | string @go(Name,*string)

	// One or more queue_configs blocks that specify the inbound queues associated with the routing profile. If no queue is added, the agent only can make outbound calls. The queue_configs block is documented below.
	queueConfigs?: [...#QueueConfigsObservation] @go(QueueConfigs,[]QueueConfigsObservation)
	queueConfigsAssociated?: [...#QueueConfigsAssociatedObservation] @go(QueueConfigsAssociated,[]QueueConfigsAssociatedObservation)

	// The identifier for the Routing Profile.
	routingProfileId?: null | string @go(RoutingProfileID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#RoutingProfileParameters: {
	// Specifies the default outbound queue for the Routing Profile.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/connect/v1beta1.Queue
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("queue_id",true)
	// +kubebuilder:validation:Optional
	defaultOutboundQueueId?: null | string @go(DefaultOutboundQueueID,*string)

	// Reference to a Queue in connect to populate defaultOutboundQueueId.
	// +kubebuilder:validation:Optional
	defaultOutboundQueueIdRef?: null | v1.#Reference @go(DefaultOutboundQueueIDRef,*v1.Reference)

	// Selector for a Queue in connect to populate defaultOutboundQueueId.
	// +kubebuilder:validation:Optional
	defaultOutboundQueueIdSelector?: null | v1.#Selector @go(DefaultOutboundQueueIDSelector,*v1.Selector)

	// Specifies the description of the Routing Profile.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Specifies the identifier of the hosting Amazon Connect Instance.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/connect/v1beta1.Instance
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	instanceId?: null | string @go(InstanceID,*string)

	// Reference to a Instance in connect to populate instanceId.
	// +kubebuilder:validation:Optional
	instanceIdRef?: null | v1.#Reference @go(InstanceIDRef,*v1.Reference)

	// Selector for a Instance in connect to populate instanceId.
	// +kubebuilder:validation:Optional
	instanceIdSelector?: null | v1.#Selector @go(InstanceIDSelector,*v1.Selector)

	// One or more media_concurrencies blocks that specify the channels that agents can handle in the Contact Control Panel (CCP) for this Routing Profile. The media_concurrencies block is documented below.
	// +kubebuilder:validation:Optional
	mediaConcurrencies?: [...#MediaConcurrenciesParameters] @go(MediaConcurrencies,[]MediaConcurrenciesParameters)

	// Specifies the name of the Routing Profile.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// One or more queue_configs blocks that specify the inbound queues associated with the routing profile. If no queue is added, the agent only can make outbound calls. The queue_configs block is documented below.
	// +kubebuilder:validation:Optional
	queueConfigs?: [...#QueueConfigsParameters] @go(QueueConfigs,[]QueueConfigsParameters)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// RoutingProfileSpec defines the desired state of RoutingProfile
#RoutingProfileSpec: {
	v1.#ResourceSpec
	forProvider: #RoutingProfileParameters @go(ForProvider)

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
	initProvider?: #RoutingProfileInitParameters @go(InitProvider)
}

// RoutingProfileStatus defines the observed state of RoutingProfile.
#RoutingProfileStatus: {
	v1.#ResourceStatus
	atProvider?: #RoutingProfileObservation @go(AtProvider)
}

// RoutingProfile is the Schema for the RoutingProfiles API. Provides details about a specific Amazon Connect Routing Profile.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#RoutingProfile: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.description) || (has(self.initProvider) && has(self.initProvider.description))",message="spec.forProvider.description is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.mediaConcurrencies) || (has(self.initProvider) && has(self.initProvider.mediaConcurrencies))",message="spec.forProvider.mediaConcurrencies is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #RoutingProfileSpec   @go(Spec)
	status?: #RoutingProfileStatus @go(Status)
}

// RoutingProfileList contains a list of RoutingProfiles
#RoutingProfileList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#RoutingProfile] @go(Items,[]RoutingProfile)
}
