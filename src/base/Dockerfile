FROM debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update --yes \
    && apt-get install --no-install-recommends --yes \
      autogen \
      automake \
      autopoint \
      bison \
      build-essential \
      ca-certificates \
      cmake \
      curl \
      flex \
      gawk \
      gettext \
      git \
      jq \
      libtool \
      libncurses5 \
      make \
      nano \
      patch \
      perl \
      pkg-config \
      python3 \
      rsync \
      unzip \
      wget \
      zip \
    && apt-get clean autoclean --yes \
    && apt-get autoremove --yes \
    && rm -rf /etc/ssh/*key*

#
# Where all things get installed (except entrypoint_*.sh scripts)
#
ENV BUILD_ENV=/usr/local/build-env

#
# For compiling JNI code:
#  - java6
#  - java8
#  - java11
#  - java17
#  - java21
#
# e.g.
#
#   CFLAGS+=" -I${JNI_H}/java6/include"
#
ENV JNI_H=${BUILD_ENV}/jni

# Symlinks for jni_md.h are created in final containers for darwin/linux/win32
RUN mkdir -p ${JNI_H} \
    && cd ${JNI_H} \
    && for jversion in $(echo "java6,java8,java11,java17,java21" | tr "," " "); do                                              \
      curl -O https://raw.githubusercontent.com/05nelsonm/build-env/sdk/jni/${jversion}.tar.gz ;                                \
      if [ "${jversion}" = "java6" ]; then SHA256_JNI="bad72b7e9aefcc3e592fee59034a8754782b26087e6c3620f717d1a63338e676"; fi;   \
      if [ "${jversion}" = "java8" ]; then SHA256_JNI="697684bbc35ee9732286c7fd8874a9a5758ba7d0ba9a7ddfc462b73cc552de2b"; fi;   \
      if [ "${jversion}" = "java11" ]; then SHA256_JNI="670d2a0f34e28c20463a8095803eb44ed254904cb1502c11078a89b416bbfbe6"; fi;  \
      if [ "${jversion}" = "java17" ]; then SHA256_JNI="e79c202f3fb5975fc0cbe46e8bd59abbba8a99c6f60642de825b12d8c4f9ab58"; fi;  \
      if [ "${jversion}" = "java21" ]; then SHA256_JNI="11e6f2865514f670cbf25e80c901882280185580242a55417591439763e0d212"; fi;  \
      if [ "$(sha256sum ${jversion}.tar.gz | cut -d ' ' -f 1)" != "${SHA256_JNI}" ]; then exit 1; fi;                           \
      tar xzf ${jversion}.tar.gz;                                                                                               \
      rm -f ${jversion}.tar.gz;                                                                                                 \
    done

COPY pkg-config-crosswrapper.sh ${BUILD_ENV}

RUN cd ${BUILD_ENV} \
    && chmod 555 pkg-config-crosswrapper.sh

COPY entrypoint_base.sh /var/opt

WORKDIR /work

ENTRYPOINT ["/var/opt/entrypoint_base.sh"]
