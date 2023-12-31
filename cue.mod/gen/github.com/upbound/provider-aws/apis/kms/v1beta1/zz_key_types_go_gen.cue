// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/kms/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#KeyInitParameters: {
	// A flag to indicate whether to bypass the key policy lockout safety check.
	// Setting this value to true increases the risk that the KMS key becomes unmanageable. Do not set this value to true indiscriminately.
	// For more information, refer to the scenario in the Default Key Policy section in the AWS Key Management Service Developer Guide.
	// The default value is false.
	bypassPolicyLockoutSafetyCheck?: null | bool @go(BypassPolicyLockoutSafetyCheck,*bool)

	// ID of the KMS Custom Key Store where the key will be stored instead of KMS (eg CloudHSM).
	customKeyStoreId?: null | string @go(CustomKeyStoreID,*string)

	// Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports.
	// Valid values: SYMMETRIC_DEFAULT,  RSA_2048, RSA_3072, RSA_4096, HMAC_256, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT. For help with choosing a key spec, see the AWS KMS Developer Guide.
	customerMasterKeySpec?: null | string @go(CustomerMasterKeySpec,*string)

	// The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.
	// If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30.
	// If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately.
	deletionWindowInDays?: null | float64 @go(DeletionWindowInDays,*float64)

	// The description of the key as viewed in AWS console.
	description?: null | string @go(Description,*string)

	// Specifies whether key rotation is enabled. Defaults to false.
	enableKeyRotation?: null | bool @go(EnableKeyRotation,*bool)

	// Specifies whether the key is enabled. Defaults to true.
	isEnabled?: null | bool @go(IsEnabled,*bool)

	// Specifies the intended use of the key. Valid values: ENCRYPT_DECRYPT, SIGN_VERIFY, or GENERATE_VERIFY_MAC.
	// Defaults to ENCRYPT_DECRYPT.
	keyUsage?: null | string @go(KeyUsage,*string)

	// Indicates whether the KMS key is a multi-Region (true) or regional (false) key. Defaults to false.
	multiRegion?: null | bool @go(MultiRegion,*bool)

	// A valid policy JSON document. Although this is a key policy, not an IAM policy, an aws_iam_policy_document, in the form that designates a principal, can be used.
	policy?: null | string @go(Policy,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

#KeyObservation: {
	// The Amazon Resource Name (ARN) of the key.
	arn?: null | string @go(Arn,*string)

	// A flag to indicate whether to bypass the key policy lockout safety check.
	// Setting this value to true increases the risk that the KMS key becomes unmanageable. Do not set this value to true indiscriminately.
	// For more information, refer to the scenario in the Default Key Policy section in the AWS Key Management Service Developer Guide.
	// The default value is false.
	bypassPolicyLockoutSafetyCheck?: null | bool @go(BypassPolicyLockoutSafetyCheck,*bool)

	// ID of the KMS Custom Key Store where the key will be stored instead of KMS (eg CloudHSM).
	customKeyStoreId?: null | string @go(CustomKeyStoreID,*string)

	// Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports.
	// Valid values: SYMMETRIC_DEFAULT,  RSA_2048, RSA_3072, RSA_4096, HMAC_256, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT. For help with choosing a key spec, see the AWS KMS Developer Guide.
	customerMasterKeySpec?: null | string @go(CustomerMasterKeySpec,*string)

	// The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.
	// If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30.
	// If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately.
	deletionWindowInDays?: null | float64 @go(DeletionWindowInDays,*float64)

	// The description of the key as viewed in AWS console.
	description?: null | string @go(Description,*string)

	// Specifies whether key rotation is enabled. Defaults to false.
	enableKeyRotation?: null | bool   @go(EnableKeyRotation,*bool)
	id?:                null | string @go(ID,*string)

	// Specifies whether the key is enabled. Defaults to true.
	isEnabled?: null | bool @go(IsEnabled,*bool)

	// The globally unique identifier for the key.
	keyId?: null | string @go(KeyID,*string)

	// Specifies the intended use of the key. Valid values: ENCRYPT_DECRYPT, SIGN_VERIFY, or GENERATE_VERIFY_MAC.
	// Defaults to ENCRYPT_DECRYPT.
	keyUsage?: null | string @go(KeyUsage,*string)

	// Indicates whether the KMS key is a multi-Region (true) or regional (false) key. Defaults to false.
	multiRegion?: null | bool @go(MultiRegion,*bool)

	// A valid policy JSON document. Although this is a key policy, not an IAM policy, an aws_iam_policy_document, in the form that designates a principal, can be used.
	policy?: null | string @go(Policy,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)
}

