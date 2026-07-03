📘 syntax: DistroRemoteConsole.sh [--start-console]
📘 syntax: DistroRemoteConsole.sh [--start-local-console]
📘 syntax: DistroRemoteConsole.sh --start-{source|deploy|remote|manage}-console
📘 syntax: DistroRemoteConsole.sh [--{source|deploy|remote|manage}] --select-remote <remote-name-glob>
📘 syntax: DistroRemoteConsole.sh --select-remote-names
📘 syntax: DistroRemoteConsole.sh --remotes <operation>
📘 syntax: DistroRemoteConsole.sh --interactive
📘 syntax: DistroRemoteConsole.sh [--help]

##  Arguments:

		None. This command is option-driven.

##  Options:

		--start-console
			Starts default remote console mode.

		--start-local-console
			Starts .local console mode.

		--start-{source|deploy|remote|manage}-console
			Starts an interactive bash session using the selected subsystem rc file.

		--source
		--deploy
		--remote
			Overrides default console type used by --select-remote.

		--manage
			Injects and runs remote console from local files.

		--select-remote [<remote-name-glob>]
			Uses target from preconfigured remotes. When no selector is provided, all
			remote names are considered and command requires exactly one configured remote.

		--remotes <arguments...>
			Manipulates the list of preconfigured (in current workspace) remotes.

			Following operations are supported:

				--upsert <remote-name> <option> <value>
					Sets remote's option value.

				--upsert-if <remote-name> <option> <value> <if-value>
					Sets remote's option value only if current value equals if-value.

				--select <remote-name> <option> [<default-value>]
					Reads remote's option value. If value is not set, default-value is returned.

				--select <remote-name> --all
					Reads all remote option values.

				--delete <remote-name> [<option> [<if-value>]]
					Deletes remote or a remote option. Optional if-value applies to option delete.

			Following options are allowed:

				SSH_NAME
				SSH_HOST
				SSH_PORT
				SSH_USER
				SSH_HOME
				SSH_ARGS

			Option notes:

				SSH_NAME
					Alias/fallback for SSH_HOST.

				SSH_HOST
					Remote host name or IP.

				SSH_PORT
					SSH port, default is 22.

				SSH_USER
					SSH user. When empty, current ssh client default is used.

				SSH_HOME
					Remote workspace directory used before launching DistroRemoteConsole.sh.

				SSH_ARGS
					Additional raw ssh arguments appended before host/command.

		--select-remote-names
			Prints all preconfigured remote names.

		--interactive
			Reserved option (currently not implemented).

		--help
			Prints command help and exits.

##  Examples:

		# Store SSH host for remote profile dev
		`DistroRemoteConsole.sh --remotes --upsert dev SSH_HOST dev.example.org`
		# Store SSH user for remote profile dev
		`DistroRemoteConsole.sh --remotes --upsert dev SSH_USER admin`
		# Print all configured SSH options for remote profile dev
		`DistroRemoteConsole.sh --remotes --select dev --all`
		# Start default remote console using profile dev
		`DistroRemoteConsole.sh --select-remote dev`
		# Start source console on remote profile dev
		`DistroRemoteConsole.sh --source --select-remote dev`
		# List configured remote profile names
		`DistroRemoteConsole.sh --select-remote-names`
