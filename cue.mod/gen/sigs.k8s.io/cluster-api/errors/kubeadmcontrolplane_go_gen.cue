// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go sigs.k8s.io/cluster-api/errors

package errors

// KubeadmControlPlaneError is a more descriptive kind of error that represents an error condition that
// should be set in the KubeadmControlPlane.Status. The "Reason" field is meant for short,
// enum-style constants meant to be interpreted by control planes. The "Message"
// field is meant to be read by humans.
#KubeadmControlPlaneError: {
	Reason:  #KubeadmControlPlaneStatusError
	Message: string
}
