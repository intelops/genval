// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/upbound/provider-aws/apis/transfer/v1beta1

package v1beta1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#EndpointDetailsInitParameters: {
	// A list of address allocation IDs that are required to attach an Elastic IP address to your SFTP server's endpoint. This property can only be used when endpoint_type is set to VPC.
	addressAllocationIds?: [...null | string] @go(AddressAllocationIds,[]*string)

	// A list of security groups IDs that are available to attach to your server's endpoint. If no security groups are specified, the VPC's default security groups are automatically assigned to your endpoint. This property can only be used when endpoint_type is set to VPC.
	securityGroupIds?: [...null | string] @go(SecurityGroupIds,[]*string)

	// A list of subnet IDs that are required to host your SFTP server endpoint in your VPC. This property can only be used when endpoint_type is set to VPC.
	subnetIds?: [...null | string] @go(SubnetIds,[]*string)

	// The ID of the VPC endpoint. This property can only be used when endpoint_type is set to VPC_ENDPOINT
	vpcEndpointId?: null | string @go(VPCEndpointID,*string)
}

#EndpointDetailsObservation: {
	// A list of address allocation IDs that are required to attach an Elastic IP address to your SFTP server's endpoint. This property can only be used when endpoint_type is set to VPC.
	addressAllocationIds?: [...null | string] @go(AddressAllocationIds,[]*string)

	// A list of security groups IDs that are available to attach to your server's endpoint. If no security groups are specified, the VPC's default security groups are automatically assigned to your endpoint. This property can only be used when endpoint_type is set to VPC.
	securityGroupIds?: [...null | string] @go(SecurityGroupIds,[]*string)

	// A list of subnet IDs that are required to host your SFTP server endpoint in your VPC. This property can only be used when endpoint_type is set to VPC.
	subnetIds?: [...null | string] @go(SubnetIds,[]*string)

	// The ID of the VPC endpoint. This property can only be used when endpoint_type is set to VPC_ENDPOINT
	vpcEndpointId?: null | string @go(VPCEndpointID,*string)

	// The VPC ID of the virtual private cloud in which the SFTP server's endpoint will be hosted. This property can only be used when endpoint_type is set to VPC.
	vpcId?: null | string @go(VPCID,*string)
}

#EndpointDetailsParameters: {
	// A list of address allocation IDs that are required to attach an Elastic IP address to your SFTP server's endpoint. This property can only be used when endpoint_type is set to VPC.
	// +kubebuilder:validation:Optional
	addressAllocationIds?: [...null | string] @go(AddressAllocationIds,[]*string)

	// A list of security groups IDs that are available to attach to your server's endpoint. If no security groups are specified, the VPC's default security groups are automatically assigned to your endpoint. This property can only be used when endpoint_type is set to VPC.
	// +kubebuilder:validation:Optional
	securityGroupIds?: [...null | string] @go(SecurityGroupIds,[]*string)

	// A list of subnet IDs that are required to host your SFTP server endpoint in your VPC. This property can only be used when endpoint_type is set to VPC.
	// +kubebuilder:validation:Optional
	subnetIds?: [...null | string] @go(SubnetIds,[]*string)

	// The ID of the VPC endpoint. This property can only be used when endpoint_type is set to VPC_ENDPOINT
	// +kubebuilder:validation:Optional
	vpcEndpointId?: null | string @go(VPCEndpointID,*string)

	// The VPC ID of the virtual private cloud in which the SFTP server's endpoint will be hosted. This property can only be used when endpoint_type is set to VPC.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ec2/v1beta1.VPC
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	vpcId?: null | string @go(VPCID,*string)

	// Reference to a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdRef?: null | v1.#Reference @go(VPCIDRef,*v1.Reference)

	// Selector for a VPC in ec2 to populate vpcId.
	// +kubebuilder:validation:Optional
	vpcIdSelector?: null | v1.#Selector @go(VPCIDSelector,*v1.Selector)
}

#OnPartialUploadInitParameters: {
	// Includes the necessary permissions for S3, EFS, and Lambda operations that Transfer can assume, so that all workflow steps can operate on the required resources.
	executionRole?: null | string @go(ExecutionRole,*string)

	// A unique identifier for the workflow.
	workflowId?: null | string @go(WorkflowID,*string)
}

