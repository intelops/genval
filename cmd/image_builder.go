package cmd

import (
	"context"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/containers/buildah"
	"github.com/containers/buildah/define"
	"github.com/containers/buildah/imagebuildah"
	buildahcli "github.com/containers/buildah/pkg/cli"
	"github.com/containers/buildah/util"
	"github.com/containers/storage/pkg/unshare"
	"github.com/intelops/genval/pkg/builder"
	rspec "github.com/opencontainers/runtime-spec/specs-go"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type builderFlags struct {
	reqinput []string
}

var builderArgs builderFlags

func init() {
	buildDescription := `
  Builds an OCI image using instructions in one or more Containerfiles.

  If no arguments are specified, Buildah will use the current working directory
  as the build context and look for a Containerfile. The build fails if no
  Containerfile nor Dockerfile is present.`

	layerFlagsResults := buildahcli.LayerResults{}
	buildFlagResults := buildahcli.BudResults{}
	fromAndBudResults := buildahcli.FromAndBudResults{}
	userNSResults := buildahcli.UserNSResults{}
	namespaceResults := buildahcli.NameSpaceResults{}

	builderCommand := &cobra.Command{
		Use:     "build [CONTEXT]",
		Aliases: []string{"build-using-dockerfile", "bud"},
		Short:   "Build an image using instructions in a Containerfile",
		Long:    buildDescription,
		RunE: func(cmd *cobra.Command, args []string) error {
			if buildah.InitReexec() {
				return nil
			}

			unshare.MaybeReexecUsingUserNamespace(false)

			br := buildahcli.BuildOptions{
				LayerResults:      &layerFlagsResults,
				BudResults:        &buildFlagResults,
				UserNSResults:     &userNSResults,
				FromAndBudResults: &fromAndBudResults,
				NameSpaceResults:  &namespaceResults,
			}
			return builderCmd(cmd, args, br)
		},
		Args: cobra.MaximumNArgs(1),
		// 	Example: `buildah build
		// buildah bud -f Containerfile.simple .
		// buildah bud --volume /home/test:/myvol:ro,Z -t imageName .
		// buildah bud -f Containerfile.simple -f Containerfile.notsosimple .`,
	}

	flags := builderCommand.Flags()
	flags.SetInterspersed(false)

	// build is a all common flags
	builderFlags := buildahcli.GetBudFlags(&buildFlagResults)
	builderFlags.StringVar(&buildFlagResults.Runtime, "runtime", util.Runtime(), "`path` to an alternate runtime. Use BUILDAH_RUNTIME environment variable to override.")
	layerFlags := buildahcli.GetLayerFlags(&layerFlagsResults)
	fromAndBudFlags, err := buildahcli.GetFromAndBudFlags(&fromAndBudResults, &userNSResults, &namespaceResults)
	if err != nil {
		logrus.Errorf("failed to setup From and Build flags: %v", err)
		os.Exit(1)
	}

	flags.AddFlagSet(&builderFlags)
	flags.AddFlagSet(&layerFlags)
	flags.AddFlagSet(&fromAndBudFlags)
	flags.SetNormalizeFunc(buildahcli.AliasFlags)
	flags.StringArrayVarP(&builderArgs.reqinput, "reqinput", "r", nil, "Paths to the required input files")

	imageCmd.AddCommand(builderCommand)
}

func builderCmd(c *cobra.Command, inputArgs []string, iopts buildahcli.BuildOptions) error {
	if buildah.InitReexec() {
		return nil
	}

	unshare.MaybeReexecUsingUserNamespace(false)
	var ctxDir string // Declare ctxDir outside of the if block
	var err error     // Declare err outside of the if block for use in both contexts

	if c.Flag("logfile").Changed {
		logfile, err := os.OpenFile(iopts.Logfile, os.O_CREATE|os.O_TRUNC|os.O_WRONLY, 0o600)
		if err != nil {
			return err
		}
		iopts.Logwriter = logfile
		defer iopts.Logwriter.Close()
	}

	if len(iopts.File) == 0 {
		ctxDir, err = builder.GetContextDir(inputArgs) // Assign ctxDir and err
		if err != nil {
			return err
		}
		fmt.Printf("Context Dir: %s\n", ctxDir)

		getFile := func(filename string) (string, error) {
			file := filepath.Join(ctxDir, filename)
			fileInfo, err := os.Stat(file)
			if err != nil {
				return "", fmt.Errorf("cannot find %s in context directory: %w", filename, err)
			}
			// The file exists, now verify the correct mode
			if mode := fileInfo.Mode(); mode.IsRegular() {
				return file, nil
			}
			return "", fmt.Errorf("assumed %s is a file but it's not", filename)
		}

		defaultFileNames := builderArgs.reqinput
		for _, name := range defaultFileNames {
			fmt.Printf("File Name: %s\n", name)

			foundFile, err := getFile(name)
			if err != nil {
				fmt.Printf("error getting the Dockerfile from %s: %v\n", name, err)
			}
			iopts.File = append(iopts.File, foundFile)
			fmt.Printf("FoundFILE: %v\n", foundFile)
		}
		fmt.Printf("Found File: %v\n", len(iopts.File))
		if len(iopts.File) == 0 {
			return fmt.Errorf("cannot find any of %v in context directory", strings.Join(defaultFileNames, ", "))
		}
	}

	options, containerfiles, removeAll, err := buildahcli.GenBuildOptions(c, inputArgs, iopts)
	if err != nil {
		return err
	}
	defer func() {
		for _, f := range removeAll {
			os.RemoveAll(f)
		}
	}()

	// var transientMounts []string
	// options.TransientMounts = transientMounts
	options.ContextDirectory = ctxDir
	options.OutputFormat = buildah.Dockerv2ImageManifest
	// options.PullPolicy = buildah.PullIfNewer
	// options.Layers = true
	options.RemoveIntermediateCtrs = true
	options.CommonBuildOpts = &define.CommonBuildOptions{}
	options.NoCache = true
	options.NamespaceOptions = []define.NamespaceOption{{
		Name: string(rspec.NetworkNamespace),
		Host: true,
	}}

	// options.DefaultMountsFilePath = DefaultMountsFile
	// for _, mount := range options.TransientMounts {
	// 	transientMounts = append(transientMounts, strings.Replace(mount, "@@TEMPDIR@@", ctxDir, 1))
	// }
	// var store storage.Store
	store, err := builder.GetStore(c)
	if err != nil {
		return err
	}
	// if options.NetworkInterface == nil {
	// 	// create the network interface
	// 	// Note: It is important to do this before we pull any images/create containers.
	// 	// The default backend detection logic needs an empty store to correctly detect
	// 	// that we can use netavark, if the store was not empty it will use CNI to not break existing installs.
	// 	options.NetworkInterface, err = builder.GetNetworkInterface(store, options.CNIConfigDir, options.CNIPluginPath)
	// 	if err != nil {
	// 		return fmt.Errorf("error getting network configuration: %v", err)
	// 	}
	// }

	id, ref, err := imagebuildah.BuildDockerfiles(context.TODO(), store, options, containerfiles...)
	if err == nil && options.Manifest != "" {
		logrus.Debugf("manifest list id = %q, ref = %q", id, ref.String())
	}
	return err
}

var DefaultMountsFile string
