// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#TransitGatewayPolicyTableInitParameters: {
	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#TransitGatewayPolicyTableObservation: {
	// EC2 Transit Gateway Policy Table Amazon Resource Name (ARN).
	arn?: null | string @go(Arn,*string)

	// EC2 Transit Gateway Policy Table identifier.
	id?: null | string @go(ID,*string)

	// The state of the EC2 Transit Gateway Policy Table.
	state?: null | string @go(State,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// EC2 Transit Gateway identifier.
	transitGatewayId?: null | string @go(TransitGatewayID,*string)
}

#TransitGatewayPolicyTableParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// EC2 Transit Gateway identifier.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.TransitGateway
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	transitGatewayId?: null | string @go(TransitGatewayID,*string)

	// Reference to a TransitGateway in ec2 to populate transitGatewayId.
	// +kubebuilder:validation:Optional
	transitGatewayIdRef?: null | v1.#Reference @go(TransitGatewayIDRef,*v1.Reference)

	// Selector for a TransitGateway in ec2 to populate transitGatewayId.
	// +kubebuilder:validation:Optional
	transitGatewayIdSelector?: null | v1.#Selector @go(TransitGatewayIDSelector,*v1.Selector)
}

// TransitGatewayPolicyTableSpec defines the desired state of TransitGatewayPolicyTable
#TransitGatewayPolicyTableSpec: {
	v1.#ResourceSpec
	forProvider: #TransitGatewayPolicyTableParameters @go(ForProvider)

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
	initProvider?: #TransitGatewayPolicyTableInitParameters @go(InitProvider)
}

// TransitGatewayPolicyTableStatus defines the observed state of TransitGatewayPolicyTable.
#TransitGatewayPolicyTableStatus: {
	v1.#ResourceStatus
	atProvider?: #TransitGatewayPolicyTableObservation @go(AtProvider)
}

// TransitGatewayPolicyTable is the Schema for the TransitGatewayPolicyTables API. Manages an EC2 Transit Gateway Policy Table
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#TransitGatewayPolicyTable: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta               @go(ObjectMeta)
	spec:      #TransitGatewayPolicyTableSpec   @go(Spec)
	status?:   #TransitGatewayPolicyTableStatus @go(Status)
}

// TransitGatewayPolicyTableList contains a list of TransitGatewayPolicyTables
#TransitGatewayPolicyTableList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#TransitGatewayPolicyTable] @go(Items,[]TransitGatewayPolicyTable)
}
