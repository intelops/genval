// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/serverlessrepo/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#CloudFormationStackInitParameters: {
	// The ARN of the application from the Serverless Application Repository.
	applicationId?: null | string @go(ApplicationID,*string)

	// A list of capabilities. Valid values are CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_RESOURCE_POLICY, or CAPABILITY_AUTO_EXPAND
	capabilities?: [...null | string] @go(Capabilities,[]*string)

	// The name of the stack to create. The resource deployed in AWS will be prefixed with serverlessrepo-
	name?: null | string @go(Name,*string)

	// A map of Parameter structures that specify input parameters for the stack.
	parameters?: {[string]: null | string} @go(Parameters,map[string]*string)

	// The version of the application to deploy. If not supplied, deploys the latest version.
	semanticVersion?: null | string @go(SemanticVersion,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#CloudFormationStackObservation: {
	// The ARN of the application from the Serverless Application Repository.
	applicationId?: null | string @go(ApplicationID,*string)

	// A list of capabilities. Valid values are CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_RESOURCE_POLICY, or CAPABILITY_AUTO_EXPAND
	capabilities?: [...null | string] @go(Capabilities,[]*string)

	// A unique identifier of the stack.
	id?: null | string @go(ID,*string)

	// The name of the stack to create. The resource deployed in AWS will be prefixed with serverlessrepo-
	name?: null | string @go(Name,*string)

	// A map of outputs from the stack.
	outputs?: {[string]: null | string} @go(Outputs,map[string]*string)

	// A map of Parameter structures that specify input parameters for the stack.
	parameters?: {[string]: null | string} @go(Parameters,map[string]*string)

	// The version of the application to deploy. If not supplied, deploys the latest version.
	semanticVersion?: null | string @go(SemanticVersion,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#CloudFormationStackParameters: {
	// The ARN of the application from the Serverless Application Repository.
	// +kubebuilder:validation:Optional
	applicationId?: null | string @go(ApplicationID,*string)

	// A list of capabilities. Valid values are CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_RESOURCE_POLICY, or CAPABILITY_AUTO_EXPAND
	// +kubebuilder:validation:Optional
	capabilities?: [...null | string] @go(Capabilities,[]*string)

	// The name of the stack to create. The resource deployed in AWS will be prefixed with serverlessrepo-
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// A map of Parameter structures that specify input parameters for the stack.
	// +kubebuilder:validation:Optional
	parameters?: {[string]: null | string} @go(Parameters,map[string]*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The version of the application to deploy. If not supplied, deploys the latest version.
	// +kubebuilder:validation:Optional
	semanticVersion?: null | string @go(SemanticVersion,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// CloudFormationStackSpec defines the desired state of CloudFormationStack
#CloudFormationStackSpec: {
	v1.#ResourceSpec
	forProvider: #CloudFormationStackParameters @go(ForProvider)

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
	initProvider?: #CloudFormationStackInitParameters @go(InitProvider)
}

// CloudFormationStackStatus defines the observed state of CloudFormationStack.
#CloudFormationStackStatus: {
	v1.#ResourceStatus
	atProvider?: #CloudFormationStackObservation @go(AtProvider)
}

// CloudFormationStack is the Schema for the CloudFormationStacks API. Deploys an Application CloudFormation Stack from the Serverless Application Repository.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#CloudFormationStack: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.applicationId) || (has(self.initProvider) && has(self.initProvider.applicationId))",message="spec.forProvider.applicationId is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.capabilities) || (has(self.initProvider) && has(self.initProvider.capabilities))",message="spec.forProvider.capabilities is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #CloudFormationStackSpec   @go(Spec)
	status?: #CloudFormationStackStatus @go(Status)
}

// CloudFormationStackList contains a list of CloudFormationStacks
#CloudFormationStackList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#CloudFormationStack] @go(Items,[]CloudFormationStack)
}
