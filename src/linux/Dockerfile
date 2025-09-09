FROM 05nelsonm/build-env.staging.crosstool:latest AS stage0

ARG CROSS_TRIPLE
COPY crosstool.config /work/.config
COPY patches /work/patches

ENV HOME=/work

RUN cd /work \
    && unset LD_LIBRARY_PATH \
    && ct-ng build || (tail -250 build.log && exit 1)

RUN cd /work/x-tools/${CROSS_TRIPLE} \
    && rm build.log.bz2 \
    && rm share/${CROSS_TRIPLE}-ct-ng.config.bz2

FROM 05nelsonm/build-env.base:latest

ARG CROSS_TRIPLE
ENV CROSS_TRIPLE=${CROSS_TRIPLE}
ENV CROSS_ROOT=${BUILD_ENV}/${CROSS_TRIPLE}
ENV CROSS_BIN=${CROSS_ROOT}/bin

# For pkg-config-crosswrapper.sh
ENV BUILD_ENV_SYSROOT=${CROSS_ROOT}/${CROSS_TRIPLE}/sysroot

ENV PATH=${CROSS_BIN}:${PATH}

ENV AR=${CROSS_BIN}/${CROSS_TRIPLE}-ar \
    AS=${CROSS_BIN}/${CROSS_TRIPLE}-as \
    CC=${CROSS_BIN}/${CROSS_TRIPLE}-gcc \
    CPP=${CROSS_BIN}/${CROSS_TRIPLE}-cpp \
    CXX=${CROSS_BIN}/${CROSS_TRIPLE}-g++ \
    LD=${CROSS_BIN}/${CROSS_TRIPLE}-ld \
    RANLIB=${CROSS_BIN}/${CROSS_TRIPLE}-ranlib \
    STRIP=${CROSS_BIN}/${CROSS_TRIPLE}-strip

COPY --from=stage0 /work/x-tools/${CROSS_TRIPLE} ${CROSS_ROOT}

RUN cd ${CROSS_BIN} \
    && ln -s ${BUILD_ENV}/pkg-config-crosswrapper.sh ${CROSS_TRIPLE}-pkg-config         \
    && for jversion in $(echo "java6,java8,java11,java17,java21" | tr "," " "); do      \
      cd ${JNI_H}/${jversion}/include;                                                  \
      ln -s linux/jni_md.h jni_md.h;                                                    \
      if [ "$jversion" != "java6" ]; then continue; fi;                                 \
      ln -s linux/jni.h jni.h;                                                          \
    done
