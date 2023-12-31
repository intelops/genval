// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane/apis/pkg/meta/v1alpha1

package v1alpha1

_#errWrongConvertToConfiguration:   "must convert to *v1.Configuration"
_#errWrongConvertFromConfiguration: "must convert from *v1.Configuration"
_#errWrongConvertToProvider:        "must convert to *v1.Provider"
_#errWrongConvertFromProvider:      "must convert from *v1.Provider"

// A ToHubConverter converts v1alpha1 types to the 'hub' v1 type.
//
// goverter:converter
// goverter:name GeneratedToHubConverter
// goverter:extend ConvertObjectMeta
// +k8s:deepcopy-gen=false
#ToHubConverter: _

// A FromHubConverter converts v1alpha1 types from the 'hub' v1 type.
//
// goverter:converter
// goverter:name GeneratedFromHubConverter
// goverter:extend ConvertObjectMeta
// +k8s:deepcopy-gen=false
#FromHubConverter: _
