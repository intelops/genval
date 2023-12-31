// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/cloudwatchlogs/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DestinationInitParameters: {
	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#DestinationObservation: {
	// The Amazon Resource Name (ARN) specifying the log destination.
	arn?: null | string @go(Arn,*string)
	id?:  null | string @go(ID,*string)

	// The ARN of an IAM role that grants Amazon CloudWatch Logs permissions to put data into the target.
	roleArn?: null | string @go(RoleArn,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The ARN of the target Amazon Kinesis stream resource for the destination.
	targetArn?: null | string @go(TargetArn,*string)
}

#DestinationParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The ARN of an IAM role that grants Amazon CloudWatch Logs permissions to put data into the target.
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

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The ARN of the target Amazon Kinesis stream resource for the destination.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kinesis/v1beta1.Stream
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.TerraformID()
	// +kubebuilder:validation:Optional
	targetArn?: null | string @go(TargetArn,*string)

	// Reference to a Stream in kinesis to populate targetArn.
	// +kubebuilder:validation:Optional
	targetArnRef?: null | v1.#Reference @go(TargetArnRef,*v1.Reference)

	// Selector for a Stream in kinesis to populate targetArn.
	// +kubebuilder:validation:Optional
	targetArnSelector?: null | v1.#Selector @go(TargetArnSelector,*v1.Selector)
}

// DestinationSpec defines the desired state of Destination
#DestinationSpec: {
	v1.#ResourceSpec
	forProvider: #DestinationParameters @go(ForProvider)

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
	initProvider?: #DestinationInitParameters @go(InitProvider)
}

// DestinationStatus defines the observed state of Destination.
#DestinationStatus: {
	v1.#ResourceStatus
	atProvider?: #DestinationObservation @go(AtProvider)
}

// Destination is the Schema for the Destinations API. Provides a CloudWatch Logs destination.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Destination: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #DestinationSpec   @go(Spec)
	status?:   #DestinationStatus @go(Status)
}

// DestinationList contains a list of Destinations
#DestinationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Destination] @go(Items,[]Destination)
}
