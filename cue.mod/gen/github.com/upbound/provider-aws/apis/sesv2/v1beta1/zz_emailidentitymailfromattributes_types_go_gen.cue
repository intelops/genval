// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sesv2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#EmailIdentityMailFromAttributesInitParameters: {
	// The action to take if the required MX record isn't found when you send an email. Valid values: USE_DEFAULT_VALUE, REJECT_MESSAGE.
	behaviorOnMxFailure?: null | string @go(BehaviorOnMxFailure,*string)

	// The custom MAIL FROM domain that you want the verified identity to use. Required if behavior_on_mx_failure is REJECT_MESSAGE.
	mailFromDomain?: null | string @go(MailFromDomain,*string)
}

#EmailIdentityMailFromAttributesObservation: {
	// The action to take if the required MX record isn't found when you send an email. Valid values: USE_DEFAULT_VALUE, REJECT_MESSAGE.
	behaviorOnMxFailure?: null | string @go(BehaviorOnMxFailure,*string)
	id?:                  null | string @go(ID,*string)

	// The custom MAIL FROM domain that you want the verified identity to use. Required if behavior_on_mx_failure is REJECT_MESSAGE.
	mailFromDomain?: null | string @go(MailFromDomain,*string)
}

#EmailIdentityMailFromAttributesParameters: {
	// The action to take if the required MX record isn't found when you send an email. Valid values: USE_DEFAULT_VALUE, REJECT_MESSAGE.
	// +kubebuilder:validation:Optional
	behaviorOnMxFailure?: null | string @go(BehaviorOnMxFailure,*string)

	// The custom MAIL FROM domain that you want the verified identity to use. Required if behavior_on_mx_failure is REJECT_MESSAGE.
	// +kubebuilder:validation:Optional
	mailFromDomain?: null | string @go(MailFromDomain,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// EmailIdentityMailFromAttributesSpec defines the desired state of EmailIdentityMailFromAttributes
#EmailIdentityMailFromAttributesSpec: {
	v1.#ResourceSpec
	forProvider: #EmailIdentityMailFromAttributesParameters @go(ForProvider)

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
	initProvider?: #EmailIdentityMailFromAttributesInitParameters @go(InitProvider)
}

// EmailIdentityMailFromAttributesStatus defines the observed state of EmailIdentityMailFromAttributes.
#EmailIdentityMailFromAttributesStatus: {
	v1.#ResourceStatus
	atProvider?: #EmailIdentityMailFromAttributesObservation @go(AtProvider)
}

// EmailIdentityMailFromAttributes is the Schema for the EmailIdentityMailFromAttributess API.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#EmailIdentityMailFromAttributes: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta                     @go(ObjectMeta)
	spec:      #EmailIdentityMailFromAttributesSpec   @go(Spec)
	status?:   #EmailIdentityMailFromAttributesStatus @go(Status)
}

// EmailIdentityMailFromAttributesList contains a list of EmailIdentityMailFromAttributess
#EmailIdentityMailFromAttributesList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#EmailIdentityMailFromAttributes] @go(Items,[]EmailIdentityMailFromAttributes)
}