// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/kendra/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#CapacityUnitsInitParameters: {
	// The amount of extra query capacity for an index and GetQuerySuggestions capacity. For more information, refer to QueryCapacityUnits.
	queryCapacityUnits?: null | float64 @go(QueryCapacityUnits,*float64)

	// The amount of extra storage capacity for an index. A single capacity unit provides 30 GB of storage space or 100,000 documents, whichever is reached first. Minimum value of 0.
	storageCapacityUnits?: null | float64 @go(StorageCapacityUnits,*float64)
}

#CapacityUnitsObservation: {
	// The amount of extra query capacity for an index and GetQuerySuggestions capacity. For more information, refer to QueryCapacityUnits.
	queryCapacityUnits?: null | float64 @go(QueryCapacityUnits,*float64)

	// The amount of extra storage capacity for an index. A single capacity unit provides 30 GB of storage space or 100,000 documents, whichever is reached first. Minimum value of 0.
	storageCapacityUnits?: null | float64 @go(StorageCapacityUnits,*float64)
}

#CapacityUnitsParameters: {
	// The amount of extra query capacity for an index and GetQuerySuggestions capacity. For more information, refer to QueryCapacityUnits.
	// +kubebuilder:validation:Optional
	queryCapacityUnits?: null | float64 @go(QueryCapacityUnits,*float64)

	// The amount of extra storage capacity for an index. A single capacity unit provides 30 GB of storage space or 100,000 documents, whichever is reached first. Minimum value of 0.
	// +kubebuilder:validation:Optional
	storageCapacityUnits?: null | float64 @go(StorageCapacityUnits,*float64)
}

#DocumentMetadataConfigurationUpdatesInitParameters: {
	// The name of the index field. Minimum length of 1. Maximum length of 30.
	name?: null | string @go(Name,*string)

	// A block that provides manual tuning parameters to determine how the field affects the search results. Detailed below
	relevance?: [...#RelevanceInitParameters] @go(Relevance,[]RelevanceInitParameters)

	// A block that provides information about how the field is used during a search. Documented below. Detailed below
	search?: [...#SearchInitParameters] @go(Search,[]SearchInitParameters)

	// The data type of the index field. Valid values are STRING_VALUE, STRING_LIST_VALUE, LONG_VALUE, DATE_VALUE.
	type?: null | string @go(Type,*string)
}

#DocumentMetadataConfigurationUpdatesObservation: {
	// The name of the index field. Minimum length of 1. Maximum length of 30.
	name?: null | string @go(Name,*string)

	// A block that provides manual tuning parameters to determine how the field affects the search results. Detailed below
	relevance?: [...#RelevanceObservation] @go(Relevance,[]RelevanceObservation)

	// A block that provides information about how the field is used during a search. Documented below. Detailed below
	search?: [...#SearchObservation] @go(Search,[]SearchObservation)

	// The data type of the index field. Valid values are STRING_VALUE, STRING_LIST_VALUE, LONG_VALUE, DATE_VALUE.
	type?: null | string @go(Type,*string)
}

#DocumentMetadataConfigurationUpdatesParameters: {
	// The name of the index field. Minimum length of 1. Maximum length of 30.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// A block that provides manual tuning parameters to determine how the field affects the search results. Detailed below
	// +kubebuilder:validation:Optional
	relevance?: [...#RelevanceParameters] @go(Relevance,[]RelevanceParameters)

	// A block that provides information about how the field is used during a search. Documented below. Detailed below
	// +kubebuilder:validation:Optional
	search?: [...#SearchParameters] @go(Search,[]SearchParameters)

	// The data type of the index field. Valid values are STRING_VALUE, STRING_LIST_VALUE, LONG_VALUE, DATE_VALUE.
	// +kubebuilder:validation:Optional
	type?: null | string @go(Type,*string)
}

#FaqStatisticsInitParameters: {
}

#FaqStatisticsObservation: {
	// The total number of FAQ questions and answers contained in the index.
	indexedQuestionAnswersCount?: null | float64 @go(IndexedQuestionAnswersCount,*float64)
}

#FaqStatisticsParameters: {
}

