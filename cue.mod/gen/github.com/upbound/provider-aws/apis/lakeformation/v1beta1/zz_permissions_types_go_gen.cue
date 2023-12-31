// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/lakeformation/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DataLocationInitParameters: {
	// Identifier for the Data Catalog where the location is registered with Lake Formation. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)
}

#DataLocationObservation: {
	// –  Amazon Resource Name (ARN) that uniquely identifies the data location resource.
	arn?: null | string @go(Arn,*string)

	// Identifier for the Data Catalog where the location is registered with Lake Formation. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)
}

#DataLocationParameters: {
	// –  Amazon Resource Name (ARN) that uniquely identifies the data location resource.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/lakeformation/v1beta1.Resource
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",false)
	// +kubebuilder:validation:Optional
	arn?: null | string @go(Arn,*string)

	// Reference to a Resource in lakeformation to populate arn.
	// +kubebuilder:validation:Optional
	arnRef?: null | v1.#Reference @go(ArnRef,*v1.Reference)

	// Selector for a Resource in lakeformation to populate arn.
	// +kubebuilder:validation:Optional
	arnSelector?: null | v1.#Selector @go(ArnSelector,*v1.Selector)

	// Identifier for the Data Catalog where the location is registered with Lake Formation. By default, it is the account ID of the caller.
	// +kubebuilder:validation:Optional
	catalogId?: null | string @go(CatalogID,*string)
}

#DatabaseInitParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)
}

#DatabaseObservation: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)

	// –  Name of the database resource. Unique to the Data Catalog.
	name?: null | string @go(Name,*string)
}

#DatabaseParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	// +kubebuilder:validation:Optional
	catalogId?: null | string @go(CatalogID,*string)

	// –  Name of the database resource. Unique to the Data Catalog.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/glue/v1beta1.CatalogDatabase
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Reference to a CatalogDatabase in glue to populate name.
	// +kubebuilder:validation:Optional
	nameRef?: null | v1.#Reference @go(NameRef,*v1.Reference)

	// Selector for a CatalogDatabase in glue to populate name.
	// +kubebuilder:validation:Optional
	nameSelector?: null | v1.#Selector @go(NameSelector,*v1.Selector)
}

#ExpressionInitParameters: {
	// name of an LF-Tag.
	key?: null | string @go(Key,*string)

	// A list of possible values of an LF-Tag.
	values?: [...null | string] @go(Values,[]*string)
}

#ExpressionObservation: {
	// name of an LF-Tag.
	key?: null | string @go(Key,*string)

	// A list of possible values of an LF-Tag.
	values?: [...null | string] @go(Values,[]*string)
}

#ExpressionParameters: {
	// name of an LF-Tag.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// A list of possible values of an LF-Tag.
	// +kubebuilder:validation:Optional
	values: [...null | string] @go(Values,[]*string)
}

#LfTagInitParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)

	// name for the tag.
	key?: null | string @go(Key,*string)

	// A list of possible values an attribute can take.
	values?: [...null | string] @go(Values,[]*string)
}

#LfTagObservation: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)

	// name for the tag.
	key?: null | string @go(Key,*string)

	// A list of possible values an attribute can take.
	values?: [...null | string] @go(Values,[]*string)
}

#LfTagParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	// +kubebuilder:validation:Optional
	catalogId?: null | string @go(CatalogID,*string)

	// name for the tag.
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// A list of possible values an attribute can take.
	// +kubebuilder:validation:Optional
	values: [...null | string] @go(Values,[]*string)
}

#LfTagPolicyInitParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)

	// A list of tag conditions that apply to the resource's tag policy. Configuration block for tag conditions that apply to the policy. See expression below.
	expression?: [...#ExpressionInitParameters] @go(Expression,[]ExpressionInitParameters)

	// –  The resource type for which the tag policy applies. Valid values are DATABASE and TABLE.
	resourceType?: null | string @go(ResourceType,*string)
}

