// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/dms/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#S3EndpointInitParameters: {
	// Whether to add column name information to the .csv output file. Default is false.
	addColumnName?: null | bool @go(AddColumnName,*bool)

	// Whether to add padding. Default is false. (Ignored for source endpoints.)
	addTrailingPaddingCharacter?: null | bool @go(AddTrailingPaddingCharacter,*bool)

	// S3 object prefix.
	bucketFolder?: null | string @go(BucketFolder,*string)

	// S3 bucket name.
	bucketName?: null | string @go(BucketName,*string)

	// Predefined (canned) access control list for objects created in an S3 bucket. Valid values include none, private, public-read, public-read-write, authenticated-read, aws-exec-read, bucket-owner-read, and bucket-owner-full-control. Default is none.
	cannedAclForObjects?: null | string @go(CannedACLForObjects,*string)

	// Whether to write insert and update operations to .csv or .parquet output files. Default is false.
	cdcInsertsAndUpdates?: null | bool @go(CdcInsertsAndUpdates,*bool)

	// Whether to write insert operations to .csv or .parquet output files. Default is false.
	cdcInsertsOnly?: null | bool @go(CdcInsertsOnly,*bool)

	// Maximum length of the interval, defined in seconds, after which to output a file to Amazon S3. (AWS default is 60.)
	cdcMaxBatchInterval?: null | float64 @go(CdcMaxBatchInterval,*float64)

	// Minimum file size condition as defined in kilobytes to output a file to Amazon S3. (AWS default is 32000 KB.)
	cdcMinFileSize?: null | float64 @go(CdcMinFileSize,*float64)

	// Folder path of CDC files. If cdc_path is set, AWS DMS reads CDC files from this path and replicates the data changes to the target endpoint. Supported in AWS DMS versions 3.4.2 and later.
	cdcPath?: null | string @go(CdcPath,*string)

	// ARN for the certificate.
	certificateArn?: null | string @go(CertificateArn,*string)

	// Set to compress target files. Valid values are GZIP and NONE. Default is NONE. (Ignored for source endpoints.)
	compressionType?: null | string @go(CompressionType,*string)

	// Delimiter used to separate columns in the source files. Default is ,.
	csvDelimiter?: null | string @go(CsvDelimiter,*string)

	// Only applies if output files for a CDC load are written in .csv format. If use_csv_no_sup_value is set to true, string to use for all columns not included in the supplemental log. If you do not specify a string value, DMS uses the null value for these columns regardless of use_csv_no_sup_value. (Ignored for source endpoints.)
	csvNoSupValue?: null | string @go(CsvNoSupValue,*string)

	// String to as null when writing to the target. (AWS default is NULL.)
	csvNullValue?: null | string @go(CsvNullValue,*string)

	// Delimiter used to separate rows in the source files. Default is newline (i.e., \n).
	csvRowDelimiter?: null | string @go(CsvRowDelimiter,*string)

	// Output format for the files that AWS DMS uses to create S3 objects. Valid values are csv and parquet.  (Ignored for source endpoints -- only csv is valid.)
	dataFormat?: null | string @go(DataFormat,*string)

	// Size of one data page in bytes. (AWS default is 1 MiB, i.e., 1048576.)
	dataPageSize?: null | float64 @go(DataPageSize,*float64)

	// Date separating delimiter to use during folder partitioning. Valid values are SLASH, UNDERSCORE, DASH, and NONE. (AWS default is SLASH.) (Ignored for source endpoints.)
	datePartitionDelimiter?: null | string @go(DatePartitionDelimiter,*string)

	// Partition S3 bucket folders based on transaction commit dates. Default is false. (Ignored for source endpoints.)
	datePartitionEnabled?: null | bool @go(DatePartitionEnabled,*bool)

	// Date format to use during folder partitioning. Use this parameter when date_partition_enabled is set to true. Valid values are YYYYMMDD, YYYYMMDDHH, YYYYMM, MMYYYYDD, and DDMMYYYY. (AWS default is YYYYMMDD.) (Ignored for source endpoints.)
	datePartitionSequence?: null | string @go(DatePartitionSequence,*string)

	// Convert the current UTC time to a timezone. The conversion occurs when a date partition folder is created and a CDC filename is generated. The timezone format is Area/Location (e.g., Europe/Paris). Use this when date_partition_enabled is true. (Ignored for source endpoints.)
	datePartitionTimezone?: null | string @go(DatePartitionTimezone,*string)

	// Undocumented argument for use as directed by AWS Support.
	detachTargetOnLobLookupFailureParquet?: null | bool @go(DetachTargetOnLobLookupFailureParquet,*bool)

	// Maximum size in bytes of an encoded dictionary page of a column. (AWS default is 1 MiB, i.e., 1048576.)
	dictPageSizeLimit?: null | float64 @go(DictPageSizeLimit,*float64)

	// Whether to enable statistics for Parquet pages and row groups. Default is true.
	enableStatistics?: null | bool @go(EnableStatistics,*bool)

	// Type of encoding to use. Value values are rle_dictionary, plain, and plain_dictionary. (AWS default is rle_dictionary.)
	encodingType?: null | string @go(EncodingType,*string)

	// Server-side encryption mode that you want to encrypt your .csv or .parquet object files copied to S3. Valid values are SSE_S3 and SSE_KMS. (AWS default is SSE_S3.) (Ignored for source endpoints -- only SSE_S3 is valid.)
	encryptionMode?: null | string @go(EncryptionMode,*string)

	// Type of endpoint. Valid values are source, target.
	endpointType?: null | string @go(EndpointType,*string)

	// Bucket owner to prevent sniping. Value is an AWS account ID.
	expectedBucketOwner?: null | string @go(ExpectedBucketOwner,*string)

	// JSON document that describes how AWS DMS should interpret the data.
	externalTableDefinition?: null | string @go(ExternalTableDefinition,*string)

	// When this value is set to 1, DMS ignores the first row header in a .csv file. (AWS default is 0.)
	ignoreHeaderRows?: null | float64 @go(IgnoreHeaderRows,*float64)

	// Whether to enable a full load to write INSERT operations to the .csv output files only to indicate how the rows were added to the source database. Default is false.
	includeOpForFullLoad?: null | bool @go(IncludeOpForFullLoad,*bool)

	// Maximum size (in KB) of any .csv file to be created while migrating to an S3 target during full load. Valid values are from 1 to 1048576. (AWS default is 1 GB, i.e., 1048576.)
	maxFileSize?: null | float64 @go(MaxFileSize,*float64)

	// - Specifies the precision of any TIMESTAMP column values written to an S3 object file in .parquet format. Default is false. (Ignored for source endpoints.)
	parquetTimestampInMillisecond?: null | bool @go(ParquetTimestampInMillisecond,*bool)

	// Version of the .parquet file format. Valid values are parquet-1-0 and parquet-2-0. (AWS default is parquet-1-0.) (Ignored for source endpoints.)
	parquetVersion?: null | string @go(ParquetVersion,*string)

	// Whether DMS saves the transaction order for a CDC load on the S3 target specified by cdc_path. Default is false. (Ignored for source endpoints.)
	preserveTransactions?: null | bool @go(PreserveTransactions,*bool)

	// For an S3 source, whether each leading double quotation mark has to be followed by an ending double quotation mark. Default is true.
	rfc4180?: null | bool @go(Rfc4180,*bool)

	// Number of rows in a row group. (AWS default is 10000.)
	rowGroupLength?: null | float64 @go(RowGroupLength,*float64)

	// SSL mode to use for the connection. Valid values are none, require, verify-ca, verify-full. (AWS default is none.)
	sslMode?: null | string @go(SSLMode,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Column to add with timestamp information to the endpoint data for an Amazon S3 target.
	timestampColumnName?: null | string @go(TimestampColumnName,*string)

	// Whether to use csv_no_sup_value for columns not included in the supplemental log. (Ignored for source endpoints.)
	useCsvNoSupValue?: null | bool @go(UseCsvNoSupValue,*bool)

	// When set to true, uses the task start time as the timestamp column value instead of the time data is written to target. For full load, when set to true, each row of the timestamp column contains the task start time. For CDC loads, each row of the timestamp column contains the transaction commit time.When set to false, the full load timestamp in the timestamp column increments with the time data arrives at the target. Default is false.
	useTaskStartTimeForFullLoadTimestamp?: null | bool @go(UseTaskStartTimeForFullLoadTimestamp,*bool)
}

