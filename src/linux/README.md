# Linux Containers

The following images are available from docker hub:
- `05nelsonm/build-env.linux-libc.aarch64`
- `05nelsonm/build-env.linux-libc.armv7a`
- `05nelsonm/build-env.linux-libc.ppc64le`
- `05nelsonm/build-env.linux-libc.riscv64`
- `05nelsonm/build-env.linux-libc.x86`
- `05nelsonm/build-env.linux-libc.x86_64`

Compiler:
- `GCC`

### Environment Variables

The following are environment variables available to all `05nelsonm/build-env.linux-libc.{arch}` 
containers, in addition to those described in the [root README](../../README.md#environment-variables).

- `CPP`
    - `${CROSS_TRIPLE}-cpp`

### Toolchain Info

The toolchains for `Linux` are built using [crosstool-ng][url-crosstool].

- `-libc`:
    - `aarch64`:
        - Linux Kernel: `4.4`
        - BinUtils: `2.29`
        - GLibC: `2.23`
        - GCC: `8.5.0`
        - [crosstool.config](libc/aarch64/crosstool.config)
    - `armv7a`:
        - Linux Kernel: `4.4`
        - BinUtils: `2.43`
        - GLibC: `2.23`
        - GCC: `8.5.0`
            - arch: `armv7-a`
            - float-abi: `hard`
            - fpu: `neon`
        - [crosstool.config](libc/armv7a/crosstool.config)
    - `ppc64le`:
        - Linux Kernel: `4.4`
        - BinUtils: `2.43`
        - GLibC: `2.23`
        - GCC: `8.5.0`
        - [crosstool.config](libc/ppc64le/crosstool.config)
    - `riscv64`:
        - Linux Kernel: `5.0`
        - BinUtils: `2.39`
        - GLibC: `2.29`
        - GCC: `8.5.0`
        - [crosstool.config](libc/riscv64/crosstool.config)
    - `x86`:
        - Linux Kernel: `4.4`
        - BinUtils: `2.43`
        - GLibC: `2.23`
        - GCC: `8.5.0`
        - [crosstool.config](libc/x86/crosstool.config)
    - `x86_64`:
        - Linux Kernel: `4.4`
        - BinUtils: `2.43`
        - GLibC: `2.23`
        - GCC: `8.5.0`
        - [crosstool.config](libc/x86_64/crosstool.config)

### Dockerfiles

 - [base](../base/Dockerfile)
 - [linux](Dockerfile)

[url-crosstool]: https://github.com/crosstool-ng/crosstool-ng
