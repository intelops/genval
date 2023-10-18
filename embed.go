package embeder

import "embed"

// Embed the Definitions in ./schema and all `.cue` files in the cue.mod directory.
//
//go:embed cue.mod/module.cue cue.mod/gen/**/*.cue cue.mod
var CueDef embed.FS
