#!/usr/bin/env bash

if [ -z "$MMDAPP" ] ; then
	set -e
	export MMDAPP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $MMDAPP"  >&2
	[ -d "$MMDAPP/.local" ] || ( echo "ERROR: expecting '.local' directory." >&2 && exit 1 )
	[ -d "$MMDAPP/remote" ] || ( echo "ERROR: expecting 'remote' directory." >&2 && exit 1 )
fi



DistroRemoteConsole(){
	local MDSC_CMD='DistroRemoteConsole'
	[ -z "$MDSC_DETAIL" ] || echo "> $MDSC_CMD $@" >&2

	set -e

	local consoleModeOverride

	while true ; do
		case "$1" in
			--source|--deploy|--remote|--manage)
				consoleModeOverride="${1:2}"
				shift
			;;
			--interactive)
				shift

				echo "Not yet!"
				exit 1

				return 0
			;;
			'')
				echo "ERROR: $MDSC_CMD: more arguments expected" >&2
				set +e ; return 1
			;;
			*)
				echo "ERROR: $MDSC_CMD: invalid option: $1" >&2
				set +e ; return 1
			;;
		esac
	done
}


case "$0" in
	*/myx/myx.distro-image/sh-scripts/DistroRemoteConsole.sh)

		if [ -z "$1" ] || [ "$1" = "--help" ] ; then
			echo "syntax: DistroRemoteConsole.sh [--{source|deploy|remote|manage}] [<project-name-glob>]" >&2
			echo "syntax: DistroRemoteConsole.sh [--{source|deploy|remote|manage}] --select-remote [<remote-name-glob>]" >&2
			echo "syntax: DistroRemoteConsole.sh --interactive" >&2
			echo "syntax: DistroRemoteConsole.sh [--help]" >&2
			if [ "$1" = "--help" ] ; then
				cat "$MMDAPP/source/myx/myx.distro-image/sh-lib/HelpRemoteConsole.text" >&2
			fi
			exit 1
		fi
		
		DistroRemoteConsole "$@"
	;;
esac
