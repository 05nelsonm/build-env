FROM 05nelsonm/build-env.base.darwin:latest

ARG GIT_HASH_CCTOOLS
ARG SDK_DIR
ARG SDK_PREFIX
ARG SDK_SHA256_OS
ARG SDK_SHA256_SIMULATOR
ARG VERSION_DARWIN
ARG VERSION_MIN
ARG VERSION_SDK

ENV VERSION_DARWIN=${VERSION_DARWIN} \
    VERSION_MIN=${VERSION_MIN} \
    VERSION_SDK=${VERSION_SDK}

RUN mkdir -p ${BUILD_ENV}/${SDK_DIR}/SDKs \
    && cd ${BUILD_ENV}/${SDK_DIR}/SDKs \
    && curl -O https://raw.githubusercontent.com/05nelsonm/build-env/sdk/${SDK_DIR}/${SDK_PREFIX}OS${VERSION_SDK}.sdk.tar.xz \
    && curl -O https://raw.githubusercontent.com/05nelsonm/build-env/sdk/${SDK_DIR}/${SDK_PREFIX}Simulator${VERSION_SDK}.sdk.tar.xz \
    && if [ "$(sha256sum ${SDK_PREFIX}OS${VERSION_SDK}.sdk.tar.xz | cut -d ' ' -f 1)" != "${SDK_SHA256_OS}" ]; then exit 1; fi \
    && if [ "$(sha256sum ${SDK_PREFIX}Simulator${VERSION_SDK}.sdk.tar.xz | cut -d ' ' -f 1)" != "${SDK_SHA256_SIMULATOR}" ]; then exit 1; fi \
    && xz -dc ${SDK_PREFIX}OS${VERSION_SDK}.sdk.tar.xz | tar xf - \
    && xz -dc ${SDK_PREFIX}Simulator${VERSION_SDK}.sdk.tar.xz | tar xf - \
    && rm -rf *.sdk.tar.xz \
    && chmod 755 *.sdk

RUN ARGS_1="aarch64|arm64|OS|arm" \
    ARGS_2="aarch64|arm64|Simulator|arm" \
    ARGS_3="x86_64|x86_64|Simulator|x86_64" \
    && for _args in $(echo "$ARGS_1,$ARGS_2,$ARGS_3" | tr "," " "); do                                  \
      _arch_container="$(echo ${_args} | cut -d '|' -f 1)";                                             \
      _cpu="$(echo ${_args} | cut -d '|' -f 2)";                                                        \
      _platform_suffix="$(echo ${_args} | cut -d '|' -f 3)";                                            \
      _cc_prefix="$(echo ${_args} | cut -d '|' -f 4)";                                                  \
#
      _platform="${SDK_PREFIX}${_platform_suffix}";                                                     \
      _platform_lc="$(echo ${_platform} | tr '[:upper:]' '[:lower:]')";                                 \
      _platform_uc="$(echo ${_platform_lc} | tr '[:lower:]' '[:upper:]')";                              \
#
      _cc_target="${_cc_prefix}-apple-darwin${VERSION_DARWIN}";                                         \
      _install_dir="${BUILD_ENV}/${SDK_DIR}/${_arch_container}-${_platform_lc}";                        \
#
      mkdir -p ${_install_dir}/bin;                                                                     \
#
      mkdir -p /build;                                                                                  \
      cd /build;                                                                                        \
      git clone https://github.com/tpoechtrager/cctools-port.git ;                                      \
      cd cctools-port;                                                                                  \
      git checkout ${GIT_HASH_CCTOOLS};                                                                 \
      cd usage_examples/ios_toolchain;                                                                  \
#
      # Fix up wrapper.c
      sed -i 's|env(\&sdk, "IOS_SDK_SYSROOT", sdkpath)|sdk = sdkpath|' wrapper.c;                       \
      sed -i 's|env(\&cpu, "IOS_TARGET_CPU", TARGET_CPU)|cpu = TARGET_CPU|' wrapper.c;                  \
      sed -i "s|IPHONEOS_DEPLOYMENT_TARGET|${_platform_uc}_DEPLOYMENT_TARGET|" wrapper.c;               \
      sed -i "s|-miphoneos-version-min|-m${_platform_lc}-version-min|" wrapper.c;                       \
#
      cc -O2 -Wall -Wextra -pedantic wrapper.c \
        -DSDK_DIR=\"${_platform}${VERSION_SDK}.sdk\" \
        -DTARGET_CPU=\"${_cpu}\" \
        -DOS_VER_MIN=\"${VERSION_MIN}\" \
        -o "${_install_dir}/bin/${_cc_target}-wrapper";                                                 \
#
      cd ${_install_dir};                                                                               \
      # {cc_target}-wrapper expects SDK dir to be at ../SDK from its location
      ln -s ../SDKs SDK;                                                                                \
      # To make configuring environment variables easier
      ln -s ../SDKs/${_platform}${VERSION_SDK}.sdk .sdk;                                                \
#
      cd /build/cctools-port/cctools;                                                                   \
      ./configure \
        --target="${_cc_target}" \
        --prefix="${_install_dir}" \
        --with-libtapi="${BUILD_ENV}/darwin" \
        --with-libxar="${BUILD_ENV}/darwin" \
        --with-libdispatch="${BUILD_ENV}/darwin" \
        --with-libblocksruntime="${BUILD_ENV}/darwin" \
        --with-llvm-config="$(command -v llvm-config || exit 2)";                                       \
      make -j"$(nproc)";                                                                                \
      make install;                                                                                     \
#
      cd ${_install_dir}/bin;                                                                           \
      ln -s ${_cc_target}-lipo lipo;                                                                    \
#
      _archs="${_cc_prefix}";                                                                           \
      if [ "${_cc_prefix}" = "arm" ]; then                                                              \
        _archs="arm,arm64,aarch64";                                                                     \
#
        for _tool in $(ls | grep 'arm-apple-darwin'); do                                \
          if [ "${_tool}" = "${_cc_target}-wrapper" ]; then continue; fi;               \
          ln -s "${_tool}" "$(echo ${_tool} | sed 's+arm-+aarch64-+')";                 \
          ln -s "${_tool}" "$(echo ${_tool} | sed 's+arm-+arm64-+')";                   \
        done;                                                                                           \
      fi;                                                                                               \
      unset _tool;                                                                                      \
#
      for _arch in $(echo "${_archs}" | tr "," " "); do                                 \
        _a_target="${_arch}-apple-darwin${VERSION_DARWIN}";                             \
#
        ln -s "${_cc_target}-wrapper" "${_a_target}-clang";                             \
        ln -s "${_cc_target}-wrapper" "${_a_target}-clang++";                           \
#
        ln -s "${BUILD_ENV}/pkg-config-crosswrapper.sh" "${_a_target}-pkg-config";      \
        ln -s "$(command -v dsymutil || exit 3)" "${_a_target}-dsymutil";               \
        unset _a_target;                                                                \
      done;                                                                                             \
      unset _archs _arch;                                                                               \
#
      cd /build;                                                                                        \
      _path_before="${PATH}";                                                                           \
      export PATH="${_install_dir}/bin:${PATH}";                                                        \
      echo 'int main(){return 0;}' | ${_cc_target}-clang -xc -O2 -o test - 1>/dev/null || exit 9;       \
      export PATH="${_path_before}";                                                                    \
#
      unset _arch_container _cpu _platform _cc_prefix _platform _platform_lc _platform_uc;              \
      unset _cc_target _install_dir _path_before;                                                       \
#
      cd /;                                                                                             \
      rm -rf /build;                                                                                    \
    done
