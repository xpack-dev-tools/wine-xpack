# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2020 Liviu Ionescu.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# Helper script used in the second edition of the xPack build
# scripts. As the name implies, it should contain only functions and
# should be included with 'source' by the container build scripts.

# -----------------------------------------------------------------------------

function wine_common_options()
{
  config_options+=("--without-alsa")
  config_options+=("--without-capi")
  config_options+=("--without-cms")
  config_options+=("--without-coreaudio")
  config_options+=("--without-cups")
  config_options+=("--without-dbus")
  config_options+=("--without-faudio")
  config_options+=("--without-fontconfig")
  config_options+=("--without-freetype")
  config_options+=("--without-gettext")
  config_options+=("--without-gettextpo")
  config_options+=("--without-gphoto")
  config_options+=("--without-gnutls")
  config_options+=("--without-gsm")
  config_options+=("--without-gssapi")
  config_options+=("--without-gstreamer")
  config_options+=("--without-hal")
  config_options+=("--without-inotify")
  config_options+=("--without-jpeg")
  config_options+=("--without-jxrlib")
  config_options+=("--without-krb5")
  config_options+=("--without-ldap")
  config_options+=("--without-mpg123")
  config_options+=("--without-netapi")
  config_options+=("--without-openal")
  config_options+=("--without-opengl")
  config_options+=("--without-osmesa")
  config_options+=("--without-oss")
  config_options+=("--without-pcap")
  config_options+=("--without-png")
  config_options+=("--without-pulse")
  config_options+=("--without-quicktime")
  config_options+=("--without-sane")
  config_options+=("--without-sdl")
  config_options+=("--without-tiff")
  config_options+=("--without-udev")
  config_options+=("--without-usb")
  config_options+=("--without-v4l2")
  config_options+=("--without-vkd3d")
  config_options+=("--without-vulkan")
  config_options+=("--without-xcomposite")
  config_options+=("--without-xcursor")
  config_options+=("--without-xfixes")
  config_options+=("--without-xinerama")
  config_options+=("--without-xinput")
  config_options+=("--without-xinput2")
  config_options+=("--without-xml")
  config_options+=("--without-xrandr")
  config_options+=("--without-xrender")
  config_options+=("--without-xshape")
  config_options+=("--without-xshm")
  config_options+=("--without-xslt")
  config_options+=("--without-xxf86vm")
  config_options+=("--without-x")
}

