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

function build_versions()
{
  WINE_VERSION="$(echo "${RELEASE_VERSION}" | sed -e 's|\.[0-9][0-9]*-.*||')"

  if [ "${TARGET_PLATFORM}" != "linux" ] || [ "${TARGET_ARCH}" != "x64" ]
  then
    echo "This package can be built only on Intel Linux"
    exit 1
  fi

  # Keep them in sync with combo archive content.
  if [[ "${RELEASE_VERSION}" =~ 6\.17\.* ]]
  then
    # -------------------------------------------------------------------------

    (
      xbb_activate

      # From now on, install all binaries in the public arena.
      BINS_INSTALL_FOLDER_PATH="${APP_INSTALL_FOLDER_PATH}"

      # i686-w64-mingw32-gcc not available in the Docker container.
      SKIP_WIN32="y"

      build_wine "6.17"

      run_verbose rm -rfv "${APP_INSTALL_FOLDER_PATH}/share/man"
    )

    # -------------------------------------------------------------------------
  else
    echo "Unsupported version ${RELEASE_VERSION}."
    exit 1
  fi
}

# -----------------------------------------------------------------------------
