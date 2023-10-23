// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/mq/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#BrokerInitParameters: {
	// Specifies whether any broker modifications are applied immediately, or during the next maintenance window. Default is false.
	applyImmediately?: null | bool @go(ApplyImmediately,*bool)

	// Authentication strategy used to secure the broker. Valid values are simple and ldap. ldap is not supported for engine_type RabbitMQ.
	authenticationStrategy?: null | string @go(AuthenticationStrategy,*string)

	// Whether to automatically upgrade to new minor versions of brokers as Amazon MQ makes releases available.
	autoMinorVersionUpgrade?: null | bool @go(AutoMinorVersionUpgrade,*bool)

	// Name of the broker.
	brokerName?: null | string @go(BrokerName,*string)

	// Configuration block for broker configuration. Applies to engine_type of ActiveMQ only. Detailed below.
	configuration?: [...#ConfigurationInitParameters] @go(Configuration,[]ConfigurationInitParameters)

	// Deployment mode of the broker. Valid values are SINGLE_INSTANCE, ACTIVE_STANDBY_MULTI_AZ, and CLUSTER_MULTI_AZ. Default is SINGLE_INSTANCE.
	deploymentMode?: null | string @go(DeploymentMode,*string)

	// Configuration block containing encryption options. Detailed below.
	encryptionOptions?: [...#EncryptionOptionsInitParameters] @go(EncryptionOptions,[]EncryptionOptionsInitParameters)

	// Type of broker engine. Valid values are ActiveMQ and RabbitMQ.
	engineType?: null | string @go(EngineType,*string)

	// Version of the broker engine. See the AmazonMQ Broker Engine docs for supported versions. For example, 5.15.0.
	engineVersion?: null | string @go(EngineVersion,*string)

	// Broker's instance type. For example, mq.t3.micro, mq.m5.large.
	hostInstanceType?: null | string @go(HostInstanceType,*string)

	// Configuration block for the LDAP server used to authenticate and authorize connections to the broker. Not supported for engine_type RabbitMQ. Detailed below. (Currently, AWS may not process changes to LDAP server metadata.)
	ldapServerMetadata?: [...#LdapServerMetadataInitParameters] @go(LdapServerMetadata,[]LdapServerMetadataInitParameters)

	// Configuration block for the logging configuration of the broker. Detailed below.
	logs?: [...#LogsInitParameters] @go(Logs,[]LogsInitParameters)

	// Configuration block for the maintenance window start time. Detailed below.
	maintenanceWindowStartTime?: [...#MaintenanceWindowStartTimeInitParameters] @go(MaintenanceWindowStartTime,[]MaintenanceWindowStartTimeInitParameters)

	// Whether to enable connections from applications outside of the VPC that hosts the broker's subnets.
	publiclyAccessible?: null | bool @go(PubliclyAccessible,*bool)

	// Storage type of the broker. For engine_type ActiveMQ, the valid values are efs and ebs, and the AWS-default is efs. For engine_type RabbitMQ, only ebs is supported. When using ebs, only the mq.m5 broker instance type family is supported.
	storageType?: null | string @go(StorageType,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Configuration block for broker users. For engine_type of RabbitMQ, Amazon MQ does not return broker users preventing this resource from making user updates and drift detection. Detailed below.
	user?: [...#UserInitParameters] @go(User,[]UserInitParameters)
}

#BrokerObservation: {
	// Specifies whether any broker modifications are applied immediately, or during the next maintenance window. Default is false.
	applyImmediately?: null | bool @go(ApplyImmediately,*bool)

	// ARN of the broker.
	arn?: null | string @go(Arn,*string)

	// Authentication strategy used to secure the broker. Valid values are simple and ldap. ldap is not supported for engine_type RabbitMQ.
	authenticationStrategy?: null | string @go(AuthenticationStrategy,*string)

	// Whether to automatically upgrade to new minor versions of brokers as Amazon MQ makes releases available.
	autoMinorVersionUpgrade?: null | bool @go(AutoMinorVersionUpgrade,*bool)

	// Name of the broker.
	brokerName?: null | string @go(BrokerName,*string)

	// Configuration block for broker configuration. Applies to engine_type of ActiveMQ only. Detailed below.
	configuration?: [...#ConfigurationObservation] @go(Configuration,[]ConfigurationObservation)

	// Deployment mode of the broker. Valid values are SINGLE_INSTANCE, ACTIVE_STANDBY_MULTI_AZ, and CLUSTER_MULTI_AZ. Default is SINGLE_INSTANCE.
	deploymentMode?: null | string @go(DeploymentMode,*string)

	// Configuration block containing encryption options. Detailed below.
	encryptionOptions?: [...#EncryptionOptionsObservation] @go(EncryptionOptions,[]EncryptionOptionsObservation)

	// Type of broker engine. Valid values are ActiveMQ and RabbitMQ.
	engineType?: null | string @go(EngineType,*string)

	// Version of the broker engine. See the AmazonMQ Broker Engine docs for supported versions. For example, 5.15.0.
	engineVersion?: null | string @go(EngineVersion,*string)

	// Broker's instance type. For example, mq.t3.micro, mq.m5.large.
	hostInstanceType?: null | string @go(HostInstanceType,*string)

	// Unique ID that Amazon MQ generates for the broker.
	id?: null | string @go(ID,*string)

	// List of information about allocated brokers (both active & standby).
	instances?: [...#InstancesObservation] @go(Instances,[]InstancesObservation)

	// Configuration block for the LDAP server used to authenticate and authorize connections to the broker. Not supported for engine_type RabbitMQ. Detailed below. (Currently, AWS may not process changes to LDAP server metadata.)
	ldapServerMetadata?: [...#LdapServerMetadataObservation] @go(LdapServerMetadata,[]LdapServerMetadataObservation)

	// Configuration block for the logging configuration of the broker. Detailed below.
	logs?: [...#LogsObservation] @go(Logs,[]LogsObservation)

	// Configuration block for the maintenance window start time. Detailed below.
	maintenanceWindowStartTime?: [...#MaintenanceWindowStartTimeObservation] @go(MaintenanceWindowStartTime,[]MaintenanceWindowStartTimeObservation)

	// Whether to enable connections from applications outside of the VPC that hosts the broker's subnets.
	publiclyAccessible?: null | bool @go(PubliclyAccessible,*bool)

	// List of security group IDs assigned to the broker.
	securityGroups?: [...null | string] @go(SecurityGroups,[]*string)

	// Storage type of the broker. For engine_type ActiveMQ, the valid values are efs and ebs, and the AWS-default is efs. For engine_type RabbitMQ, only ebs is supported. When using ebs, only the mq.m5 broker instance type family is supported.
	storageType?: null | string @go(StorageType,*string)

	// List of subnet IDs in which to launch the broker. A SINGLE_INSTANCE deployment requires one subnet. An ACTIVE_STANDBY_MULTI_AZ deployment requires multiple subnets.
	subnetIds?: [...null | string] @go(SubnetIds,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Configuration block for broker users. For engine_type of RabbitMQ, Amazon MQ does not return broker users preventing this resource from making user updates and drift detection. Detailed below.
	user?: [...#UserObservation] @go(User,[]UserObservation)
}

#BrokerParameters: {
	// Specifies whether any broker modifications are applied immediately, or during the next maintenance window. Default is false.
	// +kubebuilder:validation:Optional
	applyImmediately?: null | bool @go(ApplyImmediately,*bool)

	// Authentication strategy used to secure the broker. Valid values are simple and ldap. ldap is not supported for engine_type RabbitMQ.
	// +kubebuilder:validation:Optional
	authenticationStrategy?: null | string @go(AuthenticationStrategy,*string)

	// Whether to automatically upgrade to new minor versions of brokers as Amazon MQ makes releases available.
	// +kubebuilder:validation:Optional
	autoMinorVersionUpgrade?: null | bool @go(AutoMinorVersionUpgrade,*bool)

	// Name of the broker.
	// +kubebuilder:validation:Optional
	brokerName?: null | string @go(BrokerName,*string)

	// Configuration block for broker configuration. Applies to engine_type of ActiveMQ only. Detailed below.
	// +kubebuilder:validation:Optional
	configuration?: [...#ConfigurationParameters] @go(Configuration,[]ConfigurationParameters)

	// Deployment mode of the broker. Valid values are SINGLE_INSTANCE, ACTIVE_STANDBY_MULTI_AZ, and CLUSTER_MULTI_AZ. Default is SINGLE_INSTANCE.
	// +kubebuilder:validation:Optional
	deploymentMode?: null | string @go(DeploymentMode,*string)

	// Configuration block containing encryption options. Detailed below.
	// +kubebuilder:validation:Optional
	encryptionOptions?: [...#EncryptionOptionsParameters] @go(EncryptionOptions,[]EncryptionOptionsParameters)

	// Type of broker engine. Valid values are ActiveMQ and RabbitMQ.
	// +kubebuilder:validation:Optional
	engineType?: null | string @go(EngineType,*string)

	// Version of the broker engine. See the AmazonMQ Broker Engine docs for supported versions. For example, 5.15.0.
	// +kubebuilder:validation:Optional
	engineVersion?: null | string @go(EngineVersion,*string)

	// Broker's instance type. For example, mq.t3.micro, mq.m5.large.
	// +kubebuilder:validation:Optional
	hostInstanceType?: null | string @go(HostInstanceType,*string)

	// Configuration block for the LDAP server used to authenticate and authorize connections to the broker. Not supported for engine_type RabbitMQ. Detailed below. (Currently, AWS may not process changes to LDAP server metadata.)
	// +kubebuilder:validation:Optional
	ldapServerMetadata?: [...#LdapServerMetadataParameters] @go(LdapServerMetadata,[]LdapServerMetadataParameters)

	// Configuration block for the logging configuration of the broker. Detailed below.
	// +kubebuilder:validation:Optional
	logs?: [...#LogsParameters] @go(Logs,[]LogsParameters)

	// Configuration block for the maintenance window start time. Detailed below.
	// +kubebuilder:validation:Optional
	maintenanceWindowStartTime?: [...#MaintenanceWindowStartTimeParameters] @go(MaintenanceWindowStartTime,[]MaintenanceWindowStartTimeParameters)

	// Whether to enable connections from applications outside of the VPC that hosts the broker's subnets.
	// +kubebuilder:validation:Optional
	publiclyAccessible?: null | bool @go(PubliclyAccessible,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// References to SecurityGroup in ec2 to populate securityGroups.
	// +kubebuilder:validation:Optional
	securityGroupRefs?: [...v1.#Reference] @go(SecurityGroupRefs,[]v1.Reference)

	// Selector for a list of SecurityGroup in ec2 to populate securityGroups.
	// +kubebuilder:validation:Optional
	securityGroupSelector?: null | v1.#Selector @go(SecurityGroupSelector,*v1.Selector)

	// List of security group IDs assigned to the broker.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.SecurityGroup
	// +crossplane:generate:reference:refFieldName=SecurityGroupRefs
	// +crossplane:generate:reference:selectorFieldName=SecurityGroupSelector
	// +kubebuilder:validation:Optional
	securityGroups?: [...null | string] @go(SecurityGroups,[]*string)

	// Storage type of the broker. For engine_type ActiveMQ, the valid values are efs and ebs, and the AWS-default is efs. For engine_type RabbitMQ, only ebs is supported. When using ebs, only the mq.m5 broker instance type family is supported.
	// +kubebuilder:validation:Optional
	storageType?: null | string @go(StorageType,*string)

	// References to Subnet in ec2 to populate subnetIds.
	// +kubebuilder:validation:Optional
	subnetIdRefs?: [...v1.#Reference] @go(SubnetIDRefs,[]v1.Reference)

	// Selector for a list of Subnet in ec2 to populate subnetIds.
	// +kubebuilder:validation:Optional
	subnetIdSelector?: null | v1.#Selector @go(SubnetIDSelector,*v1.Selector)

	// List of subnet IDs in which to launch the broker. A SINGLE_INSTANCE deployment requires one subnet. An ACTIVE_STANDBY_MULTI_AZ deployment requires multiple subnets.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.Subnet
	// +crossplane:generate:reference:refFieldName=SubnetIDRefs
	// +crossplane:generate:reference:selectorFieldName=SubnetIDSelector
	// +kubebuilder:validation:Optional
	subnetIds?: [...null | string] @go(SubnetIds,[]*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Configuration block for broker users. For engine_type of RabbitMQ, Amazon MQ does not return broker users preventing this resource from making user updates and drift detection. Detailed below.
	// +kubebuilder:validation:Optional
	user?: [...#UserParameters] @go(User,[]UserParameters)
}

#ConfigurationInitParameters: {
	// Revision of the Configuration.
	revision?: null | float64 @go(Revision,*float64)
}

#ConfigurationObservation: {
	// The Configuration ID.
	id?: null | string @go(ID,*string)

	// Revision of the Configuration.
	revision?: null | float64 @go(Revision,*float64)
}

#ConfigurationParameters: {
	// The Configuration ID.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/mq/v1beta1.Configuration
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	id?: null | string @go(ID,*string)

	// Reference to a Configuration in mq to populate id.
	// +kubebuilder:validation:Optional
	idRef?: null | v1.#Reference @go(IDRef,*v1.Reference)

	// Selector for a Configuration in mq to populate id.
	// +kubebuilder:validation:Optional
	idSelector?: null | v1.#Selector @go(IDSelector,*v1.Selector)

	// Revision of the Configuration.
	// +kubebuilder:validation:Optional
	revision?: null | float64 @go(Revision,*float64)
}

#EncryptionOptionsInitParameters: {
	// Amazon Resource Name (ARN) of Key Management Service (KMS) Customer Master Key (CMK) to use for encryption at rest. Requires setting use_aws_owned_key to false. To perform drift detection when AWS-managed CMKs or customer-managed CMKs are in use, this value must be configured.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// Whether to enable an AWS-owned KMS CMK that is not in your account. Defaults to true. Setting to false without configuring kms_key_id will create an AWS-managed CMK aliased to aws/mq in your account.
	useAwsOwnedKey?: null | bool @go(UseAwsOwnedKey,*bool)
}

#EncryptionOptionsObservation: {
	// Amazon Resource Name (ARN) of Key Management Service (KMS) Customer Master Key (CMK) to use for encryption at rest. Requires setting use_aws_owned_key to false. To perform drift detection when AWS-managed CMKs or customer-managed CMKs are in use, this value must be configured.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// Whether to enable an AWS-owned KMS CMK that is not in your account. Defaults to true. Setting to false without configuring kms_key_id will create an AWS-managed CMK aliased to aws/mq in your account.
	useAwsOwnedKey?: null | bool @go(UseAwsOwnedKey,*bool)
}

#EncryptionOptionsParameters: {
	// Amazon Resource Name (ARN) of Key Management Service (KMS) Customer Master Key (CMK) to use for encryption at rest. Requires setting use_aws_owned_key to false. To perform drift detection when AWS-managed CMKs or customer-managed CMKs are in use, this value must be configured.
	// +kubebuilder:validation:Optional
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// Whether to enable an AWS-owned KMS CMK that is not in your account. Defaults to true. Setting to false without configuring kms_key_id will create an AWS-managed CMK aliased to aws/mq in your account.
	// +kubebuilder:validation:Optional
	useAwsOwnedKey?: null | bool @go(UseAwsOwnedKey,*bool)
}

#InstancesInitParameters: {
}

#InstancesObservation: {
	// The URL of the ActiveMQ Web Console or the RabbitMQ Management UI depending on engine_type.
	consoleUrl?: null | string @go(ConsoleURL,*string)

	// Broker's wire-level protocol endpoints in the following order & format referenceable e.g., as instances.0.endpoints.0 (SSL):
	endpoints?: [...null | string] @go(Endpoints,[]*string)

	// IP Address of the broker.
	ipAddress?: null | string @go(IPAddress,*string)
}

#InstancesParameters: {
}

#LdapServerMetadataInitParameters: {
	// List of a fully qualified domain name of the LDAP server and an optional failover server.
	hosts?: [...null | string] @go(Hosts,[]*string)

	// Fully qualified name of the directory to search for a user’s groups.
	roleBase?: null | string @go(RoleBase,*string)

	// Specifies the LDAP attribute that identifies the group name attribute in the object returned from the group membership query.
	roleName?: null | string @go(RoleName,*string)

	// Search criteria for groups.
	roleSearchMatching?: null | string @go(RoleSearchMatching,*string)

	// Whether the directory search scope is the entire sub-tree.
	roleSearchSubtree?: null | bool @go(RoleSearchSubtree,*bool)

	// Service account username.
	serviceAccountUsername?: null | string @go(ServiceAccountUsername,*string)

	// Fully qualified name of the directory where you want to search for users.
	userBase?: null | string @go(UserBase,*string)

	// Specifies the name of the LDAP attribute for the user group membership.
	userRoleName?: null | string @go(UserRoleName,*string)

	// Search criteria for users.
	userSearchMatching?: null | string @go(UserSearchMatching,*string)

	// Whether the directory search scope is the entire sub-tree.
	userSearchSubtree?: null | bool @go(UserSearchSubtree,*bool)
}

#LdapServerMetadataObservation: {
	// List of a fully qualified domain name of the LDAP server and an optional failover server.
	hosts?: [...null | string] @go(Hosts,[]*string)

	// Fully qualified name of the directory to search for a user’s groups.
	roleBase?: null | string @go(RoleBase,*string)

	// Specifies the LDAP attribute that identifies the group name attribute in the object returned from the group membership query.
	roleName?: null | string @go(RoleName,*string)

	// Search criteria for groups.
	roleSearchMatching?: null | string @go(RoleSearchMatching,*string)

	// Whether the directory search scope is the entire sub-tree.
	roleSearchSubtree?: null | bool @go(RoleSearchSubtree,*bool)

	// Service account username.
	serviceAccountUsername?: null | string @go(ServiceAccountUsername,*string)

	// Fully qualified name of the directory where you want to search for users.
	userBase?: null | string @go(UserBase,*string)

	// Specifies the name of the LDAP attribute for the user group membership.
	userRoleName?: null | string @go(UserRoleName,*string)

	// Search criteria for users.
	userSearchMatching?: null | string @go(UserSearchMatching,*string)

	// Whether the directory search scope is the entire sub-tree.
	userSearchSubtree?: null | bool @go(UserSearchSubtree,*bool)
}

#LdapServerMetadataParameters: {
	// List of a fully qualified domain name of the LDAP server and an optional failover server.
	// +kubebuilder:validation:Optional
	hosts?: [...null | string] @go(Hosts,[]*string)

	// Fully qualified name of the directory to search for a user’s groups.
	// +kubebuilder:validation:Optional
	roleBase?: null | string @go(RoleBase,*string)

	// Specifies the LDAP attribute that identifies the group name attribute in the object returned from the group membership query.
	// +kubebuilder:validation:Optional
	roleName?: null | string @go(RoleName,*string)

	// Search criteria for groups.
	// +kubebuilder:validation:Optional
	roleSearchMatching?: null | string @go(RoleSearchMatching,*string)

	// Whether the directory search scope is the entire sub-tree.
	// +kubebuilder:validation:Optional
	roleSearchSubtree?: null | bool @go(RoleSearchSubtree,*bool)

	// Service account password.
	// +kubebuilder:validation:Optional
	serviceAccountPasswordSecretRef?: null | v1.#SecretKeySelector @go(ServiceAccountPasswordSecretRef,*v1.SecretKeySelector)

	// Service account username.
	// +kubebuilder:validation:Optional
	serviceAccountUsername?: null | string @go(ServiceAccountUsername,*string)

	// Fully qualified name of the directory where you want to search for users.
	// +kubebuilder:validation:Optional
	userBase?: null | string @go(UserBase,*string)

	// Specifies the name of the LDAP attribute for the user group membership.
	// +kubebuilder:validation:Optional
	userRoleName?: null | string @go(UserRoleName,*string)

	// Search criteria for users.
	// +kubebuilder:validation:Optional
	userSearchMatching?: null | string @go(UserSearchMatching,*string)

	// Whether the directory search scope is the entire sub-tree.
	// +kubebuilder:validation:Optional
	userSearchSubtree?: null | bool @go(UserSearchSubtree,*bool)
}

#LogsInitParameters: {
	// Enables audit logging. Auditing is only possible for engine_type of ActiveMQ. User management action made using JMX or the ActiveMQ Web Console is logged. Defaults to false.
	audit?: null | string @go(Audit,*string)

	// Enables general logging via CloudWatch. Defaults to false.
	general?: null | bool @go(General,*bool)
}

#LogsObservation: {
	// Enables audit logging. Auditing is only possible for engine_type of ActiveMQ. User management action made using JMX or the ActiveMQ Web Console is logged. Defaults to false.
	audit?: null | string @go(Audit,*string)

	// Enables general logging via CloudWatch. Defaults to false.
	general?: null | bool @go(General,*bool)
}

#LogsParameters: {
	// Enables audit logging. Auditing is only possible for engine_type of ActiveMQ. User management action made using JMX or the ActiveMQ Web Console is logged. Defaults to false.
	// +kubebuilder:validation:Optional
	audit?: null | string @go(Audit,*string)

	// Enables general logging via CloudWatch. Defaults to false.
	// +kubebuilder:validation:Optional
	general?: null | bool @go(General,*bool)
}

#MaintenanceWindowStartTimeInitParameters: {
	// Day of the week, e.g., MONDAY, TUESDAY, or WEDNESDAY.
	dayOfWeek?: null | string @go(DayOfWeek,*string)

	// Time, in 24-hour format, e.g., 02:00.
	timeOfDay?: null | string @go(TimeOfDay,*string)

	// Time zone in either the Country/City format or the UTC offset format, e.g., CET.
	timeZone?: null | string @go(TimeZone,*string)
}

#MaintenanceWindowStartTimeObservation: {
	// Day of the week, e.g., MONDAY, TUESDAY, or WEDNESDAY.
	dayOfWeek?: null | string @go(DayOfWeek,*string)

	// Time, in 24-hour format, e.g., 02:00.
	timeOfDay?: null | string @go(TimeOfDay,*string)

	// Time zone in either the Country/City format or the UTC offset format, e.g., CET.
	timeZone?: null | string @go(TimeZone,*string)
}

#MaintenanceWindowStartTimeParameters: {
	// Day of the week, e.g., MONDAY, TUESDAY, or WEDNESDAY.
	// +kubebuilder:validation:Optional
	dayOfWeek?: null | string @go(DayOfWeek,*string)

	// Time, in 24-hour format, e.g., 02:00.
	// +kubebuilder:validation:Optional
	timeOfDay?: null | string @go(TimeOfDay,*string)

	// Time zone in either the Country/City format or the UTC offset format, e.g., CET.
	// +kubebuilder:validation:Optional
	timeZone?: null | string @go(TimeZone,*string)
}

#UserInitParameters: {
	// Whether to enable access to the ActiveMQ Web Console for the user. Applies to engine_type of ActiveMQ only.
	consoleAccess?: null | bool @go(ConsoleAccess,*bool)

	// List of groups (20 maximum) to which the ActiveMQ user belongs. Applies to engine_type of ActiveMQ only.
	groups?: [...null | string] @go(Groups,[]*string)

	// Username of the user.
	username?: null | string @go(Username,*string)
}

#UserObservation: {
	// Whether to enable access to the ActiveMQ Web Console for the user. Applies to engine_type of ActiveMQ only.
	consoleAccess?: null | bool @go(ConsoleAccess,*bool)

	// List of groups (20 maximum) to which the ActiveMQ user belongs. Applies to engine_type of ActiveMQ only.
	groups?: [...null | string] @go(Groups,[]*string)

	// Username of the user.
	username?: null | string @go(Username,*string)
}

#UserParameters: {
	// Whether to enable access to the ActiveMQ Web Console for the user. Applies to engine_type of ActiveMQ only.
	// +kubebuilder:validation:Optional
	consoleAccess?: null | bool @go(ConsoleAccess,*bool)

	// List of groups (20 maximum) to which the ActiveMQ user belongs. Applies to engine_type of ActiveMQ only.
	// +kubebuilder:validation:Optional
	groups?: [...null | string] @go(Groups,[]*string)

	// Password of the user. It must be 12 to 250 characters long, at least 4 unique characters, and must not contain commas.
	// +kubebuilder:validation:Required
	passwordSecretRef: v1.#SecretKeySelector @go(PasswordSecretRef)

	// Username of the user.
	// +kubebuilder:validation:Optional
	username?: null | string @go(Username,*string)
}

// BrokerSpec defines the desired state of Broker
#BrokerSpec: {
	v1.#ResourceSpec
	forProvider: #BrokerParameters @go(ForProvider)

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
	initProvider?: #BrokerInitParameters @go(InitProvider)
}

// BrokerStatus defines the observed state of Broker.
#BrokerStatus: {
	v1.#ResourceStatus
	atProvider?: #BrokerObservation @go(AtProvider)
}

// Broker is the Schema for the Brokers API. Provides an MQ Broker Resource
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Broker: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.brokerName) || (has(self.initProvider) && has(self.initProvider.brokerName))",message="spec.forProvider.brokerName is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.engineType) || (has(self.initProvider) && has(self.initProvider.engineType))",message="spec.forProvider.engineType is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.engineVersion) || (has(self.initProvider) && has(self.initProvider.engineVersion))",message="spec.forProvider.engineVersion is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.hostInstanceType) || (has(self.initProvider) && has(self.initProvider.hostInstanceType))",message="spec.forProvider.hostInstanceType is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.user) || (has(self.initProvider) && has(self.initProvider.user))",message="spec.forProvider.user is a required parameter"
	spec:    #BrokerSpec   @go(Spec)
	status?: #BrokerStatus @go(Status)
}

// BrokerList contains a list of Brokers
#BrokerList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Broker] @go(Items,[]Broker)
}
