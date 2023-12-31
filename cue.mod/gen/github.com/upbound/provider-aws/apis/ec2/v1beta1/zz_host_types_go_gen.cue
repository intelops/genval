// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#HostInitParameters: {
	// Indicates whether the host accepts any untargeted instance launches that match its instance type configuration, or if it only accepts Host tenancy instance launches that specify its unique host ID. Valid values: on, off. Default: on.
	autoPlacement?: null | string @go(AutoPlacement,*string)

	// The Availability Zone in which to allocate the Dedicated Host.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Indicates whether to enable or disable host recovery for the Dedicated Host. Valid values: on, off. Default: off.
	hostRecovery?: null | string @go(HostRecovery,*string)

	// Specifies the instance family to be supported by the Dedicated Hosts. If you specify an instance family, the Dedicated Hosts support multiple instance types within that instance family. Exactly one of instance_family or instance_type must be specified.
	instanceFamily?: null | string @go(InstanceFamily,*string)

	// Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only. Exactly one of instance_family or instance_type must be specified.
	instanceType?: null | string @go(InstanceType,*string)

	// The Amazon Resource Name (ARN) of the AWS Outpost on which to allocate the Dedicated Host.
	outpostArn?: null | string @go(OutpostArn,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#HostObservation: {
	// The ARN of the Dedicated Host.
	arn?: null | string @go(Arn,*string)

	// Indicates whether the host accepts any untargeted instance launches that match its instance type configuration, or if it only accepts Host tenancy instance launches that specify its unique host ID. Valid values: on, off. Default: on.
	autoPlacement?: null | string @go(AutoPlacement,*string)

	// The Availability Zone in which to allocate the Dedicated Host.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Indicates whether to enable or disable host recovery for the Dedicated Host. Valid values: on, off. Default: off.
	hostRecovery?: null | string @go(HostRecovery,*string)

	// The ID of the allocated Dedicated Host. This is used to launch an instance onto a specific host.
	id?: null | string @go(ID,*string)

	// Specifies the instance family to be supported by the Dedicated Hosts. If you specify an instance family, the Dedicated Hosts support multiple instance types within that instance family. Exactly one of instance_family or instance_type must be specified.
	instanceFamily?: null | string @go(InstanceFamily,*string)

	// Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only. Exactly one of instance_family or instance_type must be specified.
	instanceType?: null | string @go(InstanceType,*string)

	// The Amazon Resource Name (ARN) of the AWS Outpost on which to allocate the Dedicated Host.
	outpostArn?: null | string @go(OutpostArn,*string)

	// The ID of the AWS account that owns the Dedicated Host.
	ownerId?: null | string @go(OwnerID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#HostParameters: {
	// Indicates whether the host accepts any untargeted instance launches that match its instance type configuration, or if it only accepts Host tenancy instance launches that specify its unique host ID. Valid values: on, off. Default: on.
	// +kubebuilder:validation:Optional
	autoPlacement?: null | string @go(AutoPlacement,*string)

	// The Availability Zone in which to allocate the Dedicated Host.
	// +kubebuilder:validation:Optional
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Indicates whether to enable or disable host recovery for the Dedicated Host. Valid values: on, off. Default: off.
	// +kubebuilder:validation:Optional
	hostRecovery?: null | string @go(HostRecovery,*string)

	// Specifies the instance family to be supported by the Dedicated Hosts. If you specify an instance family, the Dedicated Hosts support multiple instance types within that instance family. Exactly one of instance_family or instance_type must be specified.
	// +kubebuilder:validation:Optional
	instanceFamily?: null | string @go(InstanceFamily,*string)

	// Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only. Exactly one of instance_family or instance_type must be specified.
	// +kubebuilder:validation:Optional
	instanceType?: null | string @go(InstanceType,*string)

	// The Amazon Resource Name (ARN) of the AWS Outpost on which to allocate the Dedicated Host.
	// +kubebuilder:validation:Optional
	outpostArn?: null | string @go(OutpostArn,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// HostSpec defines the desired state of Host
#HostSpec: {
	v1.#ResourceSpec
	forProvider: #HostParameters @go(ForProvider)

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
	initProvider?: #HostInitParameters @go(InitProvider)
}

// HostStatus defines the observed state of Host.
#HostStatus: {
	v1.#ResourceStatus
	atProvider?: #HostObservation @go(AtProvider)
}

// Host is the Schema for the Hosts API. Provides an EC2 Host resource. This allows Dedicated Hosts to be allocated, modified, and released.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Host: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.availabilityZone) || (has(self.initProvider) && has(self.initProvider.availabilityZone))",message="spec.forProvider.availabilityZone is a required parameter"
	spec:    #HostSpec   @go(Spec)
	status?: #HostStatus @go(Status)
}

// HostList contains a list of Hosts
#HostList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Host] @go(Items,[]Host)
}
