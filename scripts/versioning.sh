# -----------------------------------------------------------------------------
# This file is part of the xPacks distribution.
#   (https://xpack.github.io)
# Copyright (c) 2020 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# Helper script used in the xPack build scripts. As the name implies,
# it should contain only functions and should be included with 'source'
# by the build scripts (both native and container).

# -----------------------------------------------------------------------------

function build_application_versioned_components()
{
  XBB_WINE_VERSION="$(echo "${XBB_RELEASE_VERSION}" | sed -e 's|\.[0-9][0-9]*-.*||')"

  if [ "${XBB_TARGET_PLATFORM}" != "linux" ] || [ "${XBB_TARGET_ARCH}" != "x64" ]
  then
    echo "This package can be built only on Intel Linux"
    exit 1
  fi

  # Keep them in sync with combo archive content.
  if [[ "${XBB_RELEASE_VERSION}" =~ 6\.17\.* ]]
  then
    # -------------------------------------------------------------------------

    xbb_set_binaries_install "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

    # No dependencies.

    xbb_set_binaries_install "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"

    # i686-w64-mingw32-gcc not available in the Docker container.
    XBB_WINE_SKIP_WIN32="y"

    build_wine "${XBB_WINE_VERSION}"

    run_verbose rm -rfv "${APP_INSTALL_FOLDER_PATH}/share/man"

    # -------------------------------------------------------------------------
  else
    echo "Unsupported version ${XBB_RELEASE_VERSION}."
    exit 1
  fi
}

# -----------------------------------------------------------------------------
