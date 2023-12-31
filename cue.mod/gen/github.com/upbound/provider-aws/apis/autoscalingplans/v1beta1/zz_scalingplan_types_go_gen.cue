// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/autoscalingplans/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ApplicationSourceInitParameters: {
	// ARN of a AWS CloudFormation stack.
	cloudformationStackArn?: null | string @go(CloudFormationStackArn,*string)

	// Set of tags.
	tagFilter?: [...#TagFilterInitParameters] @go(TagFilter,[]TagFilterInitParameters)
}

#ApplicationSourceObservation: {
	// ARN of a AWS CloudFormation stack.
	cloudformationStackArn?: null | string @go(CloudFormationStackArn,*string)

	// Set of tags.
	tagFilter?: [...#TagFilterObservation] @go(TagFilter,[]TagFilterObservation)
}

#ApplicationSourceParameters: {
	// ARN of a AWS CloudFormation stack.
	// +kubebuilder:validation:Optional
	cloudformationStackArn?: null | string @go(CloudFormationStackArn,*string)

	// Set of tags.
	// +kubebuilder:validation:Optional
	tagFilter?: [...#TagFilterParameters] @go(TagFilter,[]TagFilterParameters)
}

#CustomizedLoadMetricSpecificationInitParameters: {
	// Dimensions of the metric.
	dimensions?: {[string]: null | string} @go(Dimensions,map[string]*string)

	// Name of the metric.
	metricName?: null | string @go(MetricName,*string)

	// Namespace of the metric.
	namespace?: null | string @go(Namespace,*string)

	// Statistic of the metric. Currently, the value must always be Sum.
	statistic?: null | string @go(Statistic,*string)

	// Unit of the metric.
	unit?: null | string @go(Unit,*string)
}

#CustomizedLoadMetricSpecificationObservation: {
	// Dimensions of the metric.
	dimensions?: {[string]: null | string} @go(Dimensions,map[string]*string)

	// Name of the metric.
	metricName?: null | string @go(MetricName,*string)

	// Namespace of the metric.
	namespace?: null | string @go(Namespace,*string)

	// Statistic of the metric. Currently, the value must always be Sum.
	statistic?: null | string @go(Statistic,*string)

	// Unit of the metric.
	unit?: null | string @go(Unit,*string)
}

#CustomizedLoadMetricSpecificationParameters: {
	// Dimensions of the metric.
	// +kubebuilder:validation:Optional
	dimensions?: {[string]: null | string} @go(Dimensions,map[string]*string)

	// Name of the metric.
	// +kubebuilder:validation:Optional
	metricName?: null | string @go(MetricName,*string)

	// Namespace of the metric.
	// +kubebuilder:validation:Optional
	namespace?: null | string @go(Namespace,*string)

	// Statistic of the metric. Currently, the value must always be Sum.
	// +kubebuilder:validation:Optional
	statistic?: null | string @go(Statistic,*string)

	// Unit of the metric.
	// +kubebuilder:validation:Optional
	unit?: null | string @go(Unit,*string)
}

#CustomizedScalingMetricSpecificationInitParameters: {
	// Dimensions of the metric.
	dimensions?: {[string]: null | string} @go(Dimensions,map[string]*string)

	// Name of the metric.
	metricName?: null | string @go(MetricName,*string)

	// Namespace of the metric.
	namespace?: null | string @go(Namespace,*string)

	// Statistic of the metric. Currently, the value must always be Sum.
	statistic?: null | string @go(Statistic,*string)

	// Unit of the metric.
	unit?: null | string @go(Unit,*string)
}

#CustomizedScalingMetricSpecificationObservation: {
	// Dimensions of the metric.
	dimensions?: {[string]: null | string} @go(Dimensions,map[string]*string)

	// Name of the metric.
	metricName?: null | string @go(MetricName,*string)

	// Namespace of the metric.
	namespace?: null | string @go(Namespace,*string)

	// Statistic of the metric. Currently, the value must always be Sum.
	statistic?: null | string @go(Statistic,*string)

	// Unit of the metric.
	unit?: null | string @go(Unit,*string)
}

