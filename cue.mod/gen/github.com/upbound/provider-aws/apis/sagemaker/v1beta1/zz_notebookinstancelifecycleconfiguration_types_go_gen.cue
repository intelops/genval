// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sagemaker/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#NotebookInstanceLifecycleConfigurationInitParameters: {
	// A shell script (base64-encoded) that runs only once when the SageMaker Notebook Instance is created.
	onCreate?: null | string @go(OnCreate,*string)

	// A shell script (base64-encoded) that runs every time the SageMaker Notebook Instance is started including the time it's created.
	onStart?: null | string @go(OnStart,*string)
}

#NotebookInstanceLifecycleConfigurationObservation: {
	// The Amazon Resource Name (ARN) assigned by AWS to this lifecycle configuration.
	arn?: null | string @go(Arn,*string)
	id?:  null | string @go(ID,*string)

	// A shell script (base64-encoded) that runs only once when the SageMaker Notebook Instance is created.
	onCreate?: null | string @go(OnCreate,*string)

	// A shell script (base64-encoded) that runs every time the SageMaker Notebook Instance is started including the time it's created.
	onStart?: null | string @go(OnStart,*string)
}

#NotebookInstanceLifecycleConfigurationParameters: {
	// A shell script (base64-encoded) that runs only once when the SageMaker Notebook Instance is created.
	// +kubebuilder:validation:Optional
	onCreate?: null | string @go(OnCreate,*string)

	// A shell script (base64-encoded) that runs every time the SageMaker Notebook Instance is started including the time it's created.
	// +kubebuilder:validation:Optional
	onStart?: null | string @go(OnStart,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// NotebookInstanceLifecycleConfigurationSpec defines the desired state of NotebookInstanceLifecycleConfiguration
#NotebookInstanceLifecycleConfigurationSpec: {
	v1.#ResourceSpec
	forProvider: #NotebookInstanceLifecycleConfigurationParameters @go(ForProvider)

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
	initProvider?: #NotebookInstanceLifecycleConfigurationInitParameters @go(InitProvider)
}

// NotebookInstanceLifecycleConfigurationStatus defines the observed state of NotebookInstanceLifecycleConfiguration.
#NotebookInstanceLifecycleConfigurationStatus: {
	v1.#ResourceStatus
	atProvider?: #NotebookInstanceLifecycleConfigurationObservation @go(AtProvider)
}

// NotebookInstanceLifecycleConfiguration is the Schema for the NotebookInstanceLifecycleConfigurations API. Provides a lifecycle configuration for SageMaker Notebook Instances.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#NotebookInstanceLifecycleConfiguration: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta                            @go(ObjectMeta)
	spec:      #NotebookInstanceLifecycleConfigurationSpec   @go(Spec)
	status?:   #NotebookInstanceLifecycleConfigurationStatus @go(Status)
}

// NotebookInstanceLifecycleConfigurationList contains a list of NotebookInstanceLifecycleConfigurations
#NotebookInstanceLifecycleConfigurationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#NotebookInstanceLifecycleConfiguration] @go(Items,[]NotebookInstanceLifecycleConfiguration)
}