#IndexInitParameters: {
	// A block that sets the number of additional document storage and query capacity units that should be used by the index. Detailed below.
	capacityUnits?: [...#CapacityUnitsInitParameters] @go(CapacityUnits,[]CapacityUnitsInitParameters)

	// The description of the Index.
	description?: null | string @go(Description,*string)

	// One or more blocks that specify the configuration settings for any metadata applied to the documents in the index. Minimum number of 0 items. Maximum number of 500 items. If specified, you must define all elements, including those that are provided by default. These index fields are documented at Amazon Kendra Index documentation. For an example resource that defines these default index fields, refer to the default example above. For an example resource that appends additional index fields, refer to the append example above. All arguments for each block must be specified. Note that blocks cannot be removed since index fields cannot be deleted. This argument is detailed below.
	documentMetadataConfigurationUpdates?: [...#DocumentMetadataConfigurationUpdatesInitParameters] @go(DocumentMetadataConfigurationUpdates,[]DocumentMetadataConfigurationUpdatesInitParameters)

	// The Amazon Kendra edition to use for the index. Choose DEVELOPER_EDITION for indexes intended for development, testing, or proof of concept. Use ENTERPRISE_EDITION for your production databases. Once you set the edition for an index, it can't be changed. Defaults to ENTERPRISE_EDITION
	edition?: null | string @go(Edition,*string)

	// Specifies the name of the Index.
	name?: null | string @go(Name,*string)

	// A block that specifies the identifier of the AWS KMS customer managed key (CMK) that's used to encrypt data indexed by Amazon Kendra. Amazon Kendra doesn't support asymmetric CMKs. Detailed below.
	serverSideEncryptionConfiguration?: [...#ServerSideEncryptionConfigurationInitParameters] @go(ServerSideEncryptionConfiguration,[]ServerSideEncryptionConfigurationInitParameters)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The user context policy. Valid values are ATTRIBUTE_FILTER or USER_TOKEN. For more information, refer to UserContextPolicy. Defaults to ATTRIBUTE_FILTER.
	userContextPolicy?: null | string @go(UserContextPolicy,*string)

	// A block that enables fetching access levels of groups and users from an AWS Single Sign-On identity source. To configure this, see UserGroupResolutionConfiguration. Detailed below.
	userGroupResolutionConfiguration?: [...#UserGroupResolutionConfigurationInitParameters] @go(UserGroupResolutionConfiguration,[]UserGroupResolutionConfigurationInitParameters)

	// A block that specifies the user token configuration. Detailed below.
	userTokenConfigurations?: [...#UserTokenConfigurationsInitParameters] @go(UserTokenConfigurations,[]UserTokenConfigurationsInitParameters)
}

#IndexObservation: {
	// The Amazon Resource Name (ARN) of the Index.
	arn?: null | string @go(Arn,*string)

	// A block that sets the number of additional document storage and query capacity units that should be used by the index. Detailed below.
	capacityUnits?: [...#CapacityUnitsObservation] @go(CapacityUnits,[]CapacityUnitsObservation)

	// The Unix datetime that the index was created.
	createdAt?: null | string @go(CreatedAt,*string)

	// The description of the Index.
	description?: null | string @go(Description,*string)

	// One or more blocks that specify the configuration settings for any metadata applied to the documents in the index. Minimum number of 0 items. Maximum number of 500 items. If specified, you must define all elements, including those that are provided by default. These index fields are documented at Amazon Kendra Index documentation. For an example resource that defines these default index fields, refer to the default example above. For an example resource that appends additional index fields, refer to the append example above. All arguments for each block must be specified. Note that blocks cannot be removed since index fields cannot be deleted. This argument is detailed below.
	documentMetadataConfigurationUpdates?: [...#DocumentMetadataConfigurationUpdatesObservation] @go(DocumentMetadataConfigurationUpdates,[]DocumentMetadataConfigurationUpdatesObservation)

	// The Amazon Kendra edition to use for the index. Choose DEVELOPER_EDITION for indexes intended for development, testing, or proof of concept. Use ENTERPRISE_EDITION for your production databases. Once you set the edition for an index, it can't be changed. Defaults to ENTERPRISE_EDITION
	edition?: null | string @go(Edition,*string)

	// When the Status field value is FAILED, this contains a message that explains why.
	errorMessage?: null | string @go(ErrorMessage,*string)

	// The identifier of the Index.
	id?: null | string @go(ID,*string)

	// A block that provides information about the number of FAQ questions and answers and the number of text documents indexed. Detailed below.
	indexStatistics?: [...#IndexStatisticsObservation] @go(IndexStatistics,[]IndexStatisticsObservation)

	// Specifies the name of the Index.
	name?: null | string @go(Name,*string)

	// An AWS Identity and Access Management (IAM) role that gives Amazon Kendra permissions to access your Amazon CloudWatch logs and metrics. This is also the role you use when you call the BatchPutDocument API to index documents from an Amazon S3 bucket.
	roleArn?: null | string @go(RoleArn,*string)

	// A block that specifies the identifier of the AWS KMS customer managed key (CMK) that's used to encrypt data indexed by Amazon Kendra. Amazon Kendra doesn't support asymmetric CMKs. Detailed below.
	serverSideEncryptionConfiguration?: [...#ServerSideEncryptionConfigurationObservation] @go(ServerSideEncryptionConfiguration,[]ServerSideEncryptionConfigurationObservation)

	// The current status of the index. When the value is ACTIVE, the index is ready for use. If the Status field value is FAILED, the error_message field contains a message that explains why.
	status?: null | string @go(Status,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The Unix datetime that the index was last updated.
	updatedAt?: null | string @go(UpdatedAt,*string)

	// The user context policy. Valid values are ATTRIBUTE_FILTER or USER_TOKEN. For more information, refer to UserContextPolicy. Defaults to ATTRIBUTE_FILTER.
	userContextPolicy?: null | string @go(UserContextPolicy,*string)

	// A block that enables fetching access levels of groups and users from an AWS Single Sign-On identity source. To configure this, see UserGroupResolutionConfiguration. Detailed below.
	userGroupResolutionConfiguration?: [...#UserGroupResolutionConfigurationObservation] @go(UserGroupResolutionConfiguration,[]UserGroupResolutionConfigurationObservation)

	// A block that specifies the user token configuration. Detailed below.
	userTokenConfigurations?: [...#UserTokenConfigurationsObservation] @go(UserTokenConfigurations,[]UserTokenConfigurationsObservation)
}

#IndexParameters: {
	// A block that sets the number of additional document storage and query capacity units that should be used by the index. Detailed below.
	// +kubebuilder:validation:Optional
	capacityUnits?: [...#CapacityUnitsParameters] @go(CapacityUnits,[]CapacityUnitsParameters)

	// The description of the Index.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// One or more blocks that specify the configuration settings for any metadata applied to the documents in the index. Minimum number of 0 items. Maximum number of 500 items. If specified, you must define all elements, including those that are provided by default. These index fields are documented at Amazon Kendra Index documentation. For an example resource that defines these default index fields, refer to the default example above. For an example resource that appends additional index fields, refer to the append example above. All arguments for each block must be specified. Note that blocks cannot be removed since index fields cannot be deleted. This argument is detailed below.
	// +kubebuilder:validation:Optional
	documentMetadataConfigurationUpdates?: [...#DocumentMetadataConfigurationUpdatesParameters] @go(DocumentMetadataConfigurationUpdates,[]DocumentMetadataConfigurationUpdatesParameters)

	// The Amazon Kendra edition to use for the index. Choose DEVELOPER_EDITION for indexes intended for development, testing, or proof of concept. Use ENTERPRISE_EDITION for your production databases. Once you set the edition for an index, it can't be changed. Defaults to ENTERPRISE_EDITION
	// +kubebuilder:validation:Optional
	edition?: null | string @go(Edition,*string)

	// Specifies the name of the Index.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// An AWS Identity and Access Management (IAM) role that gives Amazon Kendra permissions to access your Amazon CloudWatch logs and metrics. This is also the role you use when you call the BatchPutDocument API to index documents from an Amazon S3 bucket.
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

	// A block that specifies the identifier of the AWS KMS customer managed key (CMK) that's used to encrypt data indexed by Amazon Kendra. Amazon Kendra doesn't support asymmetric CMKs. Detailed below.
	// +kubebuilder:validation:Optional
	serverSideEncryptionConfiguration?: [...#ServerSideEncryptionConfigurationParameters] @go(ServerSideEncryptionConfiguration,[]ServerSideEncryptionConfigurationParameters)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The user context policy. Valid values are ATTRIBUTE_FILTER or USER_TOKEN. For more information, refer to UserContextPolicy. Defaults to ATTRIBUTE_FILTER.
	// +kubebuilder:validation:Optional
	userContextPolicy?: null | string @go(UserContextPolicy,*string)

	// A block that enables fetching access levels of groups and users from an AWS Single Sign-On identity source. To configure this, see UserGroupResolutionConfiguration. Detailed below.
	// +kubebuilder:validation:Optional
	userGroupResolutionConfiguration?: [...#UserGroupResolutionConfigurationParameters] @go(UserGroupResolutionConfiguration,[]UserGroupResolutionConfigurationParameters)

	// A block that specifies the user token configuration. Detailed below.
	// +kubebuilder:validation:Optional
	userTokenConfigurations?: [...#UserTokenConfigurationsParameters] @go(UserTokenConfigurations,[]UserTokenConfigurationsParameters)
}

#IndexStatisticsInitParameters: {
}

#IndexStatisticsObservation: {
	// A block that specifies the number of question and answer topics in the index. Detailed below.
	faqStatistics?: [...#FaqStatisticsObservation] @go(FaqStatistics,[]FaqStatisticsObservation)

	// A block that specifies the number of text documents indexed. Detailed below.
	textDocumentStatistics?: [...#TextDocumentStatisticsObservation] @go(TextDocumentStatistics,[]TextDocumentStatisticsObservation)
}

#IndexStatisticsParameters: {
}

#JSONTokenTypeConfigurationInitParameters: {
	// The group attribute field. Minimum length of 1. Maximum length of 2048.
	groupAttributeField?: null | string @go(GroupAttributeField,*string)

	// The user name attribute field. Minimum length of 1. Maximum length of 2048.
	userNameAttributeField?: null | string @go(UserNameAttributeField,*string)
}

#JSONTokenTypeConfigurationObservation: {
	// The group attribute field. Minimum length of 1. Maximum length of 2048.
	groupAttributeField?: null | string @go(GroupAttributeField,*string)

	// The user name attribute field. Minimum length of 1. Maximum length of 2048.
	userNameAttributeField?: null | string @go(UserNameAttributeField,*string)
}

#JSONTokenTypeConfigurationParameters: {
	// The group attribute field. Minimum length of 1. Maximum length of 2048.
	// +kubebuilder:validation:Optional
	groupAttributeField?: null | string @go(GroupAttributeField,*string)

	// The user name attribute field. Minimum length of 1. Maximum length of 2048.
	// +kubebuilder:validation:Optional
	userNameAttributeField?: null | string @go(UserNameAttributeField,*string)
}

#JwtTokenTypeConfigurationInitParameters: {
	// The regular expression that identifies the claim. Minimum length of 1. Maximum length of 100.
	claimRegex?: null | string @go(ClaimRegex,*string)

	// The group attribute field. Minimum length of 1. Maximum length of 2048.
	groupAttributeField?: null | string @go(GroupAttributeField,*string)

	// The issuer of the token. Minimum length of 1. Maximum length of 65.
	issuer?: null | string @go(Issuer,*string)

	// The location of the key. Valid values are URL or SECRET_MANAGER
	keyLocation?: null | string @go(KeyLocation,*string)

	// The Amazon Resource Name (ARN) of the secret.
	secretsManagerArn?: null | string @go(SecretsManagerArn,*string)

	// The signing key URL. Valid pattern is ^(https?|ftp|file):\/\/([^\s]*)
	url?: null | string @go(URL,*string)

	// The user name attribute field. Minimum length of 1. Maximum length of 2048.
	userNameAttributeField?: null | string @go(UserNameAttributeField,*string)
}

#JwtTokenTypeConfigurationObservation: {
	// The regular expression that identifies the claim. Minimum length of 1. Maximum length of 100.
	claimRegex?: null | string @go(ClaimRegex,*string)

	// The group attribute field. Minimum length of 1. Maximum length of 2048.
	groupAttributeField?: null | string @go(GroupAttributeField,*string)

	// The issuer of the token. Minimum length of 1. Maximum length of 65.
	issuer?: null | string @go(Issuer,*string)

	// The location of the key. Valid values are URL or SECRET_MANAGER
	keyLocation?: null | string @go(KeyLocation,*string)

	// The Amazon Resource Name (ARN) of the secret.
	secretsManagerArn?: null | string @go(SecretsManagerArn,*string)

	// The signing key URL. Valid pattern is ^(https?|ftp|file):\/\/([^\s]*)
	url?: null | string @go(URL,*string)

	// The user name attribute field. Minimum length of 1. Maximum length of 2048.
	userNameAttributeField?: null | string @go(UserNameAttributeField,*string)
}

#JwtTokenTypeConfigurationParameters: {
	// The regular expression that identifies the claim. Minimum length of 1. Maximum length of 100.
	// +kubebuilder:validation:Optional
	claimRegex?: null | string @go(ClaimRegex,*string)

	// The group attribute field. Minimum length of 1. Maximum length of 2048.
	// +kubebuilder:validation:Optional
	groupAttributeField?: null | string @go(GroupAttributeField,*string)

	// The issuer of the token. Minimum length of 1. Maximum length of 65.
	// +kubebuilder:validation:Optional
	issuer?: null | string @go(Issuer,*string)

	// The location of the key. Valid values are URL or SECRET_MANAGER
	// +kubebuilder:validation:Optional
	keyLocation?: null | string @go(KeyLocation,*string)

	// The Amazon Resource Name (ARN) of the secret.
	// +kubebuilder:validation:Optional
	secretsManagerArn?: null | string @go(SecretsManagerArn,*string)

	// The signing key URL. Valid pattern is ^(https?|ftp|file):\/\/([^\s]*)
	// +kubebuilder:validation:Optional
	url?: null | string @go(URL,*string)

	// The user name attribute field. Minimum length of 1. Maximum length of 2048.
	// +kubebuilder:validation:Optional
	userNameAttributeField?: null | string @go(UserNameAttributeField,*string)
}

#RelevanceInitParameters: {
	// Specifies the time period that the boost applies to. For more information, refer to Duration.
	duration?: null | string @go(Duration,*string)

	// Indicates that this field determines how "fresh" a document is. For more information, refer to Freshness.
	freshness?: null | bool @go(Freshness,*bool)

	// The relative importance of the field in the search. Larger numbers provide more of a boost than smaller numbers. Minimum value of 1. Maximum value of 10.
	importance?: null | float64 @go(Importance,*float64)

	// Determines how values should be interpreted. For more information, refer to RankOrder.
	rankOrder?: null | string @go(RankOrder,*string)

	// A list of values that should be given a different boost when they appear in the result list. For more information, refer to ValueImportanceMap.
	valuesImportanceMap?: {[string]: null | float64} @go(ValuesImportanceMap,map[string]*float64)
}

#RelevanceObservation: {
	// Specifies the time period that the boost applies to. For more information, refer to Duration.
	duration?: null | string @go(Duration,*string)

	// Indicates that this field determines how "fresh" a document is. For more information, refer to Freshness.
	freshness?: null | bool @go(Freshness,*bool)

	// The relative importance of the field in the search. Larger numbers provide more of a boost than smaller numbers. Minimum value of 1. Maximum value of 10.
	importance?: null | float64 @go(Importance,*float64)

	// Determines how values should be interpreted. For more information, refer to RankOrder.
	rankOrder?: null | string @go(RankOrder,*string)

	// A list of values that should be given a different boost when they appear in the result list. For more information, refer to ValueImportanceMap.
	valuesImportanceMap?: {[string]: null | float64} @go(ValuesImportanceMap,map[string]*float64)
}

#RelevanceParameters: {
	// Specifies the time period that the boost applies to. For more information, refer to Duration.
	// +kubebuilder:validation:Optional
	duration?: null | string @go(Duration,*string)

	// Indicates that this field determines how "fresh" a document is. For more information, refer to Freshness.
	// +kubebuilder:validation:Optional
	freshness?: null | bool @go(Freshness,*bool)

	// The relative importance of the field in the search. Larger numbers provide more of a boost than smaller numbers. Minimum value of 1. Maximum value of 10.
	// +kubebuilder:validation:Optional
	importance?: null | float64 @go(Importance,*float64)

	// Determines how values should be interpreted. For more information, refer to RankOrder.
	// +kubebuilder:validation:Optional
	rankOrder?: null | string @go(RankOrder,*string)

	// A list of values that should be given a different boost when they appear in the result list. For more information, refer to ValueImportanceMap.
	// +kubebuilder:validation:Optional
	valuesImportanceMap?: {[string]: null | float64} @go(ValuesImportanceMap,map[string]*float64)
}

#SearchInitParameters: {
	// Determines whether the field is returned in the query response. The default is true.
	displayable?: null | bool @go(Displayable,*bool)

	// Indicates that the field can be used to create search facets, a count of results for each value in the field. The default is false.
	facetable?: null | bool @go(Facetable,*bool)

	// Determines whether the field is used in the search. If the Searchable field is true, you can use relevance tuning to manually tune how Amazon Kendra weights the field in the search. The default is true for string fields and false for number and date fields.
	searchable?: null | bool @go(Searchable,*bool)

	// Determines whether the field can be used to sort the results of a query. If you specify sorting on a field that does not have Sortable set to true, Amazon Kendra returns an exception. The default is false.
	sortable?: null | bool @go(Sortable,*bool)
}

#SearchObservation: {
	// Determines whether the field is returned in the query response. The default is true.
	displayable?: null | bool @go(Displayable,*bool)

	// Indicates that the field can be used to create search facets, a count of results for each value in the field. The default is false.
	facetable?: null | bool @go(Facetable,*bool)

	// Determines whether the field is used in the search. If the Searchable field is true, you can use relevance tuning to manually tune how Amazon Kendra weights the field in the search. The default is true for string fields and false for number and date fields.
	searchable?: null | bool @go(Searchable,*bool)

	// Determines whether the field can be used to sort the results of a query. If you specify sorting on a field that does not have Sortable set to true, Amazon Kendra returns an exception. The default is false.
	sortable?: null | bool @go(Sortable,*bool)
}

#SearchParameters: {
	// Determines whether the field is returned in the query response. The default is true.
	// +kubebuilder:validation:Optional
	displayable?: null | bool @go(Displayable,*bool)

	// Indicates that the field can be used to create search facets, a count of results for each value in the field. The default is false.
	// +kubebuilder:validation:Optional
	facetable?: null | bool @go(Facetable,*bool)

	// Determines whether the field is used in the search. If the Searchable field is true, you can use relevance tuning to manually tune how Amazon Kendra weights the field in the search. The default is true for string fields and false for number and date fields.
	// +kubebuilder:validation:Optional
	searchable?: null | bool @go(Searchable,*bool)

	// Determines whether the field can be used to sort the results of a query. If you specify sorting on a field that does not have Sortable set to true, Amazon Kendra returns an exception. The default is false.
	// +kubebuilder:validation:Optional
	sortable?: null | bool @go(Sortable,*bool)
}

#ServerSideEncryptionConfigurationInitParameters: {
	// The identifier of the AWS KMScustomer master key (CMK). Amazon Kendra doesn't support asymmetric CMKs.
	kmsKeyId?: null | string @go(KMSKeyID,*string)
}

