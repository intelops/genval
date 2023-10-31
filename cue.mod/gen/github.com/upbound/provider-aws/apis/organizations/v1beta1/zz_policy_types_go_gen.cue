// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/organizations/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#PolicyInitParameters: {
	// The policy content to add to the new policy. For example, if you create a service control policy (SCP), this string must be JSON text that specifies the permissions that admins in attached accounts can delegate to their users, groups, and roles. For more information about the SCP syntax, see the Service Control Policy Syntax documentation and for more information on the Tag Policy syntax, see the Tag Policy Syntax documentation.
	content?: null | string @go(Content,*string)

	// A description to assign to the policy.
	description?: null | string @go(Description,*string)

	// The friendly name to assign to the policy.
	name?: null | string @go(Name,*string)

	// If set to true, destroy will not delete the policy and instead just remove the resource from state. This can be useful in situations where the policies (and the associated attachment) must be preserved to meet the AWS minimum requirement of 1 attached policy.
	skipDestroy?: null | bool @go(SkipDestroy,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The type of policy to create. Valid values are AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY (SCP), and TAG_POLICY. Defaults to SERVICE_CONTROL_POLICY.
	type?: null | string @go(Type,*string)
}

#PolicyObservation: {
	// Amazon Resource Name (ARN) of the policy.
	arn?: null | string @go(Arn,*string)

	// The policy content to add to the new policy. For example, if you create a service control policy (SCP), this string must be JSON text that specifies the permissions that admins in attached accounts can delegate to their users, groups, and roles. For more information about the SCP syntax, see the Service Control Policy Syntax documentation and for more information on the Tag Policy syntax, see the Tag Policy Syntax documentation.
	content?: null | string @go(Content,*string)

	// A description to assign to the policy.
	description?: null | string @go(Description,*string)

	// The unique identifier (ID) of the policy.
	id?: null | string @go(ID,*string)

	// The friendly name to assign to the policy.
	name?: null | string @go(Name,*string)

	// If set to true, destroy will not delete the policy and instead just remove the resource from state. This can be useful in situations where the policies (and the associated attachment) must be preserved to meet the AWS minimum requirement of 1 attached policy.
	skipDestroy?: null | bool @go(SkipDestroy,*bool)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The type of policy to create. Valid values are AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY (SCP), and TAG_POLICY. Defaults to SERVICE_CONTROL_POLICY.
	type?: null | string @go(Type,*string)
}

#PolicyParameters: {
	// The policy content to add to the new policy. For example, if you create a service control policy (SCP), this string must be JSON text that specifies the permissions that admins in attached accounts can delegate to their users, groups, and roles. For more information about the SCP syntax, see the Service Control Policy Syntax documentation and for more information on the Tag Policy syntax, see the Tag Policy Syntax documentation.
	// +kubebuilder:validation:Optional
	content?: null | string @go(Content,*string)

	// A description to assign to the policy.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// The friendly name to assign to the policy.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// If set to true, destroy will not delete the policy and instead just remove the resource from state. This can be useful in situations where the policies (and the associated attachment) must be preserved to meet the AWS minimum requirement of 1 attached policy.
	// +kubebuilder:validation:Optional
	skipDestroy?: null | bool @go(SkipDestroy,*bool)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The type of policy to create. Valid values are AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY (SCP), and TAG_POLICY. Defaults to SERVICE_CONTROL_POLICY.
	// +kubebuilder:validation:Optional
	type?: null | string @go(Type,*string)
}

// PolicySpec defines the desired state of Policy
#PolicySpec: {
	v1.#ResourceSpec
	forProvider: #PolicyParameters @go(ForProvider)

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
	initProvider?: #PolicyInitParameters @go(InitProvider)
}

// PolicyStatus defines the observed state of Policy.
#PolicyStatus: {
	v1.#ResourceStatus
	atProvider?: #PolicyObservation @go(AtProvider)
}

// Policy is the Schema for the Policys API. Provides a resource to manage an AWS Organizations policy.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Policy: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.content) || (has(self.initProvider) && has(self.initProvider.content))",message="spec.forProvider.content is a required parameter"
	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #PolicySpec   @go(Spec)
	status?: #PolicyStatus @go(Status)
}

// PolicyList contains a list of Policys
#PolicyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Policy] @go(Items,[]Policy)
}
