// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane/apis/pkg/meta/v1

package v1

import (
	rbacv1 "k8s.io/api/rbac/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// ProviderSpec specifies the configuration of a Provider.
#ProviderSpec: {
	// Configuration for the packaged Provider's controller.
	controller: #ControllerSpec @go(Controller)

	#MetaSpec
}

// ControllerSpec specifies the configuration for the packaged Provider
// controller.
#ControllerSpec: {
	// Image is the packaged Provider controller image.
	image?: null | string @go(Image,*string)

	// PermissionRequests for RBAC rules required for this provider's controller
	// to function. The RBAC manager is responsible for assessing the requested
	// permissions.
	// +optional
	permissionRequests?: [...rbacv1.#PolicyRule] @go(PermissionRequests,[]rbacv1.PolicyRule)
}

// A Provider is the description of a Crossplane Provider package.
#Provider: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #ProviderSpec      @go(Spec)
}
