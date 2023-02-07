
[![GitHub package.json version](https://img.shields.io/github/package-json/v/xpack-dev-tools/wine-xpack)](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/package.json)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/xpack-dev-tools/wine-xpack)](https://github.com/xpack-dev-tools/wine-xpack/releases/)
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/wine.svg?color=blue)](https://www.npmjs.com/package/@xpack-dev-tools/wine/)
[![license](https://img.shields.io/github/license/xpack-dev-tools/wine-xpack)](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/LICENSE)

# The xPack WineHQ

A standalone cross-platform (macOS/Linux) **WineHQ**
binary distribution, intended for reproducible builds.

In addition to the the binary archives and the package meta data,
this project also includes the build scripts.

## Overview

This open source project is hosted on GitHub as
[`xpack-dev-tools/wine-xpack`](https://github.com/xpack-dev-tools/wine-xpack)
and provides the platform specific binaries for the
[xPack WineHQ](https://xpack.github.io/wine/).

This distribution follows the official [WineHQ](https://www.winehq.org)
build system project.

The binaries can be installed automatically as **binary xPacks** or manually as
**portable archives**.

## Release schedule

The [upstream](https://dl.winehq.org/wine/source/) release cycle is about
two weeks, with one major release every year.

This distribution generally plans to have at least one,
possibly two releases per year.

## User info

This section is intended as a shortcut for those who plan
to use the WineHQ binaries. For full details please read the
[xPack WineHQ](https://xpack.github.io/wine/) pages.

### Easy install

The easiest way to install WineHQ is using the **binary xPack**, available as
[`@xpack-dev-tools/wine`](https://www.npmjs.com/package/@xpack-dev-tools/wine)
from the [`npmjs.com`](https://www.npmjs.com) registry.

#### Prerequisites

A recent [xpm](https://xpack.github.io/xpm/),
which is a portable [Node.js](https://nodejs.org/) command line application.

It is recommended to update to the latest version with:

```sh
npm install --location=global xpm@latest
```

For details please follow the instructions in the
[xPack install](https://xpack.github.io/install/) page.

#### Install

With the `xpm` tool available, installing
the latest version of the package and adding it as
a dependency for a project is quite easy:

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/wine@latest --verbose

ls -l xpacks/.bin
```

This command will:

- install the latest available version,
into the central xPacks store, if not already there
- add symbolic links to the central store
(or `.cmd` forwarders on Windows) into
the local `xpacks/.bin` folder.

The central xPacks store is a platform dependent
folder; check the output of the `xpm` command for the actual
folder used on your platform).
This location is configurable via the environment variable
`XPACKS_STORE_FOLDER`; for more details please check the
[xpm folders](https://xpack.github.io/xpm/folders/) page.

It is also possible to install WineHQ globally, in the user home folder:

```sh
xpm install --global @xpack-dev-tools/wine@latest --verbose
```

After install, the package should create a structure like this (macOS files;
only the first two depth levels are shown):

```console
$ tree -L 2 /Users/ilg/Library/xPacks/\@xpack-dev-tools/wine/7.22.0-2.1/.content/
/Users/ilg/Library/xPacks/\@xpack-dev-tools/wine/7.22.0-2.1/.content/
/home/ilg/Work/xpacks/wine-xpack.git/build/linux-x64/application/
├── bin
│   ├── function_grep.pl
│   ├── msidb
│   ├── msiexec
│   ├── notepad
│   ├── regedit
│   ├── regsvr32
│   ├── widl
│   ├── wine
│   ├── wine64
│   ├── wine64-preloader
│   ├── wineboot
│   ├── winebuild
│   ├── winecfg
│   ├── wineconsole
│   ├── winecpp -> winegcc
│   ├── winedbg
│   ├── winedump
│   ├── winefile
│   ├── wineg++ -> winegcc
│   ├── winegcc
│   ├── winemaker
│   ├── winemine
│   ├── winepath
│   ├── wine-preloader
│   ├── wineserver
│   ├── wmc
│   └── wrc
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── include
│   └── wine
├── lib
│   └── wine
├── lib32
│   └── wine
├── libexec
│   ├── libgcc_s.so.1
│   ├── libresolv-2.27.so
│   └── libresolv.so.2 -> libresolv-2.27.so
├── README.md
└── share
    ├── applications
    └── wine

15 directories, 32 files
```

No other files are installed in any system folders or other locations.

#### Uninstall

To remove the links created by xpm in the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/wine
```

To completely remove the package from the global store:

```sh
xpm uninstall --global @xpack-dev-tools/wine
```

### Manual install

For all platforms, the **xPack WineHQ**
binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [Releases](https://github.com/xpack-dev-tools/wine-xpack/releases/)
page.

For more details please read the
[Install](https://xpack.github.io/wine/install/) page.

### Versioning

The version strings used by the WineHQ project are two number strings
like `6.17`; to make it semver compatible, `.0` is added as the third digit;
the xPack distribution adds a four number,
but since semver allows only three numbers, all additional ones can
be added only as pre-release strings, separated by a dash,
like `7.22.0-2`. When published as a npm package, the version gets
a fifth number, like `7.22.0-2.1`.

Since adherence of third party packages to semver is not guaranteed,
it is recommended to use semver expressions like `^7.22.0` and `~7.22.0`
with caution, and prefer exact matches, like `7.22.0-2.1`.

## Maintainer info

For maintainer info, please see the
[README-MAINTAINER](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/README-MAINTAINER.md)

## Support

The quick advice for getting support is to use the GitHub
[Discussions](https://github.com/xpack-dev-tools/wine-xpack/discussions/).

For more details please read the
[Support](https://xpack.github.io/wine/support/) page.

## License

The original content is released under the
[MIT License](https://opensource.org/licenses/MIT), with all rights
reserved to [Liviu Ionescu](https://github.com/ilg-ul/).

The binary distributions include several open-source components; the
corresponding licenses are available in the installed
`distro-info/licenses` folder.

## Download analytics

- GitHub [`xpack-dev-tools/wine-xpack`](https://github.com/xpack-dev-tools/wine-xpack/) repo
  - latest xPack release
[![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/wine-xpack/latest/total.svg)](https://github.com/xpack-dev-tools/wine-xpack/releases/)
  - all xPack releases [![Github All Releases](https://img.shields.io/github/downloads/xpack-dev-tools/wine-xpack/total.svg)](https://github.com/xpack-dev-tools/wine-xpack/releases/)
  - [individual file counters](https://somsubhra.github.io/github-release-stats/?username=xpack-dev-tools&repository=wine-xpack) (grouped per release)
- npmjs.com [`@xpack-dev-tools/wine`](https://www.npmjs.com/package/@xpack-dev-tools/wine/) xPack
  - latest release, per month
[![npm (scoped)](https://img.shields.io/npm/v/@xpack-dev-tools/wine.svg)](https://www.npmjs.com/package/@xpack-dev-tools/wine/)
[![npm](https://img.shields.io/npm/dm/@xpack-dev-tools/wine.svg)](https://www.npmjs.com/package/@xpack-dev-tools/wine/)
  - all releases [![npm](https://img.shields.io/npm/dt/@xpack-dev-tools/wine.svg)](https://www.npmjs.com/package/@xpack-dev-tools/wine/)

Credit to [Shields IO](https://shields.io) for the badges and to
[Somsubhra/github-release-stats](https://github.com/Somsubhra/github-release-stats)
for the individual file counters.
