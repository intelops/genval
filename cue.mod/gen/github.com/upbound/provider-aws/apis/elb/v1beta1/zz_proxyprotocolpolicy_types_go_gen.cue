// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/elb/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ProxyProtocolPolicyInitParameters: {
	// List of instance ports to which the policy
	// should be applied. This can be specified if the protocol is SSL or TCP.
	instancePorts?: [...null | string] @go(InstancePorts,[]*string)
}

#ProxyProtocolPolicyObservation: {
	// The ID of the policy.
	id?: null | string @go(ID,*string)

	// List of instance ports to which the policy
	// should be applied. This can be specified if the protocol is SSL or TCP.
	instancePorts?: [...null | string] @go(InstancePorts,[]*string)

	// The load balancer to which the policy
	// should be attached.
	loadBalancer?: null | string @go(LoadBalancer,*string)
}

#ProxyProtocolPolicyParameters: {
	// List of instance ports to which the policy
	// should be applied. This can be specified if the protocol is SSL or TCP.
	// +kubebuilder:validation:Optional
	instancePorts?: [...null | string] @go(InstancePorts,[]*string)

	// The load balancer to which the policy
	// should be attached.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/elb/v1beta1.ELB
	// +kubebuilder:validation:Optional
	loadBalancer?: null | string @go(LoadBalancer,*string)

	// Reference to a ELB in elb to populate loadBalancer.
	// +kubebuilder:validation:Optional
	loadBalancerRef?: null | v1.#Reference @go(LoadBalancerRef,*v1.Reference)

	// Selector for a ELB in elb to populate loadBalancer.
	// +kubebuilder:validation:Optional
	loadBalancerSelector?: null | v1.#Selector @go(LoadBalancerSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// ProxyProtocolPolicySpec defines the desired state of ProxyProtocolPolicy
#ProxyProtocolPolicySpec: {
	v1.#ResourceSpec
	forProvider: #ProxyProtocolPolicyParameters @go(ForProvider)

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
	initProvider?: #ProxyProtocolPolicyInitParameters @go(InitProvider)
}

// ProxyProtocolPolicyStatus defines the observed state of ProxyProtocolPolicy.
#ProxyProtocolPolicyStatus: {
	v1.#ResourceStatus
	atProvider?: #ProxyProtocolPolicyObservation @go(AtProvider)
}

// ProxyProtocolPolicy is the Schema for the ProxyProtocolPolicys API. Provides a proxy protocol policy, which allows an ELB to carry a client connection information to a backend.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#ProxyProtocolPolicy: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.instancePorts) || (has(self.initProvider) && has(self.initProvider.instancePorts))",message="spec.forProvider.instancePorts is a required parameter"
	spec:    #ProxyProtocolPolicySpec   @go(Spec)
	status?: #ProxyProtocolPolicyStatus @go(Status)
}

// ProxyProtocolPolicyList contains a list of ProxyProtocolPolicys
#ProxyProtocolPolicyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#ProxyProtocolPolicy] @go(Items,[]ProxyProtocolPolicy)
}
