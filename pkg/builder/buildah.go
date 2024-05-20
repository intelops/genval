package builder

import (
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/containers/buildah/define"
	"github.com/containers/common/libnetwork/network"
	netTypes "github.com/containers/common/libnetwork/types"
	"github.com/containers/common/pkg/config"
	"github.com/containers/common/pkg/umask"
	is "github.com/containers/image/v5/storage"
	"github.com/containers/storage"
	"github.com/containers/storage/pkg/unshare"
	"github.com/docker/docker/pkg/homedir"
	"github.com/spf13/cobra"
)

type globalFlags struct {
	Debug                      bool
	LogLevel                   string
	Root                       string
	RunRoot                    string
	StorageDriver              string
	RegistriesConf             string
	RegistriesConfDir          string
	DefaultMountsFile          string
	StorageOpts                []string
	UserNSUID                  []string
	UserNSGID                  []string
	CPUProfile                 string
	cpuProfileFile             *os.File
	MemoryProfile              string
	UserShortNameAliasConfPath string
	CgroupManager              string
}

var globalFlagResults globalFlags

// configuration, including customizations made in containers.conf
var needToShutdownStore = false

func GetStore(c *cobra.Command) (storage.Store, error) {
	if err := setXDGRuntimeDir(); err != nil {
		return nil, err
	}
	options, err := storage.DefaultStoreOptions()
	if err != nil {
		return nil, err
	}
	if flagChanged(c, "root") || flagChanged(c, "runroot") {
		options.GraphRoot = globalFlagResults.Root
		options.RunRoot = globalFlagResults.RunRoot
	}
	if flagChanged(c, "storage-driver") {
		options.GraphDriverName = globalFlagResults.StorageDriver
		// If any options setup in config, these should be dropped if user overrode the driver
		options.GraphDriverOptions = []string{}
	}
	if flagChanged(c, "storage-opt") {
		if len(globalFlagResults.StorageOpts) > 0 {
			options.GraphDriverOptions = globalFlagResults.StorageOpts
		}
	}

	// Do not allow to mount a graphdriver that is not vfs if we are creating the userns as part
	// of the mount command.
	// Differently, allow the mount if we are already in a userns, as the mount point will still
	// be accessible once "buildah mount" exits.
	if os.Geteuid() != 0 && options.GraphDriverName != "vfs" {
		return nil, fmt.Errorf("cannot mount using driver %s in rootless mode. You need to run it in a `%s unshare` session", options.GraphDriverName, c.Root().Name())
	}

	if len(globalFlagResults.UserNSUID) > 0 {
		uopts := globalFlagResults.UserNSUID
		gopts := globalFlagResults.UserNSGID

		if len(gopts) == 0 {
			gopts = uopts
		}

		uidmap, gidmap, err := unshare.ParseIDMappings(uopts, gopts)
		if err != nil {
			return nil, err
		}
		options.UIDMap = uidmap
		options.GIDMap = gidmap
	} else {
		if len(globalFlagResults.UserNSGID) > 0 {
			return nil, errors.New("option --userns-gid-map can not be used without --userns-uid-map")
		}
	}

	// If a subcommand has the flags, check if they are set; if so, override the global values
	if flagChanged(c, "userns-uid-map") {
		uopts, _ := c.Flags().GetStringSlice("userns-uid-map")
		gopts, _ := c.Flags().GetStringSlice("userns-gid-map")
		if len(gopts) == 0 {
			gopts = uopts
		}
		uidmap, gidmap, err := unshare.ParseIDMappings(uopts, gopts)
		if err != nil {
			return nil, err
		}
		options.UIDMap = uidmap
		options.GIDMap = gidmap
	} else {
		if flagChanged(c, "userns-gid-map") {
			return nil, errors.New("option --userns-gid-map can not be used without --userns-uid-map")
		}
	}
	umask.Check()

	store, err := storage.GetStore(options)
	if store != nil {
		is.Transport.SetStore(store)
	}
	// Do we really need to shutdown store before exit?
	// needToShutdownStore = true
	return store, err
}

func setXDGRuntimeDir() error {
	if unshare.IsRootless() && os.Getenv("XDG_RUNTIME_DIR") == "" {
		runtimeDir, err := homedir.GetRuntimeDir()
		if err != nil {
			return err
		}
		if err := os.Setenv("XDG_RUNTIME_DIR", runtimeDir); err != nil {
			return errors.New("could not set XDG_RUNTIME_DIR")
		}
	}
	return nil
}

func GetContextDir(inputArgs []string) (string, error) {
	contextDir := ""
	cliArgs := inputArgs
	var err error
	// Nothing provided, we assume the current working directory as build
	// context
	if len(cliArgs) == 0 {
		contextDir, err = os.Getwd()
		if err != nil {
			return "", fmt.Errorf("unable to choose current working directory as build context: %w", err)
		}
	} else {
		// The context directory could be a URL.  Try to handle that.
		tempDir, subDir, err := define.TempDirForURL("", "buildah", cliArgs[0])
		if err != nil {
			return "", fmt.Errorf("prepping temporary context directory: %w", err)
		}
		if tempDir != "" {
			// We had to download it to a temporary directory.
			// Delete it later.
			contextDir = filepath.Join(tempDir, subDir)
		} else {
			// Nope, it was local.  Use it as is.
			absDir, err := filepath.Abs(cliArgs[0])
			if err != nil {
				return "", fmt.Errorf("determining path to directory: %w", err)
			}
			contextDir = absDir
		}
	}
	return contextDir, err
}

func flagChanged(c *cobra.Command, name string) bool {
	if fs := c.Flag(name); fs != nil && fs.Changed {
		return true
	}
	return false
}

// getNetworkInterface creates the network interface
func GetNetworkInterface(store storage.Store, cniConfDir, cniPluginPath string) (netTypes.ContainerNetwork, error) {
	conf, err := config.Default()
	if err != nil {
		return nil, err
	}
	// copy the config to not modify the default by accident
	newconf := *conf
	if len(cniConfDir) > 0 {
		newconf.Network.NetworkConfigDir = cniConfDir
	}
	if len(cniPluginPath) > 0 {
		plugins := strings.Split(cniPluginPath, string(os.PathListSeparator))
		newconf.Network.CNIPluginDirs.Set(plugins)
	}

	_, netInt, err := network.NetworkBackend(store, &newconf, false)
	if err != nil {
		return nil, err
	}
	return netInt, nil
}
