FROM 05nelsonm/build-env.base:latest

ARG ANDROID_NDK_REVISION
ARG ANDROID_NDK_SHA256
ARG ANDROID_NDK_VERSION

ENV ANDROID_NDK_REVISION=${ANDROID_NDK_REVISION} \
    ANDROID_NDK_VERSION=${ANDROID_NDK_VERSION}

ENV ANDROID_NDK=${BUILD_ENV}/android-ndk-r${ANDROID_NDK_REVISION}
ENV ANDROID_NDK_HOME=${ANDROID_NDK} \
    ANDROID_NDK_ROOT=${ANDROID_NDK} \
    CROSS_ROOT=${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64

ENV CROSS_BIN=${CROSS_ROOT}/bin

# For pkg-config-crosswrapper.sh
ENV BUILD_ENV_SYSROOT=${CROSS_ROOT}/sysroot

ENV PATH=${CROSS_BIN}:${PATH}

RUN cd ${BUILD_ENV} \
    && curl -O https://dl.google.com/android/repository/android-ndk-r${ANDROID_NDK_REVISION}-linux.zip \
    && if [ "$(sha256sum android-ndk-r${ANDROID_NDK_REVISION}-linux.zip | cut -d ' ' -f 1)" != "${ANDROID_NDK_SHA256}" ]; then exit 1; fi \
    && unzip android-ndk-r${ANDROID_NDK_REVISION}-linux.zip \
    && rm -rf android-ndk-r${ANDROID_NDK_REVISION}-linux.zip

RUN for jversion in $(echo "java6,java8,java11,java17,java21" | tr "," " "); do \
      cd ${JNI_H}/${jversion}/include;                                          \
      ln -s linux/jni_md.h jni_md.h;                                            \
      if [ "$jversion" != "java6" ]; then continue; fi;                         \
      ln -s linux/jni.h jni.h;                                                  \
    done

COPY entrypoint_android.sh /var/opt

ENTRYPOINT ["/var/opt/entrypoint_android.sh"]
