// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/cognitoidp/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#UserPoolUICustomizationInitParameters: {
	// The CSS values in the UI customization, provided as a String. At least one of css or image_file is required.
	css?: null | string @go(CSS,*string)

	// The uploaded logo image for the UI customization, provided as a base64-encoded String. Drift detection is not possible for this argument. At least one of css or image_file is required.
	imageFile?: null | string @go(ImageFile,*string)
}

#UserPoolUICustomizationObservation: {
	// The CSS values in the UI customization, provided as a String. At least one of css or image_file is required.
	css?: null | string @go(CSS,*string)

	// The CSS version number.
	cssVersion?: null | string @go(CSSVersion,*string)

	// The client ID for the client app. Defaults to ALL. If ALL is specified, the css and/or image_file settings will be used for every client that has no UI customization set previously.
	clientId?: null | string @go(ClientID,*string)

	// The creation date in RFC3339 format for the UI customization.
	creationDate?: null | string @go(CreationDate,*string)
	id?:           null | string @go(ID,*string)

	// The uploaded logo image for the UI customization, provided as a base64-encoded String. Drift detection is not possible for this argument. At least one of css or image_file is required.
	imageFile?: null | string @go(ImageFile,*string)

	// The logo image URL for the UI customization.
	imageUrl?: null | string @go(ImageURL,*string)

	// The last-modified date in RFC3339 format for the UI customization.
	lastModifiedDate?: null | string @go(LastModifiedDate,*string)

	// The user pool ID for the user pool.
	userPoolId?: null | string @go(UserPoolID,*string)
}

#UserPoolUICustomizationParameters: {
	// The CSS values in the UI customization, provided as a String. At least one of css or image_file is required.
	// +kubebuilder:validation:Optional
	css?: null | string @go(CSS,*string)

	// The client ID for the client app. Defaults to ALL. If ALL is specified, the css and/or image_file settings will be used for every client that has no UI customization set previously.
	// +crossplane:generate:reference:type=UserPoolClient
	// +kubebuilder:validation:Optional
	clientId?: null | string @go(ClientID,*string)

	// Reference to a UserPoolClient to populate clientId.
	// +kubebuilder:validation:Optional
	clientIdRef?: null | v1.#Reference @go(ClientIDRef,*v1.Reference)

	// Selector for a UserPoolClient to populate clientId.
	// +kubebuilder:validation:Optional
	clientIdSelector?: null | v1.#Selector @go(ClientIDSelector,*v1.Selector)

	// The uploaded logo image for the UI customization, provided as a base64-encoded String. Drift detection is not possible for this argument. At least one of css or image_file is required.
	// +kubebuilder:validation:Optional
	imageFile?: null | string @go(ImageFile,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// The user pool ID for the user pool.
	// +crossplane:generate:reference:type=UserPool
	// +kubebuilder:validation:Optional
	userPoolId?: null | string @go(UserPoolID,*string)

	// Reference to a UserPool to populate userPoolId.
	// +kubebuilder:validation:Optional
	userPoolIdRef?: null | v1.#Reference @go(UserPoolIDRef,*v1.Reference)

	// Selector for a UserPool to populate userPoolId.
	// +kubebuilder:validation:Optional
	userPoolIdSelector?: null | v1.#Selector @go(UserPoolIDSelector,*v1.Selector)
}

// UserPoolUICustomizationSpec defines the desired state of UserPoolUICustomization
#UserPoolUICustomizationSpec: {
	v1.#ResourceSpec
	forProvider: #UserPoolUICustomizationParameters @go(ForProvider)

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
	initProvider?: #UserPoolUICustomizationInitParameters @go(InitProvider)
}

// UserPoolUICustomizationStatus defines the observed state of UserPoolUICustomization.
#UserPoolUICustomizationStatus: {
	v1.#ResourceStatus
	atProvider?: #UserPoolUICustomizationObservation @go(AtProvider)
}

// UserPoolUICustomization is the Schema for the UserPoolUICustomizations API. Provides a Cognito User Pool UI Customization resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#UserPoolUICustomization: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta             @go(ObjectMeta)
	spec:      #UserPoolUICustomizationSpec   @go(Spec)
	status?:   #UserPoolUICustomizationStatus @go(Status)
}

// UserPoolUICustomizationList contains a list of UserPoolUICustomizations
#UserPoolUICustomizationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#UserPoolUICustomization] @go(Items,[]UserPoolUICustomization)
}
