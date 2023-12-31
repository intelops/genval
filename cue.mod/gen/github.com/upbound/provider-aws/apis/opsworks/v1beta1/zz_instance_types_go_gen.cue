// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/opsworks/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#EBSBlockDeviceInitParameters: {
	// Whether the volume should be destroyed on instance termination. Default is true.
	deleteOnTermination?: null | bool @go(DeleteOnTermination,*bool)

	// Name of the device to mount.
	deviceName?: null | string @go(DeviceName,*string)

	// Amount of provisioned IOPS. This must be set with a volume_type of io1.
	iops?: null | float64 @go(Iops,*float64)

	// Snapshot ID to mount.
	snapshotId?: null | string @go(SnapshotID,*string)

	// Size of the volume in gigabytes.
	volumeSize?: null | float64 @go(VolumeSize,*float64)

	// Type of volume. Valid values are standard, gp2, or io1. Default is standard.
	volumeType?: null | string @go(VolumeType,*string)
}

#EBSBlockDeviceObservation: {
	// Whether the volume should be destroyed on instance termination. Default is true.
	deleteOnTermination?: null | bool @go(DeleteOnTermination,*bool)

	// Name of the device to mount.
	deviceName?: null | string @go(DeviceName,*string)

	// Amount of provisioned IOPS. This must be set with a volume_type of io1.
	iops?: null | float64 @go(Iops,*float64)

	// Snapshot ID to mount.
	snapshotId?: null | string @go(SnapshotID,*string)

	// Size of the volume in gigabytes.
	volumeSize?: null | float64 @go(VolumeSize,*float64)

	// Type of volume. Valid values are standard, gp2, or io1. Default is standard.
	volumeType?: null | string @go(VolumeType,*string)
}

#EBSBlockDeviceParameters: {
	// Whether the volume should be destroyed on instance termination. Default is true.
	// +kubebuilder:validation:Optional
	deleteOnTermination?: null | bool @go(DeleteOnTermination,*bool)

	// Name of the device to mount.
	// +kubebuilder:validation:Optional
	deviceName?: null | string @go(DeviceName,*string)

	// Amount of provisioned IOPS. This must be set with a volume_type of io1.
	// +kubebuilder:validation:Optional
	iops?: null | float64 @go(Iops,*float64)

	// Snapshot ID to mount.
	// +kubebuilder:validation:Optional
	snapshotId?: null | string @go(SnapshotID,*string)

	// Size of the volume in gigabytes.
	// +kubebuilder:validation:Optional
	volumeSize?: null | float64 @go(VolumeSize,*float64)

	// Type of volume. Valid values are standard, gp2, or io1. Default is standard.
	// +kubebuilder:validation:Optional
	volumeType?: null | string @go(VolumeType,*string)
}

#EphemeralBlockDeviceInitParameters: {
	// Name of the block device to mount on the instance.
	deviceName?: null | string @go(DeviceName,*string)

	// The Instance Store Device Name (e.g., ephemeral0).
	virtualName?: null | string @go(VirtualName,*string)
}

#EphemeralBlockDeviceObservation: {
	// Name of the block device to mount on the instance.
	deviceName?: null | string @go(DeviceName,*string)

	// The Instance Store Device Name (e.g., ephemeral0).
	virtualName?: null | string @go(VirtualName,*string)
}

#EphemeralBlockDeviceParameters: {
	// Name of the block device to mount on the instance.
	// +kubebuilder:validation:Optional
	deviceName?: null | string @go(DeviceName,*string)

	// The Instance Store Device Name (e.g., ephemeral0).
	// +kubebuilder:validation:Optional
	virtualName?: null | string @go(VirtualName,*string)
}

