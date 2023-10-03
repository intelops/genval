// main.go root main package

package main

import (
	"flag"
	"fmt"

	"github.com/intelops/genval/cmd/cueval"
	"github.com/intelops/genval/cmd/docker"
)

var mode string

func init() {
	flag.StringVar(&mode, "mode", "", "Specify mode: 'docker' for Dockerfile validation/generation or 'cueval' for K8s resource validation/generation.")

	// Customize flag.Usage to show detailed help topics
	flag.Usage = func() {
		usageText := `
Usage of genval:

Modes:
    docker: Dockerfile validation and generation. Arguments: <input.json> <output.Dockerfile>
    Example usage: ./genval -mode=docker input.json output.Dockerfile

    cueval: K8s resource validation and generation. Arguments: <Resource> <Input JSON>
    Example usage: ./genval -mode=cueval deployment deployment.json

`
		fmt.Println(usageText)
		flag.PrintDefaults()
	}
}

func main() {
	flag.Parse()

	// Pass arguments after the mode flag
	args := flag.Args()

	switch mode {
	case "docker":
		docker.Execute(args) // Call the Docker mode's execution function
	case "cueval":
		cueval.Execute(args) // Call the K8s mode's execution function
	default:
		fmt.Println("Invalid mode. Choose 'docker' or 'cueval'.")
		flag.Usage()
	}
}
