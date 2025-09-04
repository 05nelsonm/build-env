# Android Containers

The following images are available from docker hub:
- `05nelsonm/build-env.android.aarch64`
- `05nelsonm/build-env.android.armv7a`
- `05nelsonm/build-env.android.x86`
- `05nelsonm/build-env.android.x86_64`

Compiler:
- `LLVM/Clang`

### Environment Variables

The following are environment variables available to all `05nelsonm/build-env.android.{arch}` 
containers, in addition to those described in the [root README](../../README.md#environment-variables).

- `ANDROID_TARGET_API`:
    - `aarch64`:
        - Default: `21`
        - Available: `21` to `35`
    - `armv7a`:
        - Default: `21`
        - Available: `21` to `35`
    - `x86`:
        - Default: `21`
        - Available: `21` to `35`
    - `x86_64`:
        - Default: `21`
        - Available: `21` to `35`
    - The Android API to compile for. This can be modified by passing argument 
      `-e ANDROID_TARGET_API={api}` with `docker run`. Doing so will automatically 
      update downstream environment variables, such as `CROSS_TRIPLE`, `CC`, `CXX`, etc.
- `CROSS_TARGET`:
    - The triple, without `ANDROID_TARGET_API` appended.
    - `aarch64`: `aarch64-linux-android`
    - `armv7a`: `armv7a-linux-androideabi`
    - `x86`: `i686-linux-android`
    - `x86_64`: `x86_64-linux-android`
- `ANDROID_NDK_REVISION`:
    - e.g. `28c`
- `ANDROID_NDK_VERSION`:
    - e.g. `28.2.13676358`
- `ANDROID_NDK`:
    - The directory where the android `NDK` is installed.
- `ANDROID_NDK_HOME`:
    - An alias for `ANDROID_NDK`
- `ANDROID_NDK_ROOT`:
    - An alias for `ANDROID_NDK`

### Toolchain Info

The toolchains for `Android` are provided by [Android NDK][url-android-ndk].

### Dockerfiles

 - [base](../base/Dockerfile)
 - [base.android](../base/android/Dockerfile)
 - [android](Dockerfile)

### Notable History

Prior to `0.4.0`, the following environment variables were available. They have since changed or 
have been removed.

- `PATH_NDK`
    - Removed. Replace with `ANDROID_NDK`
- `PATH_PREBUILT`
    - Removed. Replace with `CROSS_ROOT`
- `VERSION_ANDROID`
    - Removed. Replace with `ANDROID_TARGET_API`
- `VERSION_NDK`
    - Removed. Replace with `ANDROID_NDK_VERSION`
- `REVISION_NDK`
    - Removed. Replace with `ANDROID_NDK_REVISION`
- `SUPPORTED_APIS`
    - Removed.

[url-android-ndk]: https://github.com/android/ndk/wiki
