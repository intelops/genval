package embeder

import "embed"

// Embed all `.cue` files in the cue.mod directory.

//go:embed module.cue gen/**/*.cue
var CueDef embed.FS