#ServerSideEncryptionConfigurationObservation: {
	// The identifier of the AWS KMScustomer master key (CMK). Amazon Kendra doesn't support asymmetric CMKs.
	kmsKeyId?: null | string @go(KMSKeyID,*string)
}

#ServerSideEncryptionConfigurationParameters: {
	// The identifier of the AWS KMScustomer master key (CMK). Amazon Kendra doesn't support asymmetric CMKs.
	// +kubebuilder:validation:Optional
	kmsKeyId?: null | string @go(KMSKeyID,*string)
}

#TextDocumentStatisticsInitParameters: {
}

#TextDocumentStatisticsObservation: {
	// The total size, in bytes, of the indexed documents.
	indexedTextBytes?: null | float64 @go(IndexedTextBytes,*float64)

	// The number of text documents indexed.
	indexedTextDocumentsCount?: null | float64 @go(IndexedTextDocumentsCount,*float64)
}

#TextDocumentStatisticsParameters: {
}

#UserGroupResolutionConfigurationInitParameters: {
	// The identity store provider (mode) you want to use to fetch access levels of groups and users. AWS Single Sign-On is currently the only available mode. Your users and groups must exist in an AWS SSO identity source in order to use this mode. Valid Values are AWS_SSO or NONE.
	userGroupResolutionMode?: null | string @go(UserGroupResolutionMode,*string)
}

