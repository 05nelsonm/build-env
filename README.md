# build-env

A compilation of pre-built docker containers for cross compiling software. An 
older toolchain is utilized in order to support running on older operating systems. 
Currently is very bare bones, but gets the job done.

`05nelsonm/build-env.{target os}.{target arch}:{tag}`

e.g.
```sh
# Drop into a shell with current directory mounted to compile something for macOS aarch64

docker run \
  --rm \
  -u "$(id -u):$(id -g)" \
  -v ./:/work \
  -it 05nelsonm/build-env.macos.aarch64:0.1.0 \
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
   ```

 - Android images
   ```
   CROSS_TARGET         # CROSS_TRIPLE w/o the version suffix
   PATH_NDK             # location of the Android NDK
   PATH_PREBUILT        # location of the prebuilt toolchain
   ANDROID_NDK
   ANDROID_NDK_HOME
   ANDROID_NDK_ROOT
   VERSION_ANDROID      # the API version (21)
   ```

 - Macos images
   ```
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

By default, `android` containers are set to use API 21 but sym links are 
generated for all API versions on all tools. If you need a higher API, simply 
use

```
${CROSS_TARGET}{version}-{tool}

e.g. ${CROSS_TARGET}23-clang
```
