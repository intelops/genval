// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/networkfirewall/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AttachmentInitParameters: {
}

#AttachmentObservation: {
	// The identifier of the firewall endpoint that AWS Network Firewall has instantiated in the subnet. You use this to identify the firewall endpoint in the VPC route tables, when you redirect the VPC traffic through the endpoint.
	endpointId?: null | string @go(EndpointID,*string)

	// The unique identifier for the subnet.
	subnetId?: null | string @go(SubnetID,*string)
}

#AttachmentParameters: {
}

#EncryptionConfigurationInitParameters: {
	// The ID of the customer managed key. You can use any of the key identifiers that KMS supports, unless you're using a key that's managed by another account. If you're using a key managed by another account, then specify the key ARN.
	keyId?: null | string @go(KeyID,*string)

	// The type of AWS KMS key to use for encryption of your Network Firewall resources. Valid values are CUSTOMER_KMS and AWS_OWNED_KMS_KEY.
	type?: null | string @go(Type,*string)
}

#EncryptionConfigurationObservation: {
	// The ID of the customer managed key. You can use any of the key identifiers that KMS supports, unless you're using a key that's managed by another account. If you're using a key managed by another account, then specify the key ARN.
	keyId?: null | string @go(KeyID,*string)

	// The type of AWS KMS key to use for encryption of your Network Firewall resources. Valid values are CUSTOMER_KMS and AWS_OWNED_KMS_KEY.
	type?: null | string @go(Type,*string)
}

#EncryptionConfigurationParameters: {
	// The ID of the customer managed key. You can use any of the key identifiers that KMS supports, unless you're using a key that's managed by another account. If you're using a key managed by another account, then specify the key ARN.
	// +kubebuilder:validation:Optional
	keyId?: null | string @go(KeyID,*string)

	// The type of AWS KMS key to use for encryption of your Network Firewall resources. Valid values are CUSTOMER_KMS and AWS_OWNED_KMS_KEY.
	// +kubebuilder:validation:Optional
	type?: null | string @go(Type,*string)
}

