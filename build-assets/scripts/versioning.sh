# -----------------------------------------------------------------------------
# This file is part of the xPack project (http://xpack.github.io).
# Copyright (c) 2020-2026 Liviu Ionescu. All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
#
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/mit.
#
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

function application_build_versioned_components()
{
  XBB_WINE_VERSION="$(echo "${XBB_RELEASE_VERSION}" | sed -e 's|[.][0-9][0-9]*-.*||' | sed -e 's|[.]0[.]0$|.0|')"

  # The 64-bit build passes on macOS, but the binary hangs.
  if [ "${XBB_REQUESTED_HOST_PLATFORM}" != "linux" ] || [ "${XBB_REQUESTED_HOST_ARCH}" != "x64" ]
  then
    echo "This package can be built only on x64 Linux"
    exit 1
  fi

  if [ "${XBB_REQUESTED_HOST_PLATFORM}" == "darwin" ]
  then
    # On macOS, the 32-bit Wine build fails when compiling Carbon.h.
    XBB_WINE_SKIP_WIN32="y"
  fi

  # Keep them in sync with the combo archive content.
  if [[ "${XBB_RELEASE_VERSION}" =~ 10[.][0-9]*[.][0-9]* ]] || \
     [[ "${XBB_RELEASE_VERSION}" =~ 9[.][0-9]*[.][0-9]* ]] || \
     [[ "${XBB_RELEASE_VERSION}" =~ 8[.][0-9]*[.][0-9]* ]]
  then
    # -------------------------------------------------------------------------
    # Build the native dependencies.

    # None

    # -------------------------------------------------------------------------
    # Build the target dependencies.

    xbb_reset_env
    xbb_set_target "requested"

    # -------------------------------------------------------------------------
    # Build the application binaries.

    xbb_set_executables_install_path "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install_path "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

    # https://dl.winehq.org/wine/source/
    wine_build "${XBB_WINE_VERSION}"

    run_verbose rm -rfv "${XBB_APPLICATION_INSTALL_FOLDER_PATH}/share/man"

    # -------------------------------------------------------------------------
  elif [[ "${XBB_RELEASE_VERSION}" =~ 7[.][0-9]*[.][0-9]* ]]
  then
    # -------------------------------------------------------------------------
    # Build the native dependencies.

    # None

    # -------------------------------------------------------------------------
    # Build the target dependencies.

    xbb_reset_env
    xbb_set_target "requested"

    # https://sourceforge.net/projects/libpng/files/libpng16/
    # libpng_build "1.6.39"

    # -------------------------------------------------------------------------
    # Build the application binaries.

    xbb_set_executables_install_path "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install_path "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

    # Disable parallel build due to buggy dllutils in binutils 2.38.
    # XBB_APPLICATION_JOBS=1

    # https://dl.winehq.org/wine/source/
    wine_build "${XBB_WINE_VERSION}"

    run_verbose rm -rfv "${XBB_APPLICATION_INSTALL_FOLDER_PATH}/share/man"

    # -------------------------------------------------------------------------
  elif [[ "${XBB_RELEASE_VERSION}" =~ 6[.][0-9]*[.][0-9]* ]]
  then
    # -------------------------------------------------------------------------
    # Build the native dependencies.

    # None

    # -------------------------------------------------------------------------
    # Build the target dependencies.

    xbb_reset_env
    # Before set target (to possibly update CC & co variables).
    # xbb_activate_installed_bin

    xbb_set_target "requested"

    # https://sourceforge.net/projects/libpng/files/libpng16/
    libpng_build "1.6.37"

    # -------------------------------------------------------------------------
    # Build the application binaries.

    xbb_set_executables_install_path "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install_path "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

    # Disable parallel build due to buggy dllutils in binutils 2.38.
    XBB_APPLICATION_JOBS=1

    # https://dl.winehq.org/wine/source/
    wine_build "${XBB_WINE_VERSION}"

    run_verbose rm -rfv "${XBB_APPLICATION_INSTALL_FOLDER_PATH}/share/man"

    # -------------------------------------------------------------------------
  else
    echo "Unsupported ${XBB_APPLICATION_LOWER_CASE_NAME} version ${XBB_RELEASE_VERSION}"
    exit 1
  fi
}

# -----------------------------------------------------------------------------
