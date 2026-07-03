#!/usr/bin/env bash

if [ -z "$MMDAPP" ] ; then
	set -e
	export MMDAPP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $MMDAPP"  >&2
	[ -d "$MMDAPP/.local" ] || ( echo "⛔ ERROR: expecting '.local' directory." >&2 && exit 1 )
	[ -d "$MMDAPP/remote" ] || ( echo "⛔ ERROR: expecting 'remote' directory." >&2 && exit 1 )
fi



DistroRemoteConsoleLegacySettingsFile(){
	echo "$MMDAPP/.local/MDLC.remote.settings.env"
}


DistroRemoteConsoleLegacySelect(){
	local remoteName="$1" optionName="$2"
	local settingsFile
	settingsFile="$( DistroRemoteConsoleLegacySettingsFile )"
	[ -f "$settingsFile" ] || return 0
	awk -F '\t' -v rn="$remoteName" -v on="$optionName" '
		$1 == rn && $2 == on { value = $3 }
		END { print value }
	' "$settingsFile"
}


DistroRemoteConsoleLegacyNames(){
	local settingsFile
	settingsFile="$( DistroRemoteConsoleLegacySettingsFile )"
	[ -f "$settingsFile" ] || return 0
	awk -F '\t' '
		NF >= 2 {
			names[$1] = 1
		}
		END {
			for (name in names) {
				print name
			}
		}
	' "$settingsFile" | sort
}


DistroRemoteConsoleRemotes(){
	local op="$1"
	local remoteName="$2"
	[ -n "$MDLT_ORIGIN" ] || MDLT_ORIGIN="$MMDAPP/.local"
	. "$MDLT_ORIGIN/myx/myx.distro-.local/sh-lib/LocalTools.Config.include"

	case "$op" in
		--upsert)
			local optionName="$3" optionValue="$4"
			[ -n "$remoteName" ] && [ -n "$optionName" ] || {
				echo "⛔ ERROR: --remotes --upsert expects <remote-name> <option> <value>" >&2
				set +e ; return 1
			}
			DistroRemoteConsoleRemotes --backend "$remoteName" --upsert "$optionName" "$optionValue"
			return $?
		;;
		--upsert-if)
			local optionName="$3" optionValue="$4" ifValue="$5"
			[ -n "$remoteName" ] && [ -n "$optionName" ] || {
				echo "⛔ ERROR: --remotes --upsert-if expects <remote-name> <option> <value> <if-value>" >&2
				set +e ; return 1
			}
			DistroRemoteConsoleRemotes --backend "$remoteName" --upsert-if "$optionName" "$optionValue" "$ifValue"
			return $?
		;;
		--select)
			local optionName="$3" defaultValue="$4"
			[ -n "$remoteName" ] && [ -n "$optionName" ] || {
				echo "⛔ ERROR: --remotes --select expects <remote-name> <option>|--all [default-value]" >&2
				set +e ; return 1
			}
			if [ "$optionName" = "--all" ] ; then
				local output
				output="$( DistroRemoteConsoleRemotes --backend "$remoteName" --select --all )"
				if [ -n "$output" ] ; then
					echo "$output"
					return 0
				fi
				local settingsFile
				settingsFile="$( DistroRemoteConsoleLegacySettingsFile )"
				[ ! -f "$settingsFile" ] || awk -F '\t' -v rn="$remoteName" '
					$1 == rn {
						printf "%s=%s\n", $2, $3
					}
				' "$settingsFile"
				return 0
			fi

			local value
			value="$( DistroRemoteConsoleRemotes --backend "$remoteName" --select "$optionName" "" )"
			if [ -n "$value" ] ; then
				echo "$value"
				return 0
			fi
			value="$( DistroRemoteConsoleLegacySelect "$remoteName" "$optionName" )"
			if [ -n "$value" ] ; then
				echo "$value"
				return 0
			fi
			echo "${defaultValue:-}"
			return 0
		;;
		--delete)
			local optionName="$3" ifValue="$4"
			[ -n "$remoteName" ] || {
				echo "⛔ ERROR: --remotes --delete expects <remote-name> [<option> [<if-value>]]" >&2
				set +e ; return 1
			}
			if [ -z "$optionName" ] ; then
				local f="$MMDAPP/remote/static/${remoteName}.remote.env"
				[ ! -f "$f" ] || rm -f "$f"
				return 0
			fi
			if [ -z "$ifValue" ] ; then
				DistroRemoteConsoleRemotes --backend "$remoteName" --delete "$optionName"
			else
				DistroRemoteConsoleRemotes --backend "$remoteName" --delete-if "$optionName" "$ifValue"
			fi
			return $?
		;;
		--select-names)
			{
				if [ -d "$MMDAPP/remote/static" ] ; then
					find "$MMDAPP/remote/static" -maxdepth 1 -type f -name '*.remote.env' 2>/dev/null \
					| sed -e 's:^.*/::' -e 's:\.remote\.env$::'
				fi
				DistroRemoteConsoleLegacyNames
			} | awk '!seen[$0]++ { print }' | sort
			return 0
		;;
		--backend)
			shift
			local scopeRemoteName="$1"
			shift
			set -- --remote-config-option "$scopeRemoteName" "$@"
			. "$MDLT_ORIGIN/myx/myx.distro-.local/sh-lib/LocalTools.Config.include"
			return $?
		;;
		*)
			echo "⛔ ERROR: --remotes expects one of: --upsert, --upsert-if, --select, --delete" >&2
			set +e ; return 1
		;;
	esac
}


