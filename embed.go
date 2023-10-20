package embeder

import "embed"

// Embed all `.cue` files in the cue.mod directory.
//
//go:embed cue.mod/module.cue cue.mod/gen/**/*.cue cue.mod
var CueDef embed.FS
