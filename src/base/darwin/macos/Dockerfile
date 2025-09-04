FROM 05nelsonm/build-env.base.darwin:latest

ARG GIT_HASH_OSXCROSS
ARG SDK_SHA256
ARG SDK_TAR_COMPRESSION
ARG VERSION_DARWIN
ARG VERSION_MIN
ARG VERSION_SDK

ENV CROSS_ROOT=${BUILD_ENV}/macos
ENV CROSS_BIN=${CROSS_ROOT}/bin \
    PATH_SDK=${CROSS_ROOT}/SDK/MacOSX${VERSION_SDK}.sdk \
    VERSION_DARWIN=${VERSION_DARWIN} \
    VERSION_MIN=${VERSION_MIN} \
    VERSION_SDK=${VERSION_SDK}

#
# This is such that osxcross-macports works out of the box using the
# min sdk version. Modify it via docker run -e MACOSX_DEPLOYMENT_TARGET=...
#
# See: https://github.com/tpoechtrager/osxcross/blob/master/README.MACPORTS.md
#
ENV MACOSX_DEPLOYMENT_TARGET=${VERSION_MIN}

ENV OSXCROSS_ENABLE_WERROR_IMPLICIT_FUNCTION_DECLARATION=1

# For pkg-config-crosswrapper.sh
ENV BUILD_ENV_SYSROOT=${CROSS_ROOT}/macports/pkgs

ENV PATH=${CROSS_BIN}:${PATH}

RUN mkdir -p /build \
    && cd /build \
    && git clone https://github.com/tpoechtrager/osxcross.git \
    && cd osxcross \
    && git checkout ${GIT_HASH_OSXCROSS} \
    && cd tarballs \
    && curl -O https://raw.githubusercontent.com/05nelsonm/build-env/sdk/macos/MacOSX${VERSION_SDK}.sdk.tar.${SDK_TAR_COMPRESSION} \
    && if [ "$(sha256sum MacOSX${VERSION_SDK}.sdk.tar.${SDK_TAR_COMPRESSION} | cut -d ' ' -f 1)" != "${SDK_SHA256}" ]; then exit 1; fi \
    && cd .. \
    && sed -i 's+build_xar+# build_xar+' build.sh \
    && sed -i 's+\"--with-libxar=\$TARGET_DIR \"+"--with-libxar=${BUILD_ENV}/darwin "+' build.sh \
    && sed -i 's+get_sources https://github.com/tpoechtrager/apple-libtapi.git 1300.6.5+f_res=0+' build.sh \
    && sed -i 's+\"--with-libtapi=\$TARGET_DIR \"+"--with-libtapi=${BUILD_ENV}/darwin "+' build.sh \
    && TARGET_DIR=${CROSS_ROOT} \
      UNATTENDED=1 \
      ./build.sh \
    && cd / \
    && rm -rf /build

# Replace osxcross's pkg-config wrappers with pkg-config-crosswrapper.sh
RUN cd ${BUILD_ENV} \
    && sed -i "s|/usr/lib/pkgconfig:\${BUILD_ENV_SYSROOT}/usr/share/pkgconfig|/opt/local/lib/pkgconfig|" \
      pkg-config-crosswrapper.sh \
    && cd ${CROSS_BIN} \
    && for target in $(ls | grep "$VERSION_DARWIN-pkg-config"); do      \
      rm $target;                                                       \
      ln -s ${BUILD_ENV}/pkg-config-crosswrapper.sh $target;            \
    done

# Ensure osxcross-macports works for non-root users whenever argument
# -u "$(id -u):$(id -g)" is used with docker run.
RUN mkdir -p -m 777 ${CROSS_ROOT}/macports
