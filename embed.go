package embeder

import "embed"

// Embed the def.cue file and the entire cue.mod directory.
//
//go:embed schema/*.cue cue.mod/module.cue cue.mod/gen/**/*.cue cue.mod
var CueDef embed.FS
