// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ssm/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ParameterInitParameters_2: {
	// Regular expression used to validate the parameter value.
	allowedPattern?: null | string @go(AllowedPattern,*string)

	// ARN of the parameter.
	arn?: null | string @go(Arn,*string)

	// Data type of the parameter. Valid values: text, aws:ssm:integration and aws:ec2:image for AMI format, see the Native parameter support for Amazon Machine Image IDs.
	dataType?: null | string @go(DataType,*string)

	// Description of the parameter.
	description?: null | string @go(Description,*string)

	// Value of the parameter. This argument is not valid with a type of SecureString.
	insecureValue?: null | string @go(InsecureValue,*string)

	// KMS key ID or ARN for encrypting a SecureString.
	keyId?: null | string @go(KeyID,*string)

	// Overwrite an existing parameter.
	overwrite?: null | bool @go(Overwrite,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Parameter tier to assign to the parameter. If not specified, will use the default parameter tier for the region. Valid tiers are Standard, Advanced, and Intelligent-Tiering. Downgrading an Advanced tier parameter to Standard will recreate the resource. For more information on parameter tiers, see the AWS SSM Parameter tier comparison and guide.
	tier?: null | string @go(Tier,*string)

	// Type of the parameter. Valid types are String, StringList and SecureString.
	type?: null | string @go(Type,*string)
}

#ParameterObservation_2: {
	// Regular expression used to validate the parameter value.
	allowedPattern?: null | string @go(AllowedPattern,*string)

	// ARN of the parameter.
	arn?: null | string @go(Arn,*string)

	// Data type of the parameter. Valid values: text, aws:ssm:integration and aws:ec2:image for AMI format, see the Native parameter support for Amazon Machine Image IDs.
	dataType?: null | string @go(DataType,*string)

	// Description of the parameter.
	description?: null | string @go(Description,*string)
	id?:          null | string @go(ID,*string)

	// Value of the parameter. This argument is not valid with a type of SecureString.
	insecureValue?: null | string @go(InsecureValue,*string)

	// KMS key ID or ARN for encrypting a SecureString.
	keyId?: null | string @go(KeyID,*string)

	// Overwrite an existing parameter.
	overwrite?: null | bool @go(Overwrite,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// Parameter tier to assign to the parameter. If not specified, will use the default parameter tier for the region. Valid tiers are Standard, Advanced, and Intelligent-Tiering. Downgrading an Advanced tier parameter to Standard will recreate the resource. For more information on parameter tiers, see the AWS SSM Parameter tier comparison and guide.
	tier?: null | string @go(Tier,*string)

	// Type of the parameter. Valid types are String, StringList and SecureString.
	type?: null | string @go(Type,*string)

	// Version of the parameter.
	version?: null | float64 @go(Version,*float64)
}

#ParameterParameters_2: {
	// Regular expression used to validate the parameter value.
	// +kubebuilder:validation:Optional
	allowedPattern?: null | string @go(AllowedPattern,*string)

	// ARN of the parameter.
	// +kubebuilder:validation:Optional
	arn?: null | string @go(Arn,*string)

	// Data type of the parameter. Valid values: text, aws:ssm:integration and aws:ec2:image for AMI format, see the Native parameter support for Amazon Machine Image IDs.
	// +kubebuilder:validation:Optional
	dataType?: null | string @go(DataType,*string)

	// Description of the parameter.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Value of the parameter. This argument is not valid with a type of SecureString.
	// +kubebuilder:validation:Optional
	insecureValue?: null | string @go(InsecureValue,*string)

	// KMS key ID or ARN for encrypting a SecureString.
	// +kubebuilder:validation:Optional
	keyId?: null | string @go(KeyID,*string)

	// Overwrite an existing parameter.
	// +kubebuilder:validation:Optional
	overwrite?: null | bool @go(Overwrite,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Parameter tier to assign to the parameter. If not specified, will use the default parameter tier for the region. Valid tiers are Standard, Advanced, and Intelligent-Tiering. Downgrading an Advanced tier parameter to Standard will recreate the resource. For more information on parameter tiers, see the AWS SSM Parameter tier comparison and guide.
	// +kubebuilder:validation:Optional
	tier?: null | string @go(Tier,*string)

	// Type of the parameter. Valid types are String, StringList and SecureString.
	// +kubebuilder:validation:Optional
	type?: null | string @go(Type,*string)

	// Value of the parameter.15 and later, this may require additional configuration handling for certain scenarios.15 Upgrade Guide.
	// +kubebuilder:validation:Optional
	valueSecretRef?: null | v1.#SecretKeySelector @go(ValueSecretRef,*v1.SecretKeySelector)
}

// ParameterSpec defines the desired state of Parameter
#ParameterSpec: {
	v1.#ResourceSpec
	forProvider: #ParameterParameters_2 @go(ForProvider)

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
	initProvider?: #ParameterInitParameters_2 @go(InitProvider)
}

// ParameterStatus defines the observed state of Parameter.
#ParameterStatus: {
	v1.#ResourceStatus
	atProvider?: #ParameterObservation_2 @go(AtProvider)
}

// Parameter is the Schema for the Parameters API. Provides a SSM Parameter resource
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Parameter: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.type) || (has(self.initProvider) && has(self.initProvider.type))",message="spec.forProvider.type is a required parameter"
	spec:    #ParameterSpec   @go(Spec)
	status?: #ParameterStatus @go(Status)
}

// ParameterList contains a list of Parameters
#ParameterList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Parameter] @go(Items,[]Parameter)
}
