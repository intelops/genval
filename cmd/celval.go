package cmd

import (
	"github.com/spf13/cobra"
)

var celvalCmd = &cobra.Command{
	Use:   "celval",
	Short: "Validate config files like, Dockerfile, Kubernetes and related manifests, and Terraform files using Common Expression Language (CEL) policies",
	Long: `
celval command provides capabilities for validating configuration files for Kubernetes and related technolgies,
Terraform files, and Dockerfiles using Common Expression Language (CEL) policies.

`,
}

func init() {
	rootCmd.AddCommand(celvalCmd)
}
