// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sagemaker/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DataCatalogConfigInitParameters: {
	// The name of the Glue table catalog.
	catalog?: null | string @go(Catalog,*string)

	// The name of the Glue table database.
	database?: null | string @go(Database,*string)

	// The name of the Glue table.
	tableName?: null | string @go(TableName,*string)
}

#DataCatalogConfigObservation: {
	// The name of the Glue table catalog.
	catalog?: null | string @go(Catalog,*string)

	// The name of the Glue table database.
	database?: null | string @go(Database,*string)

	// The name of the Glue table.
	tableName?: null | string @go(TableName,*string)
}

#DataCatalogConfigParameters: {
	// The name of the Glue table catalog.
	// +kubebuilder:validation:Optional
	catalog?: null | string @go(Catalog,*string)

	// The name of the Glue table database.
	// +kubebuilder:validation:Optional
	database?: null | string @go(Database,*string)

	// The name of the Glue table.
	// +kubebuilder:validation:Optional
	tableName?: null | string @go(TableName,*string)
}

#FeatureDefinitionInitParameters: {
	// The name of a feature. feature_name cannot be any of the following: is_deleted, write_time, api_invocation_time.
	featureName?: null | string @go(FeatureName,*string)

	// The value type of a feature. Valid values are Integral, Fractional, or String.
	featureType?: null | string @go(FeatureType,*string)
}

#FeatureDefinitionObservation: {
	// The name of a feature. feature_name cannot be any of the following: is_deleted, write_time, api_invocation_time.
	featureName?: null | string @go(FeatureName,*string)

	// The value type of a feature. Valid values are Integral, Fractional, or String.
	featureType?: null | string @go(FeatureType,*string)
}

#FeatureDefinitionParameters: {
	// The name of a feature. feature_name cannot be any of the following: is_deleted, write_time, api_invocation_time.
	// +kubebuilder:validation:Optional
	featureName?: null | string @go(FeatureName,*string)

	// The value type of a feature. Valid values are Integral, Fractional, or String.
	// +kubebuilder:validation:Optional
	featureType?: null | string @go(FeatureType,*string)
}

