# CHANGELOG

## Version 0.1.1 (2023-12-15)
 - Adds a `darwin.base` image layer which `macos.base` now inherits from
     - `darwin.base` is just the build of Apple's `llvm` to build other
       non-macos targets atop of (future).
 - Adds support for `powerpc64le` to `linux-libc` line
     - ID: `05nelsonm/build-env.linux-libc.ppc64le`

## Version 0.1.0 (2023-11-02)
 - Initial release
