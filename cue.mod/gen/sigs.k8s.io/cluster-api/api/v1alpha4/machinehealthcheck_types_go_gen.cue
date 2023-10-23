// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go sigs.k8s.io/cluster-api/api/v1alpha4

package v1alpha4

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/util/intstr"
	corev1 "k8s.io/api/core/v1"
)

// MachineHealthCheckSpec defines the desired state of MachineHealthCheck.
#MachineHealthCheckSpec: {
	// ClusterName is the name of the Cluster this object belongs to.
	// +kubebuilder:validation:MinLength=1
	clusterName: string @go(ClusterName)

	// Label selector to match machines whose health will be exercised
	selector: metav1.#LabelSelector @go(Selector)

	// UnhealthyConditions contains a list of the conditions that determine
	// whether a node is considered unhealthy.  The conditions are combined in a
	// logical OR, i.e. if any of the conditions is met, the node is unhealthy.
	//
	// +kubebuilder:validation:MinItems=1
	unhealthyConditions: [...#UnhealthyCondition] @go(UnhealthyConditions,[]UnhealthyCondition)

	// Any further remediation is only allowed if at most "MaxUnhealthy" machines selected by
	// "selector" are not healthy.
	// +optional
	maxUnhealthy?: null | intstr.#IntOrString @go(MaxUnhealthy,*intstr.IntOrString)

	// Any further remediation is only allowed if the number of machines selected by "selector" as not healthy
	// is within the range of "UnhealthyRange". Takes precedence over MaxUnhealthy.
	// Eg. "[3-5]" - This means that remediation will be allowed only when:
	// (a) there are at least 3 unhealthy machines (and)
	// (b) there are at most 5 unhealthy machines
	// +optional
	// +kubebuilder:validation:Pattern=^\[[0-9]+-[0-9]+\]$
	unhealthyRange?: null | string @go(UnhealthyRange,*string)

	// Machines older than this duration without a node will be considered to have
	// failed and will be remediated.
	// If not set, this value is defaulted to 10 minutes.
	// If you wish to disable this feature, set the value explicitly to 0.
	// +optional
	nodeStartupTimeout?: null | metav1.#Duration @go(NodeStartupTimeout,*metav1.Duration)

	// RemediationTemplate is a reference to a remediation template
	// provided by an infrastructure provider.
	//
	// This field is completely optional, when filled, the MachineHealthCheck controller
	// creates a new object from the template referenced and hands off remediation of the machine to
	// a controller that lives outside of Cluster API.
	// +optional
	remediationTemplate?: null | corev1.#ObjectReference @go(RemediationTemplate,*corev1.ObjectReference)
}

// UnhealthyCondition represents a Node condition type and value with a timeout
// specified as a duration.  When the named condition has been in the given
// status for at least the timeout value, a node is considered unhealthy.
#UnhealthyCondition: {
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:MinLength=1
	type: corev1.#NodeConditionType @go(Type)

	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:MinLength=1
	status:  corev1.#ConditionStatus @go(Status)
	timeout: metav1.#Duration        @go(Timeout)
}

// MachineHealthCheckStatus defines the observed state of MachineHealthCheck.
#MachineHealthCheckStatus: {
	// total number of machines counted by this machine health check
	// +kubebuilder:validation:Minimum=0
	expectedMachines?: int32 @go(ExpectedMachines)

	// total number of healthy machines counted by this machine health check
	// +kubebuilder:validation:Minimum=0
	currentHealthy?: int32 @go(CurrentHealthy)

	// RemediationsAllowed is the number of further remediations allowed by this machine health check before
	// maxUnhealthy short circuiting will be applied
	// +kubebuilder:validation:Minimum=0
	remediationsAllowed?: int32 @go(RemediationsAllowed)

	// ObservedGeneration is the latest generation observed by the controller.
	// +optional
	observedGeneration?: int64 @go(ObservedGeneration)

	// Targets shows the current list of machines the machine health check is watching
	// +optional
	targets?: [...string] @go(Targets,[]string)

	// Conditions defines current service state of the MachineHealthCheck.
	// +optional
	conditions?: #Conditions @go(Conditions)
}

// MachineHealthCheck is the Schema for the machinehealthchecks API.
//
// Deprecated: This type will be removed in one of the next releases.
#MachineHealthCheck: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// Specification of machine health check policy
	spec?: #MachineHealthCheckSpec @go(Spec)

	// Most recently observed status of MachineHealthCheck resource
	status?: #MachineHealthCheckStatus @go(Status)
}

// MachineHealthCheckList contains a list of MachineHealthCheck.
//
// Deprecated: This type will be removed in one of the next releases.
#MachineHealthCheckList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#MachineHealthCheck] @go(Items,[]MachineHealthCheck)
}
