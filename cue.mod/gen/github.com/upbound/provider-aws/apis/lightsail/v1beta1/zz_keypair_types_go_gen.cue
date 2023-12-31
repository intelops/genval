// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/lightsail/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#KeyPairInitParameters: {
	// The name of the Lightsail Key Pair
	name?: null | string @go(Name,*string)

	// –  An optional PGP key to encrypt the resulting private
	// key material. Only used when creating a new key pair
	pgpKey?: null | string @go(PgpKey,*string)

	// The public key material. This public key will be
	// imported into Lightsail
	publicKey?: null | string @go(PublicKey,*string)
}

#KeyPairObservation: {
	// The ARN of the Lightsail key pair
	arn?: null | string @go(Arn,*string)

	// The MD5 public key fingerprint for the encrypted
	// private key
	encryptedFingerprint?: null | string @go(EncryptedFingerprint,*string)

	// – the private key material, base 64 encoded and
	// encrypted with the given pgp_key. This is only populated when creating a new
	// key and pgp_key is supplied
	encryptedPrivateKey?: null | string @go(EncryptedPrivateKey,*string)

	// The MD5 public key fingerprint as specified in section 4 of RFC 4716.
	fingerprint?: null | string @go(Fingerprint,*string)

	// The name used for this key pair
	id?: null | string @go(ID,*string)

	// The name of the Lightsail Key Pair
	name?: null | string @go(Name,*string)

	// –  An optional PGP key to encrypt the resulting private
	// key material. Only used when creating a new key pair
	pgpKey?: null | string @go(PgpKey,*string)

	// the private key, base64 encoded. This is only populated
	// when creating a new key, and when no pgp_key is provided
	privateKey?: null | string @go(PrivateKey,*string)

	// The public key material. This public key will be
	// imported into Lightsail
	publicKey?: null | string @go(PublicKey,*string)
}

#KeyPairParameters: {
	// The name of the Lightsail Key Pair
	// +kubebuilder:validation:Optional
	name?: null | string @go(Name,*string)

	// –  An optional PGP key to encrypt the resulting private
	// key material. Only used when creating a new key pair
	// +kubebuilder:validation:Optional
	pgpKey?: null | string @go(PgpKey,*string)

	// The public key material. This public key will be
	// imported into Lightsail
	// +kubebuilder:validation:Optional
	publicKey?: null | string @go(PublicKey,*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)
}

// KeyPairSpec defines the desired state of KeyPair
#KeyPairSpec: {
	v1.#ResourceSpec
	forProvider: #KeyPairParameters @go(ForProvider)

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
	initProvider?: #KeyPairInitParameters @go(InitProvider)
}

// KeyPairStatus defines the observed state of KeyPair.
#KeyPairStatus: {
	v1.#ResourceStatus
	atProvider?: #KeyPairObservation @go(AtProvider)
}

// KeyPair is the Schema for the KeyPairs API. Provides an Lightsail Key Pair
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#KeyPair: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #KeyPairSpec       @go(Spec)
	status?:   #KeyPairStatus     @go(Status)
}

// KeyPairList contains a list of KeyPairs
#KeyPairList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#KeyPair] @go(Items,[]KeyPair)
}
