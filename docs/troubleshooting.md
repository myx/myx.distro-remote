# Troubleshooting

[Back to the README](../README.md)

## --select-remote or --manage reports an error

Both need a glob that matches exactly one profile. An ambiguous or unmatched glob is an error.

List the registered profiles with `DistroRemoteConsole.sh --select-remote-names`. Then use a glob that matches one.

## The remote console asks for a password

Install your SSH public key on the remote machine, so connections need no password. The [Mac setup guide](../sh-lib/help/Man.SetupRemoteMac.help.md) shows the steps with `ssh-copy-id`.

## A tool from another family is missing on the remote

The remote console exposes every family except agents. The agents tools are not available there.

Run `command -v <Tool>.fn.sh` to check whether a tool is reachable.

## A command fails but the pipeline reports success

A failing command prints `⛔ ERROR: exited with error status (1)` on stderr. The console pipeline still returns 0.

Check the result instead. Look for a non-empty answer, or for the file the command should have made.

## Remote means the workspace, not a deploy target

To reach deploy targets, use [myx.distro-deploy](https://github.com/myx/myx.distro-deploy). This package drives a whole workspace on another machine.
