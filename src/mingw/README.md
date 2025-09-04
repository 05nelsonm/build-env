# MinGW Containers

The following images are available from docker hub:
- `05nelsonm/build-env.mingw.x86`
- `05nelsonm/build-env.mingw.x86_64`

Compiler:
- `GCC`

### Environment Variables

The following are environment variables available to all `05nelsonm/build-env.mingw.{arch}` 
containers, in addition to those described in the [root README](../../README.md#environment-variables).

- `CPP`
    - `${CROSS_TRIPLE}-cpp`
- `WIDL`
    - `${CROSS_TRIPLE}-widl`
- `WINDMC`
    - `${CROSS_TRIPLE}-windmc`
- `WINDRES`
    - `${CROSS_TRIPLE}-windres`

### Toolchain Info

The toolchains for `MinGW` are provided by the debian package manager.

### Dockerfiles

 - [base](../base/Dockerfile)
 - [base.mingw](../base/mingw/Dockerfile)
 - [mingw](Dockerfile)