#OnPartialUploadObservation: {
	// Includes the necessary permissions for S3, EFS, and Lambda operations that Transfer can assume, so that all workflow steps can operate on the required resources.
	executionRole?: null | string @go(ExecutionRole,*string)

	// A unique identifier for the workflow.
	workflowId?: null | string @go(WorkflowID,*string)
}

#OnPartialUploadParameters: {
	// Includes the necessary permissions for S3, EFS, and Lambda operations that Transfer can assume, so that all workflow steps can operate on the required resources.
	// +kubebuilder:validation:Optional
	executionRole?: null | string @go(ExecutionRole,*string)

	// A unique identifier for the workflow.
	// +kubebuilder:validation:Optional
	workflowId?: null | string @go(WorkflowID,*string)
}

#OnUploadInitParameters: {
	// Includes the necessary permissions for S3, EFS, and Lambda operations that Transfer can assume, so that all workflow steps can operate on the required resources.
	executionRole?: null | string @go(ExecutionRole,*string)

	// A unique identifier for the workflow.
	workflowId?: null | string @go(WorkflowID,*string)
}

#OnUploadObservation: {
	// Includes the necessary permissions for S3, EFS, and Lambda operations that Transfer can assume, so that all workflow steps can operate on the required resources.
	executionRole?: null | string @go(ExecutionRole,*string)

	// A unique identifier for the workflow.
	workflowId?: null | string @go(WorkflowID,*string)
}

#OnUploadParameters: {
	// Includes the necessary permissions for S3, EFS, and Lambda operations that Transfer can assume, so that all workflow steps can operate on the required resources.
	// +kubebuilder:validation:Optional
	executionRole?: null | string @go(ExecutionRole,*string)

	// A unique identifier for the workflow.
	// +kubebuilder:validation:Optional
	workflowId?: null | string @go(WorkflowID,*string)
}

#ProtocolDetailsInitParameters: {
	// Indicates the transport method for the AS2 messages. Currently, only HTTP is supported.
	as2Transports?: [...null | string] @go(As2Transports,[]*string)

	// Indicates passive mode, for FTP and FTPS protocols. Enter a single IPv4 address, such as the public IP address of a firewall, router, or load balancer.
	passiveIp?: null | string @go(PassiveIP,*string)

	// Use to ignore the error that is generated when the client attempts to use SETSTAT on a file you are uploading to an S3 bucket. Valid values: DEFAULT, ENABLE_NO_OP.
	setStatOption?: null | string @go(SetStatOption,*string)

	// A property used with Transfer Family servers that use the FTPS protocol. Provides a mechanism to resume or share a negotiated secret key between the control and data connection for an FTPS session. Valid values: DISABLED, ENABLED, ENFORCED.
	tlsSessionResumptionMode?: null | string @go(TLSSessionResumptionMode,*string)
}

#ProtocolDetailsObservation: {
	// Indicates the transport method for the AS2 messages. Currently, only HTTP is supported.
	as2Transports?: [...null | string] @go(As2Transports,[]*string)

	// Indicates passive mode, for FTP and FTPS protocols. Enter a single IPv4 address, such as the public IP address of a firewall, router, or load balancer.
	passiveIp?: null | string @go(PassiveIP,*string)

	// Use to ignore the error that is generated when the client attempts to use SETSTAT on a file you are uploading to an S3 bucket. Valid values: DEFAULT, ENABLE_NO_OP.
	setStatOption?: null | string @go(SetStatOption,*string)

	// A property used with Transfer Family servers that use the FTPS protocol. Provides a mechanism to resume or share a negotiated secret key between the control and data connection for an FTPS session. Valid values: DISABLED, ENABLED, ENFORCED.
	tlsSessionResumptionMode?: null | string @go(TLSSessionResumptionMode,*string)
}

#ProtocolDetailsParameters: {
	// Indicates the transport method for the AS2 messages. Currently, only HTTP is supported.
	// +kubebuilder:validation:Optional
	as2Transports?: [...null | string] @go(As2Transports,[]*string)

	// Indicates passive mode, for FTP and FTPS protocols. Enter a single IPv4 address, such as the public IP address of a firewall, router, or load balancer.
	// +kubebuilder:validation:Optional
	passiveIp?: null | string @go(PassiveIP,*string)

	// Use to ignore the error that is generated when the client attempts to use SETSTAT on a file you are uploading to an S3 bucket. Valid values: DEFAULT, ENABLE_NO_OP.
	// +kubebuilder:validation:Optional
	setStatOption?: null | string @go(SetStatOption,*string)

	// A property used with Transfer Family servers that use the FTPS protocol. Provides a mechanism to resume or share a negotiated secret key between the control and data connection for an FTPS session. Valid values: DISABLED, ENABLED, ENFORCED.
	// +kubebuilder:validation:Optional
	tlsSessionResumptionMode?: null | string @go(TLSSessionResumptionMode,*string)
}

