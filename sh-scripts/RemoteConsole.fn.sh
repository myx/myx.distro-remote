#!/usr/bin/env bash

if [ -z "$MMDAPP" ] ; then
	set -e
	export MMDAPP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $MMDAPP"  >&2
	[ -d "$MMDAPP/.local" ] || ( echo "⛔ ERROR: expecting '.local' directory." >&2 && exit 1 )
	[ -d "$MMDAPP/remote" ] || ( echo "⛔ ERROR: expecting 'remote' directory." >&2 && exit 1 )
fi



DistroRemoteConsole(){
	local MDSC_CMD='DistroRemoteConsole'
	[ -z "$MDSC_DETAIL" ] || echo "> $MDSC_CMD $@" >&2

	set -e

	local consoleModeOverride

	while true ; do
		case "$1" in
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
			--source|--deploy|--remote|--manage)
				## not done
				consoleModeOverride="${1:2}"
				shift
			;;
			--interactive)
				## not done
				shift

				echo "Not yet!"
				exit 1

				return 0
			;;
			'')
				echo "⛔ ERROR: $MDSC_CMD: more arguments expected" >&2
				set +e ; return 1
			;;
			*)
				echo "⛔ ERROR: $MDSC_CMD: invalid option: $1" >&2
				set +e ; return 1
			;;
		esac
	done
}


case "$0" in
	*/myx/myx.distro-image/sh-scripts/DistroRemoteConsole.sh)

		if [ -z "$1" ] || [ "$1"="--help" ] ; then
			echo "📘 syntax: DistroRemoteConsole.sh [--{source|deploy|remote|manage}] [<project-name-glob>]" >&2
			echo "📘 syntax: DistroRemoteConsole.sh [--{source|deploy|remote|manage}] --select-remote [<remote-name-glob>]" >&2
			echo "📘 syntax: DistroRemoteConsole.sh --interactive" >&2
			echo "📘 syntax: DistroRemoteConsole.sh [--help]" >&2
			if [ "$1"="--help" ] ; then
				cat "$MDLT_ORIGIN/myx/myx.distro-image/sh-lib/help/HelpRemoteConsole.text" >&2
			fi
			exit 1
		fi
		
		DistroRemoteConsole "$@"
	;;
esac