DistroRemoteConsoleRemoteOption(){
	local remoteName="$1" optionName="$2" defaultValue="$3"
	local value
	value="$( DistroRemoteConsoleRemotes --select "$remoteName" "$optionName" "" )"
	if [ -n "$value" ] ; then
		echo "$value"
		return 0
	fi
	value="$( DistroRemoteConsoleLegacySelect "$remoteName" "$optionName" )"
	if [ -n "$value" ] ; then
		echo "$value"
		return 0
	fi
	echo "${defaultValue:-}"
}


DistroRemoteConsoleResolveRemoteName(){
	local remoteNameGlob="$1"
	local candidate matched="" matchedCount=0
	while IFS= read -r candidate ; do
		[ -n "$candidate" ] || continue
		case "$candidate" in
			$remoteNameGlob)
				matched="$candidate"
				matchedCount=$((matchedCount + 1))
			;;
		esac
	done < <( DistroRemoteConsoleRemotes --select-names )

	if [ "$matchedCount" = "0" ] ; then
		echo ""
		return 0
	fi
	if [ "$matchedCount" != "1" ] ; then
		echo "⛔ ERROR: DistroRemoteConsole: remote selector is ambiguous: $remoteNameGlob" >&2
		DistroRemoteConsoleRemotes --select-names | while IFS= read -r candidate ; do
			case "$candidate" in
				$remoteNameGlob)
					echo "  - $candidate" >&2
				;;
			esac
		done
		set +e ; return 1
	fi
	echo "$matched"
}


