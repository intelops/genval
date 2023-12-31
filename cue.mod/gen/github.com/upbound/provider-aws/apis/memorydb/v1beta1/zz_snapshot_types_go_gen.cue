// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/memorydb/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ClusterConfigurationInitParameters: {
}

#ClusterConfigurationObservation: {
	// Description for the cluster.
	description?: null | string @go(Description,*string)

	// Version number of the Redis engine used by the cluster.
	engineVersion?: null | string @go(EngineVersion,*string)

	// The weekly time range during which maintenance on the cluster is performed.
	maintenanceWindow?: null | string @go(MaintenanceWindow,*string)

	// Name of the snapshot. Conflicts with name_prefix.
	name?: null | string @go(Name,*string)

	// Compute and memory capacity of the nodes in the cluster.
	nodeType?: null | string @go(NodeType,*string)

	// Number of shards in the cluster.
	numShards?: null | float64 @go(NumShards,*float64)

	// Name of the parameter group associated with the cluster.
	parameterGroupName?: null | string @go(ParameterGroupName,*string)

	// Port number on which the cluster accepts connections.
	port?: null | float64 @go(Port,*float64)

	// Number of days for which MemoryDB retains automatic snapshots before deleting them.
	snapshotRetentionLimit?: null | float64 @go(SnapshotRetentionLimit,*float64)

	// The daily time range (in UTC) during which MemoryDB begins taking a daily snapshot of the shard.
	snapshotWindow?: null | string @go(SnapshotWindow,*string)

	// Name of the subnet group used by the cluster.
	subnetGroupName?: null | string @go(SubnetGroupName,*string)

	// ARN of the SNS topic to which cluster notifications are sent.
	topicArn?: null | string @go(TopicArn,*string)

	// The VPC in which the cluster exists.
	vpcId?: null | string @go(VPCID,*string)
}

#ClusterConfigurationParameters: {
}

#SnapshotInitParameters: {
	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#SnapshotObservation: {
	// The ARN of the snapshot.
	arn?: null | string @go(Arn,*string)

	// The configuration of the cluster from which the snapshot was taken.
	clusterConfiguration?: [...#ClusterConfigurationObservation] @go(ClusterConfiguration,[]ClusterConfigurationObservation)

	// Name of the MemoryDB cluster to take a snapshot of.
	clusterName?: null | string @go(ClusterName,*string)

	// The name of the snapshot.
	id?: null | string @go(ID,*string)

	// ARN of the KMS key used to encrypt the snapshot at rest.
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)

	// Indicates whether the snapshot is from an automatic backup (automated) or was created manually (manual).
	source?: null | string @go(Source,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#SnapshotParameters: {
	// Name of the MemoryDB cluster to take a snapshot of.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/memorydb/v1beta1.Cluster
	// +kubebuilder:validation:Optional
	clusterName?: null | string @go(ClusterName,*string)

	// Reference to a Cluster in memorydb to populate clusterName.
	// +kubebuilder:validation:Optional
	clusterNameRef?: null | v1.#Reference @go(ClusterNameRef,*v1.Reference)

	// Selector for a Cluster in memorydb to populate clusterName.
	// +kubebuilder:validation:Optional
	clusterNameSelector?: null | v1.#Selector @go(ClusterNameSelector,*v1.Selector)

	// ARN of the KMS key used to encrypt the snapshot at rest.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/kms/v1beta1.Key
	// +kubebuilder:validation:Optional
	kmsKeyArn?: null | string @go(KMSKeyArn,*string)

	// Reference to a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnRef?: null | v1.#Reference @go(KMSKeyArnRef,*v1.Reference)

	// Selector for a Key in kms to populate kmsKeyArn.
	// +kubebuilder:validation:Optional
	kmsKeyArnSelector?: null | v1.#Selector @go(KMSKeyArnSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// SnapshotSpec defines the desired state of Snapshot
#SnapshotSpec: {
	v1.#ResourceSpec
	forProvider: #SnapshotParameters @go(ForProvider)

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
	initProvider?: #SnapshotInitParameters @go(InitProvider)
}

// SnapshotStatus defines the observed state of Snapshot.
#SnapshotStatus: {
	v1.#ResourceStatus
	atProvider?: #SnapshotObservation @go(AtProvider)
}

// Snapshot is the Schema for the Snapshots API. Provides a MemoryDB Snapshot.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Snapshot: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #SnapshotSpec      @go(Spec)
	status?:   #SnapshotStatus    @go(Status)
}

// SnapshotList contains a list of Snapshots
#SnapshotList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Snapshot] @go(Items,[]Snapshot)
}