#CustomizedScalingMetricSpecificationParameters: {
	// Dimensions of the metric.
	// +kubebuilder:validation:Optional
	dimensions?: {[string]: null | string} @go(Dimensions,map[string]*string)

	// Name of the metric.
	// +kubebuilder:validation:Optional
	metricName?: null | string @go(MetricName,*string)

	// Namespace of the metric.
	// +kubebuilder:validation:Optional
	namespace?: null | string @go(Namespace,*string)

	// Statistic of the metric. Currently, the value must always be Sum.
	// +kubebuilder:validation:Optional
	statistic?: null | string @go(Statistic,*string)

	// Unit of the metric.
	// +kubebuilder:validation:Optional
	unit?: null | string @go(Unit,*string)
}

#PredefinedLoadMetricSpecificationInitParameters: {
	// Metric type. Valid values: ALBTargetGroupRequestCount, ASGTotalCPUUtilization, ASGTotalNetworkIn, ASGTotalNetworkOut.
	predefinedLoadMetricType?: null | string @go(PredefinedLoadMetricType,*string)

	// Identifies the resource associated with the metric type.
	resourceLabel?: null | string @go(ResourceLabel,*string)
}

#PredefinedLoadMetricSpecificationObservation: {
	// Metric type. Valid values: ALBTargetGroupRequestCount, ASGTotalCPUUtilization, ASGTotalNetworkIn, ASGTotalNetworkOut.
	predefinedLoadMetricType?: null | string @go(PredefinedLoadMetricType,*string)

	// Identifies the resource associated with the metric type.
	resourceLabel?: null | string @go(ResourceLabel,*string)
}

#PredefinedLoadMetricSpecificationParameters: {
	// Metric type. Valid values: ALBTargetGroupRequestCount, ASGTotalCPUUtilization, ASGTotalNetworkIn, ASGTotalNetworkOut.
	// +kubebuilder:validation:Optional
	predefinedLoadMetricType?: null | string @go(PredefinedLoadMetricType,*string)

	// Identifies the resource associated with the metric type.
	// +kubebuilder:validation:Optional
	resourceLabel?: null | string @go(ResourceLabel,*string)
}

#PredefinedScalingMetricSpecificationInitParameters: {
	// Metric type. Valid values: ALBRequestCountPerTarget, ASGAverageCPUUtilization, ASGAverageNetworkIn, ASGAverageNetworkOut, DynamoDBReadCapacityUtilization, DynamoDBWriteCapacityUtilization, ECSServiceAverageCPUUtilization, ECSServiceAverageMemoryUtilization, EC2SpotFleetRequestAverageCPUUtilization, EC2SpotFleetRequestAverageNetworkIn, EC2SpotFleetRequestAverageNetworkOut, RDSReaderAverageCPUUtilization, RDSReaderAverageDatabaseConnections.
	predefinedScalingMetricType?: null | string @go(PredefinedScalingMetricType,*string)

	// Identifies the resource associated with the metric type.
	resourceLabel?: null | string @go(ResourceLabel,*string)
}

#PredefinedScalingMetricSpecificationObservation: {
	// Metric type. Valid values: ALBRequestCountPerTarget, ASGAverageCPUUtilization, ASGAverageNetworkIn, ASGAverageNetworkOut, DynamoDBReadCapacityUtilization, DynamoDBWriteCapacityUtilization, ECSServiceAverageCPUUtilization, ECSServiceAverageMemoryUtilization, EC2SpotFleetRequestAverageCPUUtilization, EC2SpotFleetRequestAverageNetworkIn, EC2SpotFleetRequestAverageNetworkOut, RDSReaderAverageCPUUtilization, RDSReaderAverageDatabaseConnections.
	predefinedScalingMetricType?: null | string @go(PredefinedScalingMetricType,*string)

	// Identifies the resource associated with the metric type.
	resourceLabel?: null | string @go(ResourceLabel,*string)
}

#PredefinedScalingMetricSpecificationParameters: {
	// Metric type. Valid values: ALBRequestCountPerTarget, ASGAverageCPUUtilization, ASGAverageNetworkIn, ASGAverageNetworkOut, DynamoDBReadCapacityUtilization, DynamoDBWriteCapacityUtilization, ECSServiceAverageCPUUtilization, ECSServiceAverageMemoryUtilization, EC2SpotFleetRequestAverageCPUUtilization, EC2SpotFleetRequestAverageNetworkIn, EC2SpotFleetRequestAverageNetworkOut, RDSReaderAverageCPUUtilization, RDSReaderAverageDatabaseConnections.
	// +kubebuilder:validation:Optional
	predefinedScalingMetricType?: null | string @go(PredefinedScalingMetricType,*string)

	// Identifies the resource associated with the metric type.
	// +kubebuilder:validation:Optional
	resourceLabel?: null | string @go(ResourceLabel,*string)
}

