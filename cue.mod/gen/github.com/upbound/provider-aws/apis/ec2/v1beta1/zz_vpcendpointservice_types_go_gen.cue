// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#PrivateDNSNameConfigurationInitParameters: {
}

#PrivateDNSNameConfigurationObservation: {
	// Name of the record subdomain the service provider needs to create.
	name?: null | string @go(Name,*string)

	// The state of the VPC endpoint service.
	state?: null | string @go(State,*string)

	// Endpoint service verification type, for example TXT.
	type?: null | string @go(Type,*string)

	// Value the service provider adds to the private DNS name domain record before verification.
	value?: null | string @go(Value,*string)
}

#PrivateDNSNameConfigurationParameters: {
}

#VPCEndpointServiceInitParameters: {
	// Whether or not VPC endpoint connection requests to the service must be accepted by the service owner - true or false.
	acceptanceRequired?: null | bool @go(AcceptanceRequired,*bool)

	// Amazon Resource Names (ARNs) of one or more Gateway Load Balancers for the endpoint service.
	gatewayLoadBalancerArns?: [...null | string] @go(GatewayLoadBalancerArns,[]*string)

	// Amazon Resource Names (ARNs) of one or more Network Load Balancers for the endpoint service.
	networkLoadBalancerArns?: [...null | string] @go(NetworkLoadBalancerArns,[]*string)

	// The private DNS name for the service.
	privateDnsName?: null | string @go(PrivateDNSName,*string)

	// The supported IP address types. The possible values are ipv4 and ipv6.
	supportedIpAddressTypes?: [...null | string] @go(SupportedIPAddressTypes,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#VPCEndpointServiceObservation: {
	// Whether or not VPC endpoint connection requests to the service must be accepted by the service owner - true or false.
	acceptanceRequired?: null | bool @go(AcceptanceRequired,*bool)

	// The ARNs of one or more principals allowed to discover the endpoint service.
	allowedPrincipals?: [...null | string] @go(AllowedPrincipals,[]*string)

	// The Amazon Resource Name (ARN) of the VPC endpoint service.
	arn?: null | string @go(Arn,*string)

	// A set of Availability Zones in which the service is available.
	availabilityZones?: [...null | string] @go(AvailabilityZones,[]*string)

	// A set of DNS names for the service.
	baseEndpointDnsNames?: [...null | string] @go(BaseEndpointDNSNames,[]*string)

	// Amazon Resource Names (ARNs) of one or more Gateway Load Balancers for the endpoint service.
	gatewayLoadBalancerArns?: [...null | string] @go(GatewayLoadBalancerArns,[]*string)

	// The ID of the VPC endpoint service.
	id?: null | string @go(ID,*string)

	// Whether or not the service manages its VPC endpoints - true or false.
	managesVpcEndpoints?: null | bool @go(ManagesVPCEndpoints,*bool)

	// Amazon Resource Names (ARNs) of one or more Network Load Balancers for the endpoint service.
	networkLoadBalancerArns?: [...null | string] @go(NetworkLoadBalancerArns,[]*string)

	// The private DNS name for the service.
	privateDnsName?: null | string @go(PrivateDNSName,*string)

	// List of objects containing information about the endpoint service private DNS name configuration.
	privateDnsNameConfiguration?: [...#PrivateDNSNameConfigurationObservation] @go(PrivateDNSNameConfiguration,[]PrivateDNSNameConfigurationObservation)

	// The service name.
	serviceName?: null | string @go(ServiceName,*string)

	// The service type, Gateway or Interface.
	serviceType?: null | string @go(ServiceType,*string)

	// The state of the VPC endpoint service.
	state?: null | string @go(State,*string)

	// The supported IP address types. The possible values are ipv4 and ipv6.
	supportedIpAddressTypes?: [...null | string] @go(SupportedIPAddressTypes,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#VPCEndpointServiceParameters: {
	// Whether or not VPC endpoint connection requests to the service must be accepted by the service owner - true or false.
	// +kubebuilder:validation:Optional
	acceptanceRequired?: null | bool @go(AcceptanceRequired,*bool)

	// Amazon Resource Names (ARNs) of one or more Gateway Load Balancers for the endpoint service.
	// +kubebuilder:validation:Optional
	gatewayLoadBalancerArns?: [...null | string] @go(GatewayLoadBalancerArns,[]*string)

	// Amazon Resource Names (ARNs) of one or more Network Load Balancers for the endpoint service.
	// +kubebuilder:validation:Optional
	networkLoadBalancerArns?: [...null | string] @go(NetworkLoadBalancerArns,[]*string)

	// The private DNS name for the service.
	// +kubebuilder:validation:Optional
	privateDnsName?: null | string @go(PrivateDNSName,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The supported IP address types. The possible values are ipv4 and ipv6.
	// +kubebuilder:validation:Optional
	supportedIpAddressTypes?: [...null | string] @go(SupportedIPAddressTypes,[]*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// VPCEndpointServiceSpec defines the desired state of VPCEndpointService
#VPCEndpointServiceSpec: {
	v1.#ResourceSpec
	forProvider: #VPCEndpointServiceParameters @go(ForProvider)

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
	initProvider?: #VPCEndpointServiceInitParameters @go(InitProvider)
}

// VPCEndpointServiceStatus defines the observed state of VPCEndpointService.
#VPCEndpointServiceStatus: {
	v1.#ResourceStatus
	atProvider?: #VPCEndpointServiceObservation @go(AtProvider)
}

// VPCEndpointService is the Schema for the VPCEndpointServices API. Provides a VPC Endpoint Service resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#VPCEndpointService: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.acceptanceRequired) || (has(self.initProvider) && has(self.initProvider.acceptanceRequired))",message="spec.forProvider.acceptanceRequired is a required parameter"
	spec:    #VPCEndpointServiceSpec   @go(Spec)
	status?: #VPCEndpointServiceStatus @go(Status)
}

// VPCEndpointServiceList contains a list of VPCEndpointServices
#VPCEndpointServiceList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VPCEndpointService] @go(Items,[]VPCEndpointService)
}
