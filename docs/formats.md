# Formats

[Back to the README](../README.md)

## Profile names and globs

A profile name is a short name you choose, such as `dev`. `--select-remote` and `--manage` take a glob over the registered names.

- The glob must match exactly one profile.
- An ambiguous or unmatched glob is an error.
- `--select-remote` with no glob considers every registered name. It then needs exactly one registered remote.

## Where profiles are stored

Each profile is one file in the workspace: `remote/static/<profile>.remote.env`. `--select-remote-names` lists these files.

## How the profile options combine

- `SSH_HOST` is the host name or IP address. `SSH_NAME` is an alias, and it is the fallback when `SSH_HOST` is empty.
- `SSH_PORT` defaults to 22.
- When `SSH_USER` is empty, the ssh client uses its own default user.
- `SSH_HOME` is the remote workspace directory. The tool enters it before it starts the remote console.
- `SSH_ARGS` holds raw ssh arguments. The tool appends them before the host and the command.
