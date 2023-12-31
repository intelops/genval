// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/rds/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ClusterInstanceInitParameters: {
	// Specifies whether any database modifications
	// are applied immediately, or during the next maintenance window. Default isfalse.
	applyImmediately?: null | bool @go(ApplyImmediately,*bool)

	// Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default true.
	autoMinorVersionUpgrade?: null | bool @go(AutoMinorVersionUpgrade,*bool)

	// The EC2 Availability Zone that the DB instance is created in. See docs about the details.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// The identifier of the CA certificate for the DB instance.
	caCertIdentifier?: null | string @go(CACertIdentifier,*string)

	// defined tags from the DB instance to snapshots of the DB instance. Default false.
	copyTagsToSnapshot?: null | bool @go(CopyTagsToSnapshot,*bool)

	// The name of the DB parameter group to associate with this instance.
	dbParameterGroupName?: null | string @go(DBParameterGroupName,*string)

	// The name of the database engine to be used for the RDS instance. Defaults to aurora. Valid Values: aurora, aurora-mysql, aurora-postgresql.
	// For information on the difference between the available Aurora MySQL engines
	// see Comparison between Aurora MySQL 1 and Aurora MySQL 2
	// in the Amazon RDS User Guide.
	engine?: null | string @go(Engine,*string)

	// The database engine version.
	engineVersion?: null | string @go(EngineVersion,*string)

	// The instance class to use. For details on CPU
	// and memory, see Scaling Aurora DB Instances. Aurora uses db.* instance classes/types. Please see AWS Documentation for currently available instance classes and complete details.
	instanceClass?: null | string @go(InstanceClass,*string)

	// The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60.
	monitoringInterval?: null | float64 @go(MonitoringInterval,*float64)

	// Specifies whether Performance Insights is enabled or not.
	performanceInsightsEnabled?: null | bool @go(PerformanceInsightsEnabled,*bool)

	// Amount of time in days to retain Performance Insights data. Valid values are 7, 731 (2 years) or a multiple of 31. When specifying performance_insights_retention_period, performance_insights_enabled needs to be set to true. Defaults to '7'.
	performanceInsightsRetentionPeriod?: null | float64 @go(PerformanceInsightsRetentionPeriod,*float64)

	// The daily time range during which automated backups are created if automated backups are enabled. Eg: "04:00-09:00". NOTE: If preferred_backup_window is set at the cluster level, this argument must be omitted.
	preferredBackupWindow?: null | string @go(PreferredBackupWindow,*string)

	// The window to perform maintenance in.
	// Syntax: "ddd:hh24:mi-ddd:hh24:mi". Eg: "Mon:00:00-Mon:03:00".
	preferredMaintenanceWindow?: null | string @go(PreferredMaintenanceWindow,*string)

	// Default 0. Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer.
	promotionTier?: null | float64 @go(PromotionTier,*float64)

	// Bool to control if instance is publicly accessible.
	// Default false. See the documentation on Creating DB Instances for more
	// details on controlling this property.
	publiclyAccessible?: null | bool @go(PubliclyAccessible,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#ClusterInstanceObservation: {
	// Specifies whether any database modifications
	// are applied immediately, or during the next maintenance window. Default isfalse.
	applyImmediately?: null | bool @go(ApplyImmediately,*bool)

	// Amazon Resource Name (ARN) of cluster instance
	arn?: null | string @go(Arn,*string)

	// Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default true.
	autoMinorVersionUpgrade?: null | bool @go(AutoMinorVersionUpgrade,*bool)

	// The EC2 Availability Zone that the DB instance is created in. See docs about the details.
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// The identifier of the CA certificate for the DB instance.
	caCertIdentifier?: null | string @go(CACertIdentifier,*string)

	// The identifier of the aws_rds_cluster in which to launch this instance.
	clusterIdentifier?: null | string @go(ClusterIdentifier,*string)

	// defined tags from the DB instance to snapshots of the DB instance. Default false.
	copyTagsToSnapshot?: null | bool @go(CopyTagsToSnapshot,*bool)

	// The name of the DB parameter group to associate with this instance.
	dbParameterGroupName?: null | string @go(DBParameterGroupName,*string)

	// A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name of the attached aws_rds_cluster.
	dbSubnetGroupName?: null | string @go(DBSubnetGroupName,*string)

	// The region-unique, immutable identifier for the DB instance.
	dbiResourceId?: null | string @go(DbiResourceID,*string)

	// The DNS address for this instance. May not be writable
	endpoint?: null | string @go(Endpoint,*string)

	// The name of the database engine to be used for the RDS instance. Defaults to aurora. Valid Values: aurora, aurora-mysql, aurora-postgresql.
	// For information on the difference between the available Aurora MySQL engines
	// see Comparison between Aurora MySQL 1 and Aurora MySQL 2
	// in the Amazon RDS User Guide.
	engine?: null | string @go(Engine,*string)

	// The database engine version.
	engineVersion?: null | string @go(EngineVersion,*string)

	// The database engine version
	engineVersionActual?: null | string @go(EngineVersionActual,*string)

	// The Instance identifier
	id?: null | string @go(ID,*string)

	// The instance class to use. For details on CPU
	// and memory, see Scaling Aurora DB Instances. Aurora uses db.* instance classes/types. Please see AWS Documentation for currently available instance classes and complete details.
	instanceClass?: null | string @go(InstanceClass,*string)

	// The ARN for the KMS encryption key if one is set to the cluster.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60.
	monitoringInterval?: null | float64 @go(MonitoringInterval,*float64)

	// The ARN for the IAM role that permits RDS to send
	// enhanced monitoring metrics to CloudWatch Logs. You can find more information on the AWS Documentation
	// what IAM permissions are needed to allow Enhanced Monitoring for RDS Instances.
	monitoringRoleArn?: null | string @go(MonitoringRoleArn,*string)

	// The network type of the DB instance.
	networkType?: null | string @go(NetworkType,*string)

	// Specifies whether Performance Insights is enabled or not.
	performanceInsightsEnabled?: null | bool @go(PerformanceInsightsEnabled,*bool)

	// ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true.
	performanceInsightsKmsKeyId?: null | string @go(PerformanceInsightsKMSKeyID,*string)

	// Amount of time in days to retain Performance Insights data. Valid values are 7, 731 (2 years) or a multiple of 31. When specifying performance_insights_retention_period, performance_insights_enabled needs to be set to true. Defaults to '7'.
	performanceInsightsRetentionPeriod?: null | float64 @go(PerformanceInsightsRetentionPeriod,*float64)

	// The database port
	port?: null | float64 @go(Port,*float64)

	// The daily time range during which automated backups are created if automated backups are enabled. Eg: "04:00-09:00". NOTE: If preferred_backup_window is set at the cluster level, this argument must be omitted.
	preferredBackupWindow?: null | string @go(PreferredBackupWindow,*string)

	// The window to perform maintenance in.
	// Syntax: "ddd:hh24:mi-ddd:hh24:mi". Eg: "Mon:00:00-Mon:03:00".
	preferredMaintenanceWindow?: null | string @go(PreferredMaintenanceWindow,*string)

	// Default 0. Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer.
	promotionTier?: null | float64 @go(PromotionTier,*float64)

	// Bool to control if instance is publicly accessible.
	// Default false. See the documentation on Creating DB Instances for more
	// details on controlling this property.
	publiclyAccessible?: null | bool @go(PubliclyAccessible,*bool)

	// Specifies whether the DB cluster is encrypted.
	storageEncrypted?: null | bool @go(StorageEncrypted,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// – Boolean indicating if this instance is writable. False indicates this instance is a read replica.
	writer?: null | bool @go(Writer,*bool)
}

#ClusterInstanceParameters: {
	// Specifies whether any database modifications
	// are applied immediately, or during the next maintenance window. Default isfalse.
	// +kubebuilder:validation:Optional
	applyImmediately?: null | bool @go(ApplyImmediately,*bool)

	// Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default true.
	// +kubebuilder:validation:Optional
	autoMinorVersionUpgrade?: null | bool @go(AutoMinorVersionUpgrade,*bool)

	// The EC2 Availability Zone that the DB instance is created in. See docs about the details.
	// +kubebuilder:validation:Optional
	availabilityZone?: null | string @go(AvailabilityZone,*string)

	// The identifier of the CA certificate for the DB instance.
	// +kubebuilder:validation:Optional
	caCertIdentifier?: null | string @go(CACertIdentifier,*string)

	// The identifier of the aws_rds_cluster in which to launch this instance.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/rds/v1beta1.Cluster
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	clusterIdentifier?: null | string @go(ClusterIdentifier,*string)

	// Reference to a Cluster in rds to populate clusterIdentifier.
	// +kubebuilder:validation:Optional
	clusterIdentifierRef?: null | v1.#Reference @go(ClusterIdentifierRef,*v1.Reference)

	// Selector for a Cluster in rds to populate clusterIdentifier.
	// +kubebuilder:validation:Optional
	clusterIdentifierSelector?: null | v1.#Selector @go(ClusterIdentifierSelector,*v1.Selector)

	// defined tags from the DB instance to snapshots of the DB instance. Default false.
	// +kubebuilder:validation:Optional
	copyTagsToSnapshot?: null | bool @go(CopyTagsToSnapshot,*bool)

	// The name of the DB parameter group to associate with this instance.
	// +kubebuilder:validation:Optional
	dbParameterGroupName?: null | string @go(DBParameterGroupName,*string)

	// A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name of the attached aws_rds_cluster.
	// +crossplane:generate:reference:type=SubnetGroup
	// +kubebuilder:validation:Optional
	dbSubnetGroupName?: null | string @go(DBSubnetGroupName,*string)

	// Reference to a SubnetGroup to populate dbSubnetGroupName.
	// +kubebuilder:validation:Optional
	dbSubnetGroupNameRef?: null | v1.#Reference @go(DBSubnetGroupNameRef,*v1.Reference)

	// Selector for a SubnetGroup to populate dbSubnetGroupName.
	// +kubebuilder:validation:Optional
	dbSubnetGroupNameSelector?: null | v1.#Selector @go(DBSubnetGroupNameSelector,*v1.Selector)

	// The name of the database engine to be used for the RDS instance. Defaults to aurora. Valid Values: aurora, aurora-mysql, aurora-postgresql.
	// For information on the difference between the available Aurora MySQL engines
	// see Comparison between Aurora MySQL 1 and Aurora MySQL 2
	// in the Amazon RDS User Guide.
	// +kubebuilder:validation:Optional
	engine?: null | string @go(Engine,*string)

	// The database engine version.
	// +kubebuilder:validation:Optional
	engineVersion?: null | string @go(EngineVersion,*string)

	// The instance class to use. For details on CPU
	// and memory, see Scaling Aurora DB Instances. Aurora uses db.* instance classes/types. Please see AWS Documentation for currently available instance classes and complete details.
	// +kubebuilder:validation:Optional
	instanceClass?: null | string @go(InstanceClass,*string)

	// The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60.
	// +kubebuilder:validation:Optional
	monitoringInterval?: null | float64 @go(MonitoringInterval,*float64)

	// The ARN for the IAM role that permits RDS to send
	// enhanced monitoring metrics to CloudWatch Logs. You can find more information on the AWS Documentation
	// what IAM permissions are needed to allow Enhanced Monitoring for RDS Instances.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	monitoringRoleArn?: null | string @go(MonitoringRoleArn,*string)

	// Reference to a Role in iam to populate monitoringRoleArn.
	// +kubebuilder:validation:Optional
	monitoringRoleArnRef?: null | v1.#Reference @go(MonitoringRoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate monitoringRoleArn.
	// +kubebuilder:validation:Optional
	monitoringRoleArnSelector?: null | v1.#Selector @go(MonitoringRoleArnSelector,*v1.Selector)

	// Specifies whether Performance Insights is enabled or not.
	// +kubebuilder:validation:Optional
	performanceInsightsEnabled?: null | bool @go(PerformanceInsightsEnabled,*bool)

	// ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +kubebuilder:validation:Optional
	performanceInsightsKmsKeyId?: null | string @go(PerformanceInsightsKMSKeyID,*string)

	// Reference to a Key in kms to populate performanceInsightsKmsKeyId.
	// +kubebuilder:validation:Optional
	performanceInsightsKmsKeyIdRef?: null | v1.#Reference @go(PerformanceInsightsKMSKeyIDRef,*v1.Reference)

	// Selector for a Key in kms to populate performanceInsightsKmsKeyId.
	// +kubebuilder:validation:Optional
	performanceInsightsKmsKeyIdSelector?: null | v1.#Selector @go(PerformanceInsightsKMSKeyIDSelector,*v1.Selector)

	// Amount of time in days to retain Performance Insights data. Valid values are 7, 731 (2 years) or a multiple of 31. When specifying performance_insights_retention_period, performance_insights_enabled needs to be set to true. Defaults to '7'.
	// +kubebuilder:validation:Optional
	performanceInsightsRetentionPeriod?: null | float64 @go(PerformanceInsightsRetentionPeriod,*float64)

	// The daily time range during which automated backups are created if automated backups are enabled. Eg: "04:00-09:00". NOTE: If preferred_backup_window is set at the cluster level, this argument must be omitted.
	// +kubebuilder:validation:Optional
	preferredBackupWindow?: null | string @go(PreferredBackupWindow,*string)

	// The window to perform maintenance in.
	// Syntax: "ddd:hh24:mi-ddd:hh24:mi". Eg: "Mon:00:00-Mon:03:00".
	// +kubebuilder:validation:Optional
	preferredMaintenanceWindow?: null | string @go(PreferredMaintenanceWindow,*string)

	// Default 0. Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer.
	// +kubebuilder:validation:Optional
	promotionTier?: null | float64 @go(PromotionTier,*float64)

	// Bool to control if instance is publicly accessible.
	// Default false. See the documentation on Creating DB Instances for more
	// details on controlling this property.
	// +kubebuilder:validation:Optional
	publiclyAccessible?: null | bool @go(PubliclyAccessible,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// ClusterInstanceSpec defines the desired state of ClusterInstance
#ClusterInstanceSpec: {
	v1.#ResourceSpec
	forProvider: #ClusterInstanceParameters @go(ForProvider)

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
	initProvider?: #ClusterInstanceInitParameters @go(InitProvider)
}

// ClusterInstanceStatus defines the observed state of ClusterInstance.
#ClusterInstanceStatus: {
	v1.#ResourceStatus
	atProvider?: #ClusterInstanceObservation @go(AtProvider)
}

// ClusterInstance is the Schema for the ClusterInstances API. Provides an RDS Cluster Resource Instance
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ClusterInstance: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.instanceClass) || (has(self.initProvider) && has(self.initProvider.instanceClass))",message="spec.forProvider.instanceClass is a required parameter"
	spec:    #ClusterInstanceSpec   @go(Spec)
	status?: #ClusterInstanceStatus @go(Status)
}

// ClusterInstanceList contains a list of ClusterInstances
#ClusterInstanceList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ClusterInstance] @go(Items,[]ClusterInstance)
}
