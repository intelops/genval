// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/apprunner/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ConnectionInitParameters: {
	// Source repository provider. Valid values: GITHUB.
	providerType?: null | string @go(ProviderType,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#ConnectionObservation: {
	// ARN of the connection.
	arn?: null | string @go(Arn,*string)
	id?:  null | string @go(ID,*string)

	// Source repository provider. Valid values: GITHUB.
	providerType?: null | string @go(ProviderType,*string)

	// Current state of the App Runner connection. When the state is AVAILABLE, you can use the connection to create an aws_apprunner_service resource.
	status?: null | string @go(Status,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#ConnectionParameters: {
	// Source repository provider. Valid values: GITHUB.
	// +kubebuilder:validation:Optional
	providerType?: null | string @go(ProviderType,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// ConnectionSpec defines the desired state of Connection
#ConnectionSpec: {
	v1.#ResourceSpec
	forProvider: #ConnectionParameters @go(ForProvider)

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
	initProvider?: #ConnectionInitParameters @go(InitProvider)
}

// ConnectionStatus defines the observed state of Connection.
#ConnectionStatus: {
	v1.#ResourceStatus
	atProvider?: #ConnectionObservation @go(AtProvider)
}

// Connection is the Schema for the Connections API. Manages an App Runner Connection.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Connection: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.providerType) || (has(self.initProvider) && has(self.initProvider.providerType))",message="spec.forProvider.providerType is a required parameter"
	spec:    #ConnectionSpec   @go(Spec)
	status?: #ConnectionStatus @go(Status)
}

// ConnectionList contains a list of Connections
#ConnectionList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Connection] @go(Items,[]Connection)
}
