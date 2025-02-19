# build-env

[![badge-license]][url-license]
[![badge-latest-release]][url-latest-release]

A consortium of docker containers with pre-built tools for cross compiling software. 
An older toolchain is utilized in order to support running on older operating systems. 
Currently is very bare bones, but gets the job done.

`05nelsonm/build-env.{target os}.{target arch}:{tag}`

e.g.
```sh
# Drop into a shell with current directory mounted to compile something for Linux aarch64

docker run \
  --rm \
  -u "$(id -u):$(id -g)" \
  -v ./:/work \
  -it 05nelsonm/build-env.linux-libc.aarch64:0.3.0 \
  bash
```

### The following environment variables are available:

 - All images
   ```
   CROSS_BIN            # location of the compiler tools (on PATH)
   CROSS_TRIPLE         # the compiler name (e.g. i686-linux-android21)
   CC
   CXX
   AR
   AS
   LD
   RANLIB
   STRIP
   JNI_H                # location of jni.h and jni_md.h headers for various
                        # versions of java (currently 6,8,11,17,21)
                        # e.g. CFLAGS="-I${JNI_H}/java8/include"
   ```

 - Android images
   ```
   CROSS_TARGET         # CROSS_TRIPLE but w/o the version suffix
   PATH_NDK             # location of the Android NDK
   PATH_PREBUILT        # location of the Android NDK prebuilt toolchain
   ANDROID_NDK          # alias of PATH_NDK
   ANDROID_NDK_HOME     # alias of PATH_NDK
   ANDROID_NDK_ROOT     # alias of PATH_NDK
   VERSION_ANDROID      # the API version (current default is 21)
   VERSION_NDK          # e.g. 26.1.10909125
   REVISION_NDK         # e.g. 26b
   ```

 - Ios & Ios Simulator images
   ```
   CROSS_TARGET         # CROSS_TRIPLE but w/o the version suffix
   PATH_SDK             # location of iPhoneOS{version}.sdk
   PATH_IOSCROSS        # location of ioscross
   VERSION_DARWIN
   VERSION_SDK
   VERSION_MIN          # minimum ios version
   ```

 - Macos images
   ```
   CROSS_TARGET         # CROSS_TRIPLE but w/o the version suffix
   PATH_SDK             # location of MacOSX{version}.sdk
   PATH_OSXCROSS        # location of osxcross
   VERSION_DARWIN
   VERSION_SDK
   ```

 - Mingw images
   ```
   WIDL
   WINDMC
   WINDRES
   ```

### Notes

Use the provided environment variables whenever possible.

**Android:**

By default, `android` containers are set to use the minimum supported version 
of the Android NDK, but sym links are generated for all API versions on all 
tools. If you need a higher API, use the `CROSS_TARGET` environment variable.

```
${CROSS_TARGET}{desired-api}-{tool}

# e.g. ${CROSS_TARGET}23-clang
```

**Macos:**

The `macos-lts` containers utilize `MacOSX12.3.sdk` providing a minimum supported 
version of `10.9`. This will follow Apple's End Of Life schedule for `macOS` which can be 
found [HERE][url-macos-eol]. After about 1 year of EOL, the SDK will be bumped.

The `macos` containers utilize `MacOSX15.1.sdk` (currently) providing a minimum supported 
version of `10.13`. This will follow Kotlin Multiplatform's Xcode compatibility version 
which can be found [HERE][url-kotlin-compatibility].

[badge-latest-release]: https://img.shields.io/badge/latest--release-0.3.0-blue.svg?style=flat
[badge-license]: https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg?style=flat

[url-latest-release]: https://github.com/05nelsonm/build-env/releases/latest
[url-license]: https://www.apache.org/licenses/LICENSE-2.0
[url-kotlin-compatibility]: https://kotlinlang.org/docs/multiplatform-compatibility-guide.html#version-compatibility
[url-macos-eol]: https://endoflife.date/macos
