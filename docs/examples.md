# Examples

[Back to the README](../README.md)

## Register a remote and open it

	DistroRemoteConsole.sh --remotes --upsert dev SSH_HOST dev.example.org
	DistroRemoteConsole.sh --remotes --upsert dev SSH_USER admin
	DistroRemoteConsole.sh --remotes --upsert dev SSH_HOME /home/admin/workspace
	DistroRemoteConsole.sh --select-remote dev

## Open the remote's deploy console

	DistroRemoteConsole.sh --deploy --select-remote dev

## Upgrade the tools on a remote

	DistroRemoteConsole.sh --manage dev --upgrade-remote-tools

## Set up a Mac as a remote

The [Mac setup guide](../sh-lib/help/Man.SetupRemoteMac.help.md) turns on Remote Login on the Mac. It then installs your SSH public key with `ssh-copy-id`, so you can connect without a password.