function build_wine()
{
  # https://www.winehq.org
  # https://dl.winehq.org/wine/source/
  # https://dl.winehq.org/wine/source/6.x/wine-6.17.tar.xz

  # https://github.com/archlinux/svntogit-community/blob/packages/wine/trunk/PKGBUILD

  # 2017-09-16, "4.3"
  # 2019-11-29, "4.21"
  # Fails with a missing yywrap
  # 2020-01-21, "5.0"
  # 2020-02-02, "5.1"
  # 2021-06-04, "6.10"
  # 2020-11-20, "5.22"
  # 2021-09-10, "6.17"
  # 2021-11-05, "6.21"
  # 2021-12-03, "6.23"

  local wine_version="$1"

  local wine_version_major="$(echo ${wine_version} | sed -e 's|\([0-9][0-9]*\)\.\([0-9][0-9]*\)|\1|')"
  local wine_version_minor="$(echo ${wine_version} | sed -e 's|\([0-9][0-9]*\)\.\([0-9][0-9]*\)|\2|')"

  local wine_src_folder_name="wine-${wine_version}"

  local wine_archive="${wine_src_folder_name}.tar.xz"

  if [ "${wine_version_minor}" != "0" ]
  then
    wine_version_minor="x"
  fi
  local wine_url="https://dl.winehq.org/wine/source/${wine_version_major}.${wine_version_minor}/${wine_archive}"

  local wine_folder_name="${wine_src_folder_name}"

  mkdir -pv "${LOGS_FOLDER_PATH}/${wine_folder_name}"

  local wine_stamp_file_path="${STAMPS_FOLDER_PATH}/stamp-${wine_folder_name}-installed"
  if [ ! -f "${wine_stamp_file_path}" ]
  then

    cd "${SOURCES_FOLDER_PATH}"

    download_and_extract "${wine_url}" "${wine_archive}" \
      "${wine_src_folder_name}"

    # The 64-bit variant.
    (
      mkdir -pv "${BUILD_FOLDER_PATH}/${wine_folder_name}-64"
      cd "${BUILD_FOLDER_PATH}/${wine_folder_name}-64"

      # None so far.
      xbb_activate_installed_dev

      CPPFLAGS="${XBB_CPPFLAGS}"
      CFLAGS="${XBB_CFLAGS_NO_W}"
      CXXFLAGS="${XBB_CXXFLAGS_NO_W}"

      LDFLAGS="${XBB_LDFLAGS_APP_STATIC_GCC}"
      # LDFLAGS="${XBB_LDFLAGS_APP}"
      if [ "${TARGET_PLATFORM}" == "linux" ]
      then
        LDFLAGS+=" -Wl,-rpath,${LD_LIBRARY_PATH}"
      fi

      export CPPFLAGS
      export CFLAGS
      export CXXFLAGS
      export LDFLAGS

      if [ ! -f "config.status" ]
      then
        (
          if [ "${IS_DEVELOP}" == "y" ]
          then
            env | sort
          fi

          echo
          echo "Running wine64 configure..."

          if [ "${IS_DEVELOP}" == "y" ]
          then
            run_verbose bash "${SOURCES_FOLDER_PATH}/${wine_src_folder_name}/configure" --help
          fi

          config_options=()

          config_options+=("--prefix=${BINS_INSTALL_FOLDER_PATH}")
          config_options+=("--mandir=${LIBS_INSTALL_FOLDER_PATH}/share/man")

          config_options+=("--build=${BUILD}")
          config_options+=("--host=${HOST}")
          config_options+=("--target=${TARGET}")

          config_options+=("--with-mingw")
          config_options+=("--with-pthread")
          config_options+=("--with-unwind")

          wine_common_options

          config_options+=("--enable-win64")

          config_options+=("--disable-tests")
          config_options+=("--disable-win16")

          run_verbose bash ${DEBUG} "${SOURCES_FOLDER_PATH}/${wine_src_folder_name}/configure" \
            "${config_options[@]}"

          cp "config.log" "${LOGS_FOLDER_PATH}/${wine_folder_name}/config-log-64-$(ndate).txt"
        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${wine_folder_name}/configure-output-64-$(ndate).txt"
      fi

      (
        echo
        echo "Running wine64 make..."

        # Build.
        run_verbose make -j ${JOBS} STRIP=true

        run_verbose make install

        # wine: Unhandled page fault on read access to 0000000000000108 at address 000000038B5B4C00 (thread 0114), starting debugger...
        # run_verbose make test

      ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${wine_folder_name}/make-output-64-$(ndate).txt"
    )

    # -------------------------------------------------------------------------

    if [ "${SKIP_WIN32:-}" != "y" ]
    then
      (
        mkdir -pv "${BUILD_FOLDER_PATH}/${wine_folder_name}-32"
        cd "${BUILD_FOLDER_PATH}/${wine_folder_name}-32"

        # None so far.
        xbb_activate_installed_dev

        CPPFLAGS="${XBB_CPPFLAGS}"
        CFLAGS="${XBB_CFLAGS_NO_W}"
        CXXFLAGS="${XBB_CXXFLAGS_NO_W}"

        LDFLAGS="${XBB_LDFLAGS_APP_STATIC_GCC}"
        # LDFLAGS="${XBB_LDFLAGS_APP}"
        if [ "${TARGET_PLATFORM}" == "linux" ]
        then
          LDFLAGS+=" -Wl,-rpath,${LD_LIBRARY_PATH}"
        fi

        export CPPFLAGS
        export CFLAGS
        export CXXFLAGS
        export LDFLAGS

        if [ ! -f "config.status" ]
        then
          (
            if [ "${IS_DEVELOP}" == "y" ]
            then
              env | sort
            fi

            echo
            echo "Running wine32 configure..."

            if [ "${IS_DEVELOP}" == "y" ]
            then
              run_verbose bash "${SOURCES_FOLDER_PATH}/${wine_src_folder_name}/configure" --help
            fi

            config_options=()

            config_options+=("--prefix=${BINS_INSTALL_FOLDER_PATH}")
            config_options+=("--libdir=${BINS_INSTALL_FOLDER_PATH}/lib32")
            config_options+=("--mandir=${LIBS_INSTALL_FOLDER_PATH}/share/man")

            config_options+=("--build=${BUILD}")
            config_options+=("--host=${HOST}")
            config_options+=("--target=${TARGET}")

            config_options+=("--with-mingw")
            config_options+=("--with-pthread")
            config_options+=("--with-unwind")

            wine_common_options

            config_options+=("--with-wine64=${BUILD_FOLDER_PATH}/${wine_folder_name}-64")

            config_options+=("--disable-tests")
            config_options+=("--disable-win16")

            run_verbose bash ${DEBUG} "${SOURCES_FOLDER_PATH}/${wine_src_folder_name}/configure" \
              "${config_options[@]}"

            cp "config.log" "${LOGS_FOLDER_PATH}/${wine_folder_name}/config-log-32-$(ndate).txt"
          ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${wine_folder_name}/configure-output-32-$(ndate).txt"
        fi

        (
          echo
          echo "Running wine32 make..."

          # Build.
          run_verbose make -j ${JOBS} STRIP=true

          run_verbose make install

          # wine: Unhandled page fault on read access to 0000000000000108 at address 000000038B5B4C00 (thread 0114), starting debugger...
          # run_verbose make test

        ) 2>&1 | tee "${LOGS_FOLDER_PATH}/${wine_folder_name}/make-output-32-$(ndate).txt"
      )
    fi

    hash -r

    touch "${wine_stamp_file_path}"

  else
    echo "Component wine already installed."
  fi

  test_functions+=("test_wine")
}

function test_wine()
{
  (
    # xbb_activate_installed_bin

    echo
    echo "Checking the wine shared libraries..."

    show_libs "$(realpath ${BINS_INSTALL_FOLDER_PATH}/bin/wine64)"
    show_libs "$(realpath ${BINS_INSTALL_FOLDER_PATH}/bin/winebuild)"

    show_libs "$(realpath ${BINS_INSTALL_FOLDER_PATH}/bin/winegcc)"
    show_libs "$(realpath ${BINS_INSTALL_FOLDER_PATH}/bin/wineg++)"

    libwine=$(find ${BINS_INSTALL_FOLDER_PATH}/lib* -name 'libwine.so')
    if [ ! -z "${libwine}" ]
    then
      show_libs "$(realpath ${libwine})"
    fi

    echo
    echo "Testing if wine binaries start properly..."

    # First check if the program is able to tell its version.
    run_app "${BINS_INSTALL_FOLDER_PATH}/bin/wine64" --version

    # Require gcc-xbs
    # run_app "${BINS_INSTALL_FOLDER_PATH}/bin/winegcc" --version
    # run_app "${BINS_INSTALL_FOLDER_PATH}/bin/wineg++" --version

    run_app "${BINS_INSTALL_FOLDER_PATH}/bin/winebuild" --version
    run_app "${BINS_INSTALL_FOLDER_PATH}/bin/winecfg" --version
    # run_app "${BINS_INSTALL_FOLDER_PATH}/bin/wineconsole" dir

    # This test should check if the program is able to start
    # a simple executable.
    # As a side effect, the "${HOME}/.wine" folder is created
    # and populated with lots of files., so subsequent runs
    # will no longer have to do it.
    local netstat=$(find "${BINS_INSTALL_FOLDER_PATH}"/lib* -name netstat.exe)
    run_app "${BINS_INSTALL_FOLDER_PATH}/bin/wine64" ${netstat}
  )
}

# -----------------------------------------------------------------------------
