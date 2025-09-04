# iOS Containers

The following images are available from docker hub:
- `05nelsonm/build-env.ios.aarch64`
- `05nelsonm/build-env.ios-simulator.aarch64`
- `05nelsonm/build-env.ios-simulator.x86_64`

Compiler:
- `LLVM/Clang`

### Environment Variables

The following are environment variables available to all `05nelsonm/build-env.ios{-simulator}.{arch}` 
containers, in addition to those described in the [root README](../../README.md#environment-variables).

- `VERSION_DARWIN`
    - The darwin version which the toolchain is based off of.
    - Is the suffix appended to the end of `CROSS_TRIPLE`
        - e.g. `aarch64-apple-darwin24.4`
- `VERSION_MIN`
    - The minimum deployment version.
    - e.g. `12.0`
- `VERSION_SDK`
    - The `.sdk` version.
    - e.g. `18.4`
- `CROSS_TARGET`:
    - The triple, without `VERSION_DARWIN` appended.
    - `aarch64`: `aarch64-apple-darwin`
    - Simulators:
        - `aarch64`: `aarch64-apple-darwin`
        - `x86_64`: `x86_64-apple-darwin`
- `PATH_SDK`
    - The path to the `iPhone{OS/Simulator}{VERSION_SDK}.sdk` directory.

### Toolchain Info

The toolchains for `iOS` are built using [cctools-port][url-cctools].

- Environment variables:
    - `IPHONEOS_DEPLOYMENT_TARGET`
        - Default: unset
        - Overrides:
            - Value used for flag `-miphoneos-version-min`
                - Note that `VERSION_MIN` was what was used to compile the toolchain 
                  with and is used in the absence of `IPHONEOS_DEPLOYMENT_TARGET`.
        - Change via:
            - docker argument `-e IPHONEOS_DEPLOYMENT_TARGET={new min version}`
            - shell: `export IPHONEOS_DEPLOYMENT_TARGET={new min version}`
    - `IPHONESIMULATOR_DEPLOYMENT_TARGET`
        - Default: unset
        - Overrides:
            - Value used for flag `-miphonesimulator-version-min`
                - Note that `VERSION_MIN` was what was used to compile the toolchain 
                  with and is used in the absence of `IPHONESIMULATOR_DEPLOYMENT_TARGET`.
        - Change via:
            - docker argument `-e IPHONESIMULATOR_DEPLOYMENT_TARGET={new min version}`
            - shell: `export IPHONESIMULATOR_DEPLOYMENT_TARGET={new min version}`

### Dockerfiles

 - [base](../base/Dockerfile)
 - [base.darwin](../base/darwin/Dockerfile)
 - [base.ios](../base/darwin/cctools/Dockerfile)
 - [ios](Dockerfile)

### Notable History

Prior to `0.4.0`, the following environment variables were available. They have since changed or
have been removed.

- `PATH_IOSCROSS`
    - Removed. Replace with `${BUILD_ENV}/ios`
- `PATH_DARWINCROSS`
    - Removed. Replace with `${BUILD_ENV}/darwin`
- `IOS_SDK_SYSROOT`
    - Removed. Replace with `PATH_SDK`
- `IOS_SIMULATOR_SDK_SYSROOT`
    - Removed. Replace with `PATH_SDK`

[url-cctools]: https://github.com/tpoechtrager/cctools-port
