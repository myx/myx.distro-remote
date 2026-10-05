# Commands

[Back to the README](../README.md)

- `DistroRemoteConsole.sh` — register remotes, list them, open their consoles, run one-shot maintenance.
- `DistroRemoteTools.fn.sh` — re-create the remote console launcher, set workspace options, upgrade remote tools.
- `RemoteConsole.fn.sh` — the console implementation behind `DistroRemoteConsole.sh`.


## DistroRemoteConsole options

`DistroRemoteConsole.sh` takes options only, and no positional arguments.

- Start a console here:
	- `--start-console` — start the default remote console mode.
	- `--start-local-console` — start the `.local` console mode.
	- `--start-source-console`, `--start-deploy-console`, `--start-remote-console` — start an interactive bash session with that subsystem's rc file.
- Work with a registered remote:
	- `--select-remote [<remote-name-glob>]` — open a console on the remote. With no glob, exactly one remote must be configured.
	- `--source`, `--deploy`, `--remote` — choose which console `--select-remote` opens.
	- `--manage <remote-name-glob> <DistroRemoteTools-option> [args...]` — run one maintenance option on the remote over SSH, then exit. It opens no session.
	- `--select-remote-names` — print every registered remote name.
- Register remotes:
	- `--remotes <operation>` — [Configuration](configuration.md) lists the operations and the profile options.

`--interactive` is reserved. It is not implemented.

## DistroRemoteTools options

`DistroRemoteTools.fn.sh` takes options only. It is the tooling that `--manage` runs on the remote.

- `--make-workspace-integrations [--quiet]` — re-create all workspace integration files, then exit.
- `--make-console-command [--quiet]` — generate the `DistroRemoteConsole.sh` launcher, then exit.
- `--make-console-script` — print the console script body that `--make-console-command` uses.
- `--system-config-option` and `--custom-config-option` — read and change settings. `--system-` applies to the workspace and `--custom-` to the current user.
- `--upgrade-remote-tools` — run `DistroLocalTools.fn.sh --install-distro-remote`, then exit.

`--quiet` hides the notes about the files created and how to use them.


## Manuals

Each tool has a manual with its full syntax, options and examples.

- [DistroRemoteTools](../sh-lib/help/Help.DistroRemoteTools.help.md)
- [RemoteConsole](../sh-lib/help/Help.RemoteConsole.help.md)
- [SetupRemoteMac](../sh-lib/help/Man.SetupRemoteMac.help.md)
