#!/usr/bin/env bash

##
## NOTE:
## Designed to be able to run without distro context. Used to install required parts.
##

if [ -z "$MMDAPP" ] ; then
	set -e
	export MMDAPP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $MMDAPP"  >&2
	[ -d "$MMDAPP/.local" ] || ( echo "⛔ ERROR: expecting '.local' directory." >&2 && exit 1 )
fi

: "${MDLT_ORIGIN:=$MMDAPP/.local}"

DistroRemoteTools(){
	local MDSC_CMD='DistroRemoteTools'
	[ -z "$MDSC_DETAIL" ] || echo "> $MDSC_CMD" $MDSC_NO_CACHE $MDSC_NO_INDEX "$@" >&2

	set -e

	. "$MDLT_ORIGIN/myx/myx.distro-system/sh-lib/SystemContext.UseStandardOptions.include"

	case "$1" in
		--make-*)
			. "$MDLT_ORIGIN/myx/myx.distro-remote/sh-lib/RemoteTools.Make.include"
			return 0
		;;
		--*-config-option)
			. "$MDLT_ORIGIN/myx/myx.distro-.local/sh-lib/LocalTools.Config.include"
			return 0
		;;
		--upgrade-remote-tools)
			shift
			bash "$MDLT_ORIGIN/myx/myx.distro-.local/sh-scripts/DistroLocalTools.fn.sh" --install-distro-remote
			return 0
		;;
		''|--help|--help-syntax)
			echo "📘 syntax: DistroRemoteTools.fn.sh <option>" >&2
			echo "📘 syntax: DistroRemoteTools.fn.sh --upgrade-remote-tools" >&2
			echo "📘 syntax: DistroRemoteTools.fn.sh [--help]" >&2
			if [ "$1" = "--help" ] ; then
				cat "$MDLT_ORIGIN/myx/myx.distro-remote/sh-lib/HelpDistroRemoteTools.text" >&2
			fi
			return 0
		;;
		*)
			echo "⛔ ERROR: $MDSC_CMD: invalid option: $1" >&2
			set +e ; return 1
		;;
	esac
}

case "$0" in
	*/myx/myx.distro-remote/sh-scripts/DistroRemoteTools.fn.sh)
		set -e

		if [ -z "$MDLT_ORIGIN" ] || ! type DistroRemoteContext >/dev/null 2>&1 ; then
			. "${MDLT_ORIGIN:=$MMDAPP/.local}/myx/myx.distro-remote/sh-lib/RemoteContext.include"
		fi
		DistroRemoteContext --run-from-detect

		if [ -z "$1" ] || [ "$1" = "--help" ] ; then
			DistroRemoteTools "${1:-"--help-syntax"}"
			exit 1
		fi

		DistroRemoteTools "$@"
	;;
esac
