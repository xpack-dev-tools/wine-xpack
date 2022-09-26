# How to build the xPack WineHQ binaries

## Introduction

This project also includes the scripts and additional files required to
build and publish the
[xPack WineHQ](https://github.com/xpack-dev-tools/wine-xpack) binaries.

The build scripts use the
[xPack Build Box (XBB)](https://xpack.github.io/xbb/),
a set of elaborate build environments based on recent GCC versions
(Docker containers
for GNU/Linux and Windows or a custom folder for MacOS).

There are two types of builds:

- **local/native builds**, which use the tools available on the
  host machine; generally the binaries do not run on a different system
  distribution/version; intended mostly for development purposes;
- **distribution builds**, which create the archives distributed as
  binaries; expected to run on most modern systems.

This page documents the distribution builds.

For native builds, see the `build-native.sh` script.

## Repositories

- <https://github.com/xpack-dev-tools/wine-xpack.git> -
  the URL of the xPack build scripts repository
- <https://github.com/xpack-dev-tools/build-helper> - the URL of the
  xPack build helper, used as the `scripts/helper` submodule

The original releases are distributed via

- <https://dl.winehq.org/wine/source/>

### Branches

- `xpack` - the updated content, used during builds
- `xpack-develop` - the updated content, used during development
- `master` - empty

## Prerequisites

The prerequisites are common to all binary builds. Please follow the
instructions in the separate
[Prerequisites for building binaries](https://xpack.github.io/xbb/prerequisites/)
page and return when ready.

Note: Building the Arm binaries requires an Arm machine.

## Download the build scripts

The build scripts are available in the `scripts` folder of the
[`xpack-dev-tools/wine-xpack`](https://github.com/xpack-dev-tools/wine-xpack)
Git repo.

To download them, issue the following commands:

```sh
rm -rf ${HOME}/Work/wine-xpack.git; \
git clone \
  https://github.com/xpack-dev-tools/wine-xpack.git \
  ${HOME}/Work/wine-xpack.git; \
git -C ${HOME}/Work/wine-xpack.git submodule update --init --recursive
```

> Note: the repository uses submodules; for a successful build it is
> mandatory to recurse the submodules.

For development purposes, clone the `xpack-develop` branch:

```sh
rm -rf ${HOME}/Work/wine-xpack.git; \
git clone \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/wine-xpack.git \
  ${HOME}/Work/wine-xpack.git; \
git -C ${HOME}/Work/wine-xpack.git submodule update --init --recursive
```

## The `Work` folder

The scripts create a temporary build `Work/wine-${version}` folder in
the user home. Although not recommended, if for any reasons you need to
change the location of the `Work` folder,
you can redefine `WORK_FOLDER_PATH` variable before invoking the script.

## Spaces in folder names

Due to the limitations of `make`, builds started in folders with
spaces in names are known to fail.

If on your system the work folder is in such a location, redefine it in a
folder without spaces and set the `WORK_FOLDER_PATH` variable before invoking
the script.

## Customizations

There are many other settings that can be redefined via
environment variables. If necessary,
place them in a file and pass it via `--env-file`. This file is
either passed to Docker or sourced to shell. The Docker syntax
**is not** identical to shell, so some files may
not be accepted by bash.

## Versioning

The version string is an extension to semver, the format looks like `6.17.0-1`.
It includes the two digits with the original WineHQ version, a `.0`
third digit to make it semver compliant, and a fourth
digit with the xPack release number.

When publishing on the **npmjs.com** server, a fifth digit is appended.

## Changes

Compared to the original WineHQ distribution, there should be no
functional changes.

The actual changes for each version are documented in the
release web pages.

## How to build local/native binaries

### README-DEVELOP.md

The details on how to prepare the development environment for WineHQ are in the
[`README-DEVELOP.md`](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/README-DEVELOP.md)
file.

## How to build distributions

## Build

The builds currently run on 2 dedicated machines (Intel GNU/Linux,
Intel macOS).

### Build the Intel GNU/Linux binaries

The current platform for GNU/Linux and Windows production builds is a
Debian 11, running on an AMD 5600G PC with 16 GB of RAM
and 512 GB of fast M.2 SSD. The machine name is `xbbli`.

```sh
caffeinate ssh xbbli
```

Before starting a build, check if Docker is started:

```sh
docker info
```

Before running a build for the first time, it is recommended to preload the
docker images.

```sh
bash ${HOME}/Work/wine-xpack.git/scripts/helper/build.sh preload-images
```

The result should look similar to:

```console
$ docker images
REPOSITORY       TAG                    IMAGE ID       CREATED         SIZE
ilegeul/ubuntu   amd64-18.04-xbb-v3.4   ace5ae2e98e5   4 weeks ago     5.11GB
```

It is also recommended to Remove unused Docker space. This is mostly useful
after failed builds, during development, when dangling images may be left
by Docker.

To check the content of a Docker image:

```sh
docker run --interactive --tty ilegeul/ubuntu:amd64-18.04-xbb-v3.4
```

To remove unused files:

```sh
docker system prune --force
```

Since the build takes a while, use `screen` to isolate the build session
from unexpected events, like a broken
network connection or a computer entering sleep.

```sh
screen -S wine

sudo rm -rf ~/Work/wine-*-*
bash ${HOME}/Work/wine-xpack.git/scripts/helper/build.sh --develop --linux64 --win64
```

or, for development builds:

```sh
sudo rm -rf ~/Work/wine-*-*
bash ${HOME}/Work/wine-xpack.git/scripts/helper/build.sh --develop --without-html --disable-tests --linux64 --win64
```

To detach from the session, use `Ctrl-a` `Ctrl-d`; to reattach use
`screen -r wine`; to kill the session use `Ctrl-a` `Ctrl-k` and confirm.

About 25 minutes later, the output of the build script is a set of 4
archives and their SHA signatures, created in the `deploy` folder:

```console
$ ls -l ~/Work/wine-*/deploy
total 151928
50860
-rw-rw-rw- 1 ilg ilg 155566720 Sep 26 19:55 xpack-wine-6.17.0-1-linux-x64.tar.gz
50861
-rw-rw-rw- 1 ilg ilg       103 Sep 26 19:55 xpack-wine-6.17.0-1-linux-x64.tar.gz.sha
```

## Subsequent runs


### `clean`

To remove most build temporary files, use:

```sh
bash ${HOME}/Work/wine-xpack.git/scripts/helper/build.sh --all clean
```

To also remove the library build temporary files, use:

```sh
bash ${HOME}/Work/wine-xpack.git/scripts/helper/build.sh --all cleanlibs
```

To remove all temporary files, use:

```sh
bash ${HOME}/Work/wine-xpack.git/scripts/helper/build.sh --all cleanall
```

Instead of `--all`, any combination of `--win64 --linux64`
will remove the more specific folders.

For production builds it is recommended to **completely remove the build folder**:

```sh
rm -rf ~/Work/wine-*-*
```

### `--develop`

For performance reasons, the actual build folders are internal to each
Docker run, and are not persistent. This gives the best speed, but has
the disadvantage that interrupted builds cannot be resumed.

For development builds, it is possible to define the build folders in
the host file system, and resume an interrupted build.

In addition, the builds are more verbose.

### `--debug`

For development builds, it is also possible to create everything with
`-g -O0` and be able to run debug sessions.

### --jobs

By default, the build steps use all available cores. If, for any reason,
parallel builds fail, it is possible to reduce the load.

### Interrupted builds

The Docker scripts may run with root privileges. This is generally not a
problem, since at the end of the script the output files are reassigned
to the actual user.

However, for an interrupted build, this step is skipped, and files in
the install folder will remain owned by root. Thus, before removing
the build folder, it might be necessary to run a recursive `chown`.

## Testing

A simple test is performed by the script at the end, by launching the
executable to check if all shared/dynamic libraries are correctly used.

For a true test you need to unpack the archive in a temporary location
(like `~/Downloads`) and then run the
program from there. For example on macOS the output should
look like:

```console
$ .../xpack-wine-6.17.0-1/bin/wine --version
wine-6.17
```

## Installed folders

After install, the package should create a structure like this (macOS files;
only the first two depth levels are shown):

```console
$ tree -L 2 /Users/ilg/Library/xPacks/\@xpack-dev-tools/wine/6.17.0-1.1/.content/
/Users/ilg/Library/xPacks/\@xpack-dev-tools/wine/6.17.0-1.1/.content/
├── README.md
├── bin
│   ├── function_grep.pl
│   ├── msidb
│   ├── msiexec
│   ├── notepad
│   ├── regedit
│   ├── regsvr32
│   ├── widl
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
│   ├── wineserver
│   ├── wmc
│   └── wrc
├── distro-info
│   ├── CHANGELOG.md
│   ├── patches
│   └── scripts
├── include
│   └── wine
├── lib
│   └── wine
├── libexec
│   ├── libresolv-2.27.so
│   └── libresolv.so.2 -> libresolv-2.27.so
└── share
    ├── applications
    └── wine

12 directories, 29 files
```

No other files are installed in any system folders or other locations.

## Uninstall

The binaries are distributed as portable archives; thus they do not need
to run a setup and do not require an uninstall; simply removing the
folder is enough.

## Files cache

The XBB build scripts use a local cache such that files are downloaded only
during the first run, later runs being able to use the cached files.

However, occasionally some servers may not be available, and the builds
may fail.

The workaround is to manually download the files from an alternate
location (like
<https://github.com/xpack-dev-tools/files-cache/tree/master/libs>),
place them in the XBB cache (`Work/cache`) and restart the build.

## More build details

The build process is split into several scripts. The build starts on
the host, with `build.sh`, which runs `container-build.sh` several
times, once for each target, in one of the two docker containers.
Both scripts include several other helper scripts. The entire process
is quite complex, and an attempt to explain its functionality in a few
words would not be realistic. Thus, the authoritative source of details
remains the source code.
