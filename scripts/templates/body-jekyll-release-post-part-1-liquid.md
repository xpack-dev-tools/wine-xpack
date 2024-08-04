---
title:  xPack WineHQ v{{ XBB_RELEASE_VERSION }} released

summary: "Version **{{ XBB_RELEASE_VERSION }}** is a new release; it follows the upstream release."

upstream_version: "8.0"
upstream_version_major: "2"
upstream_release_date: "19 Jul 2023"

version: "{{ XBB_RELEASE_VERSION }}"
npm_subversion: "1"

download_url: https://github.com/xpack-dev-tools/wine-xpack/releases/tag/v{{ XBB_RELEASE_VERSION }}/

comments: true

date: {{ RELEASE_DATE }}

# For Jekyll releases selection.
categories:
  - releases
  - wine

# For navigation; use scripts/createtag.sh in Jekyll.
tags:
  - releases
  - wine
  - build

---

[The xPack WineHQ](https://xpack.github.io/dev-tools/wine/)
is a standalone binary distribution of
[WineHQ](https://www.winehq.org).

There are binaries **GNU/Linux** (Intel 64-bit).

## Download

The binary files are available from GitHub [Releases]({% raw %}{{ page.download_url }}{% endraw %}).

## Prerequisites

- GNU/Linux Intel 64-bit: any system with **GLIBC 2.27** or higher
  (like Ubuntu 18 or later, Debian 10 or later, RedHat 8 or later,
  Fedora 29 or later, etc)

## Install

The full details of installing the **xPack WineHQ** on various platforms
are presented in the separate
[Install]({% raw %}{{ site.baseurl }}{% endraw %}/dev-tools/wine/install/) page.

### Easy install

The easiest way to install WineHQ is with
[`xpm`]({% raw %}{{ site.baseurl }}{% endraw %}/xpm/)
by using the **binary xPack**, available as
[`@xpack-dev-tools/wine`](https://www.npmjs.com/package/@xpack-dev-tools/wine)
from the [`npmjs.com`](https://www.npmjs.com) registry.

With the `xpm` tool available, installing
the latest version of the package and adding it as
a development dependency for a project is quite easy:

```sh
cd my-project
xpm init # Add a package.json if not already present

xpm install @xpack-dev-tools/wine@latest --verbose

ls -l xpacks/.bin
```

To install this specific version, use:

```sh
xpm install @xpack-dev-tools/wine@{% raw %}{{ page.version }}.{{ page.npm_subversion }}{% endraw %} --verbose
```

It is also possible to install Meson Build globally, in the user home folder,
but this requires xPack aware tools to automatically identify them and
manage paths.

```sh
xpm install --global @xpack-dev-tools/wine@latest --verbose
```

### Uninstall

To remove the links created by xpm in the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/wine
```

To completely remove the package from the central xPack store:

```sh
xpm uninstall --global @xpack-dev-tools/wine
```

## Compliance

The **xPack WineHQ** is based on the official
[WineHQ](https://www.winehq.org), with no changes.

The current version is based on:

- WineHQ release
[{% raw %}{{ page.upstream_version }}{% endraw %}](https://dl.winehq.org/wine/source/{% raw %}{{ page.upstream_version_major }}{% endraw %}.x/)
from {% raw %}{{ page.upstream_release_date }}{% endraw %}.

## Changes

- none

## Bug fixes

- none

## Enhancements

- none

## Known problems

- none

## Shared libraries

On all platforms the packages are standalone, and expect only the standard
runtime to be present on the host.

All dependencies that are build as shared libraries are copied locally
in the `libexec` folder (or in the same folder as the executable for Windows).

### `DT_RPATH` and `LD_LIBRARY_PATH`

On GNU/Linux the binaries are adjusted to use a relative path:

```console
$ readelf -d library.so | grep runpath
 0x000000000000001d (RPATH)            Library rpath: [$ORIGIN]
```

In the GNU ld.so search strategy, the `DT_RPATH` has
the highest priority, higher than `LD_LIBRARY_PATH`, so if this later one
is set in the environment, it should not interfere with the xPack binaries.

Please note that previous versions, up to mid-2020, used `DT_RUNPATH`, which
has a priority lower than `LD_LIBRARY_PATH`, and does not tolerate setting
it in the environment.

## Documentation

The current WineHQ documentation is available online from:

- [https://www.winehq.org/documentation/](https://www.winehq.org/documentation/)

## Build

The binaries for all supported platforms
(Windows, macOS and GNU/Linux) were built using the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/), a set
of build environments based on slightly older distributions, that should be
compatible with most recent systems.

For the prerequisites and more details on the build procedure, please see the
[How to build](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/README-BUILD.md) page.

## CI tests

Before publishing, a set of simple tests were performed on an exhaustive
set of platforms. The results are available from:

- [GitHub Actions](https://github.com/xpack-dev-tools/wine-xpack/actions/)

## Tests

TBD

## Checksums

The SHA-256 hashes for the files are:
