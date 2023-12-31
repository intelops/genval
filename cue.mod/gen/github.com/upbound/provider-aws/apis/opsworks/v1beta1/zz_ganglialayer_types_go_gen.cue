// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/opsworks/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#GangliaLayerCloudwatchConfigurationInitParameters: {
	enabled?: null | bool @go(Enabled,*bool)
	logStreams?: [...#GangliaLayerCloudwatchConfigurationLogStreamsInitParameters] @go(LogStreams,[]GangliaLayerCloudwatchConfigurationLogStreamsInitParameters)
}

#GangliaLayerCloudwatchConfigurationLogStreamsInitParameters: {
	batchCount?:           null | float64 @go(BatchCount,*float64)
	batchSize?:            null | float64 @go(BatchSize,*float64)
	bufferDuration?:       null | float64 @go(BufferDuration,*float64)
	datetimeFormat?:       null | string  @go(DatetimeFormat,*string)
	encoding?:             null | string  @go(Encoding,*string)
	file?:                 null | string  @go(File,*string)
	fileFingerprintLines?: null | string  @go(FileFingerprintLines,*string)
	initialPosition?:      null | string  @go(InitialPosition,*string)

	// A human-readable name for the layer.
	logGroupName?:          null | string @go(LogGroupName,*string)
	multilineStartPattern?: null | string @go(MultilineStartPattern,*string)
	timeZone?:              null | string @go(TimeZone,*string)
}

#GangliaLayerCloudwatchConfigurationLogStreamsObservation: {
	batchCount?:           null | float64 @go(BatchCount,*float64)
	batchSize?:            null | float64 @go(BatchSize,*float64)
	bufferDuration?:       null | float64 @go(BufferDuration,*float64)
	datetimeFormat?:       null | string  @go(DatetimeFormat,*string)
	encoding?:             null | string  @go(Encoding,*string)
	file?:                 null | string  @go(File,*string)
	fileFingerprintLines?: null | string  @go(FileFingerprintLines,*string)
	initialPosition?:      null | string  @go(InitialPosition,*string)

	// A human-readable name for the layer.
	logGroupName?:          null | string @go(LogGroupName,*string)
	multilineStartPattern?: null | string @go(MultilineStartPattern,*string)
	timeZone?:              null | string @go(TimeZone,*string)
}

#GangliaLayerCloudwatchConfigurationLogStreamsParameters: {
	// +kubebuilder:validation:Optional
	batchCount?: null | float64 @go(BatchCount,*float64)

	// +kubebuilder:validation:Optional
	batchSize?: null | float64 @go(BatchSize,*float64)

	// +kubebuilder:validation:Optional
	bufferDuration?: null | float64 @go(BufferDuration,*float64)

	// +kubebuilder:validation:Optional
	datetimeFormat?: null | string @go(DatetimeFormat,*string)

	// +kubebuilder:validation:Optional
	encoding?: null | string @go(Encoding,*string)

	// +kubebuilder:validation:Optional
	file?: null | string @go(File,*string)

	// +kubebuilder:validation:Optional
	fileFingerprintLines?: null | string @go(FileFingerprintLines,*string)

	// +kubebuilder:validation:Optional
	initialPosition?: null | string @go(InitialPosition,*string)

	// A human-readable name for the layer.
	// +kubebuilder:validation:Optional
	logGroupName?: null | string @go(LogGroupName,*string)

	// +kubebuilder:validation:Optional
	multilineStartPattern?: null | string @go(MultilineStartPattern,*string)

	// +kubebuilder:validation:Optional
	timeZone?: null | string @go(TimeZone,*string)
}

#GangliaLayerCloudwatchConfigurationObservation: {
	enabled?: null | bool @go(Enabled,*bool)
	logStreams?: [...#GangliaLayerCloudwatchConfigurationLogStreamsObservation] @go(LogStreams,[]GangliaLayerCloudwatchConfigurationLogStreamsObservation)
}

#GangliaLayerCloudwatchConfigurationParameters: {
	// +kubebuilder:validation:Optional
	enabled?: null | bool @go(Enabled,*bool)

	// +kubebuilder:validation:Optional
	logStreams?: [...#GangliaLayerCloudwatchConfigurationLogStreamsParameters] @go(LogStreams,[]GangliaLayerCloudwatchConfigurationLogStreamsParameters)
}

