# myx.distro-remote

Drives a myx.distro workspace that lives on another machine, from here. Register
a remote once, then open its console or run a maintenance command on it over SSH.

Here "remote" qualifies the *workspace*, not the target of a deployment. To reach
deploy targets, use `myx.distro-deploy`.

## Getting started

Install the remote toolset into a workspace, then open the remote console:

	bash .local/myx/myx.distro-.local/sh-scripts/DistroLocalTools.fn.sh --install-distro-remote
	./DistroRemoteConsole.sh

## Common tasks

Register a remote workspace under a short profile name:

	DistroRemoteConsole.sh --remotes --upsert dev SSH_HOST dev.example.org
	DistroRemoteConsole.sh --remotes --upsert dev SSH_USER admin
	DistroRemoteConsole.sh --remotes --upsert dev SSH_HOME /home/admin/workspace

List the profiles you have registered:

	DistroRemoteConsole.sh --select-remote-names

Show everything configured for one profile:

	DistroRemoteConsole.sh --remotes --select dev --all

Open a console on the remote workspace:

	DistroRemoteConsole.sh --select-remote dev

Open the remote's *source* or *deploy* console instead of its default:

	DistroRemoteConsole.sh --source --select-remote dev
	DistroRemoteConsole.sh --deploy --select-remote dev

Run one maintenance command on a remote and exit, without opening a session:

	DistroRemoteConsole.sh --manage dev --upgrade-remote-tools
	DistroRemoteConsole.sh --manage dev --make-console-command

Remove a profile, or one of its options:

	DistroRemoteConsole.sh --remotes --delete dev SSH_PORT
	DistroRemoteConsole.sh --remotes --delete dev

`--select-remote` and `--manage` both require the glob to match exactly one
profile; an ambiguous or unmatched glob is an error.

## Remote profile options

	SSH_NAME   alias and fallback for SSH_HOST
	SSH_HOST   remote host name or IP
	SSH_PORT   SSH port; default 22
	SSH_USER   SSH user; when empty, the ssh client default is used
	SSH_HOME   remote workspace directory entered before launching its console
	SSH_ARGS   extra raw ssh arguments, appended before host and command

## Commands

- `DistroRemoteConsole.sh` — register remotes, list them, open their consoles, run one-shot maintenance.
- `DistroRemoteTools.fn.sh` — re-create the remote console launcher, set workspace options, upgrade remote tools.
- `RemoteConsole.fn.sh` — the console implementation behind `DistroRemoteConsole.sh`.

## Getting help

- `DistroRemoteConsole.sh --help` and `DistroRemoteTools.fn.sh --help` print full syntax, options and examples.
- `Remote --help` prints the remote-context dispatcher syntax.
- Press TAB after a command name and a space for shell completion.
- Setting up a Mac as a remote: `.local/myx/myx.distro-remote/sh-lib/help/Man.SetupRemoteMac.help.md`.
- [DistroRemoteTools command manual](https://github.com/myx/myx.distro-remote/blob/main/sh-lib/help/Help.DistroRemoteTools.help.md)

## Related packages

- [myx.distro](https://github.com/myx/myx.distro) — the distro system overview.
- [myx.distro-.local](https://github.com/myx/myx.distro-.local) — install and launch the toolsets.
- [myx.distro-system](https://github.com/myx/myx.distro-system) — shared indexing and query tools.
- [myx.distro-source](https://github.com/myx/myx.distro-source) — build source into a distro image.
- [myx.distro-deploy](https://github.com/myx/myx.distro-deploy) — deploy a distro image to hosts.
- [myx.distro-agents](https://github.com/myx/myx.distro-agents) — start an AI-agent CLI console.