#FeatureGroupInitParameters: {
	// A free-form description of a Feature Group.
	description?: null | string @go(Description,*string)

	// The name of the feature that stores the EventTime of a Record in a Feature Group.
	eventTimeFeatureName?: null | string @go(EventTimeFeatureName,*string)

	// A list of Feature names and types. See Feature Definition Below.
	featureDefinition?: [...#FeatureDefinitionInitParameters] @go(FeatureDefinition,[]FeatureDefinitionInitParameters)

	// The Offline Feature Store Configuration. See Offline Store Config Below.
	offlineStoreConfig?: [...#OfflineStoreConfigInitParameters] @go(OfflineStoreConfig,[]OfflineStoreConfigInitParameters)

	// The Online Feature Store Configuration. See Online Store Config Below.
	onlineStoreConfig?: [...#OnlineStoreConfigInitParameters] @go(OnlineStoreConfig,[]OnlineStoreConfigInitParameters)

	// The name of the Feature whose value uniquely identifies a Record defined in the Feature Store. Only the latest record per identifier value will be stored in the Online Store.
	recordIdentifierFeatureName?: null | string @go(RecordIdentifierFeatureName,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#FeatureGroupObservation: {
	// The Amazon Resource Name (ARN) assigned by AWS to this feature_group.
	arn?: null | string @go(Arn,*string)

	// A free-form description of a Feature Group.
	description?: null | string @go(Description,*string)

	// The name of the feature that stores the EventTime of a Record in a Feature Group.
	eventTimeFeatureName?: null | string @go(EventTimeFeatureName,*string)

	// A list of Feature names and types. See Feature Definition Below.
	featureDefinition?: [...#FeatureDefinitionObservation] @go(FeatureDefinition,[]FeatureDefinitionObservation)
	id?: null | string @go(ID,*string)

	// The Offline Feature Store Configuration. See Offline Store Config Below.
	offlineStoreConfig?: [...#OfflineStoreConfigObservation] @go(OfflineStoreConfig,[]OfflineStoreConfigObservation)

	// The Online Feature Store Configuration. See Online Store Config Below.
	onlineStoreConfig?: [...#OnlineStoreConfigObservation] @go(OnlineStoreConfig,[]OnlineStoreConfigObservation)

	// The name of the Feature whose value uniquely identifies a Record defined in the Feature Store. Only the latest record per identifier value will be stored in the Online Store.
	recordIdentifierFeatureName?: null | string @go(RecordIdentifierFeatureName,*string)

	// The Amazon Resource Name (ARN) of the IAM execution role used to persist data into the Offline Store if an offline_store_config is provided.
	roleArn?: null | string @go(RoleArn,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#FeatureGroupParameters: {
	// A free-form description of a Feature Group.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// The name of the feature that stores the EventTime of a Record in a Feature Group.
	// +kubebuilder:validation:Optional
	eventTimeFeatureName?: null | string @go(EventTimeFeatureName,*string)

	// A list of Feature names and types. See Feature Definition Below.
	// +kubebuilder:validation:Optional
	featureDefinition?: [...#FeatureDefinitionParameters] @go(FeatureDefinition,[]FeatureDefinitionParameters)

	// The Offline Feature Store Configuration. See Offline Store Config Below.
	// +kubebuilder:validation:Optional
	offlineStoreConfig?: [...#OfflineStoreConfigParameters] @go(OfflineStoreConfig,[]OfflineStoreConfigParameters)

	// The Online Feature Store Configuration. See Online Store Config Below.
	// +kubebuilder:validation:Optional
	onlineStoreConfig?: [...#OnlineStoreConfigParameters] @go(OnlineStoreConfig,[]OnlineStoreConfigParameters)

	// The name of the Feature whose value uniquely identifies a Record defined in the Feature Store. Only the latest record per identifier value will be stored in the Online Store.
	// +kubebuilder:validation:Optional
	recordIdentifierFeatureName?: null | string @go(RecordIdentifierFeatureName,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The Amazon Resource Name (ARN) of the IAM execution role used to persist data into the Offline Store if an offline_store_config is provided.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	roleArn?: null | string @go(RoleArn,*string)

	// Reference to a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnRef?: null | v1.#Reference @go(RoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate roleArn.
	// +kubebuilder:validation:Optional
	roleArnSelector?: null | v1.#Selector @go(RoleArnSelector,*v1.Selector)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#OfflineStoreConfigInitParameters: {
	// The meta data of the Glue table that is autogenerated when an OfflineStore is created. See Data Catalog Config Below.
	dataCatalogConfig?: [...#DataCatalogConfigInitParameters] @go(DataCatalogConfig,[]DataCatalogConfigInitParameters)

	// Set to true to turn Online Store On.
	disableGlueTableCreation?: null | bool @go(DisableGlueTableCreation,*bool)

	// The Amazon Simple Storage (Amazon S3) location of OfflineStore. See S3 Storage Config Below.
	s3StorageConfig?: [...#S3StorageConfigInitParameters] @go(S3StorageConfig,[]S3StorageConfigInitParameters)

	// Format for the offline store table. Supported formats are Glue (Default) and Apache Iceberg (https://iceberg.apache.org/).
	tableFormat?: null | string @go(TableFormat,*string)
}

#OfflineStoreConfigObservation: {
	// The meta data of the Glue table that is autogenerated when an OfflineStore is created. See Data Catalog Config Below.
	dataCatalogConfig?: [...#DataCatalogConfigObservation] @go(DataCatalogConfig,[]DataCatalogConfigObservation)

	// Set to true to turn Online Store On.
	disableGlueTableCreation?: null | bool @go(DisableGlueTableCreation,*bool)

	// The Amazon Simple Storage (Amazon S3) location of OfflineStore. See S3 Storage Config Below.
	s3StorageConfig?: [...#S3StorageConfigObservation] @go(S3StorageConfig,[]S3StorageConfigObservation)

	// Format for the offline store table. Supported formats are Glue (Default) and Apache Iceberg (https://iceberg.apache.org/).
	tableFormat?: null | string @go(TableFormat,*string)
}

#OfflineStoreConfigParameters: {
	// The meta data of the Glue table that is autogenerated when an OfflineStore is created. See Data Catalog Config Below.
	// +kubebuilder:validation:Optional
	dataCatalogConfig?: [...#DataCatalogConfigParameters] @go(DataCatalogConfig,[]DataCatalogConfigParameters)

	// Set to true to turn Online Store On.
	// +kubebuilder:validation:Optional
	disableGlueTableCreation?: null | bool @go(DisableGlueTableCreation,*bool)

	// The Amazon Simple Storage (Amazon S3) location of OfflineStore. See S3 Storage Config Below.
	// +kubebuilder:validation:Optional
	s3StorageConfig: [...#S3StorageConfigParameters] @go(S3StorageConfig,[]S3StorageConfigParameters)

	// Format for the offline store table. Supported formats are Glue (Default) and Apache Iceberg (https://iceberg.apache.org/).
	// +kubebuilder:validation:Optional
	tableFormat?: null | string @go(TableFormat,*string)
}

#OnlineStoreConfigInitParameters: {
	// Set to true to disable the automatic creation of an AWS Glue table when configuring an OfflineStore.
	enableOnlineStore?: null | bool @go(EnableOnlineStore,*bool)

	// Security config for at-rest encryption of your OnlineStore. See Security Config Below.
	securityConfig?: [...#SecurityConfigInitParameters] @go(SecurityConfig,[]SecurityConfigInitParameters)
}

#OnlineStoreConfigObservation: {
	// Set to true to disable the automatic creation of an AWS Glue table when configuring an OfflineStore.
	enableOnlineStore?: null | bool @go(EnableOnlineStore,*bool)

	// Security config for at-rest encryption of your OnlineStore. See Security Config Below.
	securityConfig?: [...#SecurityConfigObservation] @go(SecurityConfig,[]SecurityConfigObservation)
}

#OnlineStoreConfigParameters: {
	// Set to true to disable the automatic creation of an AWS Glue table when configuring an OfflineStore.
	// +kubebuilder:validation:Optional
	enableOnlineStore?: null | bool @go(EnableOnlineStore,*bool)

	// Security config for at-rest encryption of your OnlineStore. See Security Config Below.
	// +kubebuilder:validation:Optional
	securityConfig?: [...#SecurityConfigParameters] @go(SecurityConfig,[]SecurityConfigParameters)
}

#S3StorageConfigInitParameters: {
	// The AWS Key Management Service (KMS) key ID of the key used to encrypt any objects written into the OfflineStore S3 location.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// The S3 URI, or location in Amazon S3, of OfflineStore.
	s3Uri?: null | string @go(S3URI,*string)
}

#S3StorageConfigObservation: {
	// The AWS Key Management Service (KMS) key ID of the key used to encrypt any objects written into the OfflineStore S3 location.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// The S3 URI, or location in Amazon S3, of OfflineStore.
	s3Uri?: null | string @go(S3URI,*string)
}

#S3StorageConfigParameters: {
	// The AWS Key Management Service (KMS) key ID of the key used to encrypt any objects written into the OfflineStore S3 location.
	// +kubebuilder:validation:Optional
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// The S3 URI, or location in Amazon S3, of OfflineStore.
	// +kubebuilder:validation:Optional
	s3Uri?: null | string @go(S3URI,*string)
}

#SecurityConfigInitParameters: {
	// The AWS Key Management Service (KMS) key ID of the key used to encrypt any objects written into the OfflineStore S3 location.
	kmsKeyId?: null | string @go(KMSKeyID,*string)
}

#SecurityConfigObservation: {
	// The AWS Key Management Service (KMS) key ID of the key used to encrypt any objects written into the OfflineStore S3 location.
	kmsKeyId?: null | string @go(KMSKeyID,*string)
}

#SecurityConfigParameters: {
	// The AWS Key Management Service (KMS) key ID of the key used to encrypt any objects written into the OfflineStore S3 location.
	// +kubebuilder:validation:Optional
	kmsKeyId?: null | string @go(KMSKeyID,*string)
}

// FeatureGroupSpec defines the desired state of FeatureGroup
#FeatureGroupSpec: {
	v1.#ResourceSpec
	forProvider: #FeatureGroupParameters @go(ForProvider)

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
	initProvider?: #FeatureGroupInitParameters @go(InitProvider)
}

// FeatureGroupStatus defines the observed state of FeatureGroup.
#FeatureGroupStatus: {
	v1.#ResourceStatus
	atProvider?: #FeatureGroupObservation @go(AtProvider)
}

// FeatureGroup is the Schema for the FeatureGroups API. Provides a SageMaker Feature Group resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#FeatureGroup: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.eventTimeFeatureName) || (has(self.initProvider) && has(self.initProvider.eventTimeFeatureName))",message="spec.forProvider.eventTimeFeatureName is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.featureDefinition) || (has(self.initProvider) && has(self.initProvider.featureDefinition))",message="spec.forProvider.featureDefinition is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.recordIdentifierFeatureName) || (has(self.initProvider) && has(self.initProvider.recordIdentifierFeatureName))",message="spec.forProvider.recordIdentifierFeatureName is a required parameter"
	spec:    #FeatureGroupSpec   @go(Spec)
	status?: #FeatureGroupStatus @go(Status)
}

// FeatureGroupList contains a list of FeatureGroups
#FeatureGroupList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#FeatureGroup] @go(Items,[]FeatureGroup)
}
