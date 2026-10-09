# MAGIC.md — myx.distro-remote

Team-owned notes for the magic-* team.

## What this family is for

- Drives a myx.distro workspace that lives on another machine, from here.
- Not the route to remote deploy targets — the deploy family reaches those. "remote" qualifies the workspace, not the target of a deployment.
- It reads no index and carries no pipeline builders (`myx.distro-system/MAGIC.md`, "`*Context.include`").

## Tools and manuals

- This package's tools: `DistroRemoteTools.fn.sh`, `RemoteConsole.fn.sh`.
- Manual: `sh-lib/help/Help.DistroRemoteTools.help.md`. Read the file rather than running `--help`.
- `sh-lib/Help.DistroRemoteTools.help.md` — at the `sh-lib` root, without the `help/` segment — is a stale duplicate. Only the `help/` copy is referenced by code.

## Where things live

- Remote profiles are files: `$MMDAPP/remote/static/<name>.remote.env`. `RemoteConsole.fn.sh` lists them, and removes the file to delete a whole profile. Option reads and writes go through `--remote-config-option`, which `myx.distro-.local`'s `sh-lib/LocalTools.Config.include` implements, not this package.
- `RemoteConsole.fn.sh` refuses to run without `$MMDAPP/remote`. `DistroLocalTools.fn.sh --install-distro-remote` creates it.
- `sh-lib/console-remote-bashrc.rc` is the console. It puts its own and `.local`'s `sh-scripts/` on `PATH`, then system, deploy and source when they are installed.
