// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/ec2/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DefaultVPCDHCPOptionsInitParameters: {
	// The ID of the AWS account that owns the DHCP options set.
	ownerId?: null | string @go(OwnerID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#DefaultVPCDHCPOptionsObservation: {
	// The ARN of the DHCP Options Set.
	arn?:               null | string @go(Arn,*string)
	domainName?:        null | string @go(DomainName,*string)
	domainNameServers?: null | string @go(DomainNameServers,*string)

	// The ID of the DHCP Options Set.
	id?: null | string @go(ID,*string)

	// List of NETBIOS name servers.
	netbiosNameServers?: null | string @go(NetbiosNameServers,*string)

	// The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132.
	netbiosNodeType?: null | string @go(NetbiosNodeType,*string)
	ntpServers?:      null | string @go(NtpServers,*string)

	// The ID of the AWS account that owns the DHCP options set.
	ownerId?: null | string @go(OwnerID,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#DefaultVPCDHCPOptionsParameters: {
	// The ID of the AWS account that owns the DHCP options set.
	// +kubebuilder:validation:Optional
	ownerId?: null | string @go(OwnerID,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// DefaultVPCDHCPOptionsSpec defines the desired state of DefaultVPCDHCPOptions
#DefaultVPCDHCPOptionsSpec: {
	v1.#ResourceSpec
	forProvider: #DefaultVPCDHCPOptionsParameters @go(ForProvider)

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
	initProvider?: #DefaultVPCDHCPOptionsInitParameters @go(InitProvider)
}

// DefaultVPCDHCPOptionsStatus defines the observed state of DefaultVPCDHCPOptions.
#DefaultVPCDHCPOptionsStatus: {
	v1.#ResourceStatus
	atProvider?: #DefaultVPCDHCPOptionsObservation @go(AtProvider)
}

// DefaultVPCDHCPOptions is the Schema for the DefaultVPCDHCPOptionss API. Manage the default VPC DHCP Options resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#DefaultVPCDHCPOptions: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta           @go(ObjectMeta)
	spec:      #DefaultVPCDHCPOptionsSpec   @go(Spec)
	status?:   #DefaultVPCDHCPOptionsStatus @go(Status)
}

// DefaultVPCDHCPOptionsList contains a list of DefaultVPCDHCPOptionss
#DefaultVPCDHCPOptionsList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#DefaultVPCDHCPOptions] @go(Items,[]DefaultVPCDHCPOptions)
}
