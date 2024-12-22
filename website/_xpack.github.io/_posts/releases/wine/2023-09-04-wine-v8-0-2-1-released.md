---

title:  xPack WineHQ v8.0.2-1 released

summary: "Version **8.0.2-1** is a new release; it follows the upstream release."

upstream_version: "8.0"
upstream_version_major: "2"
upstream_release_date: "2023-07-19"

version: "8.0.2-1"
npm_subversion: "1"

download_url: https://github.com/xpack-dev-tools/wine-xpack/releases/tag/v8.0.2-1/

comments: true

date: 2023-09-04 14:46:05 +0300

redirect_to: https://xpack-dev-tools.github.io/wine-xpack/blog/2023/09/04/wine-v8-0-2-1-released/

categories:
  - releases
  - wine

tags:
  - releases
  - wine
  - build

---

The [xPack WineHQ](https://xpack.github.io/dev-tools/wine/)
is a standalone binary distribution of
[WineHQ](https://www.winehq.org).

There are binaries **GNU/Linux** (x64).

## Download

The binary files are available from [GitHub Releases]({{ page.download_url }}).

## Prerequisites

- x64 GNU/Linux: any system with **GLIBC 2.27** or higher
  (like Ubuntu 18 or later, Debian 10 or later, RedHat 8 or later,
  Fedora 29 or later, etc)

## Install

The full details of installing the **xPack WineHQ** on various platforms
are presented in the separate [Install]({{ site.baseurl }}/dev-tools/wine/install/) page.

### Easy install

The easiest way to install WineHQ is with
[`xpm`]({{ site.baseurl }}/xpm/)
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
xpm install @xpack-dev-tools/wine@{{ page.version }}.{{ page.npm_subversion }} --verbose
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
[{{ page.upstream_version }}](https://dl.winehq.org/wine/source/{{ page.upstream_version_major }}.x/) from {{ page.upstream_release_date }}.

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

```txt
bfaf3b78c4be98ecd42c6b8f13d601ce1e39c3fbef1824fb43c6c6cb1557f305
xpack-wine-8.0.2-1-linux-x64.tar.gz

```

## Deprecation notices

### 32-bit support

Support for 32-bit x86 GNU/Linux and x86 Windows was
dropped in 2022. Support for 32-bit Arm GNU/Linux (armv7l) will be preserved
for a while, due to the large user base of 32-bit Raspberry Pi systems.

### GNU/Linux minimum requirements

Support for RedHat 7 was dropped in 2022 and the
minimum requirement was raised to GLIBC 2.27, available starting
with Ubuntu 18, Debian 10 and RedHat 8.

## Pre-deprecation notice for Ubuntu 18.04

Ubuntu 18.04 LTS _Bionic Beaver_ reached the end of the standard five-year
maintenance window for Long-Term Support (LTS) release on 31 May 2023.

As a courtesy, the xPack GNU/Linux releases will continue to be based on
Ubuntu 18.04 for another year.

From 2025 onwards, the GNU/Linux binaries will be built on **Debian 10**,
(**GLIBC 2.28**), and are also expected to run on RedHat 8.

Users are urged to update their build and test infrastructure to
ensure a smooth transition to the next xPack releases.

## Download analytics

- GitHub [xpack-dev-tools/wine-xpack](https://github.com/xpack-dev-tools/wine-xpack/)
  - this release [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/wine-xpack/v{{ page.version }}/total.svg)](https://github.com/xpack-dev-tools/wine-xpack/releases/v{{ page.version }}/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/wine-xpack/total.svg)](https://github.com/xpack-dev-tools/wine-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=wine-xpack) (grouped per release)
- npmjs.com [@xpack-dev-tools/wine](https://www.npmjs.com/package/@xpack-dev-tools/wine)
  - latest releases [![npm](https://img.shields.io/npm/dw/@xpack-dev-tools/wine.svg)](https://www.npmjs.com/package/@xpack-dev-tools/wine/)
  - all @xpack-dev-tools releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/wine.svg)](https://www.npmjs.com/package/@xpack-dev-tools/wine/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
