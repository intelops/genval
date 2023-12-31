// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/redshift/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#SnapshotScheduleAssociationInitParameters: {
}

#SnapshotScheduleAssociationObservation: {
	// The cluster identifier.
	clusterIdentifier?: null | string @go(ClusterIdentifier,*string)
	id?:                null | string @go(ID,*string)

	// The snapshot schedule identifier.
	scheduleIdentifier?: null | string @go(ScheduleIdentifier,*string)
}

#SnapshotScheduleAssociationParameters: {
	// The cluster identifier.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/redshift/v1beta1.Cluster
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	clusterIdentifier?: null | string @go(ClusterIdentifier,*string)

	// Reference to a Cluster in redshift to populate clusterIdentifier.
	// +kubebuilder:validation:Optional
	clusterIdentifierRef?: null | v1.#Reference @go(ClusterIdentifierRef,*v1.Reference)

	// Selector for a Cluster in redshift to populate clusterIdentifier.
	// +kubebuilder:validation:Optional
	clusterIdentifierSelector?: null | v1.#Selector @go(ClusterIdentifierSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The snapshot schedule identifier.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/redshift/v1beta1.SnapshotSchedule
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	scheduleIdentifier?: null | string @go(ScheduleIdentifier,*string)

	// Reference to a SnapshotSchedule in redshift to populate scheduleIdentifier.
	// +kubebuilder:validation:Optional
	scheduleIdentifierRef?: null | v1.#Reference @go(ScheduleIdentifierRef,*v1.Reference)

	// Selector for a SnapshotSchedule in redshift to populate scheduleIdentifier.
	// +kubebuilder:validation:Optional
	scheduleIdentifierSelector?: null | v1.#Selector @go(ScheduleIdentifierSelector,*v1.Selector)
}

// SnapshotScheduleAssociationSpec defines the desired state of SnapshotScheduleAssociation
#SnapshotScheduleAssociationSpec: {
	v1.#ResourceSpec
	forProvider: #SnapshotScheduleAssociationParameters @go(ForProvider)

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
	initProvider?: #SnapshotScheduleAssociationInitParameters @go(InitProvider)
}

// SnapshotScheduleAssociationStatus defines the observed state of SnapshotScheduleAssociation.
#SnapshotScheduleAssociationStatus: {
	v1.#ResourceStatus
	atProvider?: #SnapshotScheduleAssociationObservation @go(AtProvider)
}

// SnapshotScheduleAssociation is the Schema for the SnapshotScheduleAssociations API. Provides an Association Redshift Cluster and Snapshot Schedule resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#SnapshotScheduleAssociation: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta                 @go(ObjectMeta)
	spec:      #SnapshotScheduleAssociationSpec   @go(Spec)
	status?:   #SnapshotScheduleAssociationStatus @go(Status)
}

// SnapshotScheduleAssociationList contains a list of SnapshotScheduleAssociations
#SnapshotScheduleAssociationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#SnapshotScheduleAssociation] @go(Items,[]SnapshotScheduleAssociation)
}
