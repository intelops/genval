// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sqs/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#QueueInitParameters: {
	// Enables content-based deduplication for FIFO queues. For more information, see the related documentation
	contentBasedDeduplication?: null | bool @go(ContentBasedDeduplication,*bool)

	// Specifies whether message deduplication occurs at the message group or queue level. Valid values are messageGroup and queue (default).
	deduplicationScope?: null | string @go(DeduplicationScope,*string)

	// The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds.
	delaySeconds?: null | float64 @go(DelaySeconds,*float64)

	// Boolean designating a FIFO queue. If not set, it defaults to false making it standard.
	fifoQueue?: null | bool @go(FifoQueue,*bool)

	// Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are perQueue (default) and perMessageGroupId.
	fifoThroughputLimit?: null | string @go(FifoThroughputLimit,*string)

	// The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes).
	kmsDataKeyReusePeriodSeconds?: null | float64 @go(KMSDataKeyReusePeriodSeconds,*float64)

	// The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. For more information, see Key Terms.
	kmsMasterKeyId?: null | string @go(KMSMasterKeyID,*string)

	// The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB).
	maxMessageSize?: null | float64 @go(MaxMessageSize,*float64)

	// The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days).
	messageRetentionSeconds?: null | float64 @go(MessageRetentionSeconds,*float64)

	// The name of the queue. Queue names must be made up of only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 80 characters long. For a FIFO (first-in-first-out) queue, the name must end with the .fifo suffix. Conflicts with name_prefix
	name?: null | string @go(Name,*string)

	// The JSON policy for the SQS queue.
	policy?: null | string @go(Policy,*string)

	// The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately.
	receiveWaitTimeSeconds?: null | float64 @go(ReceiveWaitTimeSeconds,*float64)

	// The JSON policy to set up the Dead Letter Queue redrive permission, see AWS docs.
	redriveAllowPolicy?: null | string @go(RedriveAllowPolicy,*string)

	// The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ("5").
	redrivePolicy?: null | string @go(RedrivePolicy,*string)

	// Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys. See Encryption at rest.
	sqsManagedSseEnabled?: null | bool @go(SqsManagedSseEnabled,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see AWS docs.
	visibilityTimeoutSeconds?: null | float64 @go(VisibilityTimeoutSeconds,*float64)
}

#QueueObservation: {
	// The ARN of the SQS queue
	arn?: null | string @go(Arn,*string)

	// Enables content-based deduplication for FIFO queues. For more information, see the related documentation
	contentBasedDeduplication?: null | bool @go(ContentBasedDeduplication,*bool)

	// Specifies whether message deduplication occurs at the message group or queue level. Valid values are messageGroup and queue (default).
	deduplicationScope?: null | string @go(DeduplicationScope,*string)

	// The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds.
	delaySeconds?: null | float64 @go(DelaySeconds,*float64)

	// Boolean designating a FIFO queue. If not set, it defaults to false making it standard.
	fifoQueue?: null | bool @go(FifoQueue,*bool)

	// Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are perQueue (default) and perMessageGroupId.
	fifoThroughputLimit?: null | string @go(FifoThroughputLimit,*string)

	// The URL for the created Amazon SQS queue.
	id?: null | string @go(ID,*string)

	// The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes).
	kmsDataKeyReusePeriodSeconds?: null | float64 @go(KMSDataKeyReusePeriodSeconds,*float64)

	// The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. For more information, see Key Terms.
	kmsMasterKeyId?: null | string @go(KMSMasterKeyID,*string)

	// The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB).
	maxMessageSize?: null | float64 @go(MaxMessageSize,*float64)

	// The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days).
	messageRetentionSeconds?: null | float64 @go(MessageRetentionSeconds,*float64)

	// The name of the queue. Queue names must be made up of only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 80 characters long. For a FIFO (first-in-first-out) queue, the name must end with the .fifo suffix. Conflicts with name_prefix
	name?: null | string @go(Name,*string)

	// The JSON policy for the SQS queue.
	policy?: null | string @go(Policy,*string)

	// The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately.
	receiveWaitTimeSeconds?: null | float64 @go(ReceiveWaitTimeSeconds,*float64)

	// The JSON policy to set up the Dead Letter Queue redrive permission, see AWS docs.
	redriveAllowPolicy?: null | string @go(RedriveAllowPolicy,*string)

	// The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ("5").
	redrivePolicy?: null | string @go(RedrivePolicy,*string)

	// Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys. See Encryption at rest.
	sqsManagedSseEnabled?: null | bool @go(SqsManagedSseEnabled,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Same as id: The URL for the created Amazon SQS queue.
	url?: null | string @go(URL,*string)

	// The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see AWS docs.
	visibilityTimeoutSeconds?: null | float64 @go(VisibilityTimeoutSeconds,*float64)
}

