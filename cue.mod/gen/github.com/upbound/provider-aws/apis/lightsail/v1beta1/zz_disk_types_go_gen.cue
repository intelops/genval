// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/lightsail/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DiskInitParameters: {
	// The Availability Zone in which to create your disk.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// The instance port the load balancer will connect.
	sizeInGb?: null | float64 @go(SizeInGb,*float64)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#DiskObservation: {
	// The ARN of the Lightsail load balancer.
	arn?: null | string @go(Arn,*string)

	// The Availability Zone in which to create your disk.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// The timestamp when the load balancer was created.
	createdAt?: null | string @go(CreatedAt,*string)

	// The name of the disk  (matches name).
	id?: null | string @go(ID,*string)

	// The instance port the load balancer will connect.
	sizeInGb?: null | float64 @go(SizeInGb,*float64)

	// The support code for the disk. Include this code in your email to support when you have questions about a disk in Lightsail. This code enables our support team to look up your Lightsail information more easily.
	supportCode?: null | string @go(SupportCode,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#DiskParameters: {
	// The Availability Zone in which to create your disk.
	// +kubebuilder:validation:Optional
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The instance port the load balancer will connect.
	// +kubebuilder:validation:Optional
	sizeInGb?: null | float64 @go(SizeInGb,*float64)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// DiskSpec defines the desired state of Disk
#DiskSpec: {
	v1.#ResourceSpec
	forProvider: #DiskParameters @go(ForProvider)

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
	initProvider?: #DiskInitParameters @go(InitProvider)
}

// DiskStatus defines the observed state of Disk.
#DiskStatus: {
	v1.#ResourceStatus
	atProvider?: #DiskObservation @go(AtProvider)
}

// Disk is the Schema for the Disks API. Provides a Lightsail Disk resource
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Disk: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.availabilityZone) || (has(self.initProvider) && has(self.initProvider.availabilityZone))",message="spec.forProvider.availabilityZone is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.sizeInGb) || (has(self.initProvider) && has(self.initProvider.sizeInGb))",message="spec.forProvider.sizeInGb is a required parameter"
	spec:    #DiskSpec   @go(Spec)
	status?: #DiskStatus @go(Status)
}

// DiskList contains a list of Disks
#DiskList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Disk] @go(Items,[]Disk)
}