#GangliaLayerEBSVolumeInitParameters: {
	encrypted?: null | bool @go(Encrypted,*bool)

	// For PIOPS volumes, the IOPS per disk.
	iops?: null | float64 @go(Iops,*float64)

	// The path to mount the EBS volume on the layer's instances.
	mountPoint?: null | string @go(MountPoint,*string)

	// The number of disks to use for the EBS volume.
	numberOfDisks?: null | float64 @go(NumberOfDisks,*float64)

	// The RAID level to use for the volume.
	raidLevel?: null | string @go(RaidLevel,*string)

	// The size of the volume in gigabytes.
	size?: null | float64 @go(Size,*float64)

	// The type of volume to create. This may be standard (the default), io1 or gp2.
	type?: null | string @go(Type,*string)
}

#GangliaLayerEBSVolumeObservation: {
	encrypted?: null | bool @go(Encrypted,*bool)

	// For PIOPS volumes, the IOPS per disk.
	iops?: null | float64 @go(Iops,*float64)

	// The path to mount the EBS volume on the layer's instances.
	mountPoint?: null | string @go(MountPoint,*string)

	// The number of disks to use for the EBS volume.
	numberOfDisks?: null | float64 @go(NumberOfDisks,*float64)

	// The RAID level to use for the volume.
	raidLevel?: null | string @go(RaidLevel,*string)

	// The size of the volume in gigabytes.
	size?: null | float64 @go(Size,*float64)

	// The type of volume to create. This may be standard (the default), io1 or gp2.
	type?: null | string @go(Type,*string)
}

#GangliaLayerEBSVolumeParameters: {
	// +kubebuilder:validation:Optional
	encrypted?: null | bool @go(Encrypted,*bool)

	// For PIOPS volumes, the IOPS per disk.
	// +kubebuilder:validation:Optional
	iops?: null | float64 @go(Iops,*float64)

	// The path to mount the EBS volume on the layer's instances.
	// +kubebuilder:validation:Optional
	mountPoint?: null | string @go(MountPoint,*string)

	// The number of disks to use for the EBS volume.
	// +kubebuilder:validation:Optional
	numberOfDisks?: null | float64 @go(NumberOfDisks,*float64)

	// The RAID level to use for the volume.
	// +kubebuilder:validation:Optional
	raidLevel?: null | string @go(RaidLevel,*string)

	// The size of the volume in gigabytes.
	// +kubebuilder:validation:Optional
	size?: null | float64 @go(Size,*float64)

	// The type of volume to create. This may be standard (the default), io1 or gp2.
	// +kubebuilder:validation:Optional
	type?: null | string @go(Type,*string)
}

