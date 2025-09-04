# build-env

[![badge-license]][url-license]
[![badge-latest-release]][url-latest-release]

Docker containers with pre-built cross-compiler toolchains.

`05nelsonm/build-env.{platform}.{arch}:{tag}`

e.g.
```sh
docker run \
  --rm \
  -u "$(id -u):$(id -g)" \
  -v ./:/work \
  -it 05nelsonm/build-env.linux-libc.aarch64:0.4.0 \
  bash
```

### Environment Variables

The following environment variables are available for all containers.

- `BUILD_ENV`
    - The root directory where all things not provided by package manager are installed.
- `JNI_H`
    - The root directory where `jni.h` headers are installed.
    - Versions:
        - `java6`
        - `java8`
        - `java11`
        - `java17`
        - `java21`
    - e.g. `CFLAGS+=" -I${JNI_H}/java6/include"`
- `CROSS_ROOT`
    - The root directory where the cross-compiler toolchain is installed.
- `CROSS_BIN`
    - The directory where the cross-compiler programs are installed.
    - Is always on `PATH`
- `CROSS_TRIPLE`
    - e.g. `aarch64-unknown-linux-gnu`
    - e.g. `aarch64-linux-android21`
    - e.g. `aarch64-apple-darwin24.4`
    - e.g. `x86_64-w64-mingw32`
- `AR`
    - `${CROSS_TRIPLE}-ar`
- `AS`
    - `${CROSS_TRIPLE}-as`
- `CC`
    - `${CROSS_TRIPLE}-{clang/gcc}`
    - e.g. `aarch64-unknown-linux-gnu-gcc`
    - e.g. `aarch64-linux-android21-clang`
    - e.g. `aarch64-apple-darwin24.4-clang`
    - e.g. `x86_64-w64-mingw32-gcc`
- `CXX`
    - `${CROSS_TRIPLE}-{clang++/gcc++}`
    - e.g. `aarch64-unknown-linux-gnu-g++`
    - e.g. `aarch64-linux-android21-clang++`
    - e.g. `aarch64-apple-darwin24.4-clang++`
    - e.g. `x86_64-w64-mingw32-gcc++`
- `LD`
    - `${CROSS_TRIPLE}-ld`
- `RANLIB`
    - `${CROSS_TRIPLE}-ranlib`
- `STRIP`
    - `${CROSS_TRIPLE}-strip`

Additional platform specific environment variables are provided. See:
- [Android](src/android/README.md)
- [iOS](src/ios/README.md)
- [Linux](src/linux/README.md)
- [macOS](src/macos/README.md)
- [MinGW](src/mingw/README.md)

### pkg-config

All containers have a proper `${CROSS_TRIPLE}-pkg-config` available to ensure 
only `.pc` files from the toolchain are referenced, and not those from the system.

### WORKDIR

The `WORKDIR` is `/work`

[badge-latest-release]: https://img.shields.io/badge/latest--release-0.3.0-blue.svg?style=flat
[badge-license]: https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg?style=flat

[url-latest-release]: https://github.com/05nelsonm/build-env/releases/latest
[url-license]: https://www.apache.org/licenses/LICENSE-2.0