#LfTagPolicyObservation: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)

	// A list of tag conditions that apply to the resource's tag policy. Configuration block for tag conditions that apply to the policy. See expression below.
	expression?: [...#ExpressionObservation] @go(Expression,[]ExpressionObservation)

	// –  The resource type for which the tag policy applies. Valid values are DATABASE and TABLE.
	resourceType?: null | string @go(ResourceType,*string)
}

#LfTagPolicyParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	// +kubebuilder:validation:Optional
	catalogId?: null | string @go(CatalogID,*string)

	// A list of tag conditions that apply to the resource's tag policy. Configuration block for tag conditions that apply to the policy. See expression below.
	// +kubebuilder:validation:Optional
	expression: [...#ExpressionParameters] @go(Expression,[]ExpressionParameters)

	// –  The resource type for which the tag policy applies. Valid values are DATABASE and TABLE.
	// +kubebuilder:validation:Optional
	resourceType?: null | string @go(ResourceType,*string)
}

#PermissionsInitParameters: {
	// –  Identifier for the Data Catalog. By default, the account ID. The Data Catalog is the persistent metadata store. It contains database definitions, table definitions, and other control information to manage your Lake Formation environment.
	catalogId?: null | string @go(CatalogID,*string)

	// Whether the permissions are to be granted for the Data Catalog. Defaults to false.
	catalogResource?: null | bool @go(CatalogResource,*bool)

	// Configuration block for a data location resource. Detailed below.
	dataLocation?: [...#DataLocationInitParameters] @go(DataLocation,[]DataLocationInitParameters)

	// Configuration block for a database resource. Detailed below.
	database?: [...#DatabaseInitParameters] @go(Database,[]DatabaseInitParameters)

	// Configuration block for an LF-tag resource. Detailed below.
	lfTag?: [...#LfTagInitParameters] @go(LfTag,[]LfTagInitParameters)

	// Configuration block for an LF-tag policy resource. Detailed below.
	lfTagPolicy?: [...#LfTagPolicyInitParameters] @go(LfTagPolicy,[]LfTagPolicyInitParameters)

	// –  List of permissions granted to the principal. Valid values may include ALL, ALTER, ASSOCIATE, CREATE_DATABASE, CREATE_TABLE, DATA_LOCATION_ACCESS, DELETE, DESCRIBE, DROP, INSERT, and SELECT. For details on each permission, see Lake Formation Permissions Reference.
	permissions?: [...null | string] @go(Permissions,[]*string)

	// Subset of permissions which the principal can pass.
	permissionsWithGrantOption?: [...null | string] @go(PermissionsWithGrantOption,[]*string)

	// account permissions. For more information, see Lake Formation Permissions Reference.
	principal?: null | string @go(Principal,*string)

	// Configuration block for a table resource. Detailed below.
	table?: [...#TableInitParameters] @go(Table,[]TableInitParameters)

	// Configuration block for a table with columns resource. Detailed below.
	tableWithColumns?: [...#TableWithColumnsInitParameters] @go(TableWithColumns,[]TableWithColumnsInitParameters)
}

#PermissionsObservation: {
	// –  Identifier for the Data Catalog. By default, the account ID. The Data Catalog is the persistent metadata store. It contains database definitions, table definitions, and other control information to manage your Lake Formation environment.
	catalogId?: null | string @go(CatalogID,*string)

	// Whether the permissions are to be granted for the Data Catalog. Defaults to false.
	catalogResource?: null | bool @go(CatalogResource,*bool)

	// Configuration block for a data location resource. Detailed below.
	dataLocation?: [...#DataLocationObservation] @go(DataLocation,[]DataLocationObservation)

	// Configuration block for a database resource. Detailed below.
	database?: [...#DatabaseObservation] @go(Database,[]DatabaseObservation)
	id?: null | string @go(ID,*string)

	// Configuration block for an LF-tag resource. Detailed below.
	lfTag?: [...#LfTagObservation] @go(LfTag,[]LfTagObservation)

	// Configuration block for an LF-tag policy resource. Detailed below.
	lfTagPolicy?: [...#LfTagPolicyObservation] @go(LfTagPolicy,[]LfTagPolicyObservation)

	// –  List of permissions granted to the principal. Valid values may include ALL, ALTER, ASSOCIATE, CREATE_DATABASE, CREATE_TABLE, DATA_LOCATION_ACCESS, DELETE, DESCRIBE, DROP, INSERT, and SELECT. For details on each permission, see Lake Formation Permissions Reference.
	permissions?: [...null | string] @go(Permissions,[]*string)

	// Subset of permissions which the principal can pass.
	permissionsWithGrantOption?: [...null | string] @go(PermissionsWithGrantOption,[]*string)

	// account permissions. For more information, see Lake Formation Permissions Reference.
	principal?: null | string @go(Principal,*string)

	// Configuration block for a table resource. Detailed below.
	table?: [...#TableObservation] @go(Table,[]TableObservation)

	// Configuration block for a table with columns resource. Detailed below.
	tableWithColumns?: [...#TableWithColumnsObservation] @go(TableWithColumns,[]TableWithColumnsObservation)
}

#PermissionsParameters: {
	// –  Identifier for the Data Catalog. By default, the account ID. The Data Catalog is the persistent metadata store. It contains database definitions, table definitions, and other control information to manage your Lake Formation environment.
	// +kubebuilder:validation:Optional
	catalogId?: null | string @go(CatalogID,*string)

	// Whether the permissions are to be granted for the Data Catalog. Defaults to false.
	// +kubebuilder:validation:Optional
	catalogResource?: null | bool @go(CatalogResource,*bool)

	// Configuration block for a data location resource. Detailed below.
	// +kubebuilder:validation:Optional
	dataLocation?: [...#DataLocationParameters] @go(DataLocation,[]DataLocationParameters)

	// Configuration block for a database resource. Detailed below.
	// +kubebuilder:validation:Optional
	database?: [...#DatabaseParameters] @go(Database,[]DatabaseParameters)

	// Configuration block for an LF-tag resource. Detailed below.
	// +kubebuilder:validation:Optional
	lfTag?: [...#LfTagParameters] @go(LfTag,[]LfTagParameters)

	// Configuration block for an LF-tag policy resource. Detailed below.
	// +kubebuilder:validation:Optional
	lfTagPolicy?: [...#LfTagPolicyParameters] @go(LfTagPolicy,[]LfTagPolicyParameters)

	// –  List of permissions granted to the principal. Valid values may include ALL, ALTER, ASSOCIATE, CREATE_DATABASE, CREATE_TABLE, DATA_LOCATION_ACCESS, DELETE, DESCRIBE, DROP, INSERT, and SELECT. For details on each permission, see Lake Formation Permissions Reference.
	// +kubebuilder:validation:Optional
	permissions?: [...null | string] @go(Permissions,[]*string)

	// Subset of permissions which the principal can pass.
	// +kubebuilder:validation:Optional
	permissionsWithGrantOption?: [...null | string] @go(PermissionsWithGrantOption,[]*string)

	// account permissions. For more information, see Lake Formation Permissions Reference.
	// +kubebuilder:validation:Optional
	principal?: null | string @go(Principal,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Configuration block for a table resource. Detailed below.
	// +kubebuilder:validation:Optional
	table?: [...#TableParameters] @go(Table,[]TableParameters)

	// Configuration block for a table with columns resource. Detailed below.
	// +kubebuilder:validation:Optional
	tableWithColumns?: [...#TableWithColumnsParameters] @go(TableWithColumns,[]TableWithColumnsParameters)
}

#TableInitParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)

	// –  Name of the database for the table. Unique to a Data Catalog.
	databaseName?: null | string @go(DatabaseName,*string)

	// Name of the table.
	name?: null | string @go(Name,*string)

	// Whether to use a wildcard representing every table under a database. Defaults to false.
	wildcard?: null | bool @go(Wildcard,*bool)
}

#TableObservation: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)

	// –  Name of the database for the table. Unique to a Data Catalog.
	databaseName?: null | string @go(DatabaseName,*string)

	// Name of the table.
	name?: null | string @go(Name,*string)

	// Whether to use a wildcard representing every table under a database. Defaults to false.
	wildcard?: null | bool @go(Wildcard,*bool)
}

#TableParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	// +kubebuilder:validation:Optional
	catalogId?: null | string @go(CatalogID,*string)

	// –  Name of the database for the table. Unique to a Data Catalog.
	// +kubebuilder:validation:Optional
	databaseName?: null | string @go(DatabaseName,*string)

	// Name of the table.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Whether to use a wildcard representing every table under a database. Defaults to false.
	// +kubebuilder:validation:Optional
	wildcard?: null | bool @go(Wildcard,*bool)
}

#TableWithColumnsInitParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)

	// Set of column names for the table.
	columnNames?: [...null | string] @go(ColumnNames,[]*string)

	// –  Name of the database for the table with columns resource. Unique to the Data Catalog.
	databaseName?: null | string @go(DatabaseName,*string)

	// Set of column names for the table to exclude.
	excludedColumnNames?: [...null | string] @go(ExcludedColumnNames,[]*string)

	// Whether to use a column wildcard.
	wildcard?: null | bool @go(Wildcard,*bool)
}

#TableWithColumnsObservation: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	catalogId?: null | string @go(CatalogID,*string)

	// Set of column names for the table.
	columnNames?: [...null | string] @go(ColumnNames,[]*string)

	// –  Name of the database for the table with columns resource. Unique to the Data Catalog.
	databaseName?: null | string @go(DatabaseName,*string)

	// Set of column names for the table to exclude.
	excludedColumnNames?: [...null | string] @go(ExcludedColumnNames,[]*string)

	// –  Name of the table resource.
	name?: null | string @go(Name,*string)

	// Whether to use a column wildcard.
	wildcard?: null | bool @go(Wildcard,*bool)
}

#TableWithColumnsParameters: {
	// Identifier for the Data Catalog. By default, it is the account ID of the caller.
	// +kubebuilder:validation:Optional
	catalogId?: null | string @go(CatalogID,*string)

	// Set of column names for the table.
	// +kubebuilder:validation:Optional
	columnNames?: [...null | string] @go(ColumnNames,[]*string)

	// –  Name of the database for the table with columns resource. Unique to the Data Catalog.
	// +kubebuilder:validation:Optional
	databaseName?: null | string @go(DatabaseName,*string)

	// Set of column names for the table to exclude.
	// +kubebuilder:validation:Optional
	excludedColumnNames?: [...null | string] @go(ExcludedColumnNames,[]*string)

	// –  Name of the table resource.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/glue/v1beta1.CatalogTable
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Reference to a CatalogTable in glue to populate name.
	// +kubebuilder:validation:Optional
	nameRef?: null | v1.#Reference @go(NameRef,*v1.Reference)

	// Selector for a CatalogTable in glue to populate name.
	// +kubebuilder:validation:Optional
	nameSelector?: null | v1.#Selector @go(NameSelector,*v1.Selector)

	// Whether to use a column wildcard.
	// +kubebuilder:validation:Optional
	wildcard?: null | bool @go(Wildcard,*bool)
}

// PermissionsSpec defines the desired state of Permissions
#PermissionsSpec: {
	v1.#ResourceSpec
	forProvider: #PermissionsParameters @go(ForProvider)

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
	initProvider?: #PermissionsInitParameters @go(InitProvider)
}

// PermissionsStatus defines the observed state of Permissions.
#PermissionsStatus: {
	v1.#ResourceStatus
	atProvider?: #PermissionsObservation @go(AtProvider)
}

// Permissions is the Schema for the Permissionss API. Grants permissions to the principal to access metadata in the Data Catalog and data organized in underlying data storage such as Amazon S3.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Permissions: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.permissions) || (has(self.initProvider) && has(self.initProvider.permissions))",message="spec.forProvider.permissions is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.principal) || (has(self.initProvider) && has(self.initProvider.principal))",message="spec.forProvider.principal is a required parameter"
	spec:    #PermissionsSpec   @go(Spec)
	status?: #PermissionsStatus @go(Status)
}

// PermissionsList contains a list of Permissionss
#PermissionsList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Permissions] @go(Items,[]Permissions)
}