#S3EndpointObservation: {
	// Whether to add column name information to the .csv output file. Default is false.
	addColumnName?: null | bool @go(AddColumnName,*bool)

	// Whether to add padding. Default is false. (Ignored for source endpoints.)
	addTrailingPaddingCharacter?: null | bool @go(AddTrailingPaddingCharacter,*bool)

	// S3 object prefix.
	bucketFolder?: null | string @go(BucketFolder,*string)

	// S3 bucket name.
	bucketName?: null | string @go(BucketName,*string)

	// Predefined (canned) access control list for objects created in an S3 bucket. Valid values include none, private, public-read, public-read-write, authenticated-read, aws-exec-read, bucket-owner-read, and bucket-owner-full-control. Default is none.
	cannedAclForObjects?: null | string @go(CannedACLForObjects,*string)

	// Whether to write insert and update operations to .csv or .parquet output files. Default is false.
	cdcInsertsAndUpdates?: null | bool @go(CdcInsertsAndUpdates,*bool)

	// Whether to write insert operations to .csv or .parquet output files. Default is false.
	cdcInsertsOnly?: null | bool @go(CdcInsertsOnly,*bool)

	// Maximum length of the interval, defined in seconds, after which to output a file to Amazon S3. (AWS default is 60.)
	cdcMaxBatchInterval?: null | float64 @go(CdcMaxBatchInterval,*float64)

	// Minimum file size condition as defined in kilobytes to output a file to Amazon S3. (AWS default is 32000 KB.)
	cdcMinFileSize?: null | float64 @go(CdcMinFileSize,*float64)

	// Folder path of CDC files. If cdc_path is set, AWS DMS reads CDC files from this path and replicates the data changes to the target endpoint. Supported in AWS DMS versions 3.4.2 and later.
	cdcPath?: null | string @go(CdcPath,*string)

	// ARN for the certificate.
	certificateArn?: null | string @go(CertificateArn,*string)

	// Set to compress target files. Valid values are GZIP and NONE. Default is NONE. (Ignored for source endpoints.)
	compressionType?: null | string @go(CompressionType,*string)

	// Delimiter used to separate columns in the source files. Default is ,.
	csvDelimiter?: null | string @go(CsvDelimiter,*string)

	// Only applies if output files for a CDC load are written in .csv format. If use_csv_no_sup_value is set to true, string to use for all columns not included in the supplemental log. If you do not specify a string value, DMS uses the null value for these columns regardless of use_csv_no_sup_value. (Ignored for source endpoints.)
	csvNoSupValue?: null | string @go(CsvNoSupValue,*string)

	// String to as null when writing to the target. (AWS default is NULL.)
	csvNullValue?: null | string @go(CsvNullValue,*string)

	// Delimiter used to separate rows in the source files. Default is newline (i.e., \n).
	csvRowDelimiter?: null | string @go(CsvRowDelimiter,*string)

	// Output format for the files that AWS DMS uses to create S3 objects. Valid values are csv and parquet.  (Ignored for source endpoints -- only csv is valid.)
	dataFormat?: null | string @go(DataFormat,*string)

	// Size of one data page in bytes. (AWS default is 1 MiB, i.e., 1048576.)
	dataPageSize?: null | float64 @go(DataPageSize,*float64)

	// Date separating delimiter to use during folder partitioning. Valid values are SLASH, UNDERSCORE, DASH, and NONE. (AWS default is SLASH.) (Ignored for source endpoints.)
	datePartitionDelimiter?: null | string @go(DatePartitionDelimiter,*string)

	// Partition S3 bucket folders based on transaction commit dates. Default is false. (Ignored for source endpoints.)
	datePartitionEnabled?: null | bool @go(DatePartitionEnabled,*bool)

	// Date format to use during folder partitioning. Use this parameter when date_partition_enabled is set to true. Valid values are YYYYMMDD, YYYYMMDDHH, YYYYMM, MMYYYYDD, and DDMMYYYY. (AWS default is YYYYMMDD.) (Ignored for source endpoints.)
	datePartitionSequence?: null | string @go(DatePartitionSequence,*string)

	// Convert the current UTC time to a timezone. The conversion occurs when a date partition folder is created and a CDC filename is generated. The timezone format is Area/Location (e.g., Europe/Paris). Use this when date_partition_enabled is true. (Ignored for source endpoints.)
	datePartitionTimezone?: null | string @go(DatePartitionTimezone,*string)

	// Undocumented argument for use as directed by AWS Support.
	detachTargetOnLobLookupFailureParquet?: null | bool @go(DetachTargetOnLobLookupFailureParquet,*bool)

	// Maximum size in bytes of an encoded dictionary page of a column. (AWS default is 1 MiB, i.e., 1048576.)
	dictPageSizeLimit?: null | float64 @go(DictPageSizeLimit,*float64)

	// Whether to enable statistics for Parquet pages and row groups. Default is true.
	enableStatistics?: null | bool @go(EnableStatistics,*bool)

	// Type of encoding to use. Value values are rle_dictionary, plain, and plain_dictionary. (AWS default is rle_dictionary.)
	encodingType?: null | string @go(EncodingType,*string)

	// Server-side encryption mode that you want to encrypt your .csv or .parquet object files copied to S3. Valid values are SSE_S3 and SSE_KMS. (AWS default is SSE_S3.) (Ignored for source endpoints -- only SSE_S3 is valid.)
	encryptionMode?: null | string @go(EncryptionMode,*string)

	// ARN for the endpoint.
	endpointArn?: null | string @go(EndpointArn,*string)

	// Type of endpoint. Valid values are source, target.
	endpointType?: null | string @go(EndpointType,*string)

	// Expanded name for the engine name.
	engineDisplayName?: null | string @go(EngineDisplayName,*string)

	// Bucket owner to prevent sniping. Value is an AWS account ID.
	expectedBucketOwner?: null | string @go(ExpectedBucketOwner,*string)

	// Can be used for cross-account validation. Use it in another account with aws_dms_s3_endpoint to create the endpoint cross-account.
	externalId?: null | string @go(ExternalID,*string)

	// JSON document that describes how AWS DMS should interpret the data.
	externalTableDefinition?: null | string @go(ExternalTableDefinition,*string)
	id?:                      null | string @go(ID,*string)

	// When this value is set to 1, DMS ignores the first row header in a .csv file. (AWS default is 0.)
	ignoreHeaderRows?: null | float64 @go(IgnoreHeaderRows,*float64)

	// Whether to enable a full load to write INSERT operations to the .csv output files only to indicate how the rows were added to the source database. Default is false.
	includeOpForFullLoad?: null | bool @go(IncludeOpForFullLoad,*bool)

	// ARN for the KMS key that will be used to encrypt the connection parameters. If you do not specify a value for kms_key_arn, then AWS DMS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS region.
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)

	// Maximum size (in KB) of any .csv file to be created while migrating to an S3 target during full load. Valid values are from 1 to 1048576. (AWS default is 1 GB, i.e., 1048576.)
	maxFileSize?: null | float64 @go(MaxFileSize,*float64)

	// - Specifies the precision of any TIMESTAMP column values written to an S3 object file in .parquet format. Default is false. (Ignored for source endpoints.)
	parquetTimestampInMillisecond?: null | bool @go(ParquetTimestampInMillisecond,*bool)

	// Version of the .parquet file format. Valid values are parquet-1-0 and parquet-2-0. (AWS default is parquet-1-0.) (Ignored for source endpoints.)
	parquetVersion?: null | string @go(ParquetVersion,*string)

	// Whether DMS saves the transaction order for a CDC load on the S3 target specified by cdc_path. Default is false. (Ignored for source endpoints.)
	preserveTransactions?: null | bool @go(PreserveTransactions,*bool)

	// For an S3 source, whether each leading double quotation mark has to be followed by an ending double quotation mark. Default is true.
	rfc4180?: null | bool @go(Rfc4180,*bool)

	// Number of rows in a row group. (AWS default is 10000.)
	rowGroupLength?: null | float64 @go(RowGroupLength,*float64)

	// SSL mode to use for the connection. Valid values are none, require, verify-ca, verify-full. (AWS default is none.)
	sslMode?: null | string @go(SSLMode,*string)

	// When encryption_mode is SSE_KMS, ARN for the AWS KMS key. (Ignored for source endpoints -- only SSE_S3 encryption_mode is valid.)
	serverSideEncryptionKmsKeyId?: null | string @go(ServerSideEncryptionKMSKeyID,*string)

	// ARN of the IAM role with permissions to the S3 Bucket.
	serviceAccessRoleArn?: null | string @go(ServiceAccessRoleArn,*string)

	// Status of the endpoint.
	status?: null | string @go(Status,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Column to add with timestamp information to the endpoint data for an Amazon S3 target.
	timestampColumnName?: null | string @go(TimestampColumnName,*string)

	// Whether to use csv_no_sup_value for columns not included in the supplemental log. (Ignored for source endpoints.)
	useCsvNoSupValue?: null | bool @go(UseCsvNoSupValue,*bool)

	// When set to true, uses the task start time as the timestamp column value instead of the time data is written to target. For full load, when set to true, each row of the timestamp column contains the task start time. For CDC loads, each row of the timestamp column contains the transaction commit time.When set to false, the full load timestamp in the timestamp column increments with the time data arrives at the target. Default is false.
	useTaskStartTimeForFullLoadTimestamp?: null | bool @go(UseTaskStartTimeForFullLoadTimestamp,*bool)
}

