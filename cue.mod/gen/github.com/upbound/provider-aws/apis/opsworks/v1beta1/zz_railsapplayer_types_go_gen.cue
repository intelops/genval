// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/opsworks/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#RailsAppLayerCloudwatchConfigurationInitParameters: {
	enabled?: null | bool @go(Enabled,*bool)
	logStreams?: [...#RailsAppLayerCloudwatchConfigurationLogStreamsInitParameters] @go(LogStreams,[]RailsAppLayerCloudwatchConfigurationLogStreamsInitParameters)
}

#RailsAppLayerCloudwatchConfigurationLogStreamsInitParameters: {
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

#RailsAppLayerCloudwatchConfigurationLogStreamsObservation: {
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

#RailsAppLayerCloudwatchConfigurationLogStreamsParameters: {
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

#RailsAppLayerCloudwatchConfigurationObservation: {
	enabled?: null | bool @go(Enabled,*bool)
	logStreams?: [...#RailsAppLayerCloudwatchConfigurationLogStreamsObservation] @go(LogStreams,[]RailsAppLayerCloudwatchConfigurationLogStreamsObservation)
}

#RailsAppLayerCloudwatchConfigurationParameters: {
	// +kubebuilder:validation:Optional
	enabled?: null | bool @go(Enabled,*bool)

	// +kubebuilder:validation:Optional
	logStreams?: [...#RailsAppLayerCloudwatchConfigurationLogStreamsParameters] @go(LogStreams,[]RailsAppLayerCloudwatchConfigurationLogStreamsParameters)
}

#RailsAppLayerEBSVolumeInitParameters: {
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

#RailsAppLayerEBSVolumeObservation: {
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

#RailsAppLayerEBSVolumeParameters: {
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