#ScalingInstructionInitParameters: {
	// Customized load metric to use for predictive scaling. You must specify either customized_load_metric_specification or predefined_load_metric_specification when configuring predictive scaling.
	// More details can be found in the AWS Auto Scaling API Reference.
	customizedLoadMetricSpecification?: [...#CustomizedLoadMetricSpecificationInitParameters] @go(CustomizedLoadMetricSpecification,[]CustomizedLoadMetricSpecificationInitParameters)

	// Boolean controlling whether dynamic scaling by AWS Auto Scaling is disabled. Defaults to false.
	disableDynamicScaling?: null | bool @go(DisableDynamicScaling,*bool)

	// Maximum capacity of the resource. The exception to this upper limit is if you specify a non-default setting for predictive_scaling_max_capacity_behavior.
	maxCapacity?: null | float64 @go(MaxCapacity,*float64)

	// Minimum capacity of the resource.
	minCapacity?: null | float64 @go(MinCapacity,*float64)

	// Predefined load metric to use for predictive scaling. You must specify either predefined_load_metric_specification or customized_load_metric_specification when configuring predictive scaling.
	// More details can be found in the AWS Auto Scaling API Reference.
	predefinedLoadMetricSpecification?: [...#PredefinedLoadMetricSpecificationInitParameters] @go(PredefinedLoadMetricSpecification,[]PredefinedLoadMetricSpecificationInitParameters)

	// Defines the behavior that should be applied if the forecast capacity approaches or exceeds the maximum capacity specified for the resource.
	// Valid values: SetForecastCapacityToMaxCapacity, SetMaxCapacityAboveForecastCapacity, SetMaxCapacityToForecastCapacity.
	predictiveScalingMaxCapacityBehavior?: null | string @go(PredictiveScalingMaxCapacityBehavior,*string)

	// Size of the capacity buffer to use when the forecast capacity is close to or exceeds the maximum capacity.
	predictiveScalingMaxCapacityBuffer?: null | float64 @go(PredictiveScalingMaxCapacityBuffer,*float64)

	// Predictive scaling mode. Valid values: ForecastAndScale, ForecastOnly.
	predictiveScalingMode?: null | string @go(PredictiveScalingMode,*string)

	// ID of the resource. This string consists of the resource type and unique identifier.
	resourceId?: null | string @go(ResourceID,*string)

	// Scalable dimension associated with the resource. Valid values: autoscaling:autoScalingGroup:DesiredCapacity, dynamodb:index:ReadCapacityUnits, dynamodb:index:WriteCapacityUnits, dynamodb:table:ReadCapacityUnits, dynamodb:table:WriteCapacityUnits, ecs:service:DesiredCount, ec2:spot-fleet-request:TargetCapacity, rds:cluster:ReadReplicaCount.
	scalableDimension?: null | string @go(ScalableDimension,*string)

	// Controls whether a resource's externally created scaling policies are kept or replaced. Valid values: KeepExternalPolicies, ReplaceExternalPolicies. Defaults to KeepExternalPolicies.
	scalingPolicyUpdateBehavior?: null | string @go(ScalingPolicyUpdateBehavior,*string)

	// Amount of time, in seconds, to buffer the run time of scheduled scaling actions when scaling out.
	scheduledActionBufferTime?: null | float64 @go(ScheduledActionBufferTime,*float64)

	// Namespace of the AWS service. Valid values: autoscaling, dynamodb, ecs, ec2, rds.
	serviceNamespace?: null | string @go(ServiceNamespace,*string)

	// Structure that defines new target tracking configurations. Each of these structures includes a specific scaling metric and a target value for the metric, along with various parameters to use with dynamic scaling.
	// More details can be found in the AWS Auto Scaling API Reference.
	targetTrackingConfiguration?: [...#TargetTrackingConfigurationInitParameters] @go(TargetTrackingConfiguration,[]TargetTrackingConfigurationInitParameters)
}

#ScalingInstructionObservation: {
	// Customized load metric to use for predictive scaling. You must specify either customized_load_metric_specification or predefined_load_metric_specification when configuring predictive scaling.
	// More details can be found in the AWS Auto Scaling API Reference.
	customizedLoadMetricSpecification?: [...#CustomizedLoadMetricSpecificationObservation] @go(CustomizedLoadMetricSpecification,[]CustomizedLoadMetricSpecificationObservation)

	// Boolean controlling whether dynamic scaling by AWS Auto Scaling is disabled. Defaults to false.
	disableDynamicScaling?: null | bool @go(DisableDynamicScaling,*bool)

	// Maximum capacity of the resource. The exception to this upper limit is if you specify a non-default setting for predictive_scaling_max_capacity_behavior.
	maxCapacity?: null | float64 @go(MaxCapacity,*float64)

	// Minimum capacity of the resource.
	minCapacity?: null | float64 @go(MinCapacity,*float64)

	// Predefined load metric to use for predictive scaling. You must specify either predefined_load_metric_specification or customized_load_metric_specification when configuring predictive scaling.
	// More details can be found in the AWS Auto Scaling API Reference.
	predefinedLoadMetricSpecification?: [...#PredefinedLoadMetricSpecificationObservation] @go(PredefinedLoadMetricSpecification,[]PredefinedLoadMetricSpecificationObservation)

	// Defines the behavior that should be applied if the forecast capacity approaches or exceeds the maximum capacity specified for the resource.
	// Valid values: SetForecastCapacityToMaxCapacity, SetMaxCapacityAboveForecastCapacity, SetMaxCapacityToForecastCapacity.
	predictiveScalingMaxCapacityBehavior?: null | string @go(PredictiveScalingMaxCapacityBehavior,*string)

	// Size of the capacity buffer to use when the forecast capacity is close to or exceeds the maximum capacity.
	predictiveScalingMaxCapacityBuffer?: null | float64 @go(PredictiveScalingMaxCapacityBuffer,*float64)

	// Predictive scaling mode. Valid values: ForecastAndScale, ForecastOnly.
	predictiveScalingMode?: null | string @go(PredictiveScalingMode,*string)

	// ID of the resource. This string consists of the resource type and unique identifier.
	resourceId?: null | string @go(ResourceID,*string)

	// Scalable dimension associated with the resource. Valid values: autoscaling:autoScalingGroup:DesiredCapacity, dynamodb:index:ReadCapacityUnits, dynamodb:index:WriteCapacityUnits, dynamodb:table:ReadCapacityUnits, dynamodb:table:WriteCapacityUnits, ecs:service:DesiredCount, ec2:spot-fleet-request:TargetCapacity, rds:cluster:ReadReplicaCount.
	scalableDimension?: null | string @go(ScalableDimension,*string)

	// Controls whether a resource's externally created scaling policies are kept or replaced. Valid values: KeepExternalPolicies, ReplaceExternalPolicies. Defaults to KeepExternalPolicies.
	scalingPolicyUpdateBehavior?: null | string @go(ScalingPolicyUpdateBehavior,*string)

	// Amount of time, in seconds, to buffer the run time of scheduled scaling actions when scaling out.
	scheduledActionBufferTime?: null | float64 @go(ScheduledActionBufferTime,*float64)

	// Namespace of the AWS service. Valid values: autoscaling, dynamodb, ecs, ec2, rds.
	serviceNamespace?: null | string @go(ServiceNamespace,*string)

	// Structure that defines new target tracking configurations. Each of these structures includes a specific scaling metric and a target value for the metric, along with various parameters to use with dynamic scaling.
	// More details can be found in the AWS Auto Scaling API Reference.
	targetTrackingConfiguration?: [...#TargetTrackingConfigurationObservation] @go(TargetTrackingConfiguration,[]TargetTrackingConfigurationObservation)
}

#ScalingInstructionParameters: {
	// Customized load metric to use for predictive scaling. You must specify either customized_load_metric_specification or predefined_load_metric_specification when configuring predictive scaling.
	// More details can be found in the AWS Auto Scaling API Reference.
	// +kubebuilder:validation:Optional
	customizedLoadMetricSpecification?: [...#CustomizedLoadMetricSpecificationParameters] @go(CustomizedLoadMetricSpecification,[]CustomizedLoadMetricSpecificationParameters)

	// Boolean controlling whether dynamic scaling by AWS Auto Scaling is disabled. Defaults to false.
	// +kubebuilder:validation:Optional
	disableDynamicScaling?: null | bool @go(DisableDynamicScaling,*bool)

	// Maximum capacity of the resource. The exception to this upper limit is if you specify a non-default setting for predictive_scaling_max_capacity_behavior.
	// +kubebuilder:validation:Optional
	maxCapacity?: null | float64 @go(MaxCapacity,*float64)

	// Minimum capacity of the resource.
	// +kubebuilder:validation:Optional
	minCapacity?: null | float64 @go(MinCapacity,*float64)

	// Predefined load metric to use for predictive scaling. You must specify either predefined_load_metric_specification or customized_load_metric_specification when configuring predictive scaling.
	// More details can be found in the AWS Auto Scaling API Reference.
	// +kubebuilder:validation:Optional
	predefinedLoadMetricSpecification?: [...#PredefinedLoadMetricSpecificationParameters] @go(PredefinedLoadMetricSpecification,[]PredefinedLoadMetricSpecificationParameters)

	// Defines the behavior that should be applied if the forecast capacity approaches or exceeds the maximum capacity specified for the resource.
	// Valid values: SetForecastCapacityToMaxCapacity, SetMaxCapacityAboveForecastCapacity, SetMaxCapacityToForecastCapacity.
	// +kubebuilder:validation:Optional
	predictiveScalingMaxCapacityBehavior?: null | string @go(PredictiveScalingMaxCapacityBehavior,*string)

	// Size of the capacity buffer to use when the forecast capacity is close to or exceeds the maximum capacity.
	// +kubebuilder:validation:Optional
	predictiveScalingMaxCapacityBuffer?: null | float64 @go(PredictiveScalingMaxCapacityBuffer,*float64)

	// Predictive scaling mode. Valid values: ForecastAndScale, ForecastOnly.
	// +kubebuilder:validation:Optional
	predictiveScalingMode?: null | string @go(PredictiveScalingMode,*string)

	// ID of the resource. This string consists of the resource type and unique identifier.
	// +kubebuilder:validation:Optional
	resourceId?: null | string @go(ResourceID,*string)

	// Scalable dimension associated with the resource. Valid values: autoscaling:autoScalingGroup:DesiredCapacity, dynamodb:index:ReadCapacityUnits, dynamodb:index:WriteCapacityUnits, dynamodb:table:ReadCapacityUnits, dynamodb:table:WriteCapacityUnits, ecs:service:DesiredCount, ec2:spot-fleet-request:TargetCapacity, rds:cluster:ReadReplicaCount.
	// +kubebuilder:validation:Optional
	scalableDimension?: null | string @go(ScalableDimension,*string)

	// Controls whether a resource's externally created scaling policies are kept or replaced. Valid values: KeepExternalPolicies, ReplaceExternalPolicies. Defaults to KeepExternalPolicies.
	// +kubebuilder:validation:Optional
	scalingPolicyUpdateBehavior?: null | string @go(ScalingPolicyUpdateBehavior,*string)

	// Amount of time, in seconds, to buffer the run time of scheduled scaling actions when scaling out.
	// +kubebuilder:validation:Optional
	scheduledActionBufferTime?: null | float64 @go(ScheduledActionBufferTime,*float64)

	// Namespace of the AWS service. Valid values: autoscaling, dynamodb, ecs, ec2, rds.
	// +kubebuilder:validation:Optional
	serviceNamespace?: null | string @go(ServiceNamespace,*string)

	// Structure that defines new target tracking configurations. Each of these structures includes a specific scaling metric and a target value for the metric, along with various parameters to use with dynamic scaling.
	// More details can be found in the AWS Auto Scaling API Reference.
	// +kubebuilder:validation:Optional
	targetTrackingConfiguration: [...#TargetTrackingConfigurationParameters] @go(TargetTrackingConfiguration,[]TargetTrackingConfigurationParameters)
}

#ScalingPlanInitParameters: {
	// CloudFormation stack or set of tags. You can create one scaling plan per application source.
	applicationSource?: [...#ApplicationSourceInitParameters] @go(ApplicationSource,[]ApplicationSourceInitParameters)

	// Name of the scaling plan. Names cannot contain vertical bars, colons, or forward slashes.
	name?: null | string @go(Name,*string)

	// Scaling instructions. More details can be found in the AWS Auto Scaling API Reference.
	scalingInstruction?: [...#ScalingInstructionInitParameters] @go(ScalingInstruction,[]ScalingInstructionInitParameters)
}

#ScalingPlanObservation: {
	// CloudFormation stack or set of tags. You can create one scaling plan per application source.
	applicationSource?: [...#ApplicationSourceObservation] @go(ApplicationSource,[]ApplicationSourceObservation)

	// Scaling plan identifier.
	id?: null | string @go(ID,*string)

	// Name of the scaling plan. Names cannot contain vertical bars, colons, or forward slashes.
	name?: null | string @go(Name,*string)

	// Scaling instructions. More details can be found in the AWS Auto Scaling API Reference.
	scalingInstruction?: [...#ScalingInstructionObservation] @go(ScalingInstruction,[]ScalingInstructionObservation)

	// The version number of the scaling plan. This value is always 1.
	scalingPlanVersion?: null | float64 @go(ScalingPlanVersion,*float64)
}

#ScalingPlanParameters: {
	// CloudFormation stack or set of tags. You can create one scaling plan per application source.
	// +kubebuilder:validation:Optional
	applicationSource?: [...#ApplicationSourceParameters] @go(ApplicationSource,[]ApplicationSourceParameters)

	// Name of the scaling plan. Names cannot contain vertical bars, colons, or forward slashes.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Scaling instructions. More details can be found in the AWS Auto Scaling API Reference.
	// +kubebuilder:validation:Optional
	scalingInstruction?: [...#ScalingInstructionParameters] @go(ScalingInstruction,[]ScalingInstructionParameters)
}

#TagFilterInitParameters: {
	// Tag key.
	key?: null | string @go(Key,*string)

	// Tag values.
	values?: [...null | string] @go(Values,[]*string)
}

#TagFilterObservation: {
	// Tag key.
	key?: null | string @go(Key,*string)

	// Tag values.
	values?: [...null | string] @go(Values,[]*string)
}

#TagFilterParameters: {
	// Tag key.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// Tag values.
	// +kubebuilder:validation:Optional
	values?: [...null | string] @go(Values,[]*string)
}

#TargetTrackingConfigurationInitParameters: {
	// Customized metric. You can specify either customized_scaling_metric_specification or predefined_scaling_metric_specification.
	// More details can be found in the AWS Auto Scaling API Reference.
	customizedScalingMetricSpecification?: [...#CustomizedScalingMetricSpecificationInitParameters] @go(CustomizedScalingMetricSpecification,[]CustomizedScalingMetricSpecificationInitParameters)

	// Boolean indicating whether scale in by the target tracking scaling policy is disabled. Defaults to false.
	disableScaleIn?: null | bool @go(DisableScaleIn,*bool)

	// Estimated time, in seconds, until a newly launched instance can contribute to the CloudWatch metrics.
	// This value is used only if the resource is an Auto Scaling group.
	estimatedInstanceWarmup?: null | float64 @go(EstimatedInstanceWarmup,*float64)

	// Predefined metric. You can specify either predefined_scaling_metric_specification or customized_scaling_metric_specification.
	// More details can be found in the AWS Auto Scaling API Reference.
	predefinedScalingMetricSpecification?: [...#PredefinedScalingMetricSpecificationInitParameters] @go(PredefinedScalingMetricSpecification,[]PredefinedScalingMetricSpecificationInitParameters)

	// Amount of time, in seconds, after a scale in activity completes before another scale in activity can start.
	// This value is not used if the scalable resource is an Auto Scaling group.
	scaleInCooldown?: null | float64 @go(ScaleInCooldown,*float64)

	// Amount of time, in seconds, after a scale-out activity completes before another scale-out activity can start.
	// This value is not used if the scalable resource is an Auto Scaling group.
	scaleOutCooldown?: null | float64 @go(ScaleOutCooldown,*float64)

	// Target value for the metric.
	targetValue?: null | float64 @go(TargetValue,*float64)
}

#TargetTrackingConfigurationObservation: {
	// Customized metric. You can specify either customized_scaling_metric_specification or predefined_scaling_metric_specification.
	// More details can be found in the AWS Auto Scaling API Reference.
	customizedScalingMetricSpecification?: [...#CustomizedScalingMetricSpecificationObservation] @go(CustomizedScalingMetricSpecification,[]CustomizedScalingMetricSpecificationObservation)

	// Boolean indicating whether scale in by the target tracking scaling policy is disabled. Defaults to false.
	disableScaleIn?: null | bool @go(DisableScaleIn,*bool)

	// Estimated time, in seconds, until a newly launched instance can contribute to the CloudWatch metrics.
	// This value is used only if the resource is an Auto Scaling group.
	estimatedInstanceWarmup?: null | float64 @go(EstimatedInstanceWarmup,*float64)

	// Predefined metric. You can specify either predefined_scaling_metric_specification or customized_scaling_metric_specification.
	// More details can be found in the AWS Auto Scaling API Reference.
	predefinedScalingMetricSpecification?: [...#PredefinedScalingMetricSpecificationObservation] @go(PredefinedScalingMetricSpecification,[]PredefinedScalingMetricSpecificationObservation)

	// Amount of time, in seconds, after a scale in activity completes before another scale in activity can start.
	// This value is not used if the scalable resource is an Auto Scaling group.
	scaleInCooldown?: null | float64 @go(ScaleInCooldown,*float64)

	// Amount of time, in seconds, after a scale-out activity completes before another scale-out activity can start.
	// This value is not used if the scalable resource is an Auto Scaling group.
	scaleOutCooldown?: null | float64 @go(ScaleOutCooldown,*float64)

	// Target value for the metric.
	targetValue?: null | float64 @go(TargetValue,*float64)
}

#TargetTrackingConfigurationParameters: {
	// Customized metric. You can specify either customized_scaling_metric_specification or predefined_scaling_metric_specification.
	// More details can be found in the AWS Auto Scaling API Reference.
	// +kubebuilder:validation:Optional
	customizedScalingMetricSpecification?: [...#CustomizedScalingMetricSpecificationParameters] @go(CustomizedScalingMetricSpecification,[]CustomizedScalingMetricSpecificationParameters)

	// Boolean indicating whether scale in by the target tracking scaling policy is disabled. Defaults to false.
	// +kubebuilder:validation:Optional
	disableScaleIn?: null | bool @go(DisableScaleIn,*bool)

	// Estimated time, in seconds, until a newly launched instance can contribute to the CloudWatch metrics.
	// This value is used only if the resource is an Auto Scaling group.
	// +kubebuilder:validation:Optional
	estimatedInstanceWarmup?: null | float64 @go(EstimatedInstanceWarmup,*float64)

	// Predefined metric. You can specify either predefined_scaling_metric_specification or customized_scaling_metric_specification.
	// More details can be found in the AWS Auto Scaling API Reference.
	// +kubebuilder:validation:Optional
	predefinedScalingMetricSpecification?: [...#PredefinedScalingMetricSpecificationParameters] @go(PredefinedScalingMetricSpecification,[]PredefinedScalingMetricSpecificationParameters)

	// Amount of time, in seconds, after a scale in activity completes before another scale in activity can start.
	// This value is not used if the scalable resource is an Auto Scaling group.
	// +kubebuilder:validation:Optional
	scaleInCooldown?: null | float64 @go(ScaleInCooldown,*float64)

	// Amount of time, in seconds, after a scale-out activity completes before another scale-out activity can start.
	// This value is not used if the scalable resource is an Auto Scaling group.
	// +kubebuilder:validation:Optional
	scaleOutCooldown?: null | float64 @go(ScaleOutCooldown,*float64)

	// Target value for the metric.
	// +kubebuilder:validation:Optional
	targetValue?: null | float64 @go(TargetValue,*float64)
}

// ScalingPlanSpec defines the desired state of ScalingPlan
#ScalingPlanSpec: {
	v1.#ResourceSpec
	forProvider: #ScalingPlanParameters @go(ForProvider)

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
	initProvider?: #ScalingPlanInitParameters @go(InitProvider)
}

// ScalingPlanStatus defines the observed state of ScalingPlan.
#ScalingPlanStatus: {
	v1.#ResourceStatus
	atProvider?: #ScalingPlanObservation @go(AtProvider)
}

// ScalingPlan is the Schema for the ScalingPlans API. Manages an AWS Auto Scaling scaling plan.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ScalingPlan: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.applicationSource) || (has(self.initProvider) && has(self.initProvider.applicationSource))",message="spec.forProvider.applicationSource is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.scalingInstruction) || (has(self.initProvider) && has(self.initProvider.scalingInstruction))",message="spec.forProvider.scalingInstruction is a required parameter"
	spec:    #ScalingPlanSpec   @go(Spec)
	status?: #ScalingPlanStatus @go(Status)
}

// ScalingPlanList contains a list of ScalingPlans
#ScalingPlanList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ScalingPlan] @go(Items,[]ScalingPlan)
}
