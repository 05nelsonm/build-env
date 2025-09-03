FROM 05nelsonm/build-env.base:latest

RUN apt-get install --no-install-recommends --yes \
      gcc-mingw-w64-base \
      mingw-w64-common \
      mingw-w64-tools \
    && apt-get clean autoclean --yes \
    && apt-get autoremove --yes

RUN for jversion in $(echo "java6,java8,java11,java17,java21" | tr "," " "); do	\
      cd ${JNI_H}/${jversion}/include;                                          \
      ln -s win32/jni_md.h jni_md.h;                                            \
      if [ "$jversion" != "java6" ]; then continue; fi;                         \
      ln -s win32/jni.h jni.h;                                                  \
    done
