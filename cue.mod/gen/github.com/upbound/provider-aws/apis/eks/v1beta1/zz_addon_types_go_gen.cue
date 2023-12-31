// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/eks/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#AddonInitParameters: {
	// on. The name must match one of
	// the names returned by describe-addon-versions.
	addonName?: null | string @go(AddonName,*string)

	// on. The version must
	// match one of the versions returned by describe-addon-versions.
	addonVersion?: null | string @go(AddonVersion,*string)

	// custom configuration values for addons with single JSON string. This JSON string value must match the JSON schema derived from describe-addon-configuration.
	configurationValues?: null | string @go(ConfigurationValues,*string)

	// Indicates if you want to preserve the created resources when deleting the EKS add-on.
	preserve?: null | bool @go(Preserve,*bool)

	// Define how to resolve parameter value conflicts
	// when migrating an existing add-on to an Amazon EKS add-on or when applying
	// version updates to the add-on. Valid values are NONE, OVERWRITE and PRESERVE. For more details check UpdateAddon API Docs.
	resolveConflicts?: null | string @go(ResolveConflicts,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#AddonObservation: {
	// on. The name must match one of
	// the names returned by describe-addon-versions.
	addonName?: null | string @go(AddonName,*string)

	// on. The version must
	// match one of the versions returned by describe-addon-versions.
	addonVersion?: null | string @go(AddonVersion,*string)

	// Amazon Resource Name (ARN) of the EKS add-on.
	arn?: null | string @go(Arn,*string)

	// 100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (^[0-9A-Za-z][A-Za-z0-9\-_]+$).
	clusterName?: null | string @go(ClusterName,*string)

	// custom configuration values for addons with single JSON string. This JSON string value must match the JSON schema derived from describe-addon-configuration.
	configurationValues?: null | string @go(ConfigurationValues,*string)

	// Date and time in RFC3339 format that the EKS add-on was created.
	createdAt?: null | string @go(CreatedAt,*string)

	// EKS Cluster name and EKS Addon name separated by a colon (:).
	id?: null | string @go(ID,*string)

	// Date and time in RFC3339 format that the EKS add-on was updated.
	modifiedAt?: null | string @go(ModifiedAt,*string)

	// Indicates if you want to preserve the created resources when deleting the EKS add-on.
	preserve?: null | bool @go(Preserve,*bool)

	// Define how to resolve parameter value conflicts
	// when migrating an existing add-on to an Amazon EKS add-on or when applying
	// version updates to the add-on. Valid values are NONE, OVERWRITE and PRESERVE. For more details check UpdateAddon API Docs.
	resolveConflicts?: null | string @go(ResolveConflicts,*string)

	// The Amazon Resource Name (ARN) of an
	// existing IAM role to bind to the add-on's service account. The role must be
	// assigned the IAM permissions required by the add-on. If you don't specify
	// an existing IAM role, then the add-on uses the permissions assigned to the node
	// IAM role. For more information, see Amazon EKS node IAM role
	// in the Amazon EKS User Guide.
	serviceAccountRoleArn?: null | string @go(ServiceAccountRoleArn,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Key-value map of resource tags, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#AddonParameters: {
	// on. The name must match one of
	// the names returned by describe-addon-versions.
	// +kubebuilder:validation:Optional
	addonName?: null | string @go(AddonName,*string)

	// on. The version must
	// match one of the versions returned by describe-addon-versions.
	// +kubebuilder:validation:Optional
	addonVersion?: null | string @go(AddonVersion,*string)

	// 100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (^[0-9A-Za-z][A-Za-z0-9\-_]+$).
	// +crossplane:generate:reference:type=Cluster
	// +kubebuilder:validation:Optional
	clusterName?: null | string @go(ClusterName,*string)

	// Reference to a Cluster to populate clusterName.
	// +kubebuilder:validation:Optional
	clusterNameRef?: null | v1.#Reference @go(ClusterNameRef,*v1.Reference)

	// Selector for a Cluster to populate clusterName.
	// +kubebuilder:validation:Optional
	clusterNameSelector?: null | v1.#Selector @go(ClusterNameSelector,*v1.Selector)

	// custom configuration values for addons with single JSON string. This JSON string value must match the JSON schema derived from describe-addon-configuration.
	// +kubebuilder:validation:Optional
	configurationValues?: null | string @go(ConfigurationValues,*string)

	// Indicates if you want to preserve the created resources when deleting the EKS add-on.
	// +kubebuilder:validation:Optional
	preserve?: null | bool @go(Preserve,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Define how to resolve parameter value conflicts
	// when migrating an existing add-on to an Amazon EKS add-on or when applying
	// version updates to the add-on. Valid values are NONE, OVERWRITE and PRESERVE. For more details check UpdateAddon API Docs.
	// +kubebuilder:validation:Optional
	resolveConflicts?: null | string @go(ResolveConflicts,*string)

	// The Amazon Resource Name (ARN) of an
	// existing IAM role to bind to the add-on's service account. The role must be
	// assigned the IAM permissions required by the add-on. If you don't specify
	// an existing IAM role, then the add-on uses the permissions assigned to the node
	// IAM role. For more information, see Amazon EKS node IAM role
	// in the Amazon EKS User Guide.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/iam/v1beta1.Role
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.ARNExtractor()
	// +kubebuilder:validation:Optional
	serviceAccountRoleArn?: null | string @go(ServiceAccountRoleArn,*string)

	// Reference to a Role in iam to populate serviceAccountRoleArn.
	// +kubebuilder:validation:Optional
	serviceAccountRoleArnRef?: null | v1.#Reference @go(ServiceAccountRoleArnRef,*v1.Reference)

	// Selector for a Role in iam to populate serviceAccountRoleArn.
	// +kubebuilder:validation:Optional
	serviceAccountRoleArnSelector?: null | v1.#Selector @go(ServiceAccountRoleArnSelector,*v1.Selector)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// AddonSpec defines the desired state of Addon
#AddonSpec: {
	v1.#ResourceSpec
	forProvider: #AddonParameters @go(ForProvider)

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
	initProvider?: #AddonInitParameters @go(InitProvider)
}

// AddonStatus defines the observed state of Addon.
#AddonStatus: {
	v1.#ResourceStatus
	atProvider?: #AddonObservation @go(AtProvider)
}

// Addon is the Schema for the Addons API. Manages an EKS add-on
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Addon: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.addonName) || (has(self.initProvider) && has(self.initProvider.addonName))",message="spec.forProvider.addonName is a required parameter"
	spec:    #AddonSpec   @go(Spec)
	status?: #AddonStatus @go(Status)
}

// AddonList contains a list of Addons
#AddonList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Addon] @go(Items,[]Addon)
}
