[![license](https://img.shields.io/github/license/xpack-dev-tools/wine-xpack)](https://github.com/xpack-dev-tools/wine-xpack/blob/xpack/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/xpack-dev-tools/wine-xpack.svg)](https://github.com/xpack-dev-tools/wine-xpack/issues/)
[![GitHub pulls](https://img.shields.io/github/issues-pr/xpack-dev-tools/wine-xpack.svg)](https://github.com/xpack-dev-tools/wine-xpack/pulls)

# Maintainer info

## Prerequisites

The build scripts run on GNU/Linux and macOS. The Windows binaries are
generated on Intel GNU/Linux, using [mingw-w64](https://mingw-w64.org).

For GNU/Linux, the prerequisites are:

- `curl` (installed via the system package manager)
- `git` (installed via the system package manager)
- `docker` (preferably a recent one, installed from **docker.com**)
- `npm` (shipped with Node.js; installed via **nvm**, **not**
  the system package manager)
- `xpm` (installed via `npm`)

For macOS, the prerequisites are:

- `npm` (shipped with Node.js; installed via **nvm**)
- `xpm` (installed via `npm`)
- the **Command Line Tools** from Apple

For details on installing them, please read the
[XBB prerequisites](https://xpack.github.io/xbb/prerequisites/) page.

If you already have a functional configuration from a previous run,
it is recommended to update **xpm**:

```sh
npm install --location=global xpm@latest
```

## Get project sources

The project is hosted on GitHub:

- <https://github.com/xpack-dev-tools/wine-xpack.git>

To clone the stable branch (`xpack`), run the following commands in a
terminal (on Windows use the _Git Bash_ console):

```sh
rm -rf ~/Work/xpack-dev-tools/wine-xpack.git && \
git clone https://github.com/xpack-dev-tools/wine-xpack.git \
  ~/Work/xpack-dev-tools/wine-xpack.git
```

For development purposes, clone the `xpack-develop` branch:

```sh
rm -rf ~/Work/xpack-dev-tools/wine-xpack.git && \
mkdir -p ~/Work/xpack-dev-tools && \
git clone \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/wine-xpack.git \
  ~/Work/xpack-dev-tools/wine-xpack.git
```

Or, if the repo was already cloned:

```sh
git -C ~/Work/xpack-dev-tools/wine-xpack.git pull
```

## Get helper sources

The project has a dependency to a common **helper**; clone the
`xpack-develop` branch and link it to the central xPacks store:

```sh
rm -rf ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
mkdir -p ~/Work/xpack-dev-tools && \
git clone \
  --branch xpack-develop \
  https://github.com/xpack-dev-tools/xbb-helper-xpack.git \
  ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git
```

Or, if the repo was already cloned:

```sh
git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git
```

## Release schedule

The [upstream](https://dl.winehq.org/wine/source/) stable release cycle
is one release per year, with 2-3 patch releases. The development release
cycle is about two weeks.

This distribution generally plans to follow the final patch of the
stable release (like X.0.2).

## How to make new releases

Before starting the build, perform some checks and tweaks.

### Download the build scripts

The build scripts are available in the `scripts` folder of the
[`xpack-dev-tools/wine-xpack`](https://github.com/xpack-dev-tools/wine-xpack)
Git repo.

To download them on a new machine, clone the `xpack-develop` branch,
as seen above.

### Check Git

In the `xpack-dev-tools/wine-xpack` Git repo:

- switch to the `xpack-develop` branch
- pull new changes
- if needed, merge the `xpack` branch

No need to add a tag here, it'll be added when the release is created.

### Update helper & other dependencies

Check the latest versions at <https://github.com/xpack-dev-tools/> and
update the dependencies in `package.json`.

### Check the latest upstream release

Check the WineHQ [News](https://www.winehq.org/news/) and
[downloads](https://dl.winehq.org/wine/source/); compare with the
xPack [Releases](https://github.com/xpack-dev-tools/wine-xpack/releases/).
In August-September wait for the last X.0.[23] and release it.

### Increase the version

Determine the version (like `8.0.2`) and update the `scripts/VERSION`
file; the format is `8.0.2-1`. The fourth number is the xPack release number
of this version. A fifth number will be added when publishing
the package on the `npm` server.

### Fix possible open issues

Check GitHub issues and pull requests:

- <https://github.com/xpack-dev-tools/wine-xpack/issues/>

and fix them; assign them to a milestone (like `8.0.2-1`).

### Check `README.md`

Normally `README.md` should not need changes, but better check.
Information related to the new version should not be included here,
but in the version specific release page.

### Update versions in `README` files

- update version in `README-MAINTAINER.md`
- update version in `README.md`

### Update version in `package.json` to a pre-release

Use a new version, suffixed by `.pre`.

### Update `CHANGELOG.md`

- open the `CHANGELOG.md` file
- check if all previous fixed issues are in
- add a new entry like _* v8.0.2-1 prepared_
- commit with a message like _prepare v8.0.2-1_

### Update the version specific code

- open the `scripts/versioning.sh` file
- add a new `if` with the new version before the existing code

## Build

The builds currently run on a dedicated machine (Intel GNU/Linux).

### Development run the build scripts

Before the real build, run a test build.

#### Visual Studio Code

All actions are defined as **xPack actions** and can be conveniently
triggered via the VS Code graphical interface, using the
[xPack extension](https://marketplace.visualstudio.com/items?itemName=ilg-vscode.xpack).

#### Intel GNU/Linux

Run the docker build on the production machine (`xbbli`);
start a VS Code remote session, or connect with a terminal:

```sh
caffeinate ssh xbbli
```

##### Build the Intel GNU/Linux binaries

Update the build scripts (or clone them at the first use):

```sh
git -C ~/Work/xpack-dev-tools/wine-xpack.git pull && \
xpm run install -C ~/Work/xpack-dev-tools/wine-xpack.git && \
git -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git pull && \
xpm link -C ~/Work/xpack-dev-tools/xbb-helper-xpack.git && \
xpm run link-deps -C ~/Work/xpack-dev-tools/wine-xpack.git && \
\
xpm run deep-clean --config linux-x64 -C ~/Work/xpack-dev-tools/wine-xpack.git && \
xpm run docker-prepare --config linux-x64 -C ~/Work/xpack-dev-tools/wine-xpack.git && \
xpm run docker-link-deps --config linux-x64 -C ~/Work/xpack-dev-tools/wine-xpack.git && \
xpm run docker-build-develop --config linux-x64 -C ~/Work/xpack-dev-tools/wine-xpack.git
```

About 12 minutes later, the output of the build script is a compressed
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l ~/Work/xpack-dev-tools/wine-xpack.git/build/linux-x64/deploy
total 130180
-rw-r--r-- 1 ilg ilg 133299558 Sep  4 11:08 xpack-wine-8.0.2-1-linux-x64.tar.gz
-rw-r--r-- 1 ilg ilg       102 Sep  4 11:08 xpack-wine-8.0.2-1-linux-x64.tar.gz.sha
```

### Update README-MAINTAINER listing output

- check and possibly update the `ls -l` output in README-MAINTAINER

### Update the list of links in package.json

Copy/paste the full list of links displayed at the end of the build, in
sequence, for each platform (GNU/Linux, macOS, Windows), and check the
differences compared to the repository.

Commit if necessary.

### How to build a debug version

In some cases it is necessary to run a debug session in the binaries,
or even in the libraries functions.

For these cases, the build script accepts the `--debug` options.

There are also xPack actions that use this option (`build-develop-debug`
and `docker-build-develop-debug`).

### Files cache

The XBB build scripts use a local cache such that files are downloaded only
during the first run, later runs being able to use the cached files.

However, occasionally some servers may not be available, and the builds
may fail.

The workaround is to manually download the files from an alternate
location (like
<https://github.com/xpack-dev-tools/files-cache/tree/master/libs>),
place them in the XBB cache (`Work/cache`) and restart the build.

## Run the CI build

The automation is provided by GitHub Actions and three self-hosted runners.

### Generate the GitHub workflows

Run the `generate-workflows` to re-generate the
GitHub workflow files; commit and push if necessary.

- on the development machine (`wksi`) open a ssh session to the build
machine (`xbbli`):

```sh
caffeinate ssh xbbli
```

Start the runners:

```sh
screen -S ga

~/actions-runners/xpack-dev-tools/1/run.sh &
~/actions-runners/xpack-dev-tools/2/run.sh &

# Ctrl-a Ctrl-d
```

### Push the build scripts

- push the `xpack-develop` branch to GitHub
- possibly push the helper project too

From here it'll be cloned on the production machines.

### Publish helper

Publish a new release of the helper and update the reference in `package.json`.

### Check for disk space

Check if the build machines have enough free space and eventually
do some cleanups (`df -BG -H /` on Linux, `df -gH /` on macOS).

To remove previous builds, use:

```sh
rm -rf ~/Work/xpack-dev-tools/*/build
```

### Manually trigger the build GitHub Actions

To trigger the GitHub Actions build, use the xPack action:

- `trigger-workflow-build-xbbli`

This is equivalent to:

```sh
bash ${HOME}/Work/xpack-dev-tools/wine-xpack.git/scripts/helper/trigger-workflow-build.sh --machine xbbli
```

These scripts require the `GITHUB_API_DISPATCH_TOKEN` variable to be present
in the environment, and the organization `PUBLISH_TOKEN` to be visible in the
Settings → Action →
[Secrets](https://github.com/xpack-dev-tools/wine-xpack/settings/secrets/actions)
page.

This commands uses the `xpack-develop` branch of this repo.

## Durations & results

The  build takes about 14 minutes to complete.

The workflow result and logs are available from the
[Actions](https://github.com/xpack-dev-tools/wine-xpack/actions/) page.

The resulting binaries are available for testing from
[pre-releases/test](https://github.com/xpack-dev-tools/pre-releases/releases/tag/test/).

## Testing

### CI tests

The automation is provided by GitHub Actions.

To trigger the GitHub Actions tests, use the xPack actions:

- `trigger-workflow-test-prime`
- `trigger-workflow-test-docker-linux-intel`

These are equivalent to:

```sh
bash ${HOME}/Work/xpack-dev-tools/wine-xpack.git/scripts/helper/tests/trigger-workflow-test-prime.sh
bash ${HOME}/Work/xpack-dev-tools/wine-xpack.git/scripts/helper/tests/trigger-workflow-test-docker-linux-intel.sh
```

These scripts require the `GITHUB_API_DISPATCH_TOKEN` variable to be present
in the environment, and the organization `PUBLISH_TOKEN` to be visible in the
Settings → Action →
[Secrets](https://github.com/xpack-dev-tools/wine-xpack/settings/secrets/actions)
page.

These actions use the `xpack-develop` branch of this repo and the
[pre-releases/test](https://github.com/xpack-dev-tools/pre-releases/releases/tag/test/)
binaries.

The tests results are available from the
[Actions](https://github.com/xpack-dev-tools/wine-xpack/actions/) page.

### Manual tests

To download the pre-released archive for the specific platform
and run the tests, use:

```sh
git -C ~/Work/xpack-dev-tools/wine-xpack.git pull
xpm run install -C ~/Work/xpack-dev-tools/wine-xpack.git
xpm run test-pre-release -C ~/Work/xpack-dev-tools/wine-xpack.git
```

For even more tests, on each platform (GNU/Linux),
download the archive from
[pre-releases/test](https://github.com/xpack-dev-tools/pre-releases/releases/tag/test/)
and check the binaries.

On GNU/Linux, use:

```sh
.../xpack-wine-8.0.2-1/bin/wine64 --version
wine-6.17
```

## Create a new GitHub pre-release draft

- in `CHANGELOG.md`, add the release date and a message like _* v8.0.2-1 released_
- commit with _CHANGELOG update_
- check and possibly update the `templates/body-github-release-liquid.md`
- push the `xpack-develop` branch
- run the xPack action `trigger-workflow-publish-release`

The workflow result and logs are available from the
[Actions](https://github.com/xpack-dev-tools/wine-xpack/actions/) page.

The result is a
[draft pre-release](https://github.com/xpack-dev-tools/wine-xpack/releases/)
tagged like **v8.0.2-1** (mind the dash in the middle!) and
named like **xPack WineHQ v8.0.2-1** (mind the dash),
with all binaries attached.

- edit the draft and attach it to the `xpack-develop` branch (important!)
- save the draft (do **not** publish yet!)

## Prepare a new blog post

- check and possibly update the `templates/body-jekyll-release-*-liquid.md`
  (use <https://dl.winehq.org/wine/source/> for the release date)
- run the xPack action `generate-jekyll-post`; this will leave a file
on the Desktop.

In the `xpack/web-jekyll` GitHub repo:

- select the `develop` branch
- copy the new file to `_posts/releases/wine`

If any, refer to closed
[issues](https://github.com/xpack-dev-tools/wine-xpack/issues/).

## Update the preview Web

- commit the `develop` branch of `xpack/web-jekyll` GitHub repo;
  use a message like _xPack WineHQ v8.0.2-1 released_
- push to GitHub
- wait for the GitHub Pages build to complete
- the preview web is <https://xpack.github.io/web-preview/news/>

## Create the pre-release

- go to the GitHub [Releases](https://github.com/xpack-dev-tools/wine-xpack/releases/) page
- perform the final edits and check if everything is fine
- temporarily fill in the _Continue Reading »_ with the URL of the
  web-preview release
- **keep the pre-release button enabled**
- do not enable Discussions yet
- publish the release

Note: at this moment the system should send a notification to all clients
watching this project.

## Update the READMEs listings and examples

- check and possibly update the output of `tree -L 2` in README
- check and possibly update the output of the `--version` runs in README-MAINTAINER
- commit changes

## Check the list of links in package.json

- open the `package.json` file
- check if the links in the `bin` property cover the actual binaries
- rename `widl` -> `winewidl`

## Update package.json binaries

- select the `xpack-develop` branch
- run the xPack action `update-package-binaries`
- open the `package.json` file
- check the `baseUrl:` it should match the file URLs (including the tag/version);
  no terminating `/` is required
- from the release, check the SHA & file names
- compare the SHA sums with those shown by `cat *.sha`
- check the executable names
- commit all changes, use a message like
  _package.json: update urls for 8.0.2-1.1 release_ (without _v_)

## Publish on the npmjs.com server

- select the `xpack-develop` branch
- check the latest commits `npm run git-log`
- update `CHANGELOG.md`, add a line like _* v8.0.2-1.1 published on npmjs.com_
- commit with a message like _CHANGELOG: publish npm v8.0.2-1.1_
- `npm pack` and check the content of the archive, which should list
  only the `package.json`, the `README.md`, `LICENSE` and `CHANGELOG.md`;
  possibly adjust `.npmignore`
- `npm version 8.0.2-1.1`; the first 4 numbers are the same as the
  GitHub release; the fifth number is the npm specific version
- the commits and the tag should have been pushed by the `postversion` script;
  if not, push them with `git push origin --tags`
- `npm publish --tag next` (use `npm publish --access public`
  when publishing for the first time; add the `next` tag)

After a few moments the version will be visible at:

- <https://www.npmjs.com/package/@xpack-dev-tools/wine?activeTab=versions>

## Test if the binaries can be installed with xpm

Run the xPack action `trigger-workflow-test-xpm`, this
will install the package via `xpm install` on all supported platforms.

The tests results are available from the
[Actions](https://github.com/xpack-dev-tools/wine-xpack/actions/) page.

## Update the repo

- merge `xpack-develop` into `xpack`
- push to GitHub

## Tag the npm package as `latest`

When the release is considered stable, promote it as `latest`:

- `npm dist-tag ls @xpack-dev-tools/wine`
- `npm dist-tag add @xpack-dev-tools/wine@8.0.2-1.1 latest`
- `npm dist-tag ls @xpack-dev-tools/wine`

In case the previous version is not functional and needs to be unpublished:

- `npm unpublish @xpack-dev-tools/wine@8.0.2-1.1`

## Update the Web

- in the `master` branch, merge the `develop` branch
- wait for the GitHub Pages build to complete
- the result is in <https://xpack.github.io/news/>
- remember the post URL, since it must be updated in the release page

## Create the final GitHub release

- go to the GitHub [Releases](https://github.com/xpack-dev-tools/wine-xpack/releases/) page
- check the download counter, it should match the number of tests
- add a link to the Web page `[Continue reading »]()`; use an same blog URL
- remove the _tests only_ notice
- **disable** the **pre-release** button
- click the **Update Release** button

## Share on Twitter

- in a separate browser windows, open [TweetDeck](https://tweetdeck.twitter.com/)
- using the `@xpack_project` account
- paste the release name like **xPack WineHQ v8.0.2-1 released**
- paste the link to the Web page
  [release](https://xpack.github.io/wine/releases/)
- click the **Tweet** button

## Check SourceForge mirror

- <https://sourceforge.net/projects/wine-xpack/files/>

## Remove the pre-release binaries

- go to <https://github.com/xpack-dev-tools/pre-releases/releases/tag/test/>
- remove the test binaries

## Clean the work area

Run the xPack action `trigger-workflow-deep-clean`, this
will remove the build folders on all supported platforms.

The results are available from the
[Actions](https://github.com/xpack-dev-tools/wine-xpack/actions/) page.
