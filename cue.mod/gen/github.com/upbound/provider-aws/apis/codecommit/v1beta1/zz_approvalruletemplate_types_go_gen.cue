// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/codecommit/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ApprovalRuleTemplateInitParameters: {
	// The content of the approval rule template. Maximum of 3000 characters.
	content?: null | string @go(Content,*string)

	// The description of the approval rule template. Maximum of 1000 characters.
	description?: null | string @go(Description,*string)
}

#ApprovalRuleTemplateObservation: {
	// The ID of the approval rule template
	approvalRuleTemplateId?: null | string @go(ApprovalRuleTemplateID,*string)

	// The content of the approval rule template. Maximum of 3000 characters.
	content?: null | string @go(Content,*string)

	// The date the approval rule template was created, in RFC3339 format.
	creationDate?: null | string @go(CreationDate,*string)

	// The description of the approval rule template. Maximum of 1000 characters.
	description?: null | string @go(Description,*string)
	id?:          null | string @go(ID,*string)

	// The date the approval rule template was most recently changed, in RFC3339 format.
	lastModifiedDate?: null | string @go(LastModifiedDate,*string)

	// The Amazon Resource Name (ARN) of the user who made the most recent changes to the approval rule template.
	lastModifiedUser?: null | string @go(LastModifiedUser,*string)

	// The SHA-256 hash signature for the content of the approval rule template.
	ruleContentSha256?: null | string @go(RuleContentSha256,*string)
}

#ApprovalRuleTemplateParameters: {
	// The content of the approval rule template. Maximum of 3000 characters.
	// +kubebuilder:validation:Optional
	content?: null | string @go(Content,*string)

	// The description of the approval rule template. Maximum of 1000 characters.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// ApprovalRuleTemplateSpec defines the desired state of ApprovalRuleTemplate
#ApprovalRuleTemplateSpec: {
	v1.#ResourceSpec
	forProvider: #ApprovalRuleTemplateParameters @go(ForProvider)

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
	initProvider?: #ApprovalRuleTemplateInitParameters @go(InitProvider)
}

// ApprovalRuleTemplateStatus defines the observed state of ApprovalRuleTemplate.
#ApprovalRuleTemplateStatus: {
	v1.#ResourceStatus
	atProvider?: #ApprovalRuleTemplateObservation @go(AtProvider)
}

// ApprovalRuleTemplate is the Schema for the ApprovalRuleTemplates API. Provides a CodeCommit Approval Rule Template Resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ApprovalRuleTemplate: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.content) || (has(self.initProvider) && has(self.initProvider.content))",message="spec.forProvider.content is a required parameter"
	spec:    #ApprovalRuleTemplateSpec   @go(Spec)
	status?: #ApprovalRuleTemplateStatus @go(Status)
}

// ApprovalRuleTemplateList contains a list of ApprovalRuleTemplates
#ApprovalRuleTemplateList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ApprovalRuleTemplate] @go(Items,[]ApprovalRuleTemplate)
}
