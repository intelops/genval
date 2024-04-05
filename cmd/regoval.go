package cmd

import (
	"github.com/spf13/cobra"
)

var regovalCmd = &cobra.Command{
	Use:   "regoval",
	Short: "Command that manages validation of Kubernetes and related configuration files with Rego policies",
	Long: `
regoval command maages validation of Kubernetes and related manifests, Terraform files, and Dockerfiles
using Rego policies.
.
`,
}

func init() {
	rootCmd.AddCommand(regovalCmd)
}
