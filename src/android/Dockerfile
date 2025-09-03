FROM 05nelsonm/build-env.base.android:latest

ARG ANDROID_TARGET_API
ARG ANDROID_TARGET_API_AVAILABLE
ARG CROSS_TARGET

#
# Can be overridden which will automatically adjust environment variables:
#   - CROSS_TRIPLE
#   - AR
#   - AS
#   - CC
#   - CXX
#   - LD
#   - RANLIB
#   - STRIP
#
# e.g.
#
#  docker run \
#    --rm \
#    -e ANDROID_TARGET_API=24 \
#    -it 05nelsonm/build-env.android.x86_64:latest \
#    bash
#
# See src/android/base/entrypoint_android.sh
#
ENV ANDROID_TARGET_API=${ANDROID_TARGET_API}
ENV CROSS_TARGET=${CROSS_TARGET}

RUN cd ${CROSS_BIN} \
    && for api in $(echo ${ANDROID_TARGET_API_AVAILABLE} | tr "," " "); do                      \
      ln -s ${BUILD_ENV}/pkg-config-crosswrapper.sh ${CROSS_TARGET}${api}-pkg-config;           \
      ln -s dsymutil ${CROSS_TARGET}${api}-dsymutil;                                            \
      ln -s ld ${CROSS_TARGET}${api}-ld;                                                        \
      ln -s lld ${CROSS_TARGET}${api}-lld;                                                      \
      ln -s lldb ${CROSS_TARGET}${api}-lldb;                                                    \
      ln -s llvm-ar ${CROSS_TARGET}${api}-ar;                                                   \
      ln -s llvm-as ${CROSS_TARGET}${api}-as;                                                   \
      ln -s llvm-dwp ${CROSS_TARGET}${api}-dwp;                                                 \
      ln -s llvm-lipo ${CROSS_TARGET}${api}-lipo;                                               \
      ln -s llvm-ml ${CROSS_TARGET}${api}-ml;                                                   \
      ln -s llvm-nm ${CROSS_TARGET}${api}-nm;                                                   \
      ln -s llvm-objcopy ${CROSS_TARGET}${api}-objcopy;                                         \
      ln -s llvm-objdump ${CROSS_TARGET}${api}-objdump;                                         \
      ln -s llvm-ranlib ${CROSS_TARGET}${api}-ranlib;                                           \
      ln -s llvm-rc ${CROSS_TARGET}${api}-rc;                                                   \
      ln -s llvm-readelf ${CROSS_TARGET}${api}-readelf;                                         \
      ln -s llvm-readobj ${CROSS_TARGET}${api}-readobj;                                         \
      ln -s llvm-size ${CROSS_TARGET}${api}-size;                                               \
      ln -s llvm-strings ${CROSS_TARGET}${api}-strings;                                         \
      ln -s llvm-strip ${CROSS_TARGET}${api}-strip;                                             \
    done
