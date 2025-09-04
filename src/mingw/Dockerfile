FROM 05nelsonm/build-env.base.mingw:latest

ARG ARCH

RUN ARCH_PKG="$(echo $ARCH | tr '_' '-')" \
    && apt-get install --no-install-recommends --yes \
      binutils-mingw-w64-${ARCH_PKG} \
      g++-mingw-w64-${ARCH_PKG} \
      gcc-mingw-w64-${ARCH_PKG} \
    && apt-get clean autoclean --yes \
    && apt-get autoremove --yes

ENV CROSS_TRIPLE=${ARCH}-w64-mingw32 \
    CROSS_ROOT=/usr \
    CROSS_BIN=/usr/bin

ENV AR=${CROSS_BIN}/${CROSS_TRIPLE}-ar \
    AS=${CROSS_BIN}/${CROSS_TRIPLE}-as \
    CC=${CROSS_BIN}/${CROSS_TRIPLE}-gcc \
    CPP=${CROSS_BIN}/${CROSS_TRIPLE}-cpp \
    CXX=${CROSS_BIN}/${CROSS_TRIPLE}-g++ \
    LD=${CROSS_BIN}/${CROSS_TRIPLE}-ld \
    RANLIB=${CROSS_BIN}/${CROSS_TRIPLE}-ranlib \
    STRIP=${CROSS_BIN}/${CROSS_TRIPLE}-strip \
    WIDL=${CROSS_BIN}/${CROSS_TRIPLE}-widl \
    WINDMC=${CROSS_BIN}/${CROSS_TRIPLE}-windmc \
    WINDRES=${CROSS_BIN}/${CROSS_TRIPLE}-windres
