# CHANGELOG

## Version 0.3.0 (2025-02-19)
 - `non-linux.base` now utilizes `ubuntu:24.04` [[#25]][25]
 - `macos.base`, `macos.aarch64`, and `macos.x86_64` now use
   `MacOSX15.1.sdk` [[#24]][24]
 - `android.base` now utilizes NDK revision `28` [[#27]][27]
 - Adds support for `ios.aarch64`, `ios-simulator.aarch64`, and `ios-simulator.x86_64` [[#26]][26]

## Version 0.2.0 (2024-10-11)
 - Adds `non-linux.base` image for all non-`linux-libc` images [[#18]][18]
     - Based off of `ubuntu:22.04`
 - Migrates all non-`linux-libc` images to inherit from `non-linux.base` [[#18]][18]
 - Adds `JNI` headers to all images at `${JNI_H}/{java-version}/include` [[#20]][20]
     - e.g. `export CFLAGS="-I${JNI_H}/java8/include"`

## Version 0.1.3 (2023-12-19)
 - `darwin.base` now utilizes `ubuntu:20.04` as base image [[#14]][14]
 - `darwin.base` bumped `apple-llvm` to 17 [[#14]][14]
 - `darwin.base` now includes some common tools utilized by `macos`, 
   `macos-lts`, and future images for `ios`, `tvos` and `watchos` [[#14]][14]

## Version 0.1.2 (2023-12-16)
 - `macos.base`, `macos.aarch64`, and `macos.x86_64` were migrated to 
   `macos-lts.base`, `macos-lts.aarch64`, and `macos-lts.x86_64` [[#12]][12]
     - Still uses `MacOSX12.3.sdk`
 - `macos.base`, `macos.aarch64`, and `macos.x86_64` now use 
   `MacOSX14.0.sdk` [[#12]][12]

## Version 0.1.1 (2023-12-15)
 - Adds a `darwin.base` image layer which `macos.base` now inherits from [[#7]][7]
     - `darwin.base` is just the build of Apple's `llvm` to build other
       non-macos targets atop of (future).
 - Adds support for `powerpc64le` to `linux-libc` line [[#10]][10]
     - ID: `05nelsonm/build-env.linux-libc.ppc64le`

## Version 0.1.0 (2023-11-02)
 - Initial release

[7]: https://github.com/05nelsonm/build-env/pull/7
[10]: https://github.com/05nelsonm/build-env/pull/10
[12]: https://github.com/05nelsonm/build-env/pull/12
[14]: https://github.com/05nelsonm/build-env/pull/14
[18]: https://github.com/05nelsonm/build-env/pull/18
[20]: https://github.com/05nelsonm/build-env/pull/20
[24]: https://github.com/05nelsonm/build-env/pull/24
[25]: https://github.com/05nelsonm/build-env/pull/25
[26]: https://github.com/05nelsonm/build-env/pull/26
[27]: https://github.com/05nelsonm/build-env/pull/27
