// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go knative.dev/pkg/apis/duck/v1

package v1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"knative.dev/pkg/apis"
)

// Source is the minimum resource shape to adhere to the Source Specification.
// This duck type is intended to allow implementors of Sources and
// Importers to verify their own resources meet the expectations.
// This is not a real resource.
// NOTE: The Source Specification is in progress and the shape and names could
// be modified until it has been accepted.
#Source: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #SourceSpec        @go(Spec)
	status:    #SourceStatus      @go(Status)
}

#SourceSpec: {
	// Sink is a reference to an object that will resolve to a uri to use as the sink.
	sink?: #Destination @go(Sink)

	// CloudEventOverrides defines overrides to control the output format and
	// modifications of the event sent to the sink.
	// +optional
	ceOverrides?: null | #CloudEventOverrides @go(CloudEventOverrides,*CloudEventOverrides)
}

// CloudEventOverrides defines arguments for a Source that control the output
// format of the CloudEvents produced by the Source.
#CloudEventOverrides: {
	// Extensions specify what attribute are added or overridden on the
	// outbound event. Each `Extensions` key-value pair are set on the event as
	// an attribute extension independently.
	// +optional
	extensions?: {[string]: string} @go(Extensions,map[string]string)
}

// SourceStatus shows how we expect folks to embed Addressable in
// their Status field.
#SourceStatus: {
	#Status

	// SinkURI is the current active sink URI that has been configured for the
	// Source.
	// +optional
	sinkUri?: null | apis.#URL @go(SinkURI,*apis.URL)

	// CloudEventAttributes are the specific attributes that the Source uses
	// as part of its CloudEvents.
	// +optional
	ceAttributes?: [...#CloudEventAttributes] @go(CloudEventAttributes,[]CloudEventAttributes)

	// SinkCACerts are Certification Authority (CA) certificates in PEM format
	// according to https://www.rfc-editor.org/rfc/rfc7468.
	// +optional
	sinkCACerts?: null | string @go(SinkCACerts,*string)
}

// CloudEventAttributes specifies the attributes that a Source
// uses as part of its CloudEvents.
#CloudEventAttributes: {
	// Type refers to the CloudEvent type attribute.
	type?: string @go(Type)

	// Source is the CloudEvents source attribute.
	source?: string @go(Source)
}

// SourceConditionSinkProvided has status True when the Source
// has been configured with a sink target that is resolvable.
#SourceConditionSinkProvided: apis.#ConditionType & "SinkProvided"

// SourceList is a list of Source resources
#SourceList: {
	metav1.#TypeMeta
	metadata: metav1.#ListMeta @go(ListMeta)
	items: [...#Source] @go(Items,[]Source)
}
