package cmd

import (
	"github.com/spf13/cobra"
)

var celvalCmd = &cobra.Command{
	Use:   "celval",
	Short: "celval commands manages to validation of Kubernetes and related manifests using Common Expression Language (CEL) policies",
	Long: `
celval command provides capabilities for validating configuration files for Kubernetes and related technolgies,
Terraform files, and Dockerfiles using Common Expression Language (CEL) policies.

`,
}

func init() {
	rootCmd.AddCommand(celvalCmd)
}
