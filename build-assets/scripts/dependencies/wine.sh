# -----------------------------------------------------------------------------
# This file is part of the xPack distribution.
#   (https://xpack.github.io)
# Copyright (c) 2020 Liviu Ionescu. All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose is hereby granted, under the terms of the MIT license.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

# https://www.winehq.org
# https://wiki.winehq.org/Building_Wine

# https://dl.winehq.org/wine/source/
# https://dl.winehq.org/wine/source/8.0/wine-8.0.2.tar.xz
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
# 2022-08-28, "7.16"
# 2022-10-14, "7.19"
# 2022-11-25, "7.22"
# 2023-07-19, "8.0.2"

# -----------------------------------------------------------------------------

function wine_prepare_common_options()
{
  config_options+=("--without-alsa")
  config_options+=("--without-capi")
  # config_options+=("--without-cms") # - from 7.22
  config_options+=("--without-coreaudio")
  config_options+=("--without-cups")
  config_options+=("--without-dbus")
  # config_options+=("--without-faudio") # - from 7.22
  config_options+=("--without-fontconfig")
  config_options+=("--without-freetype")
  config_options+=("--without-gettext")
  config_options+=("--without-gettextpo")
  config_options+=("--without-gphoto")
  config_options+=("--without-gnutls")
  # config_options+=("--without-gsm") # - from 7.22
  config_options+=("--without-gssapi")
  config_options+=("--without-gstreamer")
  # config_options+=("--without-hal") # - from 7.22
  config_options+=("--without-inotify")
  # config_options+=("--without-jpeg") # - from 7.22
  # config_options+=("--without-jxrlib") # - from 7.22
  config_options+=("--without-krb5")
  # config_options+=("--without-ldap") # - from 7.22
  # config_options+=("--without-mpg123") # - from 7.22
  config_options+=("--without-netapi")
  # config_options+=("--without-openal") # - from 7.22
  config_options+=("--without-opencl") # + from 7.22
  config_options+=("--without-opengl")
  config_options+=("--without-osmesa")
  config_options+=("--without-oss")
  config_options+=("--without-pcap")

  # 0034:err:wincodecs:png_encoder_create Trying to save PNG picture, but PNG support is not compiled in.
  # config_options+=("--without-png")
  # config_options+=("--with-png") # - from 7.22

  # --without-pthread since 7.22
  config_options+=("--without-pulse")
  # config_options+=("--without-quicktime") # - from 7.22
  config_options+=("--without-sane")
  config_options+=("--without-sdl")
  # config_options+=("--without-tiff") # - from 7.22
  config_options+=("--without-udev")

  # --without-unwind since 7.22
  config_options+=("--without-usb")
  config_options+=("--without-v4l2")
  # config_options+=("--without-vkd3d") # - from 7.22
  config_options+=("--without-vulkan")
  config_options+=("--without-xcomposite")
  config_options+=("--without-xcursor")
  config_options+=("--without-xfixes")
  config_options+=("--without-xinerama")
  config_options+=("--without-xinput")
  config_options+=("--without-xinput2")
  # config_options+=("--without-xml") # - from 7.22
  config_options+=("--without-xrandr")
  config_options+=("--without-xrender")
  config_options+=("--without-xshape")
  config_options+=("--without-xshm")
  # config_options+=("--without-xslt") # - from 7.22
  config_options+=("--without-xxf86vm")
  config_options+=("--without-x")
}

