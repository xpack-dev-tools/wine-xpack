# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2020 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# Helper script used in the second edition of the build scripts.
# As the name implies, it should contain only definitions and should
# be included with 'source' by the host and container scripts.

# Warning: MUST NOT depend on $HOME or other environment variables.

# -----------------------------------------------------------------------------

# Used to display the application name.
APP_NAME=${APP_NAME:-"WineHQ"}

# Used as part of file/folder paths.
APP_LC_NAME=${APP_LC_NAME:-"wine"}

DISTRO_NAME=${DISTRO_NAME:-"xPack"}
DISTRO_LC_NAME=${DISTRO_LC_NAME:-"xpack"}
DISTRO_TOP_FOLDER=${DISTRO_TOP_FOLDER:-"xPacks"}

APP_DESCRIPTION="${DISTRO_NAME} ${APP_NAME}"

# -----------------------------------------------------------------------------

GITHUB_ORG="${GITHUB_ORG:-"xpack-dev-tools"}"
GITHUB_REPO="${GITHUB_REPO:-"${APP_LC_NAME}-xpack"}"
GITHUB_PRE_RELEASES="${GITHUB_PRE_RELEASES:-"pre-releases"}"

NPM_PACKAGE="${NPM_PACKAGE:-"@xpack-dev-tools/${APP_LC_NAME}@next"}"

# -----------------------------------------------------------------------------

WITH_HTML="n"
SKIP_XBBLA64="y"
SKIP_XBBLA32="y"
SKIP_XBBMI="y"
SKIP_XBBMA="y"

# -----------------------------------------------------------------------------
