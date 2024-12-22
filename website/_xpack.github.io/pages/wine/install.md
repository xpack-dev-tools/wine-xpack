---

title: How to install the xPack WineHQ binaries
permalink: /dev-tools/wine/install/

summary: "The recommended method is via xpm."

comments: true
toc: false

version: "7.22.0"
xpack-subversion: "1"
short-version: "7.22"

date: 2022-10-04 10:32:00 +0300

redirect_to: https://xpack-dev-tools.github.io/wine-xpack/docs/install/

---

## Overview

The **xPack WineHQ** can be installed automatically, via `xpm` (the
recommended method), or manually, by downloading and unpacking one of the
portable archives.

{% capture easy_install %}

## Easy install

The easiest way to install WineHQ is by using the **binary xPack**, available as
[`@xpack-dev-tools/wine`](https://www.npmjs.com/package/@xpack-dev-tools/wine)
from the [`npmjs.com`](https://www.npmjs.com) registry.

### Prerequisites

The only requirement is a recent
xpm, which is a portable
[Node.js](https://nodejs.org) command line application. To install it,
follow the instructions from the
[xpm install]({{ site.baseurl }}/xpm/install/) page.

### Install

With xpm available, installing
the latest version of the package is quite easy:

```sh
cd my-project
xpm init # Only at first use.

xpm install @xpack-dev-tools/wine@latest --verbose
```

This command will always install the latest available version,
in the global xPacks store, which is a platform dependent folder
(check the output of the `xpm` command for the actual folder used on
your platform).

{% capture include_1 %}
The install location can be configured using the
`XPACKS_STORE_FOLDER` environment variable; for more details please check the
[xpm folders]({{ site.baseurl }}/xpm/folders/) page.
{% endcapture %}

{% include tip.html content=include_1 %}

{% include tip.html content="The archive content is unpacked into a folder
named `.content`. On some platforms
this might be hidden for normal browsing, and require
separate options (like `ls -A`) or, in file browsers, to enable
settings like **Show Hidden Files**." %}

### Uninstall

To remove the links from the current project:

```sh
cd my-project

xpm uninstall @xpack-dev-tools/wine
```

To completely remove the package from the central xPacks store:

```sh
xpm uninstall --global @xpack-dev-tools/wine --verbose
```

{% endcapture %}

{% capture manual_install %}

## Manual install

For all platforms, the **xPack WineHQ** binaries are released as portable
archives that can be installed in any location.

The archives can be downloaded from the
GitHub [releases](https://github.com/xpack-dev-tools/wine-xpack/releases/)
page.

{% endcapture %}

{% capture windows %}

Binaries are available only for GNU/Linux.

{% endcapture %}

{% capture macos %}

Binaries are available only for GNU/Linux.

{% endcapture %}

{% capture linux %}

{{ easy_install }}

### Test

To check if the xpm installed WineHQ starts, use something like:

```console
$ ~/.local/xPacks/@xpack-dev-tools/wine/{{ page.version }}-{{ page.xpack-subversion }}.1/.content/bin/wine64 --version
wine-{{ page.short-version }}
```

{{ manual_install }}

### Download

The GNU/Linux versions of **xPack WineHQ**
are packed as `.tar.gz` archives.
Download the latest version named like:

- `xpack-wine-{{ page.version }}-{{ page.xpack-subversion }}-linux-x64.tar.gz`

As the name implies, these are GNU/Linux `tar.gz` archives; they were build on
Ubuntu, but can be executed on most recent GNU/Linux distributions.

### Unpack

To manually install the xPack WineHQ,
unpack the archive and move it to
`~/.local/xPacks/wine/xpack-wine-{{ page.version }}-{{ page.xpack-subversion }}`:

```console
mkdir -p ~/.local/xPacks/wine
cd ~/.local/xPacks/wine

tar xvf ~/Downloads/xpack-wine-{{ page.version }}-{{ page.xpack-subversion }}-linux-x64.tar.gz
chmod -R -w xpack-wine-{{ page.version }}-{{ page.xpack-subversion }}
```

{% include note.html content="For manual installs, the recommended
install location is slightly different from the xpm install folders,
which use the scope (like `@xpack-dev-tools`) to group different tools,
and `.content` to store the unpacked archive." %}

```console
$ tree -L 2 '/home/ilg/.local/xPacks/wine/xpack-wine-{{ page.version }}-{{ page.xpack-subversion }}'
/home/ilg/.local/xPacks/wine/xpack-wine-{{ page.version }}-{{ page.xpack-subversion }}/
├── README.md
├── bin
│   ├── function_grep.pl
│   ├── msidb
│   ├── msiexec
│   ├── notepad
│   ├── regedit
│   ├── regsvr32
│   ├── widl
│   ├── wine
│   ├── wine-preloader
│   ├── wine64
│   ├── wine64-preloader
│   ├── wineboot
│   ├── winebuild
│   ├── winecfg
│   ├── wineconsole
│   ├── winecpp -> winegcc
│   ├── winedbg
│   ├── winedump
│   ├── winefile
│   ├── wineg++ -> winegcc
│   ├── winegcc
│   ├── winemaker
│   ├── winemine
│   ├── winepath
│   ├── wineserver
│   ├── wmc
│   └── wrc
├── distro-info
│   ├── CHANGELOG.md
│   ├── licenses
│   ├── patches
│   └── scripts
├── include
│   └── wine
├── lib
│   └── wine
├── lib32
│   └── wine
├── libexec
│   ├── libgcc_s.so.1
│   ├── libresolv-2.27.so
│   └── libresolv.so.2 -> libresolv-2.27.so
└── share
    ├── applications
    └── wine

15 directories, 32 files
```

### Test

To check if the manually installed WineHQ starts, use something like:

```console
$ ~/.local/xPacks/wine/xpack-wine-{{ page.version }}-{{ page.xpack-subversion }}/bin/wine64 --version
wine-{{ page.short-version }}
```

{% endcapture %}

{% include platform-tabs.html %}
