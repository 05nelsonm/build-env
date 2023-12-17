# CHANGELOG

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
