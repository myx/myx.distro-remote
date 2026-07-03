#!/bin/sh

[ -d "$MMDAPP/source" ] || ( echo "⛔ ERROR: expecting 'source' directory." >&2 && exit 1 )

cd "$MMDAPP"
export MMDAPP

bash "$MMDAPP/.local/myx/myx.distro-remote/sh-scripts/DistroRemoteTools.fn.sh" --upgrade-remote-tools
