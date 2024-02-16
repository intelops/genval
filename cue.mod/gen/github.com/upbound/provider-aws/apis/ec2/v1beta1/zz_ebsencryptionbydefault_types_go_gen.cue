// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#EBSEncryptionByDefaultInitParameters: {
	// Whether or not default EBS encryption is enabled. Valid values are true or false. Defaults to true.
	enabled?: null | bool @go(Enabled,*bool)
}

#EBSEncryptionByDefaultObservation: {
	// Whether or not default EBS encryption is enabled. Valid values are true or false. Defaults to true.
	enabled?: null | bool   @go(Enabled,*bool)
	id?:      null | string @go(ID,*string)
}

#EBSEncryptionByDefaultParameters: {
	// Whether or not default EBS encryption is enabled. Valid values are true or false. Defaults to true.
	// +kubebuilder:validation:Optional
	enabled?: null | bool @go(Enabled,*bool)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// EBSEncryptionByDefaultSpec defines the desired state of EBSEncryptionByDefault
#EBSEncryptionByDefaultSpec: {
	v1.#ResourceSpec
	forProvider: #EBSEncryptionByDefaultParameters @go(ForProvider)

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
	initProvider?: #EBSEncryptionByDefaultInitParameters @go(InitProvider)
}

// EBSEncryptionByDefaultStatus defines the observed state of EBSEncryptionByDefault.
#EBSEncryptionByDefaultStatus: {
	v1.#ResourceStatus
	atProvider?: #EBSEncryptionByDefaultObservation @go(AtProvider)
}

// EBSEncryptionByDefault is the Schema for the EBSEncryptionByDefaults API. Manages whether default EBS encryption is enabled for your AWS account in the current AWS region.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#EBSEncryptionByDefault: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta            @go(ObjectMeta)
	spec:      #EBSEncryptionByDefaultSpec   @go(Spec)
	status?:   #EBSEncryptionByDefaultStatus @go(Status)
}

// EBSEncryptionByDefaultList contains a list of EBSEncryptionByDefaults
#EBSEncryptionByDefaultList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#EBSEncryptionByDefault] @go(Items,[]EBSEncryptionByDefault)
}