#UserGroupResolutionConfigurationObservation: {
	// The identity store provider (mode) you want to use to fetch access levels of groups and users. AWS Single Sign-On is currently the only available mode. Your users and groups must exist in an AWS SSO identity source in order to use this mode. Valid Values are AWS_SSO or NONE.
	userGroupResolutionMode?: null | string @go(UserGroupResolutionMode,*string)
}

#UserGroupResolutionConfigurationParameters: {
	// The identity store provider (mode) you want to use to fetch access levels of groups and users. AWS Single Sign-On is currently the only available mode. Your users and groups must exist in an AWS SSO identity source in order to use this mode. Valid Values are AWS_SSO or NONE.
	// +kubebuilder:validation:Optional
	userGroupResolutionMode?: null | string @go(UserGroupResolutionMode,*string)
}

#UserTokenConfigurationsInitParameters: {
	// A block that specifies the information about the JSON token type configuration. Detailed below.
	jsonTokenTypeConfiguration?: [...#JSONTokenTypeConfigurationInitParameters] @go(JSONTokenTypeConfiguration,[]JSONTokenTypeConfigurationInitParameters)

	// A block that specifies the information about the JWT token type configuration. Detailed below.
	jwtTokenTypeConfiguration?: [...#JwtTokenTypeConfigurationInitParameters] @go(JwtTokenTypeConfiguration,[]JwtTokenTypeConfigurationInitParameters)
}

#UserTokenConfigurationsObservation: {
	// A block that specifies the information about the JSON token type configuration. Detailed below.
	jsonTokenTypeConfiguration?: [...#JSONTokenTypeConfigurationObservation] @go(JSONTokenTypeConfiguration,[]JSONTokenTypeConfigurationObservation)

	// A block that specifies the information about the JWT token type configuration. Detailed below.
	jwtTokenTypeConfiguration?: [...#JwtTokenTypeConfigurationObservation] @go(JwtTokenTypeConfiguration,[]JwtTokenTypeConfigurationObservation)
}

#UserTokenConfigurationsParameters: {
	// A block that specifies the information about the JSON token type configuration. Detailed below.
	// +kubebuilder:validation:Optional
	jsonTokenTypeConfiguration?: [...#JSONTokenTypeConfigurationParameters] @go(JSONTokenTypeConfiguration,[]JSONTokenTypeConfigurationParameters)

	// A block that specifies the information about the JWT token type configuration. Detailed below.
	// +kubebuilder:validation:Optional
	jwtTokenTypeConfiguration?: [...#JwtTokenTypeConfigurationParameters] @go(JwtTokenTypeConfiguration,[]JwtTokenTypeConfigurationParameters)
}

// IndexSpec defines the desired state of Index
#IndexSpec: {
	v1.#ResourceSpec
	forProvider: #IndexParameters @go(ForProvider)

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
	initProvider?: #IndexInitParameters @go(InitProvider)
}

// IndexStatus defines the observed state of Index.
#IndexStatus: {
	v1.#ResourceStatus
	atProvider?: #IndexObservation @go(AtProvider)
}

// Index is the Schema for the Indexs API. Provides an Amazon Kendra Index resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Index: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #IndexSpec   @go(Spec)
	status?: #IndexStatus @go(Status)
}

// IndexList contains a list of Indexs
#IndexList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Index] @go(Items,[]Index)
}
