// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/crossplane/crossplane/apis/apiextensions/fn/proto/v1alpha1

package v1alpha1

import "google.golang.org/protobuf/types/known/durationpb"

// ImagePullPolicy specifies when a Composition Function container should be
// pulled from a remote OCI registry.
#ImagePullPolicy: int32 // #enumImagePullPolicy

#enumImagePullPolicy:
	#ImagePullPolicy_IMAGE_PULL_POLICY_UNSPECIFIED |
	#ImagePullPolicy_IMAGE_PULL_POLICY_IF_NOT_PRESENT |
	#ImagePullPolicy_IMAGE_PULL_POLICY_ALWAYS |
	#ImagePullPolicy_IMAGE_PULL_POLICY_NEVER

#values_ImagePullPolicy: {
	ImagePullPolicy_IMAGE_PULL_POLICY_UNSPECIFIED:    #ImagePullPolicy_IMAGE_PULL_POLICY_UNSPECIFIED
	ImagePullPolicy_IMAGE_PULL_POLICY_IF_NOT_PRESENT: #ImagePullPolicy_IMAGE_PULL_POLICY_IF_NOT_PRESENT
	ImagePullPolicy_IMAGE_PULL_POLICY_ALWAYS:         #ImagePullPolicy_IMAGE_PULL_POLICY_ALWAYS
	ImagePullPolicy_IMAGE_PULL_POLICY_NEVER:          #ImagePullPolicy_IMAGE_PULL_POLICY_NEVER
}

#ImagePullPolicy_IMAGE_PULL_POLICY_UNSPECIFIED:    #ImagePullPolicy & 0
#ImagePullPolicy_IMAGE_PULL_POLICY_IF_NOT_PRESENT: #ImagePullPolicy & 1
#ImagePullPolicy_IMAGE_PULL_POLICY_ALWAYS:         #ImagePullPolicy & 2
#ImagePullPolicy_IMAGE_PULL_POLICY_NEVER:          #ImagePullPolicy & 3

// NetworkPolicy configures whether a container is isolated from the network.
#NetworkPolicy: int32 // #enumNetworkPolicy

#enumNetworkPolicy:
	#NetworkPolicy_NETWORK_POLICY_UNSPECIFIED |
	#NetworkPolicy_NETWORK_POLICY_ISOLATED |
	#NetworkPolicy_NETWORK_POLICY_RUNNER

#values_NetworkPolicy: {
	NetworkPolicy_NETWORK_POLICY_UNSPECIFIED: #NetworkPolicy_NETWORK_POLICY_UNSPECIFIED
	NetworkPolicy_NETWORK_POLICY_ISOLATED:    #NetworkPolicy_NETWORK_POLICY_ISOLATED
	NetworkPolicy_NETWORK_POLICY_RUNNER:      #NetworkPolicy_NETWORK_POLICY_RUNNER
}

#NetworkPolicy_NETWORK_POLICY_UNSPECIFIED: #NetworkPolicy & 0

// Run the container without network access. The default.
#NetworkPolicy_NETWORK_POLICY_ISOLATED: #NetworkPolicy & 1

// Allow the container to access the same network as the function runner.
#NetworkPolicy_NETWORK_POLICY_RUNNER: #NetworkPolicy & 2

// ImagePullAuth configures authentication to a remote OCI registry.
// It corresponds to go-containerregistry's AuthConfig type.
// https://pkg.go.dev/github.com/google/go-containerregistry@v0.11.0/pkg/authn#AuthConfig
#ImagePullAuth: {
	username?:       string @go(Username) @protobuf(1,bytes,opt,proto3)
	password?:       string @go(Password) @protobuf(2,bytes,opt,proto3)
	auth?:           string @go(Auth) @protobuf(3,bytes,opt,proto3)
	identity_token?: string @go(IdentityToken) @protobuf(4,bytes,opt,json=identityToken,proto3)
	registry_token?: string @go(RegistryToken) @protobuf(5,bytes,opt,json=registryToken,proto3)
}

// ImagePullConfig configures how a Composition Function container should be
// pulled from a remote OCI registry.
#ImagePullConfig: {
	pull_policy?: #ImagePullPolicy      @go(PullPolicy) @protobuf(1,varint,opt,json=pullPolicy,proto3,enum=apiextensions.fn.proto.v1alpha1.ImagePullPolicy)
	auth?:        null | #ImagePullAuth @go(Auth,*ImagePullAuth) @protobuf(2,bytes,opt,proto3)
}

// NetworkConfig configures whether and how a Composition Function container may
// access the network.
#NetworkConfig: {
	// Whether or not the container can access the network.
	policy?: #NetworkPolicy @go(Policy) @protobuf(1,varint,opt,proto3,enum=apiextensions.fn.proto.v1alpha1.NetworkPolicy)
}

// Resources configures what compute resources should be available to a
// Composition Function container.
#ResourceConfig: {
	limits?: null | #ResourceLimits @go(Limits,*ResourceLimits) @protobuf(1,bytes,opt,proto3)
}

// ResourceLimits configures the maximum compute resources that will be
// available to a Composition Function container.
#ResourceLimits: {
	// CPU, in cores. (500m = .5 cores)
	// Specified in Kubernetes-style resource.Quantity form.
	memory?: string @go(Memory) @protobuf(1,bytes,opt,proto3)

	// Memory, in bytes. (500Gi = 500GiB = 500 * 1024 * 1024 * 1024)
	// Specified in Kubernetes-style resource.Quantity form.
	cpu?: string @go(Cpu) @protobuf(2,bytes,opt,proto3)
}

// RunFunctionConfig configures how a Composition Function container is run.
#RunFunctionConfig: {
	// Resources available to the container.
	resources?: null | #ResourceConfig @go(Resources,*ResourceConfig) @protobuf(1,bytes,opt,proto3)

	// Network configuration for the container.
	network?: null | #NetworkConfig @go(Network,*NetworkConfig) @protobuf(2,bytes,opt,proto3)

	// Timeout after which the container will be killed.
	timeout?: null | durationpb.#Duration @go(Timeout,*durationpb.Duration) @protobuf(3,bytes,opt,proto3)
}

// A RunFunctionRequest requests that a Composition Function be run.
#RunFunctionRequest: {
	// OCI image of the Composition Function.
	image?: string @go(Image) @protobuf(1,bytes,opt,proto3)

	// A FunctionIO serialized as YAML.
	input?: bytes @go(Input,[]byte) @protobuf(2,bytes,opt,proto3)

	// Configures how the function image is pulled.
	image_pull_config?: null | #ImagePullConfig @go(ImagePullConfig,*ImagePullConfig) @protobuf(3,bytes,opt,json=imagePullConfig,proto3)

	// Configures how the function container is run.
	run_function_config?: null | #RunFunctionConfig @go(RunFunctionConfig,*RunFunctionConfig) @protobuf(4,bytes,opt,json=runFunctionConfig,proto3)
}

// A RunFunctionResponse contains the response from a Composition Function run.
// The output FunctionIO is returned as opaque bytes. Errors encountered while
// running a function (as opposed to errors returned _by_ a function) will be
// encapsulated as gRPC errors.
#RunFunctionResponse: {
	output?: bytes @go(Output,[]byte) @protobuf(1,bytes,opt,proto3)
}
