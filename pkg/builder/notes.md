# Complexities:
- Needs a containers.conf config file on the local system as done in Buildah and Podman
OR `CONTAINERS_CONF` env variable set linking it to the conf file.
## error:
```shell
could not find "netavark" in one of {[/usr/local/libexec/podman /usr/local/lib/podman /usr/libexec/podman /usr/lib/podman] {<nil>}}.  To resolve this error, set the helper_binaries_dir key in the `[engine]` section of containers.conf to the directory containing your helper binaries.
```
- Needs filesystem drivers installed on the local system `fuse-overlayfs`
-