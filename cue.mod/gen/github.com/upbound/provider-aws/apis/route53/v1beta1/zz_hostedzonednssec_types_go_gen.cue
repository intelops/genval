// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/route53/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#HostedZoneDNSSECInitParameters: {
	// Hosted Zone signing status. Valid values: SIGNING, NOT_SIGNING. Defaults to SIGNING.
	signingStatus?: null | string @go(SigningStatus,*string)
}

#HostedZoneDNSSECObservation: {
	// Identifier of the Route 53 Hosted Zone.
	hostedZoneId?: null | string @go(HostedZoneID,*string)

	// Route 53 Hosted Zone identifier.
	id?: null | string @go(ID,*string)

	// Hosted Zone signing status. Valid values: SIGNING, NOT_SIGNING. Defaults to SIGNING.
	signingStatus?: null | string @go(SigningStatus,*string)
}

#HostedZoneDNSSECParameters: {
	// Identifier of the Route 53 Hosted Zone.
	// +crossplane:generate:reference:type=Zone
	// +kubebuilder:validation:Optional
	hostedZoneId?: null | string @go(HostedZoneID,*string)

	// Reference to a Zone to populate hostedZoneId.
	// +kubebuilder:validation:Optional
	hostedZoneIdRef?: null | v1.#Reference @go(HostedZoneIDRef,*v1.Reference)

	// Selector for a Zone to populate hostedZoneId.
	// +kubebuilder:validation:Optional
	hostedZoneIdSelector?: null | v1.#Selector @go(HostedZoneIDSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Hosted Zone signing status. Valid values: SIGNING, NOT_SIGNING. Defaults to SIGNING.
	// +kubebuilder:validation:Optional
	signingStatus?: null | string @go(SigningStatus,*string)
}

// HostedZoneDNSSECSpec defines the desired state of HostedZoneDNSSEC
#HostedZoneDNSSECSpec: {
	v1.#ResourceSpec
	forProvider: #HostedZoneDNSSECParameters @go(ForProvider)

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
	initProvider?: #HostedZoneDNSSECInitParameters @go(InitProvider)
}

// HostedZoneDNSSECStatus defines the observed state of HostedZoneDNSSEC.
#HostedZoneDNSSECStatus: {
	v1.#ResourceStatus
	atProvider?: #HostedZoneDNSSECObservation @go(AtProvider)
}

// HostedZoneDNSSEC is the Schema for the HostedZoneDNSSECs API. Manages Route 53 Hosted Zone DNSSEC
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#HostedZoneDNSSEC: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta      @go(ObjectMeta)
	spec:      #HostedZoneDNSSECSpec   @go(Spec)
	status?:   #HostedZoneDNSSECStatus @go(Status)
}

// HostedZoneDNSSECList contains a list of HostedZoneDNSSECs
#HostedZoneDNSSECList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#HostedZoneDNSSEC] @go(Items,[]HostedZoneDNSSEC)
}
