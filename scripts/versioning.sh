# -----------------------------------------------------------------------------
# This file is part of the xPacks distribution.
#   (https://xpack.github.io)
# Copyright (c) 2020 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

function application_build_versioned_components()
{
  XBB_WINE_VERSION="$(echo "${XBB_RELEASE_VERSION}" | sed -e 's|[.][0-9][0-9]*-.*||')"

  if [ "${XBB_REQUESTED_HOST_PLATFORM}" != "linux" ] || [ "${XBB_REQUESTED_HOST_ARCH}" != "x64" ]
  then
    echo "This package can be built only on Intel Linux"
    exit 1
  fi

  # Keep them in sync with combo archive content.
  if [[ "${XBB_RELEASE_VERSION}" =~ 7[.].*[.].* ]]
  then
    # -------------------------------------------------------------------------
    # Build the native dependencies.

    # None

    # -------------------------------------------------------------------------
    # Build the target dependencies.

    xbb_reset_env
    xbb_set_target "requested"

    # https://sourceforge.net/projects/libpng/files/libpng16/
    libpng_build "1.6.39"
    # -------------------------------------------------------------------------
    # Build the application binaries.

    xbb_set_executables_install_path "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install_path "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

    # https://dl.winehq.org/wine/source/
    wine_build "${XBB_WINE_VERSION}"

    run_verbose rm -rfv "${XBB_APPLICATION_INSTALL_FOLDER_PATH}/share/man"

    # -------------------------------------------------------------------------
  elif [[ "${XBB_RELEASE_VERSION}" =~ 6[.].*[.].* ]]
  then
    # -------------------------------------------------------------------------
    # Build the native dependencies.

    # 6.23 is an intermediate release, which uses a preliminary compiler
    # that includes binutils 2.38 which ahs a bug in dlltool,
    # thus the need to disable parallel builds.

    XBB_APPLICATION_JOBS=1

    # Used during development only.
    # Don't forget to enable xbb_activate_installed_bin later.
    if false
    then

      # Rebuild binutils 2.39 to avoid the 2.38 bug in the current
      # mingw-w64-gcc package.
      export XBB_BINUTILS_BRANDING="${XBB_APPLICATION_DISTRO_NAME} MinGW-w64 binutils ${XBB_REQUESTED_TARGET_MACHINE}"

      # https://ftp.gnu.org/gnu/binutils/
      XBB_BINUTILS_VERSION="2.39"

      xbb_reset_env
      xbb_set_target "mingw-w64-native"

      # 32-bit first, since it is more probable to fail.
      XBB_MINGW_TRIPLETS=( "i686-w64-mingw32" "x86_64-w64-mingw32" )

      for triplet in "${XBB_MINGW_TRIPLETS[@]}"
      do

        xbb_set_extra_target_env "${triplet}"

        binutils_build "${XBB_BINUTILS_VERSION}" --triplet="${triplet}" --program-prefix="${triplet}-"

      done

      # With 2.39 parallel builds are fine.
      unset XBB_APPLICATION_JOBS

    fi

    # -------------------------------------------------------------------------
    # Build the target dependencies.

    xbb_reset_env
    # xbb_activate_installed_bin

    xbb_set_target "requested"

    # https://sourceforge.net/projects/libpng/files/libpng16/
    libpng_build "1.6.37"

    # -------------------------------------------------------------------------
    # Build the application binaries.

    xbb_set_executables_install_path "${XBB_APPLICATION_INSTALL_FOLDER_PATH}"
    xbb_set_libraries_install_path "${XBB_DEPENDENCIES_INSTALL_FOLDER_PATH}"

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
