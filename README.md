# myx.distro-remote

Tools for driving a myx.distro workspace that lives on another machine, from here.
Provides the `Remote` console command and workspace integration for connecting to
and managing those remote workspaces via SSH.

This is not the route to remote deploy targets — `myx.distro-deploy` reaches those.
Here "remote" qualifies the workspace, not the target of a deployment.

---

## Distro commands:

[**DistroRemoteTools** command manual](https://github.com/myx/myx.distro-remote/blob/main/sh-lib/help/Help.DistroRemoteTools.help.md)

---

## Variables (context environment):

	MMDAPP - workspace root (something like: "/Volumes/ws-2017/myx-work")
	MDLT_ORIGIN - source of system console commands (something like: "/Volumes/ws-2017/myx-work/.local/")
	MDSC_INMODE - console mode ("remote")
	MDSC_DETAIL - debug settings, values: <empty>, "true", "full"

---

## App Folders:

	/ - workspace root directory
	/remote - remote workspace targets root
	/.local - system tools, utilities and system integrations

---

## Distro components:

See: [distro](https://github.com/myx/myx.distro?tab=readme-ov-file#myxdistro)
See: [distro-.local](https://github.com/myx/myx.distro-.local?tab=readme-ov-file#myxdistro-.local)
See: [distro-system](https://github.com/myx/myx.distro-system?tab=readme-ov-file#myxdistro-system)
See: [distro-deploy](https://github.com/myx/myx.distro-deploy?tab=readme-ov-file#myxdistro-deploy)
See: [distro-source](https://github.com/myx/myx.distro-source?tab=readme-ov-file#myxdistro-source)
See: [distro-remote](https://github.com/myx/myx.distro-remote?tab=readme-ov-file#myxdistro-remote)
See: [distro-agents](https://github.com/myx/myx.distro-agents?tab=readme-ov-file#myxdistro-agents)
