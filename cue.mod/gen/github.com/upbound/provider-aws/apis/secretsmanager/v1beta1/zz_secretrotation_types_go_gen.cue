// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/secretsmanager/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#SecretRotationInitParameters: {
	// A structure that defines the rotation configuration for this secret. Defined below.
	rotationRules?: [...#SecretRotationRotationRulesInitParameters] @go(RotationRules,[]SecretRotationRotationRulesInitParameters)
}

#SecretRotationObservation: {
	// Amazon Resource Name (ARN) of the secret.
	id?: null | string @go(ID,*string)

	// Specifies whether automatic rotation is enabled for this secret.
	rotationEnabled?: null | bool @go(RotationEnabled,*bool)

	// Specifies the ARN of the Lambda function that can rotate the secret.
	rotationLambdaArn?: null | string @go(RotationLambdaArn,*string)

	// A structure that defines the rotation configuration for this secret. Defined below.
	rotationRules?: [...#SecretRotationRotationRulesObservation] @go(RotationRules,[]SecretRotationRotationRulesObservation)

	// Specifies the secret to which you want to add a new version. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret. The secret must already exist.
	secretId?: null | string @go(SecretID,*string)
}

#SecretRotationParameters: {
	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Specifies the ARN of the Lambda function that can rotate the secret.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/lambda/v1beta1.Function
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	rotationLambdaArn?: null | string @go(RotationLambdaArn,*string)

	// Reference to a Function in lambda to populate rotationLambdaArn.
	// +kubebuilder:validation:Optional
	rotationLambdaArnRef?: null | v1.#Reference @go(RotationLambdaArnRef,*v1.Reference)

	// Selector for a Function in lambda to populate rotationLambdaArn.
	// +kubebuilder:validation:Optional
	rotationLambdaArnSelector?: null | v1.#Selector @go(RotationLambdaArnSelector,*v1.Selector)

	// A structure that defines the rotation configuration for this secret. Defined below.
	// +kubebuilder:validation:Optional
	rotationRules?: [...#SecretRotationRotationRulesParameters] @go(RotationRules,[]SecretRotationRotationRulesParameters)

	// Specifies the secret to which you want to add a new version. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret. The secret must already exist.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/secretsmanager/v1beta1.Secret
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	secretId?: null | string @go(SecretID,*string)

	// Reference to a Secret in secretsmanager to populate secretId.
	// +kubebuilder:validation:Optional
	secretIdRef?: null | v1.#Reference @go(SecretIDRef,*v1.Reference)

	// Selector for a Secret in secretsmanager to populate secretId.
	// +kubebuilder:validation:Optional
	secretIdSelector?: null | v1.#Selector @go(SecretIDSelector,*v1.Selector)
}

#SecretRotationRotationRulesInitParameters: {
	// Specifies the number of days between automatic scheduled rotations of the secret. Either automatically_after_days or schedule_expression must be specified.
	automaticallyAfterDays?: null | float64 @go(AutomaticallyAfterDays,*float64)

	// - The length of the rotation window in hours. For example, 3h for a three hour window.
	duration?: null | string @go(Duration,*string)

	// A cron() or rate() expression that defines the schedule for rotating your secret. Either automatically_after_days or schedule_expression must be specified.
	scheduleExpression?: null | string @go(ScheduleExpression,*string)
}

#SecretRotationRotationRulesObservation: {
	// Specifies the number of days between automatic scheduled rotations of the secret. Either automatically_after_days or schedule_expression must be specified.
	automaticallyAfterDays?: null | float64 @go(AutomaticallyAfterDays,*float64)

	// - The length of the rotation window in hours. For example, 3h for a three hour window.
	duration?: null | string @go(Duration,*string)

	// A cron() or rate() expression that defines the schedule for rotating your secret. Either automatically_after_days or schedule_expression must be specified.
	scheduleExpression?: null | string @go(ScheduleExpression,*string)
}

#SecretRotationRotationRulesParameters: {
	// Specifies the number of days between automatic scheduled rotations of the secret. Either automatically_after_days or schedule_expression must be specified.
	// +kubebuilder:validation:Optional
	automaticallyAfterDays?: null | float64 @go(AutomaticallyAfterDays,*float64)

	// - The length of the rotation window in hours. For example, 3h for a three hour window.
	// +kubebuilder:validation:Optional
	duration?: null | string @go(Duration,*string)

	// A cron() or rate() expression that defines the schedule for rotating your secret. Either automatically_after_days or schedule_expression must be specified.
	// +kubebuilder:validation:Optional
	scheduleExpression?: null | string @go(ScheduleExpression,*string)
}

// SecretRotationSpec defines the desired state of SecretRotation
#SecretRotationSpec: {
	v1.#ResourceSpec
	forProvider: #SecretRotationParameters @go(ForProvider)

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
	initProvider?: #SecretRotationInitParameters @go(InitProvider)
}

// SecretRotationStatus defines the observed state of SecretRotation.
#SecretRotationStatus: {
	v1.#ResourceStatus
	atProvider?: #SecretRotationObservation @go(AtProvider)
}

// SecretRotation is the Schema for the SecretRotations API. Provides a resource to manage AWS Secrets Manager secret rotation
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#SecretRotation: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// +kubebuilder:validation:XValidation:rule="!('*' in self.managementPolicies || 'Create' in self.managementPolicies || 'Update' in self.managementPolicies) || has(self.forProvider.rotationRules) || (has(self.initProvider) && has(self.initProvider.rotationRules))",message="spec.forProvider.rotationRules is a required parameter"
	spec:    #SecretRotationSpec   @go(Spec)
	status?: #SecretRotationStatus @go(Status)
}

// SecretRotationList contains a list of SecretRotations
#SecretRotationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#SecretRotation] @go(Items,[]SecretRotation)
}
