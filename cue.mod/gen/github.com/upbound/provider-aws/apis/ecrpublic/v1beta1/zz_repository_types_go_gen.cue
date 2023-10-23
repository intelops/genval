// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ecrpublic/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#CatalogDataInitParameters: {
	// A detailed description of the contents of the repository. It is publicly visible in the Amazon ECR Public Gallery. The text must be in markdown format.
	aboutText?: null | string @go(AboutText,*string)

	// The system architecture that the images in the repository are compatible with. On the Amazon ECR Public Gallery, the following supported architectures will appear as badges on the repository and are used as search filters: ARM, ARM 64, x86, x86-64
	architectures?: [...null | string] @go(Architectures,[]*string)

	// A short description of the contents of the repository. This text appears in both the image details and also when searching for repositories on the Amazon ECR Public Gallery.
	description?: null | string @go(Description,*string)

	// The base64-encoded repository logo payload. (Only visible for verified accounts) Note that drift detection is disabled for this attribute.
	logoImageBlob?: null | string @go(LogoImageBlob,*string)

	// The operating systems that the images in the repository are compatible with. On the Amazon ECR Public Gallery, the following supported operating systems will appear as badges on the repository and are used as search filters: Linux, Windows
	operatingSystems?: [...null | string] @go(OperatingSystems,[]*string)

	// Detailed information on how to use the contents of the repository. It is publicly visible in the Amazon ECR Public Gallery. The usage text provides context, support information, and additional usage details for users of the repository. The text must be in markdown format.
	usageText?: null | string @go(UsageText,*string)
}

#CatalogDataObservation: {
	// A detailed description of the contents of the repository. It is publicly visible in the Amazon ECR Public Gallery. The text must be in markdown format.
	aboutText?: null | string @go(AboutText,*string)

	// The system architecture that the images in the repository are compatible with. On the Amazon ECR Public Gallery, the following supported architectures will appear as badges on the repository and are used as search filters: ARM, ARM 64, x86, x86-64
	architectures?: [...null | string] @go(Architectures,[]*string)

	// A short description of the contents of the repository. This text appears in both the image details and also when searching for repositories on the Amazon ECR Public Gallery.
	description?: null | string @go(Description,*string)

	// The base64-encoded repository logo payload. (Only visible for verified accounts) Note that drift detection is disabled for this attribute.
	logoImageBlob?: null | string @go(LogoImageBlob,*string)

	// The operating systems that the images in the repository are compatible with. On the Amazon ECR Public Gallery, the following supported operating systems will appear as badges on the repository and are used as search filters: Linux, Windows
	operatingSystems?: [...null | string] @go(OperatingSystems,[]*string)

	// Detailed information on how to use the contents of the repository. It is publicly visible in the Amazon ECR Public Gallery. The usage text provides context, support information, and additional usage details for users of the repository. The text must be in markdown format.
	usageText?: null | string @go(UsageText,*string)
}

#CatalogDataParameters: {
	// A detailed description of the contents of the repository. It is publicly visible in the Amazon ECR Public Gallery. The text must be in markdown format.
	// +kubebuilder:validation:Optional
	aboutText?: null | string @go(AboutText,*string)

	// The system architecture that the images in the repository are compatible with. On the Amazon ECR Public Gallery, the following supported architectures will appear as badges on the repository and are used as search filters: ARM, ARM 64, x86, x86-64
	// +kubebuilder:validation:Optional
	architectures?: [...null | string] @go(Architectures,[]*string)

	// A short description of the contents of the repository. This text appears in both the image details and also when searching for repositories on the Amazon ECR Public Gallery.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// The base64-encoded repository logo payload. (Only visible for verified accounts) Note that drift detection is disabled for this attribute.
	// +kubebuilder:validation:Optional
	logoImageBlob?: null | string @go(LogoImageBlob,*string)

	// The operating systems that the images in the repository are compatible with. On the Amazon ECR Public Gallery, the following supported operating systems will appear as badges on the repository and are used as search filters: Linux, Windows
	// +kubebuilder:validation:Optional
	operatingSystems?: [...null | string] @go(OperatingSystems,[]*string)

	// Detailed information on how to use the contents of the repository. It is publicly visible in the Amazon ECR Public Gallery. The usage text provides context, support information, and additional usage details for users of the repository. The text must be in markdown format.
	// +kubebuilder:validation:Optional
	usageText?: null | string @go(UsageText,*string)
}

#RepositoryInitParameters: {
	// Catalog data configuration for the repository. See below for schema.
	catalogData?: [...#CatalogDataInitParameters] @go(CatalogData,[]CatalogDataInitParameters)
	forceDestroy?: null | bool @go(ForceDestroy,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RepositoryObservation: {
	// Full ARN of the repository.
	arn?: null | string @go(Arn,*string)

	// Catalog data configuration for the repository. See below for schema.
	catalogData?: [...#CatalogDataObservation] @go(CatalogData,[]CatalogDataObservation)
	forceDestroy?: null | bool @go(ForceDestroy,*bool)

	// The repository name.
	id?: null | string @go(ID,*string)

	// The registry ID where the repository was created.
	registryId?: null | string @go(RegistryID,*string)

	// The URI of the repository.
	repositoryUri?: null | string @go(RepositoryURI,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#RepositoryParameters: {
	// Catalog data configuration for the repository. See below for schema.
	// +kubebuilder:validation:Optional
	catalogData?: [...#CatalogDataParameters] @go(CatalogData,[]CatalogDataParameters)

	// +kubebuilder:validation:Optional
	forceDestroy?: null | bool @go(ForceDestroy,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// RepositorySpec defines the desired state of Repository
#RepositorySpec: {
	v1.#ResourceSpec
	forProvider: #RepositoryParameters @go(ForProvider)

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
	initProvider?: #RepositoryInitParameters @go(InitProvider)
}

// RepositoryStatus defines the observed state of Repository.
#RepositoryStatus: {
	v1.#ResourceStatus
	atProvider?: #RepositoryObservation @go(AtProvider)
}

// Repository is the Schema for the Repositorys API. Provides a Public Elastic Container Registry Repository.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Repository: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #RepositorySpec    @go(Spec)
	status?:   #RepositoryStatus  @go(Status)
}

// RepositoryList contains a list of Repositorys
#RepositoryList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Repository] @go(Items,[]Repository)
}
