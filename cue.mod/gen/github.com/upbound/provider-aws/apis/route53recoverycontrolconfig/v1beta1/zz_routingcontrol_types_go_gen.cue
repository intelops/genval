// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/route53recoverycontrolconfig/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#RoutingControlInitParameters: {
	// The name describing the routing control.
	name?: null | string @go(Name,*string)
}

#RoutingControlObservation: {
	// ARN of the routing control.
	arn?: null | string @go(Arn,*string)

	// ARN of the cluster in which this routing control will reside.
	clusterArn?: null | string @go(ClusterArn,*string)

	// ARN of the control panel in which this routing control will reside.
	controlPanelArn?: null | string @go(ControlPanelArn,*string)
	id?:              null | string @go(ID,*string)

	// The name describing the routing control.
	name?: null | string @go(Name,*string)

	// Status of routing control. PENDING when it is being created/updated, PENDING_DELETION when it is being deleted, and DEPLOYED otherwise.
	status?: null | string @go(Status,*string)
}

#RoutingControlParameters: {
	// ARN of the cluster in which this routing control will reside.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/route53recoverycontrolconfig/v1beta1.Cluster
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.TerraformID()
	// +kubebuilder:validation:Optional
	clusterArn?: null | string @go(ClusterArn,*string)

	// Reference to a Cluster in route53recoverycontrolconfig to populate clusterArn.
	// +kubebuilder:validation:Optional
	clusterArnRef?: null | v1.#Reference @go(ClusterArnRef,*v1.Reference)

	// Selector for a Cluster in route53recoverycontrolconfig to populate clusterArn.
	// +kubebuilder:validation:Optional
	clusterArnSelector?: null | v1.#Selector @go(ClusterArnSelector,*v1.Selector)

	// ARN of the control panel in which this routing control will reside.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/route53recoverycontrolconfig/v1beta1.ControlPanel
	// +crossplane:generate:reference:extractor=github.com/upbound/provider-aws/config/common.TerraformID()
	// +kubebuilder:validation:Optional
	controlPanelArn?: null | string @go(ControlPanelArn,*string)

	// Reference to a ControlPanel in route53recoverycontrolconfig to populate controlPanelArn.
	// +kubebuilder:validation:Optional
	controlPanelArnRef?: null | v1.#Reference @go(ControlPanelArnRef,*v1.Reference)

	// Selector for a ControlPanel in route53recoverycontrolconfig to populate controlPanelArn.
	// +kubebuilder:validation:Optional
	controlPanelArnSelector?: null | v1.#Selector @go(ControlPanelArnSelector,*v1.Selector)

	// The name describing the routing control.
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// RoutingControlSpec defines the desired state of RoutingControl
#RoutingControlSpec: {
	v1.#ResourceSpec
	forProvider: #RoutingControlParameters @go(ForProvider)

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
	initProvider?: #RoutingControlInitParameters @go(InitProvider)
}

// RoutingControlStatus defines the observed state of RoutingControl.
#RoutingControlStatus: {
	v1.#ResourceStatus
	atProvider?: #RoutingControlObservation @go(AtProvider)
}

// RoutingControl is the Schema for the RoutingControls API. Provides an AWS Route 53 Recovery Control Config Routing Control
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#RoutingControl: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.name) || (has(self.initProvider) && has(self.initProvider.name))",message="spec.forProvider.name is a required parameter"
	spec:    #RoutingControlSpec   @go(Spec)
	status?: #RoutingControlStatus @go(Status)
}

// RoutingControlList contains a list of RoutingControls
#RoutingControlList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#RoutingControl] @go(Items,[]RoutingControl)
}
