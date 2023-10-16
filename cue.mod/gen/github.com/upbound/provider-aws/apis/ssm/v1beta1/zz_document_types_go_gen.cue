// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ssm/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AttachmentsSourceInitParameters: {
	// The key describing the location of an attachment to a document. Valid key types include: SourceUrl and S3FileUrl
	key?: null | string @go(Key,*string)

	// The name of the document attachment file
	name?: null | string @go(Name,*string)

	// The value describing the location of an attachment to a document
	values?: [...null | string] @go(Values,[]*string)
}

#AttachmentsSourceObservation: {
	// The key describing the location of an attachment to a document. Valid key types include: SourceUrl and S3FileUrl
	key?: null | string @go(Key,*string)

	// The name of the document attachment file
	name?: null | string @go(Name,*string)

	// The value describing the location of an attachment to a document
	values?: [...null | string] @go(Values,[]*string)
}

#AttachmentsSourceParameters: {
	// The key describing the location of an attachment to a document. Valid key types include: SourceUrl and S3FileUrl
	// +kubebuilder:validation:Optional
	key?: null | string @go(Key,*string)

	// The name of the document attachment file
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// The value describing the location of an attachment to a document
	// +kubebuilder:validation:Optional
	values: [...null | string] @go(Values,[]*string)
}

#DocumentInitParameters: {
	// One or more configuration blocks describing attachments sources to a version of a document. Defined below.
	attachmentsSource?: [...#AttachmentsSourceInitParameters] @go(AttachmentsSource,[]AttachmentsSourceInitParameters)

	// The JSON or YAML content of the document.
	content?: null | string @go(Content,*string)

	// The format of the document. Valid document types include: JSON and YAML
	documentFormat?: null | string @go(DocumentFormat,*string)

	// The type of the document. Valid document types include: Automation, Command, Package, Policy, and Session
	documentType?: null | string @go(DocumentType,*string)

	// Additional Permissions to attach to the document. See Permissions below for details.
	permissions?: {[string]: null | string} @go(Permissions,map[string]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The target type which defines the kinds of resources the document can run on. For example, /AWS::EC2::Instance. For a list of valid resource types, see AWS Resource Types Reference (http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html)
	targetType?: null | string @go(TargetType,*string)

	// A field specifying the version of the artifact you are creating with the document. For example, "Release 12, Update 6". This value is unique across all versions of a document and cannot be changed for an existing document version.
	versionName?: null | string @go(VersionName,*string)
}

#DocumentObservation: {
	arn?: null | string @go(Arn,*string)

	// One or more configuration blocks describing attachments sources to a version of a document. Defined below.
	attachmentsSource?: [...#AttachmentsSourceObservation] @go(AttachmentsSource,[]AttachmentsSourceObservation)

	// The JSON or YAML content of the document.
	content?: null | string @go(Content,*string)

	// The date the document was created.
	createdDate?: null | string @go(CreatedDate,*string)

	// The default version of the document.
	defaultVersion?: null | string @go(DefaultVersion,*string)

	// The description of the document.
	description?: null | string @go(Description,*string)

	// The format of the document. Valid document types include: JSON and YAML
	documentFormat?: null | string @go(DocumentFormat,*string)

	// The type of the document. Valid document types include: Automation, Command, Package, Policy, and Session
	documentType?: null | string @go(DocumentType,*string)

	// The document version.
	documentVersion?: null | string @go(DocumentVersion,*string)

	// The sha1 or sha256 of the document content
	hash?: null | string @go(Hash,*string)

	// "Sha1" "Sha256". The hashing algorithm used when hashing the content.
	hashType?: null | string @go(HashType,*string)
	id?:       null | string @go(ID,*string)

	// The latest version of the document.
	latestVersion?: null | string @go(LatestVersion,*string)

	// The AWS user account of the person who created the document.
	owner?: null | string @go(Owner,*string)

	// The parameters that are available to this document.
	parameter?: [...#ParameterObservation] @go(Parameter,[]ParameterObservation)

	// Additional Permissions to attach to the document. See Permissions below for details.
	permissions?: {[string]: null | string} @go(Permissions,map[string]*string)

	// A list of OS platforms compatible with this SSM document, either "Windows" or "Linux".
	platformTypes?: [...null | string] @go(PlatformTypes,[]*string)

	// The schema version of the document.
	schemaVersion?: null | string @go(SchemaVersion,*string)

	// "Creating", "Active" or "Deleting". The current status of the document.
	status?: null | string @go(Status,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The target type which defines the kinds of resources the document can run on. For example, /AWS::EC2::Instance. For a list of valid resource types, see AWS Resource Types Reference (http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html)
	targetType?: null | string @go(TargetType,*string)

	// A field specifying the version of the artifact you are creating with the document. For example, "Release 12, Update 6". This value is unique across all versions of a document and cannot be changed for an existing document version.
	versionName?: null | string @go(VersionName,*string)
}

#DocumentParameters: {
	// One or more configuration blocks describing attachments sources to a version of a document. Defined below.
	// +kubebuilder:validation:Optional
	attachmentsSource?: [...#AttachmentsSourceParameters] @go(AttachmentsSource,[]AttachmentsSourceParameters)

	// The JSON or YAML content of the document.
	// +kubebuilder:validation:Optional
	content?: null | string @go(Content,*string)

	// The format of the document. Valid document types include: JSON and YAML
	// +kubebuilder:validation:Optional
	documentFormat?: null | string @go(DocumentFormat,*string)

	// The type of the document. Valid document types include: Automation, Command, Package, Policy, and Session
	// +kubebuilder:validation:Optional
	documentType?: null | string @go(DocumentType,*string)

	// Additional Permissions to attach to the document. See Permissions below for details.
	// +kubebuilder:validation:Optional
	permissions?: {[string]: null | string} @go(Permissions,map[string]*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The target type which defines the kinds of resources the document can run on. For example, /AWS::EC2::Instance. For a list of valid resource types, see AWS Resource Types Reference (http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html)
	// +kubebuilder:validation:Optional
	targetType?: null | string @go(TargetType,*string)

	// A field specifying the version of the artifact you are creating with the document. For example, "Release 12, Update 6". This value is unique across all versions of a document and cannot be changed for an existing document version.
	// +kubebuilder:validation:Optional
	versionName?: null | string @go(VersionName,*string)
}

#ParameterInitParameters: {
}

#ParameterObservation: {
	defaultValue?: null | string @go(DefaultValue,*string)

	// The description of the document.
	description?: null | string @go(Description,*string)

	// The name of the document.
	name?: null | string @go(Name,*string)

	// The permission type for the document. The permission type can be Share.
	type?: null | string @go(Type,*string)
}

#ParameterParameters: {
}

// DocumentSpec defines the desired state of Document
#DocumentSpec: {
	v1.#ResourceSpec
	forProvider: #DocumentParameters @go(ForProvider)

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
	initProvider?: #DocumentInitParameters @go(InitProvider)
}

// DocumentStatus defines the observed state of Document.
#DocumentStatus: {
	v1.#ResourceStatus
	atProvider?: #DocumentObservation @go(AtProvider)
}

// Document is the Schema for the Documents API. Provides an SSM Document resource
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Document: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.content) || (has(self.initProvider) && has(self.initProvider.content))",message="spec.forProvider.content is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.documentType) || (has(self.initProvider) && has(self.initProvider.documentType))",message="spec.forProvider.documentType is a required parameter"
	spec:    #DocumentSpec   @go(Spec)
	status?: #DocumentStatus @go(Status)
}

// DocumentList contains a list of Documents
#DocumentList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Document] @go(Items,[]Document)
}