# macOS Containers

The following images are available from docker hub:
- `05nelsonm/build-env.macos.aarch64`
- `05nelsonm/build-env.macos.x86_64`
- `05nelsonm/build-env.macos-lts.aarch64`
- `05nelsonm/build-env.macos-lts.x86_64`

Compiler:
- `LLVM/Clang`

### Environment Variables

The following are environment variables available to all `05nelsonm/build-env.macos{-lts}.{arch}` 
containers, in addition to those described in the [root README](../../README.md#environment-variables).

- `VERSION_DARWIN`
    - The darwin version which the toolchain is based off of.
    - Is the suffix appended to the end of `CROSS_TRIPLE`
        - e.g. `aarch64-apple-darwin24.4`
- `VERSION_MIN`
    - The minimum deployment version.
    - e.g. `10.13`
- `VERSION_SDK`
    - The `.sdk` version.
    - e.g. `15.4`
- `CROSS_TARGET`:
    - The triple, without `VERSION_DARWIN` appended.
    - `aarch64`: `aarch64-apple-darwin`
    - `x86_64`: `x86_64-apple-darwin`
- `PATH_SDK`
    - The path to the `MacOSX{VERSION_SDK}.sdk` directory.

### Toolchain Info

The toolchains for `macOS` are built using [osxcross][url-osxcross].

- Environment variables:
    - `MACOSX_DEPLOYMENT_TARGET`
        - Default: `VERSION_MIN`
        - Overrides:
            - Value used for flag `-mmacos-version-min`
                - Note that `VERSION_MIN` was what was used to compile the toolchain
                  with and is used if `MACOSX_DEPLOYMENT_TARGET` is unset.
            - `osxcross-macports` usage
                - See: [osxcross#MACPORTS][url-osxcross-macports]
        - Change via:
            - docker argument: `-e MACOSX_DEPLOYMENT_TARGET={new min version}`
            - shell: `export MACOSX_DEPLOYMENT_TARGET={new min version}`
        - See: [osxcross#DeploymentTarget][url-osxcross-deployment-target]
    - `OSXCROSS_ENABLE_WERROR_IMPLICIT_FUNCTION_DECLARATION`
        - Default: `1` (enabled)
        - Enables/disables `-Werror=implicit-function-declaration`
        - Disable via:
            - docker argument: `-e OSXCROSS_ENABLE_WERROR_IMPLICIT_FUNCTION_DECLARATION=0`
            - shell: `export OSXCROSS_ENABLE_WERROR_IMPLICIT_FUNCTION_DECLARATION=0`
- LTS/non-LTS containers:
    - `macos-lts`
        - Built using `MacOSX` sdk version `12.3`
            - Darwin version `21.4`
            - Minimum deployment version `10.9`
    - `macos`
        - Follows [Kotlin Multiplatform Compatibility][url-kotlin-compat].
        - `0.4.0` is built using `MacOSX` sdk version `15.4`
            - Darwin version `24.4`
            - Minimum deployment version `10.13`
        - `0.3.0` is built using `MacOSX` sdk version `15.1`
            - Darwin version `24.1`
            - Minimum deployment version `10.13`

### Dockerfiles

 - [base](../base/Dockerfile)
 - [base.darwin](../base/darwin/Dockerfile)
 - [base.macos](../base/darwin/macos/Dockerfile)
 - [macos](Dockerfile)

### Notable History

Prior to `0.4.0`, the following environment variables were available. They have since changed or
have been removed.

- `PATH_OSXCROSS`
    - Removed. Replace with `${BUILD_ENV}/macos`
- `PATH_DARWINCROSS`
    - Removed. Replace with `${BUILD_ENV}/darwin`

[url-osxcross]: https://github.com/tpoechtrager/osxcross
[url-osxcross-deployment-target]: https://github.com/tpoechtrager/osxcross#deployment-target
[url-osxcross-macports]: https://github.com/tpoechtrager/osxcross/blob/master/README.MACPORTS.md
[url-kotlin-compat]: https://www.jetbrains.com/help/kotlin-multiplatform-dev/multiplatform-compatibility-guide.html#version-compatibility
