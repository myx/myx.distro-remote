# myx.distro-remote

Drives a myx.distro workspace that lives on another machine, from here. Register
a remote once, then open its console or run a maintenance command on it over SSH.

Here "remote" qualifies the *workspace*, not the target of a deployment. To reach
deploy targets, use `myx.distro-deploy`.

## Documentation

- [Installation](docs/installation.md) — requirements, install, upgrade and uninstall.
- [Configuration](docs/configuration.md) — settings, profile options and configuration commands.
- [Use](docs/use.md) — getting started, common tasks and selecting what to act on.
- [Commands](docs/commands.md) — the command reference.
- [Formats](docs/formats.md) — file formats, directives, stages and folder layout.
- [Extension](docs/extension.md) — adding your own members, builders, directives and commands.
- [Examples](docs/examples.md) — worked examples from start to finish.
- [Troubleshooting](docs/troubleshooting.md) — symptoms, causes and actions.

## Getting help

- `DistroRemoteConsole.sh --help` and `DistroRemoteTools.fn.sh --help` — full syntax, options and examples.
- `Remote --help` — remote-context dispatcher syntax.
- Press TAB after a command name and a space for shell completion.
- [Setting up a Mac as a remote](https://github.com/myx/myx.distro-remote/blob/main/sh-lib/help/Man.SetupRemoteMac.help.md) — step-by-step guide.

## Related packages

- [myx.distro](https://github.com/myx/myx.distro) — the distro system overview.
- [myx.distro-.local](https://github.com/myx/myx.distro-.local) — install and launch the toolsets.
- [myx.distro-system](https://github.com/myx/myx.distro-system) — shared indexing and query tools.
- [myx.distro-source](https://github.com/myx/myx.distro-source) — build source into a distro image.
- [myx.distro-deploy](https://github.com/myx/myx.distro-deploy) — deploy a distro image to hosts.
- [myx.distro-agents](https://github.com/myx/myx.distro-agents) — the magic-team agents and their tooling.
