// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#SerialConsoleAccessInitParameters: {
	// Whether or not serial console access is enabled. Valid values are true or false. Defaults to true.
	enabled?: null | bool @go(Enabled,*bool)
}

#SerialConsoleAccessObservation: {
	// Whether or not serial console access is enabled. Valid values are true or false. Defaults to true.
	enabled?: null | bool   @go(Enabled,*bool)
	id?:      null | string @go(ID,*string)
}

#SerialConsoleAccessParameters: {
	// Whether or not serial console access is enabled. Valid values are true or false. Defaults to true.
	// +kubebuilder:validation:Optional
	enabled?: null | bool @go(Enabled,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// SerialConsoleAccessSpec defines the desired state of SerialConsoleAccess
#SerialConsoleAccessSpec: {
	v1.#ResourceSpec
	forProvider: #SerialConsoleAccessParameters @go(ForProvider)

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
	initProvider?: #SerialConsoleAccessInitParameters @go(InitProvider)
}

// SerialConsoleAccessStatus defines the observed state of SerialConsoleAccess.
#SerialConsoleAccessStatus: {
	v1.#ResourceStatus
	atProvider?: #SerialConsoleAccessObservation @go(AtProvider)
}

// SerialConsoleAccess is the Schema for the SerialConsoleAccesss API. Manages whether serial console access is enabled for your AWS account in the current AWS region.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#SerialConsoleAccess: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta         @go(ObjectMeta)
	spec:      #SerialConsoleAccessSpec   @go(Spec)
	status?:   #SerialConsoleAccessStatus @go(Status)
}

// SerialConsoleAccessList contains a list of SerialConsoleAccesss
#SerialConsoleAccessList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#SerialConsoleAccess] @go(Items,[]SerialConsoleAccess)
}
