#!/usr/bin/env bash

##
## NOTE:
## Designed to be able to run without distro context. Used to install required parts.
##

if [ -z "$MMDAPP" ] ; then
	set -e
	export MMDAPP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $MMDAPP"  >&2
	[ -d "$MMDAPP/.local" ] || ( echo "ERROR: expecting '.local' directory." >&2 && exit 1 )
fi

DistroRemoteTools(){
	local MDSC_CMD='DistroRemoteTools'
	[ -z "$MDSC_DETAIL" ] || echo "> $MDSC_CMD $@" >&2

	set -e

	case "$1" in
		--make-*)
			. "$MMDAPP/.local/myx/myx.distro-remote/sh-lib/DistroRemoteToolsMake.include"
			set +e ; return 1
		;;
		--system-config-option|--custom-config-option)
			. "$MMDAPP/.local/myx/myx.distro-remote/sh-lib/DistroRemoteToolsConfig.include"
			set +e ; return 1
		;;
		--completion-*)
			. "$MMDAPP/.local/myx/myx.distro-remote/sh-lib/DistroRemoteToolsCompletion.include"
			set +e ; return 1
		;;
		--upgrade-remote-tools)
			shift
			bash "$MMDAPP/.local/myx/myx.distro-.local/sh-scripts/DistroLocalTools.fn.sh --install-distro-remote"
			return 0
		;;
		''|--help)
			echo "syntax: DistroRemoteTools.fn.sh <option>" >&2
			echo "syntax: DistroRemoteTools.fn.sh [--help]" >&2
			if [ "$1" = "--help" ] ; then
				cat "$MMDAPP/.local/myx/myx.distro-remote/sh-lib/HelpDistroRemoteTools.text" >&2
			fi
			set +e ; return 1
		;;
		*)
			echo "ERROR: $MDSC_CMD: invalid option: $1" >&2
			set +e ; return 1
		;;
	esac
}

case "$0" in
	*/myx/myx.distro-remote/sh-scripts/DistroRemoteTools.fn.sh)

		if [ -z "$1" ] || [ "$1" = "--help" ] ; then
			echo "syntax: DistroRemoteTools.fn.sh --upgrade-remote-tools" >&2
		fi

		set -e
		DistroRemoteTools "$@"
	;;
esac