#QueueParameters: {
	// Enables content-based deduplication for FIFO queues. For more information, see the related documentation
	// +kubebuilder:validation:Optional
	contentBasedDeduplication?: null | bool @go(ContentBasedDeduplication,*bool)

	// Specifies whether message deduplication occurs at the message group or queue level. Valid values are messageGroup and queue (default).
	// +kubebuilder:validation:Optional
	deduplicationScope?: null | string @go(DeduplicationScope,*string)

	// The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds.
	// +kubebuilder:validation:Optional
	delaySeconds?: null | float64 @go(DelaySeconds,*float64)

	// Boolean designating a FIFO queue. If not set, it defaults to false making it standard.
	// +kubebuilder:validation:Optional
	fifoQueue?: null | bool @go(FifoQueue,*bool)

	// Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are perQueue (default) and perMessageGroupId.
	// +kubebuilder:validation:Optional
	fifoThroughputLimit?: null | string @go(FifoThroughputLimit,*string)

	// The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes).
	// +kubebuilder:validation:Optional
	kmsDataKeyReusePeriodSeconds?: null | float64 @go(KMSDataKeyReusePeriodSeconds,*float64)

	// The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. For more information, see Key Terms.
	// +kubebuilder:validation:Optional
	kmsMasterKeyId?: null | string @go(KMSMasterKeyID,*string)

	// The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB).
	// +kubebuilder:validation:Optional
	maxMessageSize?: null | float64 @go(MaxMessageSize,*float64)

	// The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days).
	// +kubebuilder:validation:Optional
	messageRetentionSeconds?: null | float64 @go(MessageRetentionSeconds,*float64)

	// The name of the queue. Queue names must be made up of only uppercase and lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 80 characters long. For a FIFO (first-in-first-out) queue, the name must end with the .fifo suffix. Conflicts with name_prefix
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// The JSON policy for the SQS queue.
	// +kubebuilder:validation:Optional
	policy?: null | string @go(Policy,*string)

	// The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately.
	// +kubebuilder:validation:Optional
	receiveWaitTimeSeconds?: null | float64 @go(ReceiveWaitTimeSeconds,*float64)

	// The JSON policy to set up the Dead Letter Queue redrive permission, see AWS docs.
	// +kubebuilder:validation:Optional
	redriveAllowPolicy?: null | string @go(RedriveAllowPolicy,*string)

	// The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ("5").
	// +kubebuilder:validation:Optional
	redrivePolicy?: null | string @go(RedrivePolicy,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys. See Encryption at rest.
	// +kubebuilder:validation:Optional
	sqsManagedSseEnabled?: null | bool @go(SqsManagedSseEnabled,*bool)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see AWS docs.
	// +kubebuilder:validation:Optional
	visibilityTimeoutSeconds?: null | float64 @go(VisibilityTimeoutSeconds,*float64)
}

// QueueSpec defines the desired state of Queue
#QueueSpec: {
	v1.#ResourceSpec
	forProvider: #QueueParameters @go(ForProvider)

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
	initProvider?: #QueueInitParameters @go(InitProvider)
}

// QueueStatus defines the observed state of Queue.
#QueueStatus: {
	v1.#ResourceStatus
	atProvider?: #QueueObservation @go(AtProvider)
}

// Queue is the Schema for the Queues API. Provides a SQS resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Queue: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #QueueSpec         @go(Spec)
	status?:   #QueueStatus       @go(Status)
}

// QueueList contains a list of Queues
#QueueList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Queue] @go(Items,[]Queue)
}