#GangliaLayerInitParameters: {
	// Whether to automatically assign an elastic IP address to the layer's instances.
	autoAssignElasticIps?: null | bool @go(AutoAssignElasticIps,*bool)

	// For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances.
	autoAssignPublicIps?: null | bool @go(AutoAssignPublicIps,*bool)

	// Whether to enable auto-healing for the layer.
	autoHealing?: null | bool @go(AutoHealing,*bool)
	cloudwatchConfiguration?: [...#GangliaLayerCloudwatchConfigurationInitParameters] @go(CloudwatchConfiguration,[]GangliaLayerCloudwatchConfigurationInitParameters)
	customConfigureRecipes?: [...null | string] @go(CustomConfigureRecipes,[]*string)
	customDeployRecipes?: [...null | string] @go(CustomDeployRecipes,[]*string)

	// The ARN of an IAM profile that will be used for the layer's instances.
	customInstanceProfileArn?: null | string @go(CustomInstanceProfileArn,*string)

	// Custom JSON attributes to apply to the layer.
	customJson?: null | string @go(CustomJSON,*string)
	customSetupRecipes?: [...null | string] @go(CustomSetupRecipes,[]*string)
	customShutdownRecipes?: [...null | string] @go(CustomShutdownRecipes,[]*string)
	customUndeployRecipes?: [...null | string] @go(CustomUndeployRecipes,[]*string)

	// Whether to enable Elastic Load Balancing connection draining.
	drainElbOnShutdown?: null | bool @go(DrainELBOnShutdown,*bool)

	// ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances.
	ebsVolume?: [...#GangliaLayerEBSVolumeInitParameters] @go(EBSVolume,[]GangliaLayerEBSVolumeInitParameters)

	// Name of an Elastic Load Balancer to attach to this layer
	elasticLoadBalancer?: null | string @go(ElasticLoadBalancer,*string)

	// Whether to install OS and package updates on each instance when it boots.
	installUpdatesOnBoot?: null | bool @go(InstallUpdatesOnBoot,*bool)

	// The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event.
	instanceShutdownTimeout?: null | float64 @go(InstanceShutdownTimeout,*float64)
	loadBasedAutoScaling?: [...#GangliaLayerLoadBasedAutoScalingInitParameters] @go(LoadBasedAutoScaling,[]GangliaLayerLoadBasedAutoScalingInitParameters)

	// A human-readable name for the layer.
	name?: null | string @go(Name,*string)

	// The password to use for Ganglia.
	password?: null | string @go(Password,*string)

	// Names of a set of system packages to install on the layer's instances.
	systemPackages?: [...null | string] @go(SystemPackages,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The URL path to use for Ganglia. Defaults to "/ganglia".
	url?: null | string @go(URL,*string)

	// Whether to use EBS-optimized instances.
	useEbsOptimizedInstances?: null | bool @go(UseEBSOptimizedInstances,*bool)

	// (Optiona) The username to use for Ganglia. Defaults to "opsworks".
	username?: null | string @go(Username,*string)
}

#GangliaLayerLoadBasedAutoScalingDownscalingInitParameters: {
	alarms?: [...null | string] @go(Alarms,[]*string)
	cpuThreshold?:       null | float64 @go(CPUThreshold,*float64)
	ignoreMetricsTime?:  null | float64 @go(IgnoreMetricsTime,*float64)
	instanceCount?:      null | float64 @go(InstanceCount,*float64)
	loadThreshold?:      null | float64 @go(LoadThreshold,*float64)
	memoryThreshold?:    null | float64 @go(MemoryThreshold,*float64)
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#GangliaLayerLoadBasedAutoScalingDownscalingObservation: {
	alarms?: [...null | string] @go(Alarms,[]*string)
	cpuThreshold?:       null | float64 @go(CPUThreshold,*float64)
	ignoreMetricsTime?:  null | float64 @go(IgnoreMetricsTime,*float64)
	instanceCount?:      null | float64 @go(InstanceCount,*float64)
	loadThreshold?:      null | float64 @go(LoadThreshold,*float64)
	memoryThreshold?:    null | float64 @go(MemoryThreshold,*float64)
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#GangliaLayerLoadBasedAutoScalingDownscalingParameters: {
	// +kubebuilder:validation:Optional
	alarms?: [...null | string] @go(Alarms,[]*string)

	// +kubebuilder:validation:Optional
	cpuThreshold?: null | float64 @go(CPUThreshold,*float64)

	// +kubebuilder:validation:Optional
	ignoreMetricsTime?: null | float64 @go(IgnoreMetricsTime,*float64)

	// +kubebuilder:validation:Optional
	instanceCount?: null | float64 @go(InstanceCount,*float64)

	// +kubebuilder:validation:Optional
	loadThreshold?: null | float64 @go(LoadThreshold,*float64)

	// +kubebuilder:validation:Optional
	memoryThreshold?: null | float64 @go(MemoryThreshold,*float64)

	// +kubebuilder:validation:Optional
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#GangliaLayerLoadBasedAutoScalingInitParameters: {
	downscaling?: [...#GangliaLayerLoadBasedAutoScalingDownscalingInitParameters] @go(Downscaling,[]GangliaLayerLoadBasedAutoScalingDownscalingInitParameters)
	enable?: null | bool @go(Enable,*bool)
	upscaling?: [...#GangliaLayerLoadBasedAutoScalingUpscalingInitParameters] @go(Upscaling,[]GangliaLayerLoadBasedAutoScalingUpscalingInitParameters)
}

#GangliaLayerLoadBasedAutoScalingObservation: {
	downscaling?: [...#GangliaLayerLoadBasedAutoScalingDownscalingObservation] @go(Downscaling,[]GangliaLayerLoadBasedAutoScalingDownscalingObservation)
	enable?: null | bool @go(Enable,*bool)
	upscaling?: [...#GangliaLayerLoadBasedAutoScalingUpscalingObservation] @go(Upscaling,[]GangliaLayerLoadBasedAutoScalingUpscalingObservation)
}

#GangliaLayerLoadBasedAutoScalingParameters: {
	// +kubebuilder:validation:Optional
	downscaling?: [...#GangliaLayerLoadBasedAutoScalingDownscalingParameters] @go(Downscaling,[]GangliaLayerLoadBasedAutoScalingDownscalingParameters)

	// +kubebuilder:validation:Optional
	enable?: null | bool @go(Enable,*bool)

	// +kubebuilder:validation:Optional
	upscaling?: [...#GangliaLayerLoadBasedAutoScalingUpscalingParameters] @go(Upscaling,[]GangliaLayerLoadBasedAutoScalingUpscalingParameters)
}

#GangliaLayerLoadBasedAutoScalingUpscalingInitParameters: {
	alarms?: [...null | string] @go(Alarms,[]*string)
	cpuThreshold?:       null | float64 @go(CPUThreshold,*float64)
	ignoreMetricsTime?:  null | float64 @go(IgnoreMetricsTime,*float64)
	instanceCount?:      null | float64 @go(InstanceCount,*float64)
	loadThreshold?:      null | float64 @go(LoadThreshold,*float64)
	memoryThreshold?:    null | float64 @go(MemoryThreshold,*float64)
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#GangliaLayerLoadBasedAutoScalingUpscalingObservation: {
	alarms?: [...null | string] @go(Alarms,[]*string)
	cpuThreshold?:       null | float64 @go(CPUThreshold,*float64)
	ignoreMetricsTime?:  null | float64 @go(IgnoreMetricsTime,*float64)
	instanceCount?:      null | float64 @go(InstanceCount,*float64)
	loadThreshold?:      null | float64 @go(LoadThreshold,*float64)
	memoryThreshold?:    null | float64 @go(MemoryThreshold,*float64)
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#GangliaLayerLoadBasedAutoScalingUpscalingParameters: {
	// +kubebuilder:validation:Optional
	alarms?: [...null | string] @go(Alarms,[]*string)

	// +kubebuilder:validation:Optional
	cpuThreshold?: null | float64 @go(CPUThreshold,*float64)

	// +kubebuilder:validation:Optional
	ignoreMetricsTime?: null | float64 @go(IgnoreMetricsTime,*float64)

	// +kubebuilder:validation:Optional
	instanceCount?: null | float64 @go(InstanceCount,*float64)

	// +kubebuilder:validation:Optional
	loadThreshold?: null | float64 @go(LoadThreshold,*float64)

	// +kubebuilder:validation:Optional
	memoryThreshold?: null | float64 @go(MemoryThreshold,*float64)

	// +kubebuilder:validation:Optional
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#GangliaLayerObservation: {
	// The Amazon Resource Name(ARN) of the layer.
	arn?: null | string @go(Arn,*string)

	// Whether to automatically assign an elastic IP address to the layer's instances.
	autoAssignElasticIps?: null | bool @go(AutoAssignElasticIps,*bool)

	// For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances.
	autoAssignPublicIps?: null | bool @go(AutoAssignPublicIps,*bool)

	// Whether to enable auto-healing for the layer.
	autoHealing?: null | bool @go(AutoHealing,*bool)
	cloudwatchConfiguration?: [...#GangliaLayerCloudwatchConfigurationObservation] @go(CloudwatchConfiguration,[]GangliaLayerCloudwatchConfigurationObservation)
	customConfigureRecipes?: [...null | string] @go(CustomConfigureRecipes,[]*string)
	customDeployRecipes?: [...null | string] @go(CustomDeployRecipes,[]*string)

	// The ARN of an IAM profile that will be used for the layer's instances.
	customInstanceProfileArn?: null | string @go(CustomInstanceProfileArn,*string)

	// Custom JSON attributes to apply to the layer.
	customJson?: null | string @go(CustomJSON,*string)

	// Ids for a set of security groups to apply to the layer's instances.
	customSecurityGroupIds?: [...null | string] @go(CustomSecurityGroupIds,[]*string)
	customSetupRecipes?: [...null | string] @go(CustomSetupRecipes,[]*string)
	customShutdownRecipes?: [...null | string] @go(CustomShutdownRecipes,[]*string)
	customUndeployRecipes?: [...null | string] @go(CustomUndeployRecipes,[]*string)

	// Whether to enable Elastic Load Balancing connection draining.
	drainElbOnShutdown?: null | bool @go(DrainELBOnShutdown,*bool)

	// ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances.
	ebsVolume?: [...#GangliaLayerEBSVolumeObservation] @go(EBSVolume,[]GangliaLayerEBSVolumeObservation)

	// Name of an Elastic Load Balancer to attach to this layer
	elasticLoadBalancer?: null | string @go(ElasticLoadBalancer,*string)

	// The id of the layer.
	id?: null | string @go(ID,*string)

	// Whether to install OS and package updates on each instance when it boots.
	installUpdatesOnBoot?: null | bool @go(InstallUpdatesOnBoot,*bool)

	// The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event.
	instanceShutdownTimeout?: null | float64 @go(InstanceShutdownTimeout,*float64)
	loadBasedAutoScaling?: [...#GangliaLayerLoadBasedAutoScalingObservation] @go(LoadBasedAutoScaling,[]GangliaLayerLoadBasedAutoScalingObservation)

	// A human-readable name for the layer.
	name?: null | string @go(Name,*string)

	// The password to use for Ganglia.
	password?: null | string @go(Password,*string)

	// ID of the stack the layer will belong to.
	stackId?: null | string @go(StackID,*string)

	// Names of a set of system packages to install on the layer's instances.
	systemPackages?: [...null | string] @go(SystemPackages,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The URL path to use for Ganglia. Defaults to "/ganglia".
	url?: null | string @go(URL,*string)

	// Whether to use EBS-optimized instances.
	useEbsOptimizedInstances?: null | bool @go(UseEBSOptimizedInstances,*bool)

	// (Optiona) The username to use for Ganglia. Defaults to "opsworks".
	username?: null | string @go(Username,*string)
}

#GangliaLayerParameters: {
	// Whether to automatically assign an elastic IP address to the layer's instances.
	// +kubebuilder:validation:Optional
	autoAssignElasticIps?: null | bool @go(AutoAssignElasticIps,*bool)

	// For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances.
	// +kubebuilder:validation:Optional
	autoAssignPublicIps?: null | bool @go(AutoAssignPublicIps,*bool)

	// Whether to enable auto-healing for the layer.
	// +kubebuilder:validation:Optional
	autoHealing?: null | bool @go(AutoHealing,*bool)

	// +kubebuilder:validation:Optional
	cloudwatchConfiguration?: [...#GangliaLayerCloudwatchConfigurationParameters] @go(CloudwatchConfiguration,[]GangliaLayerCloudwatchConfigurationParameters)

	// +kubebuilder:validation:Optional
	customConfigureRecipes?: [...null | string] @go(CustomConfigureRecipes,[]*string)

	// +kubebuilder:validation:Optional
	customDeployRecipes?: [...null | string] @go(CustomDeployRecipes,[]*string)

	// The ARN of an IAM profile that will be used for the layer's instances.
	// +kubebuilder:validation:Optional
	customInstanceProfileArn?: null | string @go(CustomInstanceProfileArn,*string)

	// Custom JSON attributes to apply to the layer.
	// +kubebuilder:validation:Optional
	customJson?: null | string @go(CustomJSON,*string)

	// References to SecurityGroup in ec2 to populate customSecurityGroupIds.
	// +kubebuilder:validation:Optional
	customSecurityGroupIdRefs?: [...v1.#Reference] @go(CustomSecurityGroupIDRefs,[]v1.Reference)

	// Selector for a list of SecurityGroup in ec2 to populate customSecurityGroupIds.
	// +kubebuilder:validation:Optional
	customSecurityGroupIdSelector?: null | v1.#Selector @go(CustomSecurityGroupIDSelector,*v1.Selector)

	// Ids for a set of security groups to apply to the layer's instances.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.SecurityGroup
	// +crossplane:generate:reference:refFieldName=CustomSecurityGroupIDRefs
	// +crossplane:generate:reference:selectorFieldName=CustomSecurityGroupIDSelector
	// +kubebuilder:validation:Optional
	customSecurityGroupIds?: [...null | string] @go(CustomSecurityGroupIds,[]*string)

	// +kubebuilder:validation:Optional
	customSetupRecipes?: [...null | string] @go(CustomSetupRecipes,[]*string)

	// +kubebuilder:validation:Optional
	customShutdownRecipes?: [...null | string] @go(CustomShutdownRecipes,[]*string)

	// +kubebuilder:validation:Optional
	customUndeployRecipes?: [...null | string] @go(CustomUndeployRecipes,[]*string)

	// Whether to enable Elastic Load Balancing connection draining.
	// +kubebuilder:validation:Optional
	drainElbOnShutdown?: null | bool @go(DrainELBOnShutdown,*bool)

	// ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances.
	// +kubebuilder:validation:Optional
	ebsVolume?: [...#GangliaLayerEBSVolumeParameters] @go(EBSVolume,[]GangliaLayerEBSVolumeParameters)

	// Name of an Elastic Load Balancer to attach to this layer
	// +kubebuilder:validation:Optional
	elasticLoadBalancer?: null | string @go(ElasticLoadBalancer,*string)

	// Whether to install OS and package updates on each instance when it boots.
	// +kubebuilder:validation:Optional
	installUpdatesOnBoot?: null | bool @go(InstallUpdatesOnBoot,*bool)

	// The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event.
	// +kubebuilder:validation:Optional
	instanceShutdownTimeout?: null | float64 @go(InstanceShutdownTimeout,*float64)

	// +kubebuilder:validation:Optional
	loadBasedAutoScaling?: [...#GangliaLayerLoadBasedAutoScalingParameters] @go(LoadBasedAutoScaling,[]GangliaLayerLoadBasedAutoScalingParameters)

	// A human-readable name for the layer.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// The password to use for Ganglia.
	// +kubebuilder:validation:Optional
	password?: null | string @go(Password,*string)

	// ID of the stack the layer will belong to.
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

	// Names of a set of system packages to install on the layer's instances.
	// +kubebuilder:validation:Optional
	systemPackages?: [...null | string] @go(SystemPackages,[]*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The URL path to use for Ganglia. Defaults to "/ganglia".
	// +kubebuilder:validation:Optional
	url?: null | string @go(URL,*string)

	// Whether to use EBS-optimized instances.
	// +kubebuilder:validation:Optional
	useEbsOptimizedInstances?: null | bool @go(UseEBSOptimizedInstances,*bool)

	// (Optiona) The username to use for Ganglia. Defaults to "opsworks".
	// +kubebuilder:validation:Optional
	username?: null | string @go(Username,*string)
}

// GangliaLayerSpec defines the desired state of GangliaLayer
#GangliaLayerSpec: {
	v1.#ResourceSpec
	forProvider: #GangliaLayerParameters @go(ForProvider)

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
	initProvider?: #GangliaLayerInitParameters @go(InitProvider)
}

// GangliaLayerStatus defines the observed state of GangliaLayer.
#GangliaLayerStatus: {
	v1.#ResourceStatus
	atProvider?: #GangliaLayerObservation @go(AtProvider)
}

// GangliaLayer is the Schema for the GangliaLayers API. Provides an OpsWorks Ganglia layer resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#GangliaLayer: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.password) || (has(self.initProvider) && has(self.initProvider.password))",message="spec.forProvider.password is a required parameter"
	spec:    #GangliaLayerSpec   @go(Spec)
	status?: #GangliaLayerStatus @go(Status)
}

// GangliaLayerList contains a list of GangliaLayers
#GangliaLayerList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#GangliaLayer] @go(Items,[]GangliaLayer)
}