function wine_build()
{
  echo_develop
  echo_develop "[${FUNCNAME[0]} $@]"

  local wine_version="$1"

  local wine_version_major=$(xbb_get_version_major "${wine_version}")
  local wine_version_minor=$(xbb_get_version_minor "${wine_version}")

  local wine_src_folder_name="wine-${wine_version}"

  local wine_archive="${wine_src_folder_name}.tar.xz"

  local wine_version_minor_x
  if [ "${wine_version_minor}" == "0" ]
  then
    wine_version_minor_x="0"
  else
    wine_version_minor_x="x"
  fi
  local wine_url="https://dl.winehq.org/wine/source/${wine_version_major}.${wine_version_minor_x}/${wine_archive}"

  local wine_folder_name="${wine_src_folder_name}"

  mkdir -pv "${XBB_LOGS_FOLDER_PATH}/${wine_folder_name}"

  local wine_patch_file_name="wine-${wine_version}.git.patch"
  local wine_stamp_file_path="${XBB_STAMPS_FOLDER_PATH}/stamp-${wine_folder_name}-installed"
  if [ ! -f "${wine_stamp_file_path}" ]
  then

    mkdir -pv "${XBB_SOURCES_FOLDER_PATH}"
    cd "${XBB_SOURCES_FOLDER_PATH}"

    download_and_extract "${wine_url}" "${wine_archive}" \
      "${wine_src_folder_name}" "${wine_patch_file_name}"

    # The 64-bit variant.
    (
      mkdir -pv "${XBB_BUILD_FOLDER_PATH}/${wine_folder_name}-64"
      cd "${XBB_BUILD_FOLDER_PATH}/${wine_folder_name}-64"

      # None so far.
      xbb_activate_dependencies_dev

      CPPFLAGS="${XBB_CPPFLAGS}"
      CFLAGS="${XBB_CFLAGS_NO_W}"
      CXXFLAGS="${XBB_CXXFLAGS_NO_W}"

      # LDFLAGS="${XBB_LDFLAGS_APP_STATIC_GCC}"
      LDFLAGS="${XBB_LDFLAGS_APP}"

      xbb_adjust_ldflags_rpath

      export CPPFLAGS
      export CFLAGS
      export CXXFLAGS
      export LDFLAGS

      # binutils 2.38 has a problem with parallel builds.
      run_verbose $(which x86_64-w64-mingw32-dlltool) --version

      if [ ! -f "config.status" ]
      then
        (
          xbb_show_env_develop

          echo
          echo "Running wine64 configure..."

          if is_development
          then
            run_verbose bash "${XBB_SOURCES_FOLDER_PATH}/${wine_src_folder_name}/configure" --help
          fi

          config_options=()

          config_options+=("--prefix=${XBB_EXECUTABLES_INSTALL_FOLDER_PATH}")

          config_options+=("--mandir=${XBB_LIBRARIES_INSTALL_FOLDER_PATH}/share/man")

          config_options+=("--build=${XBB_BUILD_TRIPLET}")
          config_options+=("--host=${XBB_HOST_TRIPLET}")
          config_options+=("--target=${XBB_TARGET_TRIPLET}")

          config_options+=("--with-mingw")
          config_options+=("--with-pthread")
          config_options+=("--with-unwind")

          wine_prepare_common_options

          config_options+=("--enable-win64")

          config_options+=("--disable-tests")
          config_options+=("--disable-win16")

          run_verbose bash ${DEBUG} "${XBB_SOURCES_FOLDER_PATH}/${wine_src_folder_name}/configure" \
            "${config_options[@]}"

          cp "config.log" "${XBB_LOGS_FOLDER_PATH}/${wine_folder_name}/config-log-64-$(ndate).txt"
        ) 2>&1 | tee "${XBB_LOGS_FOLDER_PATH}/${wine_folder_name}/configure-output-64-$(ndate).txt"
      fi

      (
        echo
        echo "Running wine64 make..."

        # Build.
        # run_verbose make -j ${XBB_JOBS} STRIP=true
        # dlltool seems to have a problem with parallel builds.
        # /home/ilg/Work/xpack-dev-tools/wine-xpack.git/build/linux-x64/xpacks/.bin/x86_64-w64-mingw32-dlltool: dlls/winmm/libwinmm.cross.a: error reading winmm_dll_h.o: file truncated
        local jobs=${XBB_APPLICATION_JOBS:-${XBB_JOBS}}
        run_verbose make -j ${jobs} STRIP=true

        # The install step must be done after wine 32.

        # wine: Unhandled page fault on read access to 0000000000000108 at address 000000038B5B4C00 (thread 0114), starting debugger...
        # run_verbose make test

      ) 2>&1 | tee "${XBB_LOGS_FOLDER_PATH}/${wine_folder_name}/make-output-64-$(ndate).txt"

      # -------------------------------------------------------------------------

      if [ "${XBB_WINE_SKIP_WIN32:-}" != "y" ]
      then
        (
          mkdir -pv "${XBB_BUILD_FOLDER_PATH}/${wine_folder_name}-32"
          cd "${XBB_BUILD_FOLDER_PATH}/${wine_folder_name}-32"

          if [ ! -f "config.status" ]
          then
            (
              xbb_show_env_develop

              echo
              echo "Running wine32 configure..."

              if is_development
              then
                run_verbose bash "${XBB_SOURCES_FOLDER_PATH}/${wine_src_folder_name}/configure" --help
              fi

              config_options=()

              config_options+=("--prefix=${XBB_EXECUTABLES_INSTALL_FOLDER_PATH}")

              config_options+=("--libdir=${XBB_EXECUTABLES_INSTALL_FOLDER_PATH}/lib32")
              config_options+=("--mandir=${XBB_LIBRARIES_INSTALL_FOLDER_PATH}/share/man")

              config_options+=("--build=${XBB_BUILD_TRIPLET}")
              config_options+=("--host=${XBB_HOST_TRIPLET}")
              config_options+=("--target=${XBB_TARGET_TRIPLET}")

              config_options+=("--with-mingw")
              config_options+=("--with-pthread")
              config_options+=("--with-unwind")

              wine_prepare_common_options

              config_options+=("--with-wine64=${XBB_BUILD_FOLDER_PATH}/${wine_folder_name}-64")

              config_options+=("--disable-tests")
              config_options+=("--disable-win16")

              run_verbose bash ${DEBUG} "${XBB_SOURCES_FOLDER_PATH}/${wine_src_folder_name}/configure" \
                "${config_options[@]}"

              cp "config.log" "${XBB_LOGS_FOLDER_PATH}/${wine_folder_name}/config-log-32-$(ndate).txt"
            ) 2>&1 | tee "${XBB_LOGS_FOLDER_PATH}/${wine_folder_name}/configure-output-32-$(ndate).txt"
          fi

          (
            echo
            echo "Running wine32 make..."

            # Build.
            # run_verbose make -j ${XBB_JOBS} STRIP=true
            # dlltool seems to have a problem with parallel builds.
            local jobs=${XBB_APPLICATION_JOBS:-${XBB_JOBS}}
            run_verbose make -j ${jobs} STRIP=true

            run_verbose make install

            i686-w64-mingw32-strip --strip-unneeded "${XBB_EXECUTABLES_INSTALL_FOLDER_PATH}"/lib32/wine/i386-windows/*.dll

            # wine: Unhandled page fault on read access to 0000000000000108 at address 000000038B5B4C00 (thread 0114), starting debugger...
            # run_verbose make test

          ) 2>&1 | tee "${XBB_LOGS_FOLDER_PATH}/${wine_folder_name}/make-output-32-$(ndate).txt"
        )
      fi

      # cd "${XBB_BUILD_FOLDER_PATH}/${wine_folder_name}-64"
      (
        echo
        echo "Running wine64 install..."

        run_verbose make install

        x86_64-w64-mingw32-strip --strip-unneeded "${XBB_EXECUTABLES_INSTALL_FOLDER_PATH}"/lib/wine/x86_64-windows/*.dll

      ) 2>&1 | tee "${XBB_LOGS_FOLDER_PATH}/${wine_folder_name}/make-install-output-64-$(ndate).txt"
    )

    hash -r

    mkdir -pv "${XBB_STAMPS_FOLDER_PATH}"
    touch "${wine_stamp_file_path}"

  else
    echo "Component wine already installed"
  fi

  tests_add "wine_test" "${XBB_EXECUTABLES_INSTALL_FOLDER_PATH}/bin"
}

function wine_test()
{
  local test_bin_path="$1"

  echo
  echo "Checking the wine64 shared libraries..."

  local wine64_realpath="$(realpath ${test_bin_path}/wine64)"

  show_host_libs "${wine64_realpath}"
  show_host_libs "$(realpath ${test_bin_path}/winebuild)"

  show_host_libs "$(realpath ${test_bin_path}/winegcc)"
  show_host_libs "$(realpath ${test_bin_path}/wineg++)"

  libwine=$(find "$(dirname ${wine64_realpath})"/../lib* -name 'libwine.so')
  if [ ! -z "${libwine}" ]
  then
    show_host_libs "$(realpath ${libwine})"
  fi

  echo
  echo "Checking the wine shared libraries..."

  local wine_realpath="$(realpath ${test_bin_path}/wine)"

  show_host_libs "${wine_realpath}"

  echo
  echo "Testing if wine64 binaries start properly..."

  # First check if the program is able to tell its version.
  run_host_app_verbose "${test_bin_path}/wine64" --version

  # Require gcc-xbs
  # run_host_app_verbose "${test_bin_path}/winegcc" --version
  # run_host_app_verbose "${test_bin_path}/wineg++" --version

  run_host_app_verbose "${test_bin_path}/winebuild" --version

  # When running in Docker with the home mounted, wine throws:
  # wine: '/github/home' is not owned by you, refusing to create a configuration directory there
  # To avoid it, create the .wine folder beforehand.
  run_verbose mkdir -p "${HOME}/.wine"

  # This is a script that tries to access the wine and win64
  # binaries, but wine fails on machines which do not support 32-bit.
  run_host_app_verbose "${test_bin_path}/winecfg" --version || true

  # This test should check if the program is able to start
  # a simple executable.
  # As a side effect, the "${HOME}/.wine" folder is created
  # and populated with lots of files., so subsequent runs
  # will no longer have to do it.
  local netstat_64="$(dirname ${wine64_realpath})/../lib/wine/x86_64-windows/netstat.exe"
  run_host_app_verbose "${test_bin_path}/wine64" ${netstat_64}

  local netstat_32="$(dirname ${wine64_realpath})/../lib32/wine/i386-windows/netstat.exe"
  run_host_app_verbose "${test_bin_path}/wine64" ${netstat_32} || true

  echo
  echo "Testing if wine binary starts properly..."

  # The `wine` executable is a 32-bit program; running it requires the 32-bit
  # libraries, not available on some systems, thus it is not enforced.
  run_host_app_verbose "${test_bin_path}/wine" --version || true
}

# -----------------------------------------------------------------------------
