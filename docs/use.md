# Use

[Back to the README](../README.md)

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

Open the remote's source or deploy console instead of its default:

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