#S3EndpointParameters: {
	// Whether to add column name information to the .csv output file. Default is false.
	// +kubebuilder:validation:Optional
	addColumnName?: null | bool @go(AddColumnName,*bool)

	// Whether to add padding. Default is false. (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	addTrailingPaddingCharacter?: null | bool @go(AddTrailingPaddingCharacter,*bool)

	// S3 object prefix.
	// +kubebuilder:validation:Optional
	bucketFolder?: null | string @go(BucketFolder,*string)

	// S3 bucket name.
	// +kubebuilder:validation:Optional
	bucketName?: null | string @go(BucketName,*string)

	// Predefined (canned) access control list for objects created in an S3 bucket. Valid values include none, private, public-read, public-read-write, authenticated-read, aws-exec-read, bucket-owner-read, and bucket-owner-full-control. Default is none.
	// +kubebuilder:validation:Optional
	cannedAclForObjects?: null | string @go(CannedACLForObjects,*string)

	// Whether to write insert and update operations to .csv or .parquet output files. Default is false.
	// +kubebuilder:validation:Optional
	cdcInsertsAndUpdates?: null | bool @go(CdcInsertsAndUpdates,*bool)

	// Whether to write insert operations to .csv or .parquet output files. Default is false.
	// +kubebuilder:validation:Optional
	cdcInsertsOnly?: null | bool @go(CdcInsertsOnly,*bool)

	// Maximum length of the interval, defined in seconds, after which to output a file to Amazon S3. (AWS default is 60.)
	// +kubebuilder:validation:Optional
	cdcMaxBatchInterval?: null | float64 @go(CdcMaxBatchInterval,*float64)

	// Minimum file size condition as defined in kilobytes to output a file to Amazon S3. (AWS default is 32000 KB.)
	// +kubebuilder:validation:Optional
	cdcMinFileSize?: null | float64 @go(CdcMinFileSize,*float64)

	// Folder path of CDC files. If cdc_path is set, AWS DMS reads CDC files from this path and replicates the data changes to the target endpoint. Supported in AWS DMS versions 3.4.2 and later.
	// +kubebuilder:validation:Optional
	cdcPath?: null | string @go(CdcPath,*string)

	// ARN for the certificate.
	// +kubebuilder:validation:Optional
	certificateArn?: null | string @go(CertificateArn,*string)

	// Set to compress target files. Valid values are GZIP and NONE. Default is NONE. (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	compressionType?: null | string @go(CompressionType,*string)

	// Delimiter used to separate columns in the source files. Default is ,.
	// +kubebuilder:validation:Optional
	csvDelimiter?: null | string @go(CsvDelimiter,*string)

	// Only applies if output files for a CDC load are written in .csv format. If use_csv_no_sup_value is set to true, string to use for all columns not included in the supplemental log. If you do not specify a string value, DMS uses the null value for these columns regardless of use_csv_no_sup_value. (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	csvNoSupValue?: null | string @go(CsvNoSupValue,*string)

	// String to as null when writing to the target. (AWS default is NULL.)
	// +kubebuilder:validation:Optional
	csvNullValue?: null | string @go(CsvNullValue,*string)

	// Delimiter used to separate rows in the source files. Default is newline (i.e., \n).
	// +kubebuilder:validation:Optional
	csvRowDelimiter?: null | string @go(CsvRowDelimiter,*string)

	// Output format for the files that AWS DMS uses to create S3 objects. Valid values are csv and parquet.  (Ignored for source endpoints -- only csv is valid.)
	// +kubebuilder:validation:Optional
	dataFormat?: null | string @go(DataFormat,*string)

	// Size of one data page in bytes. (AWS default is 1 MiB, i.e., 1048576.)
	// +kubebuilder:validation:Optional
	dataPageSize?: null | float64 @go(DataPageSize,*float64)

	// Date separating delimiter to use during folder partitioning. Valid values are SLASH, UNDERSCORE, DASH, and NONE. (AWS default is SLASH.) (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	datePartitionDelimiter?: null | string @go(DatePartitionDelimiter,*string)

	// Partition S3 bucket folders based on transaction commit dates. Default is false. (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	datePartitionEnabled?: null | bool @go(DatePartitionEnabled,*bool)

	// Date format to use during folder partitioning. Use this parameter when date_partition_enabled is set to true. Valid values are YYYYMMDD, YYYYMMDDHH, YYYYMM, MMYYYYDD, and DDMMYYYY. (AWS default is YYYYMMDD.) (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	datePartitionSequence?: null | string @go(DatePartitionSequence,*string)

	// Convert the current UTC time to a timezone. The conversion occurs when a date partition folder is created and a CDC filename is generated. The timezone format is Area/Location (e.g., Europe/Paris). Use this when date_partition_enabled is true. (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	datePartitionTimezone?: null | string @go(DatePartitionTimezone,*string)

	// Undocumented argument for use as directed by AWS Support.
	// +kubebuilder:validation:Optional
	detachTargetOnLobLookupFailureParquet?: null | bool @go(DetachTargetOnLobLookupFailureParquet,*bool)

	// Maximum size in bytes of an encoded dictionary page of a column. (AWS default is 1 MiB, i.e., 1048576.)
	// +kubebuilder:validation:Optional
	dictPageSizeLimit?: null | float64 @go(DictPageSizeLimit,*float64)

	// Whether to enable statistics for Parquet pages and row groups. Default is true.
	// +kubebuilder:validation:Optional
	enableStatistics?: null | bool @go(EnableStatistics,*bool)

	// Type of encoding to use. Value values are rle_dictionary, plain, and plain_dictionary. (AWS default is rle_dictionary.)
	// +kubebuilder:validation:Optional
	encodingType?: null | string @go(EncodingType,*string)

	// Server-side encryption mode that you want to encrypt your .csv or .parquet object files copied to S3. Valid values are SSE_S3 and SSE_KMS. (AWS default is SSE_S3.) (Ignored for source endpoints -- only SSE_S3 is valid.)
	// +kubebuilder:validation:Optional
	encryptionMode?: null | string @go(EncryptionMode,*string)

	// Type of endpoint. Valid values are source, target.
	// +kubebuilder:validation:Optional
	endpointType?: null | string @go(EndpointType,*string)

	// Bucket owner to prevent sniping. Value is an AWS account ID.
	// +kubebuilder:validation:Optional
	expectedBucketOwner?: null | string @go(ExpectedBucketOwner,*string)

	// JSON document that describes how AWS DMS should interpret the data.
	// +kubebuilder:validation:Optional
	externalTableDefinition?: null | string @go(ExternalTableDefinition,*string)

	// When this value is set to 1, DMS ignores the first row header in a .csv file. (AWS default is 0.)
	// +kubebuilder:validation:Optional
	ignoreHeaderRows?: null | float64 @go(IgnoreHeaderRows,*float64)

	// Whether to enable a full load to write INSERT operations to the .csv output files only to indicate how the rows were added to the source database. Default is false.
	// +kubebuilder:validation:Optional
	includeOpForFullLoad?: null | bool @go(IncludeOpForFullLoad,*bool)

	// ARN for the KMS key that will be used to encrypt the connection parameters. If you do not specify a value for kms_key_arn, then AWS DMS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS region.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +kubebuilder:validation:Optional
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)

	// Reference to a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnRef?: null | v1.#Reference @go(KMSKeyArnRef,*v1.Reference)

	// Selector for a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnSelector?: null | v1.#Selector @go(KMSKeyArnSelector,*v1.Selector)

	// Maximum size (in KB) of any .csv file to be created while migrating to an S3 target during full load. Valid values are from 1 to 1048576. (AWS default is 1 GB, i.e., 1048576.)
	// +kubebuilder:validation:Optional
	maxFileSize?: null | float64 @go(MaxFileSize,*float64)

	// - Specifies the precision of any TIMESTAMP column values written to an S3 object file in .parquet format. Default is false. (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	parquetTimestampInMillisecond?: null | bool @go(ParquetTimestampInMillisecond,*bool)

	// Version of the .parquet file format. Valid values are parquet-1-0 and parquet-2-0. (AWS default is parquet-1-0.) (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	parquetVersion?: null | string @go(ParquetVersion,*string)

	// Whether DMS saves the transaction order for a CDC load on the S3 target specified by cdc_path. Default is false. (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	preserveTransactions?: null | bool @go(PreserveTransactions,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// For an S3 source, whether each leading double quotation mark has to be followed by an ending double quotation mark. Default is true.
	// +kubebuilder:validation:Optional
	rfc4180?: null | bool @go(Rfc4180,*bool)

	// Number of rows in a row group. (AWS default is 10000.)
	// +kubebuilder:validation:Optional
	rowGroupLength?: null | float64 @go(RowGroupLength,*float64)

	// SSL mode to use for the connection. Valid values are none, require, verify-ca, verify-full. (AWS default is none.)
	// +kubebuilder:validation:Optional
	sslMode?: null | string @go(SSLMode,*string)

	// When encryption_mode is SSE_KMS, ARN for the AWS KMS key. (Ignored for source endpoints -- only SSE_S3 encryption_mode is valid.)
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	serverSideEncryptionKmsKeyId?: null | string @go(ServerSideEncryptionKMSKeyID,*string)

	// Reference to a Key in kms to populate serverSideEncryptionKmsKeyId.
	// +kubebuilder:validation:Optional
	serverSideEncryptionKmsKeyIdRef?: null | v1.#Reference @go(ServerSideEncryptionKMSKeyIDRef,*v1.Reference)

	// Selector for a Key in kms to populate serverSideEncryptionKmsKeyId.
	// +kubebuilder:validation:Optional
	serverSideEncryptionKmsKeyIdSelector?: null | v1.#Selector @go(ServerSideEncryptionKMSKeyIDSelector,*v1.Selector)

	// ARN of the IAM role with permissions to the S3 Bucket.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	serviceAccessRoleArn?: null | string @go(ServiceAccessRoleArn,*string)

	// Reference to a Role in iam to populate serviceAccessRoleArn.
	// +kubebuilder:validation:Optional
	serviceAccessRoleArnRef?: null | v1.#Reference @go(ServiceAccessRoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate serviceAccessRoleArn.
	// +kubebuilder:validation:Optional
	serviceAccessRoleArnSelector?: null | v1.#Selector @go(ServiceAccessRoleArnSelector,*v1.Selector)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Column to add with timestamp information to the endpoint data for an Amazon S3 target.
	// +kubebuilder:validation:Optional
	timestampColumnName?: null | string @go(TimestampColumnName,*string)

	// Whether to use csv_no_sup_value for columns not included in the supplemental log. (Ignored for source endpoints.)
	// +kubebuilder:validation:Optional
	useCsvNoSupValue?: null | bool @go(UseCsvNoSupValue,*bool)

	// When set to true, uses the task start time as the timestamp column value instead of the time data is written to target. For full load, when set to true, each row of the timestamp column contains the task start time. For CDC loads, each row of the timestamp column contains the transaction commit time.When set to false, the full load timestamp in the timestamp column increments with the time data arrives at the target. Default is false.
	// +kubebuilder:validation:Optional
	useTaskStartTimeForFullLoadTimestamp?: null | bool @go(UseTaskStartTimeForFullLoadTimestamp,*bool)
}

// S3EndpointSpec defines the desired state of S3Endpoint
#S3EndpointSpec: {
	v1.#ResourceSpec
	forProvider: #S3EndpointParameters @go(ForProvider)

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
	initProvider?: #S3EndpointInitParameters @go(InitProvider)
}

// S3EndpointStatus defines the observed state of S3Endpoint.
#S3EndpointStatus: {
	v1.#ResourceStatus
	atProvider?: #S3EndpointObservation @go(AtProvider)
}

// S3Endpoint is the Schema for the S3Endpoints API. Provides a DMS (Data Migration Service) S3 endpoint resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#S3Endpoint: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.bucketName) || (has(self.initProvider) && has(self.initProvider.bucketName))",message="spec.forProvider.bucketName is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.endpointType) || (has(self.initProvider) && has(self.initProvider.endpointType))",message="spec.forProvider.endpointType is a required parameter"
	spec:    #S3EndpointSpec   @go(Spec)
	status?: #S3EndpointStatus @go(Status)
}

// S3EndpointList contains a list of S3Endpoints
#S3EndpointList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#S3Endpoint] @go(Items,[]S3Endpoint)
}