DistroRemoteConsoleStartSelectedRemote(){
	local remoteName="$1" consoleMode="$2"
	shift 2

	local SSH_NAME SSH_HOST SSH_PORT SSH_USER SSH_HOME SSH_ARGS
	SSH_NAME="$( DistroRemoteConsoleRemoteOption "$remoteName" SSH_NAME "" )"
	SSH_HOST="$( DistroRemoteConsoleRemoteOption "$remoteName" SSH_HOST "" )"
	SSH_PORT="$( DistroRemoteConsoleRemoteOption "$remoteName" SSH_PORT "22" )"
	SSH_USER="$( DistroRemoteConsoleRemoteOption "$remoteName" SSH_USER "" )"
	SSH_HOME="$( DistroRemoteConsoleRemoteOption "$remoteName" SSH_HOME "~" )"
	SSH_ARGS="$( DistroRemoteConsoleRemoteOption "$remoteName" SSH_ARGS "" )"
	[ -n "$SSH_HOST" ] || SSH_HOST="$SSH_NAME"

	[ -n "$SSH_HOST" ] || {
		echo "⛔ ERROR: DistroRemoteConsole: remote '$remoteName' has no SSH_HOST" >&2
		set +e ; return 1
	}

	local target="$SSH_HOST"
	[ -z "$SSH_USER" ] || target="$SSH_USER@$SSH_HOST"

	local remoteMode="${consoleMode:-remote}"
	local remoteCommand="cd $SSH_HOME && ./DistroRemoteConsole.sh --start-$remoteMode-console"

	if [ $# -gt 0 ] ; then
		local argument
		for argument in "$@" ; do
			remoteCommand="$remoteCommand $( printf '%q' "$argument" )"
		done
	fi

	if [ -n "$SSH_ARGS" ] ; then
		ssh $SSH_ARGS -p "$SSH_PORT" "$target" "$remoteCommand"
	else
		ssh -p "$SSH_PORT" "$target" "$remoteCommand"
	fi
}


DistroRemoteConsole(){
	local MDSC_CMD='DistroRemoteConsole'
	[ -z "$MDSC_DETAIL" ] || echo "> $MDSC_CMD $(printf '%q ' "$@")" >&2

	set -e

	local consoleModeOverride
	local remoteNameGlob

	while true ; do
		case "$1" in
			--select-remote)
				if [ -z "$2" ] || [ "${2#--}" != "$2" ] ; then
					remoteNameGlob="*"
					shift
				else
					remoteNameGlob="$2"
					shift 2
				fi
			;;
			--select-remote-names)
				shift
				DistroRemoteConsoleRemotes --select-names
				return 0
			;;
			--remotes)
				shift
				DistroRemoteConsoleRemotes "$@"
				return $?
			;;
			--start-console)
				shift
				Remote --start-remote-console "$@"
				return 0
			;;
			--start-local-console)
				shift
				Remote --start-.local-console "$@"
				return 0
			;;
			--start-*-console)
				local type=${1#--start-}; type=${type%-console}
				local file="$MDLT_ORIGIN/myx/myx.distro-$type/sh-lib/console-$type-bashrc.rc"
				[ -f "$file" ] || {
					echo "⛔ ERROR: $1 subsystem is not installed in this workspace" >&2
					set +e ; return 1
				}
				shift
				bash --rcfile "$file" -i "$@"
				return 0
			;;
			--source|--deploy|--remote)
				consoleModeOverride="${1:2}"
				shift
			;;
			--manage)
				shift
				echo "not implemented yet" >&2
				set +e ; return 1
			;;
			--interactive)
				shift
				echo "not implemented yet" >&2
				set +e ; return 1
			;;
			'')
				if [ -n "$remoteNameGlob" ] ; then
					local remoteName
					remoteName="$( DistroRemoteConsoleResolveRemoteName "$remoteNameGlob" )" || return 1
					[ -n "$remoteName" ] || {
						echo "⛔ ERROR: $MDSC_CMD: remote not found: $remoteNameGlob" >&2
						set +e ; return 1
					}
					DistroRemoteConsoleStartSelectedRemote "$remoteName" "$consoleModeOverride" "$@"
					return $?
				fi
				if [ -n "$consoleModeOverride" ] ; then
					DistroRemoteConsole "--start-$consoleModeOverride-console" "$@"
					return 0
				fi
				echo "⛔ ERROR: $MDSC_CMD: more arguments expected" >&2
				set +e ; return 1
			;;
			*)
				if [ -n "$remoteNameGlob" ] ; then
					local remoteName
					remoteName="$( DistroRemoteConsoleResolveRemoteName "$remoteNameGlob" )" || return 1
					[ -n "$remoteName" ] || {
						echo "⛔ ERROR: $MDSC_CMD: remote not found: $remoteNameGlob" >&2
						set +e ; return 1
					}
					DistroRemoteConsoleStartSelectedRemote "$remoteName" "$consoleModeOverride" "$@"
					return $?
				fi
				echo "⛔ ERROR: $MDSC_CMD: invalid option: $1" >&2
				set +e ; return 1
			;;
		esac
	done
}


case "$0" in
	*/myx/myx.distro-remote/sh-scripts/RemoteConsole.fn.sh)

		if [ -z "$1" ] || [ "$1" = "--help" ] ; then
			echo "📘 syntax: DistroRemoteConsole.sh [--start-console]" >&2
			echo "📘 syntax: DistroRemoteConsole.sh [--start-local-console]" >&2
			echo "📘 syntax: DistroRemoteConsole.sh --start-{source|deploy|remote|manage}-console" >&2
			echo "📘 syntax: DistroRemoteConsole.sh [--{source|deploy|remote|manage}] --select-remote <remote-name-glob>" >&2
			echo "📘 syntax: DistroRemoteConsole.sh --select-remote-names" >&2
			echo "📘 syntax: DistroRemoteConsole.sh --remotes <operation>" >&2
			echo "📘 syntax: DistroRemoteConsole.sh --interactive" >&2
			echo "📘 syntax: DistroRemoteConsole.sh [--help]" >&2
			if [ "$1" = "--help" ] ; then
				myx.common lib/catMarkdown "$MDLT_ORIGIN/myx/myx.distro-remote/sh-lib/help/Help.RemoteConsole.help.md" >&2
			fi
			exit 1
		fi
		
		DistroRemoteConsole "$@"
	;;
esac
