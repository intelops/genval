// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/transcribe/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#VocabularyInitParameters: {
	// The language code you selected for your vocabulary.
	languageCode?: null | string @go(LanguageCode,*string)

	// - A list of terms to include in the vocabulary. Conflicts with vocabulary_file_uri
	phrases?: [...null | string] @go(Phrases,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The Amazon S3 location (URI) of the text file that contains your custom vocabulary.
	vocabularyFileUri?: null | string @go(VocabularyFileURI,*string)
}

#VocabularyObservation: {
	// ARN of the Vocabulary.
	arn?: null | string @go(Arn,*string)

	// Generated download URI.
	downloadUri?: null | string @go(DownloadURI,*string)

	// Name of the Vocabulary.
	id?: null | string @go(ID,*string)

	// The language code you selected for your vocabulary.
	languageCode?: null | string @go(LanguageCode,*string)

	// - A list of terms to include in the vocabulary. Conflicts with vocabulary_file_uri
	phrases?: [...null | string] @go(Phrases,[]*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// The Amazon S3 location (URI) of the text file that contains your custom vocabulary.
	vocabularyFileUri?: null | string @go(VocabularyFileURI,*string)
}

#VocabularyParameters: {
	// The language code you selected for your vocabulary.
	// +kubebuilder:validation:Optional
	languageCode?: null | string @go(LanguageCode,*string)

	// - A list of terms to include in the vocabulary. Conflicts with vocabulary_file_uri
	// +kubebuilder:validation:Optional
	phrases?: [...null | string] @go(Phrases,[]*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// The Amazon S3 location (URI) of the text file that contains your custom vocabulary.
	// +kubebuilder:validation:Optional
	vocabularyFileUri?: null | string @go(VocabularyFileURI,*string)
}

// VocabularySpec defines the desired state of Vocabulary
#VocabularySpec: {
	v1.#ResourceSpec
	forProvider: #VocabularyParameters @go(ForProvider)

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
	initProvider?: #VocabularyInitParameters @go(InitProvider)
}

// VocabularyStatus defines the observed state of Vocabulary.
#VocabularyStatus: {
	v1.#ResourceStatus
	atProvider?: #VocabularyObservation @go(AtProvider)
}

// Vocabulary is the Schema for the Vocabularys API.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Vocabulary: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.languageCode) || (has(self.initProvider) && has(self.initProvider.languageCode))",message="spec.forProvider.languageCode is a required parameter"
	spec:    #VocabularySpec   @go(Spec)
	status?: #VocabularyStatus @go(Status)
}

// VocabularyList contains a list of Vocabularys
#VocabularyList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Vocabulary] @go(Items,[]Vocabulary)
}