#RailsAppLayerInitParameters: {
	// Keyword for the app server to use. Defaults to "apache_passenger".
	appServer?: null | string @go(AppServer,*string)

	// Whether to automatically assign an elastic IP address to the layer's instances.
	autoAssignElasticIps?: null | bool @go(AutoAssignElasticIps,*bool)

	// For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances.
	autoAssignPublicIps?: null | bool @go(AutoAssignPublicIps,*bool)

	// Whether to enable auto-healing for the layer.
	autoHealing?: null | bool @go(AutoHealing,*bool)

	// When OpsWorks is managing Bundler, which version to use. Defaults to "1.5.3".
	bundlerVersion?: null | string @go(BundlerVersion,*string)
	cloudwatchConfiguration?: [...#RailsAppLayerCloudwatchConfigurationInitParameters] @go(CloudwatchConfiguration,[]RailsAppLayerCloudwatchConfigurationInitParameters)
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
	ebsVolume?: [...#RailsAppLayerEBSVolumeInitParameters] @go(EBSVolume,[]RailsAppLayerEBSVolumeInitParameters)

	// Name of an Elastic Load Balancer to attach to this layer
	elasticLoadBalancer?: null | string @go(ElasticLoadBalancer,*string)

	// Whether to install OS and package updates on each instance when it boots.
	installUpdatesOnBoot?: null | bool @go(InstallUpdatesOnBoot,*bool)

	// The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event.
	instanceShutdownTimeout?: null | float64 @go(InstanceShutdownTimeout,*float64)
	loadBasedAutoScaling?: [...#RailsAppLayerLoadBasedAutoScalingInitParameters] @go(LoadBasedAutoScaling,[]RailsAppLayerLoadBasedAutoScalingInitParameters)

	// Whether OpsWorks should manage bundler. On by default.
	manageBundler?: null | bool @go(ManageBundler,*bool)

	// A human-readable name for the layer.
	name?: null | string @go(Name,*string)

	// The version of Passenger to use. Defaults to "4.0.46".
	passengerVersion?: null | string @go(PassengerVersion,*string)

	// The version of Ruby to use. Defaults to "2.0.0".
	rubyVersion?: null | string @go(RubyVersion,*string)

	// The version of RubyGems to use. Defaults to "2.2.2".
	rubygemsVersion?: null | string @go(RubygemsVersion,*string)

	// Names of a set of system packages to install on the layer's instances.
	systemPackages?: [...null | string] @go(SystemPackages,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Whether to use EBS-optimized instances.
	useEbsOptimizedInstances?: null | bool @go(UseEBSOptimizedInstances,*bool)
}

#RailsAppLayerLoadBasedAutoScalingDownscalingInitParameters: {
	alarms?: [...null | string] @go(Alarms,[]*string)
	cpuThreshold?:       null | float64 @go(CPUThreshold,*float64)
	ignoreMetricsTime?:  null | float64 @go(IgnoreMetricsTime,*float64)
	instanceCount?:      null | float64 @go(InstanceCount,*float64)
	loadThreshold?:      null | float64 @go(LoadThreshold,*float64)
	memoryThreshold?:    null | float64 @go(MemoryThreshold,*float64)
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#RailsAppLayerLoadBasedAutoScalingDownscalingObservation: {
	alarms?: [...null | string] @go(Alarms,[]*string)
	cpuThreshold?:       null | float64 @go(CPUThreshold,*float64)
	ignoreMetricsTime?:  null | float64 @go(IgnoreMetricsTime,*float64)
	instanceCount?:      null | float64 @go(InstanceCount,*float64)
	loadThreshold?:      null | float64 @go(LoadThreshold,*float64)
	memoryThreshold?:    null | float64 @go(MemoryThreshold,*float64)
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#RailsAppLayerLoadBasedAutoScalingDownscalingParameters: {
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

#RailsAppLayerLoadBasedAutoScalingInitParameters: {
	downscaling?: [...#RailsAppLayerLoadBasedAutoScalingDownscalingInitParameters] @go(Downscaling,[]RailsAppLayerLoadBasedAutoScalingDownscalingInitParameters)
	enable?: null | bool @go(Enable,*bool)
	upscaling?: [...#RailsAppLayerLoadBasedAutoScalingUpscalingInitParameters] @go(Upscaling,[]RailsAppLayerLoadBasedAutoScalingUpscalingInitParameters)
}

#RailsAppLayerLoadBasedAutoScalingObservation: {
	downscaling?: [...#RailsAppLayerLoadBasedAutoScalingDownscalingObservation] @go(Downscaling,[]RailsAppLayerLoadBasedAutoScalingDownscalingObservation)
	enable?: null | bool @go(Enable,*bool)
	upscaling?: [...#RailsAppLayerLoadBasedAutoScalingUpscalingObservation] @go(Upscaling,[]RailsAppLayerLoadBasedAutoScalingUpscalingObservation)
}

#RailsAppLayerLoadBasedAutoScalingParameters: {
	// +kubebuilder:validation:Optional
	downscaling?: [...#RailsAppLayerLoadBasedAutoScalingDownscalingParameters] @go(Downscaling,[]RailsAppLayerLoadBasedAutoScalingDownscalingParameters)

	// +kubebuilder:validation:Optional
	enable?: null | bool @go(Enable,*bool)

	// +kubebuilder:validation:Optional
	upscaling?: [...#RailsAppLayerLoadBasedAutoScalingUpscalingParameters] @go(Upscaling,[]RailsAppLayerLoadBasedAutoScalingUpscalingParameters)
}

#RailsAppLayerLoadBasedAutoScalingUpscalingInitParameters: {
	alarms?: [...null | string] @go(Alarms,[]*string)
	cpuThreshold?:       null | float64 @go(CPUThreshold,*float64)
	ignoreMetricsTime?:  null | float64 @go(IgnoreMetricsTime,*float64)
	instanceCount?:      null | float64 @go(InstanceCount,*float64)
	loadThreshold?:      null | float64 @go(LoadThreshold,*float64)
	memoryThreshold?:    null | float64 @go(MemoryThreshold,*float64)
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#RailsAppLayerLoadBasedAutoScalingUpscalingObservation: {
	alarms?: [...null | string] @go(Alarms,[]*string)
	cpuThreshold?:       null | float64 @go(CPUThreshold,*float64)
	ignoreMetricsTime?:  null | float64 @go(IgnoreMetricsTime,*float64)
	instanceCount?:      null | float64 @go(InstanceCount,*float64)
	loadThreshold?:      null | float64 @go(LoadThreshold,*float64)
	memoryThreshold?:    null | float64 @go(MemoryThreshold,*float64)
	thresholdsWaitTime?: null | float64 @go(ThresholdsWaitTime,*float64)
}

#RailsAppLayerLoadBasedAutoScalingUpscalingParameters: {
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

#RailsAppLayerObservation: {
	// Keyword for the app server to use. Defaults to "apache_passenger".
	appServer?: null | string @go(AppServer,*string)

	// The Amazon Resource Name(ARN) of the layer.
	arn?: null | string @go(Arn,*string)

	// Whether to automatically assign an elastic IP address to the layer's instances.
	autoAssignElasticIps?: null | bool @go(AutoAssignElasticIps,*bool)

	// For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances.
	autoAssignPublicIps?: null | bool @go(AutoAssignPublicIps,*bool)

	// Whether to enable auto-healing for the layer.
	autoHealing?: null | bool @go(AutoHealing,*bool)

	// When OpsWorks is managing Bundler, which version to use. Defaults to "1.5.3".
	bundlerVersion?: null | string @go(BundlerVersion,*string)
	cloudwatchConfiguration?: [...#RailsAppLayerCloudwatchConfigurationObservation] @go(CloudwatchConfiguration,[]RailsAppLayerCloudwatchConfigurationObservation)
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
	ebsVolume?: [...#RailsAppLayerEBSVolumeObservation] @go(EBSVolume,[]RailsAppLayerEBSVolumeObservation)

	// Name of an Elastic Load Balancer to attach to this layer
	elasticLoadBalancer?: null | string @go(ElasticLoadBalancer,*string)

	// The id of the layer.
	id?: null | string @go(ID,*string)

	// Whether to install OS and package updates on each instance when it boots.
	installUpdatesOnBoot?: null | bool @go(InstallUpdatesOnBoot,*bool)

	// The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event.
	instanceShutdownTimeout?: null | float64 @go(InstanceShutdownTimeout,*float64)
	loadBasedAutoScaling?: [...#RailsAppLayerLoadBasedAutoScalingObservation] @go(LoadBasedAutoScaling,[]RailsAppLayerLoadBasedAutoScalingObservation)

	// Whether OpsWorks should manage bundler. On by default.
	manageBundler?: null | bool @go(ManageBundler,*bool)

	// A human-readable name for the layer.
	name?: null | string @go(Name,*string)

	// The version of Passenger to use. Defaults to "4.0.46".
	passengerVersion?: null | string @go(PassengerVersion,*string)

	// The version of Ruby to use. Defaults to "2.0.0".
	rubyVersion?: null | string @go(RubyVersion,*string)

	// The version of RubyGems to use. Defaults to "2.2.2".
	rubygemsVersion?: null | string @go(RubygemsVersion,*string)

	// ID of the stack the layer will belong to.
	stackId?: null | string @go(StackID,*string)

	// Names of a set of system packages to install on the layer's instances.
	systemPackages?: [...null | string] @go(SystemPackages,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Whether to use EBS-optimized instances.
	useEbsOptimizedInstances?: null | bool @go(UseEBSOptimizedInstances,*bool)
}

#RailsAppLayerParameters: {
	// Keyword for the app server to use. Defaults to "apache_passenger".
	// +kubebuilder:validation:Optional
	appServer?: null | string @go(AppServer,*string)

	// Whether to automatically assign an elastic IP address to the layer's instances.
	// +kubebuilder:validation:Optional
	autoAssignElasticIps?: null | bool @go(AutoAssignElasticIps,*bool)

	// For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances.
	// +kubebuilder:validation:Optional
	autoAssignPublicIps?: null | bool @go(AutoAssignPublicIps,*bool)

	// Whether to enable auto-healing for the layer.
	// +kubebuilder:validation:Optional
	autoHealing?: null | bool @go(AutoHealing,*bool)

	// When OpsWorks is managing Bundler, which version to use. Defaults to "1.5.3".
	// +kubebuilder:validation:Optional
	bundlerVersion?: null | string @go(BundlerVersion,*string)

	// +kubebuilder:validation:Optional
	cloudwatchConfiguration?: [...#RailsAppLayerCloudwatchConfigurationParameters] @go(CloudwatchConfiguration,[]RailsAppLayerCloudwatchConfigurationParameters)

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
	ebsVolume?: [...#RailsAppLayerEBSVolumeParameters] @go(EBSVolume,[]RailsAppLayerEBSVolumeParameters)

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
	loadBasedAutoScaling?: [...#RailsAppLayerLoadBasedAutoScalingParameters] @go(LoadBasedAutoScaling,[]RailsAppLayerLoadBasedAutoScalingParameters)

	// Whether OpsWorks should manage bundler. On by default.
	// +kubebuilder:validation:Optional
	manageBundler?: null | bool @go(ManageBundler,*bool)

	// A human-readable name for the layer.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// The version of Passenger to use. Defaults to "4.0.46".
	// +kubebuilder:validation:Optional
	passengerVersion?: null | string @go(PassengerVersion,*string)

	// The version of Ruby to use. Defaults to "2.0.0".
	// +kubebuilder:validation:Optional
	rubyVersion?: null | string @go(RubyVersion,*string)

	// The version of RubyGems to use. Defaults to "2.2.2".
	// +kubebuilder:validation:Optional
	rubygemsVersion?: null | string @go(RubygemsVersion,*string)

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

	// Whether to use EBS-optimized instances.
	// +kubebuilder:validation:Optional
	useEbsOptimizedInstances?: null | bool @go(UseEBSOptimizedInstances,*bool)
}

// RailsAppLayerSpec defines the desired state of RailsAppLayer
#RailsAppLayerSpec: {
	v1.#ResourceSpec
	forProvider: #RailsAppLayerParameters @go(ForProvider)

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
	initProvider?: #RailsAppLayerInitParameters @go(InitProvider)
}

// RailsAppLayerStatus defines the observed state of RailsAppLayer.
#RailsAppLayerStatus: {
	v1.#ResourceStatus
	atProvider?: #RailsAppLayerObservation @go(AtProvider)
}

// RailsAppLayer is the Schema for the RailsAppLayers API. Provides an OpsWorks Ruby on Rails application layer resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#RailsAppLayer: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta   @go(ObjectMeta)
	spec:      #RailsAppLayerSpec   @go(Spec)
	status?:   #RailsAppLayerStatus @go(Status)
}

// RailsAppLayerList contains a list of RailsAppLayers
#RailsAppLayerList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#RailsAppLayer] @go(Items,[]RailsAppLayer)
}
