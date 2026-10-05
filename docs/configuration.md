# Configuration

[Back to the README](../README.md)

## Remote profile options

- `SSH_HOST` — remote host name or IP.
- `SSH_NAME` — alias and fallback for `SSH_HOST`.
- `SSH_PORT` — SSH port. Default 22.
- `SSH_USER` — SSH user. When empty, the ssh client default is used.
- `SSH_HOME` — remote workspace directory entered before launching its console.
- `SSH_ARGS` — extra raw ssh arguments, appended before host and command.

Manage them with:

- `--remotes --upsert <profile> <option> <value>` — set an option.
- `--remotes --upsert-if <profile> <option> <value> <if-value>` — set it only when it matches.
- `--remotes --select <profile> <option> [<default>]` — read one option.
- `--remotes --select <profile> --all` — read every option.
- `--remotes --delete <profile> [<option> [<if-value>]]` — delete a profile or one option.


## Workspace settings and context variables

`DistroRemoteTools.fn.sh --system-config-option` and `--custom-config-option` read and change the workspace settings. They accept the same operations and settings as the local tools. The [myx.distro-.local](https://github.com/myx/myx.distro-.local/blob/main/docs/configuration.md) docs describe them.

Remote mode uses these variables:

- `MMDAPP` — the workspace root path.
- `MDLT_ORIGIN` — the source root for distro command libraries and scripts.
- `MDSC_INMODE` — the current console mode, `remote`.
- `MDSC_DETAIL` — debug verbosity: empty, `true` or `full`.