#ServerInitParameters: {
	// The domain of the storage system that is used for file transfers. Valid values are: S3 and EFS. The default value is S3.
	domain?: null | string @go(Domain,*string)

	// The virtual private cloud (VPC) endpoint settings that you want to configure for your SFTP server. Fields documented below.
	endpointDetails?: [...#EndpointDetailsInitParameters] @go(EndpointDetails,[]EndpointDetailsInitParameters)

	// The type of endpoint that you want your SFTP server connect to. If you connect to a VPC (or VPC_ENDPOINT), your SFTP server isn't accessible over the public internet. If you want to connect your SFTP server via public internet, set PUBLIC.  Defaults to PUBLIC.
	endpointType?: null | string @go(EndpointType,*string)

	// A boolean that indicates all users associated with the server should be deleted so that the Server can be destroyed without error. The default value is false. This option only applies to servers configured with a SERVICE_MANAGED identity_provider_type.
	forceDestroy?: null | bool @go(ForceDestroy,*bool)

	// The ARN for a lambda function to use for the Identity provider.
	function?: null | string @go(Function,*string)

	// The mode of authentication enabled for this service. The default value is SERVICE_MANAGED, which allows you to store and access SFTP user credentials within the service. API_GATEWAY indicates that user authentication requires a call to an API Gateway endpoint URL provided by you to integrate an identity provider of your choice. Using AWS_DIRECTORY_SERVICE will allow for authentication against AWS Managed Active Directory or Microsoft Active Directory in your on-premises environment, or in AWS using AD Connectors. Use the AWS_LAMBDA value to directly use a Lambda function as your identity provider. If you choose this value, you must specify the ARN for the lambda function in the function argument.
	identityProviderType?: null | string @go(IdentityProviderType,*string)

	// Amazon Resource Name (ARN) of the IAM role used to authenticate the user account with an identity_provider_type of API_GATEWAY.
	invocationRole?: null | string @go(InvocationRole,*string)

	// Amazon Resource Name (ARN) of an IAM role that allows the service to write your SFTP users’ activity to your Amazon CloudWatch logs for monitoring and auditing purposes.
	loggingRole?: null | string @go(LoggingRole,*string)

	// The protocol settings that are configured for your server.
	protocolDetails?: [...#ProtocolDetailsInitParameters] @go(ProtocolDetails,[]ProtocolDetailsInitParameters)

	// Specifies the file transfer protocol or protocols over which your file transfer protocol client can connect to your server's endpoint. This defaults to SFTP . The available protocols are:
	protocols?: [...null | string] @go(Protocols,[]*string)

	// Specifies the name of the security policy that is attached to the server. Possible values are TransferSecurityPolicy-2018-11, TransferSecurityPolicy-2020-06, TransferSecurityPolicy-FIPS-2020-06 and TransferSecurityPolicy-2022-03. Default value is: TransferSecurityPolicy-2018-11.
	securityPolicyName?: null | string @go(SecurityPolicyName,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// - URL of the service endpoint used to authenticate users with an identity_provider_type of API_GATEWAY.
	url?: null | string @go(URL,*string)

	// Specifies the workflow details. See Workflow Details below.
	workflowDetails?: [...#WorkflowDetailsInitParameters] @go(WorkflowDetails,[]WorkflowDetailsInitParameters)
}

#ServerObservation: {
	// Amazon Resource Name (ARN) of Transfer Server
	arn?: null | string @go(Arn,*string)

	// The Amazon Resource Name (ARN) of the AWS Certificate Manager (ACM) certificate. This is required when protocols is set to FTPS
	certificate?: null | string @go(Certificate,*string)

	// The directory service ID of the directory service you want to connect to with an identity_provider_type of AWS_DIRECTORY_SERVICE.
	directoryId?: null | string @go(DirectoryID,*string)

	// The domain of the storage system that is used for file transfers. Valid values are: S3 and EFS. The default value is S3.
	domain?: null | string @go(Domain,*string)

	// The endpoint of the Transfer Server (e.g., s-12345678.server.transfer.REGION.amazonaws.com)
	endpoint?: null | string @go(Endpoint,*string)

	// The virtual private cloud (VPC) endpoint settings that you want to configure for your SFTP server. Fields documented below.
	endpointDetails?: [...#EndpointDetailsObservation] @go(EndpointDetails,[]EndpointDetailsObservation)

	// The type of endpoint that you want your SFTP server connect to. If you connect to a VPC (or VPC_ENDPOINT), your SFTP server isn't accessible over the public internet. If you want to connect your SFTP server via public internet, set PUBLIC.  Defaults to PUBLIC.
	endpointType?: null | string @go(EndpointType,*string)

	// A boolean that indicates all users associated with the server should be deleted so that the Server can be destroyed without error. The default value is false. This option only applies to servers configured with a SERVICE_MANAGED identity_provider_type.
	forceDestroy?: null | bool @go(ForceDestroy,*bool)

	// The ARN for a lambda function to use for the Identity provider.
	function?: null | string @go(Function,*string)

	// This value contains the message-digest algorithm (MD5) hash of the server's host key. This value is equivalent to the output of the ssh-keygen -l -E md5 -f my-new-server-key command.
	hostKeyFingerprint?: null | string @go(HostKeyFingerprint,*string)

	// The Server ID of the Transfer Server (e.g., s-12345678)
	id?: null | string @go(ID,*string)

	// The mode of authentication enabled for this service. The default value is SERVICE_MANAGED, which allows you to store and access SFTP user credentials within the service. API_GATEWAY indicates that user authentication requires a call to an API Gateway endpoint URL provided by you to integrate an identity provider of your choice. Using AWS_DIRECTORY_SERVICE will allow for authentication against AWS Managed Active Directory or Microsoft Active Directory in your on-premises environment, or in AWS using AD Connectors. Use the AWS_LAMBDA value to directly use a Lambda function as your identity provider. If you choose this value, you must specify the ARN for the lambda function in the function argument.
	identityProviderType?: null | string @go(IdentityProviderType,*string)

	// Amazon Resource Name (ARN) of the IAM role used to authenticate the user account with an identity_provider_type of API_GATEWAY.
	invocationRole?: null | string @go(InvocationRole,*string)

	// Amazon Resource Name (ARN) of an IAM role that allows the service to write your SFTP users’ activity to your Amazon CloudWatch logs for monitoring and auditing purposes.
	loggingRole?: null | string @go(LoggingRole,*string)

	// The protocol settings that are configured for your server.
	protocolDetails?: [...#ProtocolDetailsObservation] @go(ProtocolDetails,[]ProtocolDetailsObservation)

	// Specifies the file transfer protocol or protocols over which your file transfer protocol client can connect to your server's endpoint. This defaults to SFTP . The available protocols are:
	protocols?: [...null | string] @go(Protocols,[]*string)

	// Specifies the name of the security policy that is attached to the server. Possible values are TransferSecurityPolicy-2018-11, TransferSecurityPolicy-2020-06, TransferSecurityPolicy-FIPS-2020-06 and TransferSecurityPolicy-2022-03. Default value is: TransferSecurityPolicy-2018-11.
	securityPolicyName?: null | string @go(SecurityPolicyName,*string)

	// Key-value map of resource tags.
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
	tagsAll?: {[string]: null | string} @go(TagsAll,map[string]*string)

	// - URL of the service endpoint used to authenticate users with an identity_provider_type of API_GATEWAY.
	url?: null | string @go(URL,*string)

	// Specifies the workflow details. See Workflow Details below.
	workflowDetails?: [...#WorkflowDetailsObservation] @go(WorkflowDetails,[]WorkflowDetailsObservation)
}

#ServerParameters: {
	// The Amazon Resource Name (ARN) of the AWS Certificate Manager (ACM) certificate. This is required when protocols is set to FTPS
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/acm/v1beta1.Certificate
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractParamPath("arn",true)
	// +kubebuilder:validation:Optional
	certificate?: null | string @go(Certificate,*string)

	// Reference to a Certificate in acm to populate certificate.
	// +kubebuilder:validation:Optional
	certificateRef?: null | v1.#Reference @go(CertificateRef,*v1.Reference)

	// Selector for a Certificate in acm to populate certificate.
	// +kubebuilder:validation:Optional
	certificateSelector?: null | v1.#Selector @go(CertificateSelector,*v1.Selector)

	// The directory service ID of the directory service you want to connect to with an identity_provider_type of AWS_DIRECTORY_SERVICE.
	// +crossplane:generate:reference:type=github.com/upbound/provider-aws/apis/ds/v1beta1.Directory
	// +crossplane:generate:reference:extractor=github.com/crossplane/upjet/pkg/resource.ExtractResourceID()
	// +kubebuilder:validation:Optional
	directoryId?: null | string @go(DirectoryID,*string)

	// Reference to a Directory in ds to populate directoryId.
	// +kubebuilder:validation:Optional
	directoryIdRef?: null | v1.#Reference @go(DirectoryIDRef,*v1.Reference)

	// Selector for a Directory in ds to populate directoryId.
	// +kubebuilder:validation:Optional
	directoryIdSelector?: null | v1.#Selector @go(DirectoryIDSelector,*v1.Selector)

	// The domain of the storage system that is used for file transfers. Valid values are: S3 and EFS. The default value is S3.
	// +kubebuilder:validation:Optional
	domain?: null | string @go(Domain,*string)

	// The virtual private cloud (VPC) endpoint settings that you want to configure for your SFTP server. Fields documented below.
	// +kubebuilder:validation:Optional
	endpointDetails?: [...#EndpointDetailsParameters] @go(EndpointDetails,[]EndpointDetailsParameters)

	// The type of endpoint that you want your SFTP server connect to. If you connect to a VPC (or VPC_ENDPOINT), your SFTP server isn't accessible over the public internet. If you want to connect your SFTP server via public internet, set PUBLIC.  Defaults to PUBLIC.
	// +kubebuilder:validation:Optional
	endpointType?: null | string @go(EndpointType,*string)

	// A boolean that indicates all users associated with the server should be deleted so that the Server can be destroyed without error. The default value is false. This option only applies to servers configured with a SERVICE_MANAGED identity_provider_type.
	// +kubebuilder:validation:Optional
	forceDestroy?: null | bool @go(ForceDestroy,*bool)

	// The ARN for a lambda function to use for the Identity provider.
	// +kubebuilder:validation:Optional
	function?: null | string @go(Function,*string)

	// RSA, ECDSA, or ED25519 private key (e.g., as generated by the ssh-keygen -t rsa -b 2048 -N "" -m PEM -f my-new-server-key, ssh-keygen -t ecdsa -b 256 -N "" -m PEM -f my-new-server-key or ssh-keygen -t ed25519 -N "" -f my-new-server-key commands).
	// +kubebuilder:validation:Optional
	hostKeySecretRef?: null | v1.#SecretKeySelector @go(HostKeySecretRef,*v1.SecretKeySelector)

	// The mode of authentication enabled for this service. The default value is SERVICE_MANAGED, which allows you to store and access SFTP user credentials within the service. API_GATEWAY indicates that user authentication requires a call to an API Gateway endpoint URL provided by you to integrate an identity provider of your choice. Using AWS_DIRECTORY_SERVICE will allow for authentication against AWS Managed Active Directory or Microsoft Active Directory in your on-premises environment, or in AWS using AD Connectors. Use the AWS_LAMBDA value to directly use a Lambda function as your identity provider. If you choose this value, you must specify the ARN for the lambda function in the function argument.
	// +kubebuilder:validation:Optional
	identityProviderType?: null | string @go(IdentityProviderType,*string)

	// Amazon Resource Name (ARN) of the IAM role used to authenticate the user account with an identity_provider_type of API_GATEWAY.
	// +kubebuilder:validation:Optional
	invocationRole?: null | string @go(InvocationRole,*string)

	// Amazon Resource Name (ARN) of an IAM role that allows the service to write your SFTP users’ activity to your Amazon CloudWatch logs for monitoring and auditing purposes.
	// +kubebuilder:validation:Optional
	loggingRole?: null | string @go(LoggingRole,*string)

	// Specify a string to display when users connect to a server. This string is displayed after the user authenticates. The SFTP protocol does not support post-authentication display banners.
	// +kubebuilder:validation:Optional
	postAuthenticationLoginBannerSecretRef?: null | v1.#SecretKeySelector @go(PostAuthenticationLoginBannerSecretRef,*v1.SecretKeySelector)

	// Specify a string to display when users connect to a server. This string is displayed before the user authenticates.
	// +kubebuilder:validation:Optional
	preAuthenticationLoginBannerSecretRef?: null | v1.#SecretKeySelector @go(PreAuthenticationLoginBannerSecretRef,*v1.SecretKeySelector)

	// The protocol settings that are configured for your server.
	// +kubebuilder:validation:Optional
	protocolDetails?: [...#ProtocolDetailsParameters] @go(ProtocolDetails,[]ProtocolDetailsParameters)

	// Specifies the file transfer protocol or protocols over which your file transfer protocol client can connect to your server's endpoint. This defaults to SFTP . The available protocols are:
	// +kubebuilder:validation:Optional
	protocols?: [...null | string] @go(Protocols,[]*string)

	// Region is the region you'd like your resource to be created in.
	// +upjet:crd:field:TFTag=-
	// +kubebuilder:validation:Required
	region?: null | string @go(Region,*string)

	// Specifies the name of the security policy that is attached to the server. Possible values are TransferSecurityPolicy-2018-11, TransferSecurityPolicy-2020-06, TransferSecurityPolicy-FIPS-2020-06 and TransferSecurityPolicy-2022-03. Default value is: TransferSecurityPolicy-2018-11.
	// +kubebuilder:validation:Optional
	securityPolicyName?: null | string @go(SecurityPolicyName,*string)

	// Key-value map of resource tags.
	// +kubebuilder:validation:Optional
	tags?: {[string]: null | string} @go(Tags,map[string]*string)

	// - URL of the service endpoint used to authenticate users with an identity_provider_type of API_GATEWAY.
	// +kubebuilder:validation:Optional
	url?: null | string @go(URL,*string)

	// Specifies the workflow details. See Workflow Details below.
	// +kubebuilder:validation:Optional
	workflowDetails?: [...#WorkflowDetailsParameters] @go(WorkflowDetails,[]WorkflowDetailsParameters)
}

#WorkflowDetailsInitParameters: {
	// A trigger that starts a workflow if a file is only partially uploaded. See Workflow Detail below.
	onPartialUpload?: [...#OnPartialUploadInitParameters] @go(OnPartialUpload,[]OnPartialUploadInitParameters)

	// A trigger that starts a workflow: the workflow begins to execute after a file is uploaded. See Workflow Detail below.
	onUpload?: [...#OnUploadInitParameters] @go(OnUpload,[]OnUploadInitParameters)
}

#WorkflowDetailsObservation: {
	// A trigger that starts a workflow if a file is only partially uploaded. See Workflow Detail below.
	onPartialUpload?: [...#OnPartialUploadObservation] @go(OnPartialUpload,[]OnPartialUploadObservation)

	// A trigger that starts a workflow: the workflow begins to execute after a file is uploaded. See Workflow Detail below.
	onUpload?: [...#OnUploadObservation] @go(OnUpload,[]OnUploadObservation)
}

#WorkflowDetailsParameters: {
	// A trigger that starts a workflow if a file is only partially uploaded. See Workflow Detail below.
	// +kubebuilder:validation:Optional
	onPartialUpload?: [...#OnPartialUploadParameters] @go(OnPartialUpload,[]OnPartialUploadParameters)

	// A trigger that starts a workflow: the workflow begins to execute after a file is uploaded. See Workflow Detail below.
	// +kubebuilder:validation:Optional
	onUpload?: [...#OnUploadParameters] @go(OnUpload,[]OnUploadParameters)
}

// ServerSpec defines the desired state of Server
#ServerSpec: {
	v1.#ResourceSpec
	forProvider: #ServerParameters @go(ForProvider)

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
	initProvider?: #ServerInitParameters @go(InitProvider)
}

// ServerStatus defines the observed state of Server.
#ServerStatus: {
	v1.#ResourceStatus
	atProvider?: #ServerObservation @go(AtProvider)
}

// Server is the Schema for the Servers API. Provides a AWS Transfer Server resource.
// +kubebuilder:printcolumn:name="READY",type="string",JSONPath=".status.conditions[?(@.type=='Ready')].status"
// +kubebuilder:printcolumn:name="SYNCED",type="string",JSONPath=".status.conditions[?(@.type=='Synced')].status"
// +kubebuilder:printcolumn:name="EXTERNAL-NAME",type="string",JSONPath=".metadata.annotations.crossplane\\.io/external-name"
// +kubebuilder:printcolumn:name="AGE",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:subresource:status
// +kubebuilder:resource:scope=Cluster,categories={crossplane,managed,aws}
#Server: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec:      #ServerSpec        @go(Spec)
	status?:   #ServerStatus      @go(Status)
}

// ServerList contains a list of Servers
#ServerList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Server] @go(Items,[]Server)
}
