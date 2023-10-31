# build-env

A compilation of pre-built docker containers for cross compiling software against an 
older toolchain to support running on older operating systems. Currently is
very bare bones, but gets the job done.

`05nelsonm/build-env.{target os}.{target arch}`

e.g.
```sh
# Drop into a shell with current directory mounted to compile something for macOS aarch64
docker run --rm -u "$(id -u):$(id -g)" -v ./:/work -it 05nelsonm/build-env.macos.aarch64 bash
```
