// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#RouteTableInitParameters_2: {
	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#RouteTableObservation_2: {
	// The ARN of the route table.
	arn?: null | string @go(Arn,*string)

	// The ID of the routing table.
	id?: null | string @go(ID,*string)

	// The ID of the AWS account that owns the route table.
	ownerId?: null | string @go(OwnerID,*string)

	// A list of virtual gateways for propagation.
	propagatingVgws?: [...null | string] @go(PropagatingVgws,[]*string)

	// A list of route objects. Their keys are documented below. This argument is processed in attribute-as-blocks mode.
	// This means that omitting this argument is interpreted as ignoring any existing routes. To remove all managed routes an empty list should be specified. See the example above.
	route?: [...#RouteTableRouteObservation_2] @go(Route,[]RouteTableRouteObservation_2)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The VPC ID.
	vpcId?: null | string @go(VPCID,*string)
}

#RouteTableParameters_2: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The VPC ID.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPC
	// +kubebuilder:validation:Optional
	vpcId?: null | string @go(VPCID,*string)

	// Reference to a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdRef?: null | v1.#Reference @go(VPCIDRef,*v1.Reference)

	// Selector for a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdSelector?: null | v1.#Selector @go(VPCIDSelector,*v1.Selector)
}

#RouteTableRouteInitParameters_2: {
}

#RouteTableRouteObservation_2: {
	// Identifier of a carrier gateway. This attribute can only be used when the VPC contains a subnet which is associated with a Wavelength Zone.
	carrierGatewayId?: null | string @go(CarrierGatewayID,*string)

	// The CIDR block of the route.
	cidrBlock?: null | string @go(CidrBlock,*string)

	// The Amazon Resource Name (ARN) of a core network.
	coreNetworkArn?: null | string @go(CoreNetworkArn,*string)

	// The ID of a managed prefix list destination of the route.
	destinationPrefixListId?: null | string @go(DestinationPrefixListID,*string)

	// Identifier of a VPC Egress Only Internet Gateway.
	egressOnlyGatewayId?: null | string @go(EgressOnlyGatewayID,*string)

	// Identifier of a VPC internet gateway or a virtual private gateway.
	gatewayId?: null | string @go(GatewayID,*string)

	// The Ipv6 CIDR block of the route.
	ipv6CidrBlock?: null | string @go(IPv6CidrBlock,*string)

	// Identifier of an EC2 instance.
	instanceId?: null | string @go(InstanceID,*string)

	// Identifier of a Outpost local gateway.
	localGatewayId?: null | string @go(LocalGatewayID,*string)

	// Identifier of a VPC NAT gateway.
	natGatewayId?: null | string @go(NATGatewayID,*string)

	// Identifier of an EC2 network interface.
	networkInterfaceId?: null | string @go(NetworkInterfaceID,*string)

	// Identifier of an EC2 Transit Gateway.
	transitGatewayId?: null | string @go(TransitGatewayID,*string)

	// Identifier of a VPC Endpoint.
	vpcEndpointId?: null | string @go(VPCEndpointID,*string)

	// Identifier of a VPC peering connection.
	vpcPeeringConnectionId?: null | string @go(VPCPeeringConnectionID,*string)
}

#RouteTableRouteParameters_2: {
}

// RouteTableSpec defines the desired state of RouteTable
#RouteTableSpec: {
	v1.#ResourceSpec
	forProvider: #RouteTableParameters_2 @go(ForProvider)

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
	initProvider?: #RouteTableInitParameters_2 @go(InitProvider)
}

// RouteTableStatus defines the observed state of RouteTable.
#RouteTableStatus: {
	v1.#ResourceStatus
	atProvider?: #RouteTableObservation_2 @go(AtProvider)
}

// RouteTable is the Schema for the RouteTables API. Provides a resource to create a VPC routing table.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#RouteTable: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #RouteTableSpec    @go(Spec)
	status?:   #RouteTableStatus  @go(Status)
}

// RouteTableList contains a list of RouteTables
#RouteTableList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#RouteTable] @go(Items,[]RouteTable)
}
