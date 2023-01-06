# Change & release log

Entries in this file are in reverse chronological order.

## 2023-01-06

* v7.22.0-2 prepared
* e44aa10 versioning.sh: no need to build png
* 87d956b wine.sh: update options or 7.22

## 2023-01-05

* c33585f versioning.sh: no need to disable parallel build
* 82bb6ac package.json: bump mingw-w64-gcc to 12 again
* e6694b7 wine.sh: add support for patches
* 767e9b7 add wine-7.22.git.patch

## 2023-01-03

* v7.22.0-1.1 published on npmjs.com
* v7.22.0-1 released
* e004ed5 add tests/update.sh, with multilib
* 2e763a6 wine.sh: do not fail on 32-bit tests
* a2ffed5 README update
* ab83f6e package.json: bump deps
* 85ddbed package.json: update xpack.bin
* v7.22.0-1 prepared
* 6c234c5 versioning.sh: document XBB_APPLICATION_JOBS
* 8f0307d wine.sh: update versions
* dc40ead re-generate workflows
* 6d565bc package.json: revert ot mingw-gcc 11.3
* adfa463 versioning.sh: remove binutils local build
* ebb3544 versioning.sh: bump deps for 7.*
* 372ac2d application.sh: cleanup
* 0bb7f72 package.json: xpm trace & next
* b681ee7 package.json: bump deps
* e999240 wine.sh: short test 32-bit
* d6e322c versioning.sh: make local binutils conditional

## 2023-01-02

* 4963445 versioning.sh: enable win32 libs
* 9c72397 versioning.sh: regexp '.*'
* 33f29a3 application.sh: cleanup
* 26a6e15 package.json: move mingw-w64-gcc to common
* 8b882d6 XBB_APPLICATION_JOBS=1
* 331a424 README updates

## 2023-01-01

* 3f49817 package.json: pass xpm version & loglevel
* 1f7e596 wine.sh: cosmetics --prefix
* 9ebbff0 Merge branch 'xpack-develop' of https://github.com/xpack-dev-tools/wine-xpack into xpack-develop
* 63c2b5c README update

## 2022-12-31

* 493846d wine.sh: fix run_verbose underscore
* 4d7a8d7 wine.sh: fix which dlltool syntax
* 45c7281 document the dlltool bug
* f368618 Revert "wine.sh: re-enable parallel build"

## 2022-12-30

* d432d6f wine.sh: re-enable parallel build
* 1865327 README-MAINTAINER: xpm run install
* 7ff15f2 package.json: bump deps
* 9465a48 wine.sh: regexp
* 3c3161c versioning.sh: regexp

## 2022-12-27

* 09e6d69 Merge branch 'xpack-develop' of https://github.com/xpack-dev-tools/wine-xpack into xpack-develop
* 1713ac5 README update
* 46a97d9 echo FUNCNAME[0]
* 15424de temporarily build binutils 2.39
* 15fb87f cosmetics: move versions to the top

## 2022-12-26

* 1480da1 README update
* 7144cfb add README-DEVELOP with binutils 2.38 bug
* fc84613 re-generate from template
* 7090ad9 README updates
* be83d29 package.json: update
* dde23f1 package.json: bump deps
* ed38bd1 VERSION 6.23.0-1
* 49d3b9b update for xbb v5.x
* efb8696 .vscode/settings.json: ignoreWords
* f080e38 re-generate from templates
* update for XBB v5.0.0

## 2022-09-26

* v6.17.0-1.1 published on npmjs.com
* v6.17.0-1 released
* copy/paste from cmake-xpack