#KeyParameters: {
	// A flag to indicate whether to bypass the key policy lockout safety check.
	// Setting this value to true increases the risk that the KMS key becomes unmanageable. Do not set this value to true indiscriminately.
	// For more information, refer to the scenario in the Default Key Policy section in the AWS Key Management Service Developer Guide.
	// The default value is false.
	// +kubebuilder:validation:Optional
	bypassPolicyLockoutSafetyCheck?: null | bool @go(BypassPolicyLockoutSafetyCheck,*bool)

	// ID of the KMS Custom Key Store where the key will be stored instead of KMS (eg CloudHSM).
	// +kubebuilder:validation:Optional
	customKeyStoreId?: null | string @go(CustomKeyStoreID,*string)

	// Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports.
	// Valid values: SYMMETRIC_DEFAULT,  RSA_2048, RSA_3072, RSA_4096, HMAC_256, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT. For help with choosing a key spec, see the AWS KMS Developer Guide.
	// +kubebuilder:validation:Optional
	customerMasterKeySpec?: null | string @go(CustomerMasterKeySpec,*string)

	// The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.
	// If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30.
	// If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately.
	// +kubebuilder:validation:Optional
	deletionWindowInDays?: null | float64 @go(DeletionWindowInDays,*float64)

	// The description of the key as viewed in AWS console.
	// +kubebuilder:validation:Optional
	description?: null | string @go(Description,*string)

	// Specifies whether key rotation is enabled. Defaults to false.
	// +kubebuilder:validation:Optional
	enableKeyRotation?: null | bool @go(EnableKeyRotation,*bool)

	// Specifies whether the key is enabled. Defaults to true.
	// +kubebuilder:validation:Optional
	isEnabled?: null | bool @go(IsEnabled,*bool)

	// Specifies the intended use of the key. Valid values: ENCRYPT_DECRYPT, SIGN_VERIFY, or GENERATE_VERIFY_MAC.
	// Defaults to ENCRYPT_DECRYPT.
	// +kubebuilder:validation:Optional
	keyUsage?: null | string @go(KeyUsage,*string)

	// Indicates whether the KMS key is a multi-Region (true) or regional (false) key. Defaults to false.
	// +kubebuilder:validation:Optional
	multiRegion?: null | bool @go(MultiRegion,*bool)

	// A valid policy JSON document. Although this is a key policy, not an IAM policy, an aws_iam_policy_document, in the form that designates a principal, can be used.
	// +kubebuilder:validation:Optional
	policy?: null | string @go(Policy,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
}

// KeySpec defines the desired state of Key
#KeySpec: {
	v1.#ResourceSpec
	forProvider: #KeyParameters @go(ForProvider)

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
	initProvider?: #KeyInitParameters @go(InitProvider)
}

// KeyStatus defines the observed state of Key.
#KeyStatus: {
	v1.#ResourceStatus
	atProvider?: #KeyObservation @go(AtProvider)
}

// Key is the Schema for the Keys API. Manages a single-Region or multi-Region primary KMS key.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Key: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #KeySpec           @go(Spec)
	status?:   #KeyStatus         @go(Status)
}

// KeyList contains a list of Keys
#KeyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Key] @go(Items,[]Key)
}
