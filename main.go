package main

import (
	"github.com/containers/buildah"
	"github.com/containers/storage/pkg/unshare"
	"github.com/intelops/genval/cmd"
)

func main() {
	if buildah.InitReexec() {
		return
	}

	unshare.MaybeReexecUsingUserNamespace(false)
	cmd.Execute()
}