#FirewallInitParameters: {
	// A boolean flag indicating whether it is possible to delete the firewall. Defaults to false.
	deleteProtection?: null | bool @go(DeleteProtection,*bool)

	// A friendly description of the firewall.
	description?: null | string @go(Description,*string)

	// KMS encryption configuration settings. See Encryption Configuration below for details.
	encryptionConfiguration?: [...#EncryptionConfigurationInitParameters] @go(EncryptionConfiguration,[]EncryptionConfigurationInitParameters)

	// (Option) A boolean flag indicating whether it is possible to change the associated firewall policy. Defaults to false.
	firewallPolicyChangeProtection?: null | bool @go(FirewallPolicyChangeProtection,*bool)

	// A friendly name of the firewall.
	name?: null | string @go(Name,*string)

	// A boolean flag indicating whether it is possible to change the associated subnet(s). Defaults to false.
	subnetChangeProtection?: null | bool @go(SubnetChangeProtection,*bool)

	// Set of configuration blocks describing the public subnets. Each subnet must belong to a different Availability Zone in the VPC. AWS Network Firewall creates a firewall endpoint in each subnet. See Subnet Mapping below for details.
	subnetMapping?: [...#SubnetMappingInitParameters] @go(SubnetMapping,[]SubnetMappingInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#FirewallObservation: {
	// The Amazon Resource Name (ARN) that identifies the firewall.
	arn?: null | string @go(Arn,*string)

	// A boolean flag indicating whether it is possible to delete the firewall. Defaults to false.
	deleteProtection?: null | bool @go(DeleteProtection,*bool)

	// A friendly description of the firewall.
	description?: null | string @go(Description,*string)

	// KMS encryption configuration settings. See Encryption Configuration below for details.
	encryptionConfiguration?: [...#EncryptionConfigurationObservation] @go(EncryptionConfiguration,[]EncryptionConfigurationObservation)

	// The Amazon Resource Name (ARN) of the VPC Firewall policy.
	firewallPolicyArn?: null | string @go(FirewallPolicyArn,*string)

	// (Option) A boolean flag indicating whether it is possible to change the associated firewall policy. Defaults to false.
	firewallPolicyChangeProtection?: null | bool @go(FirewallPolicyChangeProtection,*bool)

	// Nested list of information about the current status of the firewall.
	firewallStatus?: [...#FirewallStatusObservation] @go(FirewallStatus,[]FirewallStatusObservation)

	// The Amazon Resource Name (ARN) that identifies the firewall.
	id?: null | string @go(ID,*string)

	// A friendly name of the firewall.
	name?: null | string @go(Name,*string)

	// A boolean flag indicating whether it is possible to change the associated subnet(s). Defaults to false.
	subnetChangeProtection?: null | bool @go(SubnetChangeProtection,*bool)

	// Set of configuration blocks describing the public subnets. Each subnet must belong to a different Availability Zone in the VPC. AWS Network Firewall creates a firewall endpoint in each subnet. See Subnet Mapping below for details.
	subnetMapping?: [...#SubnetMappingObservation] @go(SubnetMapping,[]SubnetMappingObservation)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// A string token used when updating a firewall.
	updateToken?: null | string @go(UpdateToken,*string)

	// The unique identifier of the VPC where AWS Network Firewall should create the firewall.
	vpcId?: null | string @go(VPCID,*string)
}

#FirewallParameters: {
	// A boolean flag indicating whether it is possible to delete the firewall. Defaults to false.
	// +kubebuilder:validation:Optional
	deleteProtection?: null | bool @go(DeleteProtection,*bool)

	// A friendly description of the firewall.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// KMS encryption configuration settings. See Encryption Configuration below for details.
	// +kubebuilder:validation:Optional
	encryptionConfiguration?: [...#EncryptionConfigurationParameters] @go(EncryptionConfiguration,[]EncryptionConfigurationParameters)

	// The Amazon Resource Name (ARN) of the VPC Firewall policy.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/networkfirewall/v1beta1.FirewallPolicy
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	firewallPolicyArn?: null | string @go(FirewallPolicyArn,*string)

	// Reference to a FirewallPolicy in networkfirewall to populate firewallPolicyArn.
	// +kubebuilder:validation:Optional
	firewallPolicyArnRef?: null | v1.#Reference @go(FirewallPolicyArnRef,*v1.Reference)

	// Selector for a FirewallPolicy in networkfirewall to populate firewallPolicyArn.
	// +kubebuilder:validation:Optional
	firewallPolicyArnSelector?: null | v1.#Selector @go(FirewallPolicyArnSelector,*v1.Selector)

	// (Option) A boolean flag indicating whether it is possible to change the associated firewall policy. Defaults to false.
	// +kubebuilder:validation:Optional
	firewallPolicyChangeProtection?: null | bool @go(FirewallPolicyChangeProtection,*bool)

	// A friendly name of the firewall.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// A boolean flag indicating whether it is possible to change the associated subnet(s). Defaults to false.
	// +kubebuilder:validation:Optional
	subnetChangeProtection?: null | bool @go(SubnetChangeProtection,*bool)

	// Set of configuration blocks describing the public subnets. Each subnet must belong to a different Availability Zone in the VPC. AWS Network Firewall creates a firewall endpoint in each subnet. See Subnet Mapping below for details.
	// +kubebuilder:validation:Optional
	subnetMapping?: [...#SubnetMappingParameters] @go(SubnetMapping,[]SubnetMappingParameters)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The unique identifier of the VPC where AWS Network Firewall should create the firewall.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPC
	// +kubebuilder:validation:Optional
	vpcId?: null | string @go(VPCID,*string)

	// Reference to a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdRef?: null | v1.#Reference @go(VPCIDRef,*v1.Reference)

	// Selector for a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdSelector?: null | v1.#Selector @go(VPCIDSelector,*v1.Selector)
}

#FirewallStatusInitParameters: {
}

#FirewallStatusObservation: {
	// Set of subnets configured for use by the firewall.
	syncStates?: [...#SyncStatesObservation] @go(SyncStates,[]SyncStatesObservation)
}

#FirewallStatusParameters: {
}

#SubnetMappingInitParameters: {
	// The subnet's IP address type. Valida values: "DUALSTACK", "IPV4".
	ipAddressType?: null | string @go(IPAddressType,*string)
}

#SubnetMappingObservation: {
	// The subnet's IP address type. Valida values: "DUALSTACK", "IPV4".
	ipAddressType?: null | string @go(IPAddressType,*string)

	// The unique identifier for the subnet.
	subnetId?: null | string @go(SubnetID,*string)
}

#SubnetMappingParameters: {
	// The subnet's IP address type. Valida values: "DUALSTACK", "IPV4".
	// +kubebuilder:validation:Optional
	ipAddressType?: null | string @go(IPAddressType,*string)

	// The unique identifier for the subnet.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.Subnet
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	subnetId?: null | string @go(SubnetID,*string)

	// Reference to a Subnet in ec2 to populate subnetId.
	// +kubebuilder:validation:Optional
	subnetIdRef?: null | v1.#Reference @go(SubnetIDRef,*v1.Reference)

	// Selector for a Subnet in ec2 to populate subnetId.
	// +kubebuilder:validation:Optional
	subnetIdSelector?: null | v1.#Selector @go(SubnetIDSelector,*v1.Selector)
}

#SyncStatesInitParameters: {
}

#SyncStatesObservation: {
	// Nested list describing the attachment status of the firewall's association with a single VPC subnet.
	attachment?: [...#AttachmentObservation] @go(Attachment,[]AttachmentObservation)

	// The Availability Zone where the subnet is configured.
	availabilityZone?: null | string @go(AvailabilityZone,*string)
}

#SyncStatesParameters: {
}

// FirewallSpec defines the desired state of Firewall
#FirewallSpec: {
	v1.#ResourceSpec
	forProvider: #FirewallParameters @go(ForProvider)

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
	initProvider?: #FirewallInitParameters @go(InitProvider)
}

// FirewallStatus defines the observed state of Firewall.
#FirewallStatus: {
	v1.#ResourceStatus
	atProvider?: #FirewallObservation @go(AtProvider)
}

// Firewall is the Schema for the Firewalls API. Provides an AWS Network Firewall Firewall resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Firewall: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.subnetMapping) || (has(self.initProvider) && has(self.initProvider.subnetMapping))",message="spec.forProvider.subnetMapping is a required parameter"
	spec:    #FirewallSpec   @go(Spec)
	status?: #FirewallStatus @go(Status)
}

// FirewallList contains a list of Firewalls
#FirewallList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Firewall] @go(Items,[]Firewall)
}