#InstanceInitParameters: {
	// AMI to use for the instance.  If an AMI is specified, os must be Custom.
	amiId?: null | string @go(AMIID,*string)

	// OpsWorks agent to install. Default is INHERIT.
	agentVersion?: null | string @go(AgentVersion,*string)

	// Machine architecture for created instances.  Valid values are x86_64 or i386. The default is x86_64.
	architecture?: null | string @go(Architecture,*string)

	// Creates load-based or time-based instances.  Valid values are load, timer.
	autoScalingType?: null | string @go(AutoScalingType,*string)

	// Name of the availability zone where instances will be created by default.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Time that the instance was created.
	createdAt?: null | string @go(CreatedAt,*string)

	// Whether to delete EBS volume on deletion. Default is true.
	deleteEbs?: null | bool @go(DeleteEBS,*bool)

	// Whether to delete the Elastic IP on deletion.
	deleteEip?: null | bool @go(DeleteEIP,*bool)

	// Configuration block for additional EBS block devices to attach to the instance. See Block Devices below.
	ebsBlockDevice?: [...#EBSBlockDeviceInitParameters] @go(EBSBlockDevice,[]EBSBlockDeviceInitParameters)

	// Whether the launched EC2 instance will be EBS-optimized.
	ebsOptimized?: null | bool @go(EBSOptimized,*bool)

	// ECS cluster's ARN for container instances.
	ecsClusterArn?: null | string @go(EcsClusterArn,*string)

	// Instance Elastic IP address.
	elasticIp?: null | string @go(ElasticIP,*string)

	// Configuration block for ephemeral (also known as "Instance Store") volumes on the instance. See Block Devices below.
	ephemeralBlockDevice?: [...#EphemeralBlockDeviceInitParameters] @go(EphemeralBlockDevice,[]EphemeralBlockDeviceInitParameters)

	// Instance's host name.
	hostname?: null | string @go(Hostname,*string)

	// For registered instances, infrastructure class: ec2 or on-premises.
	infrastructureClass?: null | string @go(InfrastructureClass,*string)

	// Controls where to install OS and package updates when the instance boots.  Default is true.
	installUpdatesOnBoot?: null | bool @go(InstallUpdatesOnBoot,*bool)

	// ARN of the instance's IAM profile.
	instanceProfileArn?: null | string @go(InstanceProfileArn,*string)

	// Type of instance to start.
	instanceType?: null | string @go(InstanceType,*string)

	// Name of operating system that will be installed.
	os?: null | string @go(Os,*string)

	// Configuration block for the root block device of the instance. See Block Devices below.
	rootBlockDevice?: [...#RootBlockDeviceInitParameters] @go(RootBlockDevice,[]RootBlockDeviceInitParameters)

	// Name of the type of root device instances will have by default. Valid values are ebs or instance-store.
	rootDeviceType?: null | string @go(RootDeviceType,*string)

	// Name of the SSH keypair that instances will have by default.
	sshKeyName?: null | string @go(SSHKeyName,*string)

	// Desired state of the instance. Valid values are running or stopped.
	state?: null | string @go(State,*string)

	// Instance status. Will be one of booting, connection_lost, online, pending, rebooting, requested, running_setup, setup_failed, shutting_down, start_failed, stop_failed, stopped, stopping, terminated, or terminating.
	status?: null | string @go(Status,*string)

	// Instance tenancy to use. Valid values are default, dedicated or host.
	tenancy?: null | string @go(Tenancy,*string)

	// Keyword to choose what virtualization mode created instances will use. Valid values are paravirtual or hvm.
	virtualizationType?: null | string @go(VirtualizationType,*string)
}

#InstanceObservation: {
	// AMI to use for the instance.  If an AMI is specified, os must be Custom.
	amiId?: null | string @go(AMIID,*string)

	// OpsWorks agent to install. Default is INHERIT.
	agentVersion?: null | string @go(AgentVersion,*string)

	// Machine architecture for created instances.  Valid values are x86_64 or i386. The default is x86_64.
	architecture?: null | string @go(Architecture,*string)

	// Creates load-based or time-based instances.  Valid values are load, timer.
	autoScalingType?: null | string @go(AutoScalingType,*string)

	// Name of the availability zone where instances will be created by default.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Time that the instance was created.
	createdAt?: null | string @go(CreatedAt,*string)

	// Whether to delete EBS volume on deletion. Default is true.
	deleteEbs?: null | bool @go(DeleteEBS,*bool)

	// Whether to delete the Elastic IP on deletion.
	deleteEip?: null | bool @go(DeleteEIP,*bool)

	// Configuration block for additional EBS block devices to attach to the instance. See Block Devices below.
	ebsBlockDevice?: [...#EBSBlockDeviceObservation] @go(EBSBlockDevice,[]EBSBlockDeviceObservation)

	// Whether the launched EC2 instance will be EBS-optimized.
	ebsOptimized?: null | bool @go(EBSOptimized,*bool)

	// EC2 instance ID.
	ec2InstanceId?: null | string @go(EC2InstanceID,*string)

	// ECS cluster's ARN for container instances.
	ecsClusterArn?: null | string @go(EcsClusterArn,*string)

	// Instance Elastic IP address.
	elasticIp?: null | string @go(ElasticIP,*string)

	// Configuration block for ephemeral (also known as "Instance Store") volumes on the instance. See Block Devices below.
	ephemeralBlockDevice?: [...#EphemeralBlockDeviceObservation] @go(EphemeralBlockDevice,[]EphemeralBlockDeviceObservation)

	// Instance's host name.
	hostname?: null | string @go(Hostname,*string)

	// ID of the OpsWorks instance.
	id?: null | string @go(ID,*string)

	// For registered instances, infrastructure class: ec2 or on-premises.
	infrastructureClass?: null | string @go(InfrastructureClass,*string)

	// Controls where to install OS and package updates when the instance boots.  Default is true.
	installUpdatesOnBoot?: null | bool @go(InstallUpdatesOnBoot,*bool)

	// ARN of the instance's IAM profile.
	instanceProfileArn?: null | string @go(InstanceProfileArn,*string)

	// Type of instance to start.
	instanceType?: null | string @go(InstanceType,*string)

	// ID of the last service error.
	lastServiceErrorId?: null | string @go(LastServiceErrorID,*string)

	// List of the layers the instance will belong to.
	layerIds?: [...null | string] @go(LayerIds,[]*string)

	// Name of operating system that will be installed.
	os?: null | string @go(Os,*string)

	// Instance's platform.
	platform?: null | string @go(Platform,*string)

	// Private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC.
	privateDns?: null | string @go(PrivateDNS,*string)

	// Private IP address assigned to the instance.
	privateIp?: null | string @go(PrivateIP,*string)

	// Public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC.
	publicDns?: null | string @go(PublicDNS,*string)

	// Public IP address assigned to the instance, if applicable.
	publicIp?: null | string @go(PublicIP,*string)

	// For registered instances, who performed the registration.
	registeredBy?: null | string @go(RegisteredBy,*string)

	// Instance's reported AWS OpsWorks Stacks agent version.
	reportedAgentVersion?: null | string @go(ReportedAgentVersion,*string)

	// For registered instances, the reported operating system family.
	reportedOsFamily?: null | string @go(ReportedOsFamily,*string)

	// For registered instances, the reported operating system name.
	reportedOsName?: null | string @go(ReportedOsName,*string)

	// For registered instances, the reported operating system version.
	reportedOsVersion?: null | string @go(ReportedOsVersion,*string)

	// Configuration block for the root block device of the instance. See Block Devices below.
	rootBlockDevice?: [...#RootBlockDeviceObservation] @go(RootBlockDevice,[]RootBlockDeviceObservation)

	// Name of the type of root device instances will have by default. Valid values are ebs or instance-store.
	rootDeviceType?: null | string @go(RootDeviceType,*string)

	// Root device volume ID.
	rootDeviceVolumeId?: null | string @go(RootDeviceVolumeID,*string)

	// SSH key's Deep Security Agent (DSA) fingerprint.
	sshHostDsaKeyFingerprint?: null | string @go(SSHHostDsaKeyFingerprint,*string)

	// SSH key's RSA fingerprint.
	sshHostRsaKeyFingerprint?: null | string @go(SSHHostRsaKeyFingerprint,*string)

	// Name of the SSH keypair that instances will have by default.
	sshKeyName?: null | string @go(SSHKeyName,*string)

	// Associated security groups.
	securityGroupIds?: [...null | string] @go(SecurityGroupIds,[]*string)

	// Identifier of the stack the instance will belong to.
	stackId?: null | string @go(StackID,*string)

	// Desired state of the instance. Valid values are running or stopped.
	state?: null | string @go(State,*string)

	// Instance status. Will be one of booting, connection_lost, online, pending, rebooting, requested, running_setup, setup_failed, shutting_down, start_failed, stop_failed, stopped, stopping, terminated, or terminating.
	status?: null | string @go(Status,*string)

	// Subnet ID to attach to.
	subnetId?: null | string @go(SubnetID,*string)

	// Instance tenancy to use. Valid values are default, dedicated or host.
	tenancy?: null | string @go(Tenancy,*string)

	// Keyword to choose what virtualization mode created instances will use. Valid values are paravirtual or hvm.
	virtualizationType?: null | string @go(VirtualizationType,*string)
}

#InstanceParameters: {
	// AMI to use for the instance.  If an AMI is specified, os must be Custom.
	// +kubebuilder:validation:Optional
	amiId?: null | string @go(AMIID,*string)

	// OpsWorks agent to install. Default is INHERIT.
	// +kubebuilder:validation:Optional
	agentVersion?: null | string @go(AgentVersion,*string)

	// Machine architecture for created instances.  Valid values are x86_64 or i386. The default is x86_64.
	// +kubebuilder:validation:Optional
	architecture?: null | string @go(Architecture,*string)

	// Creates load-based or time-based instances.  Valid values are load, timer.
	// +kubebuilder:validation:Optional
	autoScalingType?: null | string @go(AutoScalingType,*string)

	// Name of the availability zone where instances will be created by default.
	// +kubebuilder:validation:Optional
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// Time that the instance was created.
	// +kubebuilder:validation:Optional
	createdAt?: null | string @go(CreatedAt,*string)

	// Whether to delete EBS volume on deletion. Default is true.
	// +kubebuilder:validation:Optional
	deleteEbs?: null | bool @go(DeleteEBS,*bool)

	// Whether to delete the Elastic IP on deletion.
	// +kubebuilder:validation:Optional
	deleteEip?: null | bool @go(DeleteEIP,*bool)

	// Configuration block for additional EBS block devices to attach to the instance. See Block Devices below.
	// +kubebuilder:validation:Optional
	ebsBlockDevice?: [...#EBSBlockDeviceParameters] @go(EBSBlockDevice,[]EBSBlockDeviceParameters)

	// Whether the launched EC2 instance will be EBS-optimized.
	// +kubebuilder:validation:Optional
	ebsOptimized?: null | bool @go(EBSOptimized,*bool)

	// ECS cluster's ARN for container instances.
	// +kubebuilder:validation:Optional
	ecsClusterArn?: null | string @go(EcsClusterArn,*string)

	// Instance Elastic IP address.
	// +kubebuilder:validation:Optional
	elasticIp?: null | string @go(ElasticIP,*string)

	// Configuration block for ephemeral (also known as "Instance Store") volumes on the instance. See Block Devices below.
	// +kubebuilder:validation:Optional
	ephemeralBlockDevice?: [...#EphemeralBlockDeviceParameters] @go(EphemeralBlockDevice,[]EphemeralBlockDeviceParameters)

	// Instance's host name.
	// +kubebuilder:validation:Optional
	hostname?: null | string @go(Hostname,*string)

	// For registered instances, infrastructure class: ec2 or on-premises.
	// +kubebuilder:validation:Optional
	infrastructureClass?: null | string @go(InfrastructureClass,*string)

	// Controls where to install OS and package updates when the instance boots.  Default is true.
	// +kubebuilder:validation:Optional
	installUpdatesOnBoot?: null | bool @go(InstallUpdatesOnBoot,*bool)

	// ARN of the instance's IAM profile.
	// +kubebuilder:validation:Optional
	instanceProfileArn?: null | string @go(InstanceProfileArn,*string)

	// Type of instance to start.
	// +kubebuilder:validation:Optional
	instanceType?: null | string @go(InstanceType,*string)

	// List of the layers the instance will belong to.
	// +crossplane:generate:reference:type=CustomLayer
	// +kubebuilder:validation:Optional
	layerIds?: [...null | string] @go(LayerIds,[]*string)

	// References to CustomLayer to populate layerIds.
	// +kubebuilder:validation:Optional
	layerIdsRefs?: [...v1.#Reference] @go(LayerIdsRefs,[]v1.Reference)

	// Selector for a list of CustomLayer to populate layerIds.
	// +kubebuilder:validation:Optional
	layerIdsSelector?: null | v1.#Selector @go(LayerIdsSelector,*v1.Selector)

	// Name of operating system that will be installed.
	// +kubebuilder:validation:Optional
	os?: null | string @go(Os,*string)

	// Configuration block for the root block device of the instance. See Block Devices below.
	// +kubebuilder:validation:Optional
	rootBlockDevice?: [...#RootBlockDeviceParameters] @go(RootBlockDevice,[]RootBlockDeviceParameters)

	// Name of the type of root device instances will have by default. Valid values are ebs or instance-store.
	// +kubebuilder:validation:Optional
	rootDeviceType?: null | string @go(RootDeviceType,*string)

	// Name of the SSH keypair that instances will have by default.
	// +kubebuilder:validation:Optional
	sshKeyName?: null | string @go(SSHKeyName,*string)

	// References to SecurityGroup in ec2 to populate securityGroupIds.
	// +kubebuilder:validation:Optional
	securityGroupIdRefs?: [...v1.#Reference] @go(SecurityGroupIDRefs,[]v1.Reference)

	// Selector for a list of SecurityGroup in ec2 to populate securityGroupIds.
	// +kubebuilder:validation:Optional
	securityGroupIdSelector?: null | v1.#Selector @go(SecurityGroupIDSelector,*v1.Selector)

	// Associated security groups.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.SecurityGroup
	// +crossplane:generate:reference:refFieldName=SecurityGroupIDRefs
	// +crossplane:generate:reference:selectorFieldName=SecurityGroupIDSelector
	// +kubebuilder:validation:Optional
	securityGroupIds?: [...null | string] @go(SecurityGroupIds,[]*string)

	// Identifier of the stack the instance will belong to.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/opsworks/v1beta1.Stack
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	stackId?: null | string @go(StackID,*string)

	// Reference to a Stack in opsworks to populate stackId.
	// +kubebuilder:validation:Optional
	stackIdRef?: null | v1.#Reference @go(StackIDRef,*v1.Reference)

	// Selector for a Stack in opsworks to populate stackId.
	// +kubebuilder:validation:Optional
	stackIdSelector?: null | v1.#Selector @go(StackIDSelector,*v1.Selector)

	// Desired state of the instance. Valid values are running or stopped.
	// +kubebuilder:validation:Optional
	state?: null | string @go(State,*string)

	// Instance status. Will be one of booting, connection_lost, online, pending, rebooting, requested, running_setup, setup_failed, shutting_down, start_failed, stop_failed, stopped, stopping, terminated, or terminating.
	// +kubebuilder:validation:Optional
	status?: null | string @go(Status,*string)

	// Subnet ID to attach to.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.Subnet
	// +kubebuilder:validation:Optional
	subnetId?: null | string @go(SubnetID,*string)

	// Reference to a Subnet in ec2 to populate subnetId.
	// +kubebuilder:validation:Optional
	subnetIdRef?: null | v1.#Reference @go(SubnetIDRef,*v1.Reference)

	// Selector for a Subnet in ec2 to populate subnetId.
	// +kubebuilder:validation:Optional
	subnetIdSelector?: null | v1.#Selector @go(SubnetIDSelector,*v1.Selector)

	// Instance tenancy to use. Valid values are default, dedicated or host.
	// +kubebuilder:validation:Optional
	tenancy?: null | string @go(Tenancy,*string)

	// Keyword to choose what virtualization mode created instances will use. Valid values are paravirtual or hvm.
	// +kubebuilder:validation:Optional
	virtualizationType?: null | string @go(VirtualizationType,*string)
}

#RootBlockDeviceInitParameters: {
	// Whether the volume should be destroyed on instance termination. Default is true.
	deleteOnTermination?: null | bool @go(DeleteOnTermination,*bool)

	// Amount of provisioned IOPS. This must be set with a volume_type of io1.
	iops?: null | float64 @go(Iops,*float64)

	// Size of the volume in gigabytes.
	volumeSize?: null | float64 @go(VolumeSize,*float64)

	// Type of volume. Valid values are standard, gp2, or io1. Default is standard.
	volumeType?: null | string @go(VolumeType,*string)
}

#RootBlockDeviceObservation: {
	// Whether the volume should be destroyed on instance termination. Default is true.
	deleteOnTermination?: null | bool @go(DeleteOnTermination,*bool)

	// Amount of provisioned IOPS. This must be set with a volume_type of io1.
	iops?: null | float64 @go(Iops,*float64)

	// Size of the volume in gigabytes.
	volumeSize?: null | float64 @go(VolumeSize,*float64)

	// Type of volume. Valid values are standard, gp2, or io1. Default is standard.
	volumeType?: null | string @go(VolumeType,*string)
}

#RootBlockDeviceParameters: {
	// Whether the volume should be destroyed on instance termination. Default is true.
	// +kubebuilder:validation:Optional
	deleteOnTermination?: null | bool @go(DeleteOnTermination,*bool)

	// Amount of provisioned IOPS. This must be set with a volume_type of io1.
	// +kubebuilder:validation:Optional
	iops?: null | float64 @go(Iops,*float64)

	// Size of the volume in gigabytes.
	// +kubebuilder:validation:Optional
	volumeSize?: null | float64 @go(VolumeSize,*float64)

	// Type of volume. Valid values are standard, gp2, or io1. Default is standard.
	// +kubebuilder:validation:Optional
	volumeType?: null | string @go(VolumeType,*string)
}

// InstanceSpec defines the desired state of Instance
#InstanceSpec: {
	v1.#ResourceSpec
	forProvider: #InstanceParameters @go(ForProvider)

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
	initProvider?: #InstanceInitParameters @go(InitProvider)
}

// InstanceStatus defines the observed state of Instance.
#InstanceStatus: {
	v1.#ResourceStatus
	atProvider?: #InstanceObservation @go(AtProvider)
}

// Instance is the Schema for the Instances API. Provides an OpsWorks instance resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Instance: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #InstanceSpec      @go(Spec)
	status?:   #InstanceStatus    @go(Status)
}

// InstanceList contains a list of Instances
#InstanceList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Instance] @go(Items,[]Instance)
}
