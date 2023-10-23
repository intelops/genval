// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go sigs.k8s.io/cluster-api/api/v1alpha4

package v1alpha4

// ClusterPhase is a string representation of a Cluster Phase.
//
// This type is a high-level indicator of the status of the Cluster as it is provisioned,
// from the API user’s perspective.
//
// The value should not be interpreted by any software components as a reliable indication
// of the actual state of the Cluster, and controllers should not use the Cluster Phase field
// value when making decisions about what action to take.
//
// Controllers should always look at the actual state of the Cluster’s fields to make those decisions.
#ClusterPhase: string // #enumClusterPhase

#enumClusterPhase:
	#ClusterPhasePending |
	#ClusterPhaseProvisioning |
	#ClusterPhaseProvisioned |
	#ClusterPhaseDeleting |
	#ClusterPhaseFailed |
	#ClusterPhaseUnknown

// ClusterPhasePending is the first state a Cluster is assigned by
// Cluster API Cluster controller after being created.
#ClusterPhasePending: #ClusterPhase & "Pending"

// ClusterPhaseProvisioning is the state when the Cluster has a provider infrastructure
// object associated and can start provisioning.
#ClusterPhaseProvisioning: #ClusterPhase & "Provisioning"

// ClusterPhaseProvisioned is the state when its
// infrastructure has been created and configured.
#ClusterPhaseProvisioned: #ClusterPhase & "Provisioned"

// ClusterPhaseDeleting is the Cluster state when a delete
// request has been sent to the API Server,
// but its infrastructure has not yet been fully deleted.
#ClusterPhaseDeleting: #ClusterPhase & "Deleting"

// ClusterPhaseFailed is the Cluster state when the system
// might require user intervention.
#ClusterPhaseFailed: #ClusterPhase & "Failed"

// ClusterPhaseUnknown is returned if the Cluster state cannot be determined.
#ClusterPhaseUnknown: #ClusterPhase & "Unknown"
