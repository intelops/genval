package crossplane

import (
	ext "github.com/crossplane/crossplane/apis/apiextensions/v1"
	v1 "github.com/crossplane/crossplane/apis/pkg/v1"
	s3 "github.com/upbound/provider-aws/apis/s3/v1beta1"
	ec2 "github.com/upbound/provider-aws/apis/ec2/v1beta1"
)

#Composition:                 ext.#Composition
#CompositeResourceDefinition: ext.#CompositeResourceDefinition
#Provider:                    v1.#Provider
#Bucket:                      s3.#Bucket
#Instance:                    ec2.#Instance
