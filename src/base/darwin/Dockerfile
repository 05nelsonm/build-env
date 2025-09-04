FROM 05nelsonm/build-env.base:latest

ARG GIT_HASH_LDID
ARG GIT_HASH_LIBDISPATCH
ARG GIT_HASH_XAR
ARG GIT_HASH_LIBTAPI

RUN apt-get install --no-install-recommends --yes \
      # LLVM/Clang
      binfmt-support \
      clang-19 \
      libclang-rt-19-dev \
      libgpm2 \
      llvm-19-dev \
      # osxcross
      libbz2-dev \
      liblzma-dev \
      libssl-dev \
      libxml2-dev \
      uuid-dev \
      zlib1g-dev \
    && apt-get clean autoclean --yes \
    && apt-get autoremove --yes

ENV PATH=${BUILD_ENV}/darwin/bin:${PATH}:/usr/lib/llvm-19/bin

RUN mkdir -p /build \
    && cd /build \
    && git clone https://github.com/tpoechtrager/ldid.git \
    && cd ldid \
    && git checkout ${GIT_HASH_LDID} \
    && make INSTALLPREFIX=${BUILD_ENV}/darwin -j"$(nproc)" install \
    && cd / \
    && rm -rf /build

RUN mkdir -p /build \
    && cd /build \
    && git clone https://github.com/tpoechtrager/apple-libdispatch.git \
    && cd apple-libdispatch \
    && git checkout ${GIT_HASH_LIBDISPATCH} \
    && mkdir -p build \
    && cd build \
    && CC=clang \
      CXX=clang++ \
      cmake .. -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=${BUILD_ENV}/darwin \
    && make install -j"$(nproc)" \
    && cd / \
    && rm -rf /build

RUN mkdir -p /build \
    && cd /build \
    && git clone https://github.com/tpoechtrager/xar.git \
    && cd xar \
    && git checkout ${GIT_HASH_XAR} \
    && cd xar \
    && CFLAGS="-w" \
    && ./configure --prefix=${BUILD_ENV}/darwin \
    && make -j"$(nproc)" \
    && make install -j"$(nproc)" \
    && cd / \
    && rm -rf /build

RUN mkdir -p /build \
    && cd /build \
    && git clone https://github.com/tpoechtrager/apple-libtapi.git \
    && cd apple-libtapi \
    && git checkout ${GIT_HASH_LIBTAPI} \
    && INSTALLPREFIX=${BUILD_ENV}/darwin ./build.sh \
    && ./install.sh \
    && cd / \
    && rm -rf /build

RUN for jversion in $(echo "java6,java8,java11,java17,java21" | tr "," " "); do     \
      cd ${JNI_H}/${jversion}/include;                                              \
      ln -s darwin/jni_md.h jni_md.h;                                               \
      if [ "$jversion" != "java6" ]; then continue; fi;                             \
      ln -s darwin/jni.h jni.h;                                                     \
    done
