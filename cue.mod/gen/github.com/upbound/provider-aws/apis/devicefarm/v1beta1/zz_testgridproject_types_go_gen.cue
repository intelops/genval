// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/devicefarm/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#TestGridProjectInitParameters: {
	// Human-readable description of the project.
	description?: null | string @go(Description,*string)

	// The name of the Selenium testing project.
	name?: null | string @go(Name,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The VPC security groups and subnets that are attached to a project. See VPC Config below.
	vpcConfig?: [...#VPCConfigInitParameters] @go(VPCConfig,[]VPCConfigInitParameters)
}

#TestGridProjectObservation: {
	// The Amazon Resource Name of this Test Grid Project.
	arn?: null | string @go(Arn,*string)

	// Human-readable description of the project.
	description?: null | string @go(Description,*string)
	id?:          null | string @go(ID,*string)

	// The name of the Selenium testing project.
	name?: null | string @go(Name,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The VPC security groups and subnets that are attached to a project. See VPC Config below.
	vpcConfig?: [...#VPCConfigObservation] @go(VPCConfig,[]VPCConfigObservation)
}

#TestGridProjectParameters: {
	// Human-readable description of the project.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// The name of the Selenium testing project.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The VPC security groups and subnets that are attached to a project. See VPC Config below.
	// +kubebuilder:validation:Optional
	vpcConfig?: [...#VPCConfigParameters] @go(VPCConfig,[]VPCConfigParameters)
}

#VPCConfigInitParameters: {
}

#VPCConfigObservation: {
	// A list of VPC security group IDs in your Amazon VPC.
	securityGroupIds?: [...null | string] @go(SecurityGroupIds,[]*string)

	// A list of VPC subnet IDs in your Amazon VPC.
	subnetIds?: [...null | string] @go(SubnetIds,[]*string)

	// The ID of the Amazon VPC.
	vpcId?: null | string @go(VPCID,*string)
}

#VPCConfigParameters: {
	// References to SecurityGroup in ec2 to populate securityGroupIds.
	// +kubebuilder:validation:Optional
	securityGroupIdRefs?: [...v1.#Reference] @go(SecurityGroupIDRefs,[]v1.Reference)

	// Selector for a list of SecurityGroup in ec2 to populate securityGroupIds.
	// +kubebuilder:validation:Optional
	securityGroupIdSelector?: null | v1.#Selector @go(SecurityGroupIDSelector,*v1.Selector)

	// A list of VPC security group IDs in your Amazon VPC.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.SecurityGroup
	// +crossplane:generate:reference:refFieldName=SecurityGroupIDRefs
	// +crossplane:generate:reference:selectorFieldName=SecurityGroupIDSelector
	// +kubebuilder:validation:Optional
	securityGroupIds?: [...null | string] @go(SecurityGroupIds,[]*string)

	// References to Subnet in ec2 to populate subnetIds.
	// +kubebuilder:validation:Optional
	subnetIdRefs?: [...v1.#Reference] @go(SubnetIDRefs,[]v1.Reference)

	// Selector for a list of Subnet in ec2 to populate subnetIds.
	// +kubebuilder:validation:Optional
	subnetIdSelector?: null | v1.#Selector @go(SubnetIDSelector,*v1.Selector)

	// A list of VPC subnet IDs in your Amazon VPC.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.Subnet
	// +crossplane:generate:reference:refFieldName=SubnetIDRefs
	// +crossplane:generate:reference:selectorFieldName=SubnetIDSelector
	// +kubebuilder:validation:Optional
	subnetIds?: [...null | string] @go(SubnetIds,[]*string)

	// The ID of the Amazon VPC.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPC
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	vpcId?: null | string @go(VPCID,*string)

	// Reference to a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdRef?: null | v1.#Reference @go(VPCIDRef,*v1.Reference)

	// Selector for a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdSelector?: null | v1.#Selector @go(VPCIDSelector,*v1.Selector)
}

// TestGridProjectSpec defines the desired state of TestGridProject
#TestGridProjectSpec: {
	v1.#ResourceSpec
	forProvider: #TestGridProjectParameters @go(ForProvider)

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
	initProvider?: #TestGridProjectInitParameters @go(InitProvider)
}

// TestGridProjectStatus defines the observed state of TestGridProject.
#TestGridProjectStatus: {
	v1.#ResourceStatus
	atProvider?: #TestGridProjectObservation @go(AtProvider)
}

// TestGridProject is the Schema for the TestGridProjects API. Provides a Devicefarm test_grid_project
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#TestGridProject: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #TestGridProjectSpec   @go(Spec)
	status?: #TestGridProjectStatus @go(Status)
}

// TestGridProjectList contains a list of TestGridProjects
#TestGridProjectList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#TestGridProject] @go(Items,[]TestGridProject)
}
