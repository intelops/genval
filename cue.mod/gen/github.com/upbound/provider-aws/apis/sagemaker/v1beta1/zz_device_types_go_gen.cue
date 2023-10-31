// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/sagemaker/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#DeviceDeviceInitParameters: {
	// A description for the device.
	description?: null | string @go(Description,*string)

	// The name of the device.
	deviceName?: null | string @go(DeviceName,*string)

	// Amazon Web Services Internet of Things (IoT) object name.
	iotThingName?: null | string @go(IotThingName,*string)
}

#DeviceDeviceObservation: {
	// A description for the device.
	description?: null | string @go(Description,*string)

	// The name of the device.
	deviceName?: null | string @go(DeviceName,*string)

	// Amazon Web Services Internet of Things (IoT) object name.
	iotThingName?: null | string @go(IotThingName,*string)
}

#DeviceDeviceParameters: {
	// A description for the device.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// The name of the device.
	// +kubebuilder:validation:Optional
	deviceName?: null | string @go(DeviceName,*string)

	// Amazon Web Services Internet of Things (IoT) object name.
	// +kubebuilder:validation:Optional
	iotThingName?: null | string @go(IotThingName,*string)
}

#DeviceInitParameters: {
	// The device to register with SageMaker Edge Manager. See Device details below.
	device?: [...#DeviceDeviceInitParameters] @go(Device,[]DeviceDeviceInitParameters)
}

#DeviceObservation: {
	agentVersion?: null | string @go(AgentVersion,*string)

	// The Amazon Resource Name (ARN) assigned by AWS to this Device.
	arn?: null | string @go(Arn,*string)

	// The device to register with SageMaker Edge Manager. See Device details below.
	device?: [...#DeviceDeviceObservation] @go(Device,[]DeviceDeviceObservation)

	// The name of the Device Fleet.
	deviceFleetName?: null | string @go(DeviceFleetName,*string)

	// The id is constructed from device-fleet-name/device-name.
	id?: null | string @go(ID,*string)
}

#DeviceParameters: {
	// The device to register with SageMaker Edge Manager. See Device details below.
	// +kubebuilder:validation:Optional
	device?: [...#DeviceDeviceParameters] @go(Device,[]DeviceDeviceParameters)

	// The name of the Device Fleet.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/sagemaker/v1beta1.DeviceFleet
	// +kubebuilder:validation:Optional
	deviceFleetName?: null | string @go(DeviceFleetName,*string)

	// Reference to a DeviceFleet in sagemaker to populate deviceFleetName.
	// +kubebuilder:validation:Optional
	deviceFleetNameRef?: null | v1.#Reference @go(DeviceFleetNameRef,*v1.Reference)

	// Selector for a DeviceFleet in sagemaker to populate deviceFleetName.
	// +kubebuilder:validation:Optional
	deviceFleetNameSelector?: null | v1.#Selector @go(DeviceFleetNameSelector,*v1.Selector)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// DeviceSpec defines the desired state of Device
#DeviceSpec: {
	v1.#ResourceSpec
	forProvider: #DeviceParameters @go(ForProvider)

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
	initProvider?: #DeviceInitParameters @go(InitProvider)
}

// DeviceStatus defines the observed state of Device.
#DeviceStatus: {
	v1.#ResourceStatus
	atProvider?: #DeviceObservation @go(AtProvider)
}

// Device is the Schema for the Devices API. Provides a SageMaker Device resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Device: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.device) || (has(self.initProvider) && has(self.initProvider.device))",message="spec.forProvider.device is a required parameter"
	spec:    #DeviceSpec   @go(Spec)
	status?: #DeviceStatus @go(Status)
}

// DeviceList contains a list of Devices
#DeviceList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Device] @go(Items,[]Device)
}
