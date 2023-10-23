// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/neptune/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ClusterSnapshotInitParameters: {
}

#ClusterSnapshotObservation: {
	// Specifies the allocated storage size in gigabytes (GB).
	allocatedStorage?: null | float64 @go(AllocatedStorage,*float64)

	// List of EC2 Availability Zones that instances in the DB cluster snapshot can be restored in.
	availabilityZones?: [...null | string] @go(AvailabilityZones,[]*string)

	// The DB Cluster Identifier from which to take the snapshot.
	dbClusterIdentifier?: null | string @go(DBClusterIdentifier,*string)

	// The Amazon Resource Name (ARN) for the DB Cluster Snapshot.
	dbClusterSnapshotArn?: null | string @go(DBClusterSnapshotArn,*string)

	// Specifies the name of the database engine.
	engine?: null | string @go(Engine,*string)

	// Version of the database engine for this DB cluster snapshot.
	engineVersion?: null | string @go(EngineVersion,*string)
	id?:            null | string @go(ID,*string)

	// If storage_encrypted is true, the AWS KMS key identifier for the encrypted DB cluster snapshot.
	kmsKeyId?: null | string @go(KMSKeyID,*string)

	// License model information for the restored DB cluster.
	licenseModel?: null | string @go(LicenseModel,*string)

	// Port that the DB cluster was listening on at the time of the snapshot.
	port?:         null | float64 @go(Port,*float64)
	snapshotType?: null | string  @go(SnapshotType,*string)

	// The Amazon Resource Name (ARN) for the DB Cluster Snapshot.
	sourceDbClusterSnapshotArn?: null | string @go(SourceDBClusterSnapshotArn,*string)

	// The status of this DB Cluster Snapshot.
	status?: null | string @go(Status,*string)

	// Specifies whether the DB cluster snapshot is encrypted.
	storageEncrypted?: null | bool @go(StorageEncrypted,*bool)

	// The VPC ID associated with the DB cluster snapshot.
	vpcId?: null | string @go(VPCID,*string)
}

#ClusterSnapshotParameters: {
	// The DB Cluster Identifier from which to take the snapshot.
	// +crossplane:generate:reference:type=Cluster
	// +kubebuilder:validation:Optional
	dbClusterIdentifier?: null | string @go(DBClusterIdentifier,*string)

	// Reference to a Cluster to populate dbClusterIdentifier.
	// +kubebuilder:validation:Optional
	dbClusterIdentifierRef?: null | v1.#Reference @go(DBClusterIdentifierRef,*v1.Reference)

	// Selector for a Cluster to populate dbClusterIdentifier.
	// +kubebuilder:validation:Optional
	dbClusterIdentifierSelector?: null | v1.#Selector @go(DBClusterIdentifierSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// ClusterSnapshotSpec defines the desired state of ClusterSnapshot
#ClusterSnapshotSpec: {
	v1.#ResourceSpec
	forProvider: #ClusterSnapshotParameters @go(ForProvider)

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
	initProvider?: #ClusterSnapshotInitParameters @go(InitProvider)
}

// ClusterSnapshotStatus defines the observed state of ClusterSnapshot.
#ClusterSnapshotStatus: {
	v1.#ResourceStatus
	atProvider?: #ClusterSnapshotObservation @go(AtProvider)
}

// ClusterSnapshot is the Schema for the ClusterSnapshots API. Manages a Neptune database cluster snapshot.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ClusterSnapshot: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta     @go(ObjectMeta)
	spec:      #ClusterSnapshotSpec   @go(Spec)
	status?:   #ClusterSnapshotStatus @go(Status)
}

// ClusterSnapshotList contains a list of ClusterSnapshots
#ClusterSnapshotList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ClusterSnapshot] @go(Items,[]ClusterSnapshot)
}
