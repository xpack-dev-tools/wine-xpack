# Change & release log

Entries in this file are in reverse chronological order.

## 2023-09-04

* v8.0.2-1.1 published on npmjs.com
* 30abf3f package.json: update urls for 8.0.2-1.1 release
* 33278cb READMEs updates
* 629c0be re-generate workflows
* f97c456 dot.*ignore updated
* 26b029b CHANGELOG update
* 6290855 README update
* 5f7d8a8 package.json cleanup
* 2b44f09 CHANGELOG update
* 812ce31 README update
* 67b3810 .vscode/settings.json: ignoreWords
* 7b70eec package.json: bump deps
* 47b6a9f wine.sh: add new links
* 513e24d prepare v8.0.2-1

## 2023-09-03

* 1ff4d51 package.json: bump deps

## 2023-08-28

* b4c8f0d READMEs update

## 2023-08-25

* c3ec750 package.json: rm xpack-dev-tools-build/*
* 3fd1264 remove tests/update.sh
* ce7cfcf package.json: bump deps

## 2023-08-21

* 7b8eff7 READMEs update
* 850ad42 package.json: bump deps

## 2023-08-19

* c4c789a READMEs update
* f4721d0 package.json: bump deps

## 2023-08-15

* bfbcf3e package.json: bump deps

## 2023-08-05

* d80fd36 READMEs update

## 2023-08-04

* 126efe5 READMEs update
* 18a55b5 package.json: add build-develop-debug

## 2023-08-03

* d58acf0 READMEs update
* d036fc7 package.json: bump deps

## 2023-07-28

* 88dc716 READMEs update
* 147c3c9 READMEs update
* c93af16 package.json: bump deps
* ba74448 package.json: liquidjs --context --template
* d4c3625 scripts cosmetics
* a2a5a43 re-generate workflows
* 01333d1 package.json: minXpm 0.16.3 & @xpack-dev-tools/xbb-helper
* 2fb4a8e READMEs update
* 354f3e2 package.json: bump deps

## 2023-07-26

* ee965cc wine.sh: cosmetics
* a6540dd package.json: move scripts to actions
* 993da23 package.json: update xpack-dev-tools path
* 292a2ab READMEs update xpack-dev-tools path
* 155deb9 body-jekyll update
* 0e4398a READMEs update

## 2023-07-17

* 1a4b61d package.json: bump deps

## 2023-03-25

* 8b72215 READMEs update
* 5fa6939 READMEs update prerequisites
* a79fd9e package.json: mkdir -pv cache

## 2023-02-22

* 198f731 READMEs update

## 2023-02-14

* 064d2cc body-jekyll update

## 2023-02-10

* bef2549 wine.sh: update comments
* 0133b0f package.json: update Work/xpacks
* 6a4acf7 READMEs update

## 2023-02-07

* 8386f63 READMEs update
* 83c7051 body-jekyll update

## 2023-01-28

* 21e7d0d wine.sh: use versioning functions
* 795cc1b versioning.sh: comments

## 2023-01-27

* 3eb39a8 package.json: reorder scripts

## 2023-01-24

* 35994e2 README updates

## 2023-01-22

* 8d4249e README update

## 2023-01-11

* 73ca35a cosmetize xbb_adjust_ldflags_rpath

## 2023-01-06

* 1bb30d3 prepare v7.22.0-2
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
