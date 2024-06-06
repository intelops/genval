package oci

const (
	// CreatedAnnotation is the OpenContainers annotation for specifying
	// the date and time on which the OCI artifact was built (RFC 3339).
	CreatedAnnotation = "org.opencontainers.image.created"

	// ConfigMediaType is the OpenContainers artifact media type for the config layer.
	ConfigMediaType = "application/vnd.genval.config.v1+json"

	// ContentMediaType is the OpenContainers artifact media type for the content layer.
	ContentMediaType = "application/vnd.genval.content.v1.tar+gzip"

	ContentTypeAnnotation = "genval.content.type"

	// SourceAnnotation is the OpenContainers annotation for specifying
	// the upstream source of an OCI artifact.
	SourceAnnotation = "org.opencontainers.image.source"

	URLPrefix = "oci://"
)
