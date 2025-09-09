#!/usr/bin/env bash
# Copyright (c) 2023 Matthew Nelson
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
export LC_ALL=C
set -e

readonly DIR_TASK=$( cd "$( dirname "$0" )" >/dev/null && pwd )
readonly FILE_BUILD_LOCK="$DIR_TASK/build/.lock"
readonly ORG="05nelsonm/build-env"

# Programs
readonly DOCKER=$(which docker)
readonly GIT=$(which git)

function build:all { ## Builds all containers
  build:all:android
  build:all:ios
  build:all:linux-libc
  build:all:linux-musl
  build:all:mingw
  build:all:macos
}

function build:all:android { ## Builds all Android containers
  build:android:aarch64
  build:android:armv7a
  build:android:x86
  build:android:x86_64
}

function build:all:ios { ## Builds all iOS containers
  build:ios-simulator:aarch64
  build:ios-simulator:x86_64
  build:ios:aarch64
}

function build:all:linux-libc { ## Builds all Linux Libc containers
  build:linux-libc:aarch64
  build:linux-libc:armv7a
  build:linux-libc:ppc64le
  build:linux-libc:riscv64
  build:linux-libc:x86
  build:linux-libc:x86_64
}

function build:all:linux-musl { ## Builds all Linux Musl containers
  build:linux-musl:aarch64
  build:linux-musl:x86
  build:linux-musl:x86_64
}

function build:all:macos { ## Builds all macOS containers
  build:macos-lts:aarch64
  build:macos-lts:x86_64
  build:macos:aarch64
  build:macos:x86_64
}

function build:all:mingw { ## Builds all MinGW containers
  build:mingw:x86
  build:mingw:x86_64
}

function build:android:aarch64 { ## Builds Android arm64-v8a
  local os_name="android"
  local os_arch="aarch64"
  local build_args="CROSS_TARGET=aarch64-linux-android"
  __exec:docker:assemble
}

function build:android:armv7a { ## Builds Android armeabi-v7a
  local os_name="android"
  local os_arch="armv7a"
  local build_args="CROSS_TARGET=armv7a-linux-androideabi"
  __exec:docker:assemble
}

function build:android:x86 { ## Builds Android i686
  local os_name="android"
  local os_arch="x86"
  local build_args="CROSS_TARGET=i686-linux-android"
  __exec:docker:assemble
}

function build:android:x86_64 { ## Builds Android x86_64
  local os_name="android"
  local os_arch="x86_64"
  local build_args="CROSS_TARGET=x86_64-linux-android"
  __exec:docker:assemble
}

function build:ios-simulator:aarch64 { ## Builds iOS Simulator aarch64
  local os_name="ios"
  local os_subtype="simulator"
  local os_arch="aarch64"
  local build_args="PLATFORM=iphonesimulator"
  __exec:docker:assemble
}

function build:ios-simulator:x86_64 { ## Builds iOS Simulator x86_64
  local os_name="ios"
  local os_subtype="simulator"
  local os_arch="x86_64"
  local build_args="PLATFORM=iphonesimulator"
  __exec:docker:assemble
}

function build:ios:aarch64 { ## Builds iOS           aarch64
  local os_name="ios"
  local os_arch="aarch64"
  local build_args="PLATFORM=iphoneos"
  __exec:docker:assemble
}

function build:linux-libc:aarch64 { ## Builds Linux Libc aarch64
  local os_name="linux"
  local os_subtype="libc"
  local os_arch="aarch64"
  local build_args="CROSS_TRIPLE=aarch64-unknown-linux-gnu"
  __exec:docker:assemble
}

function build:linux-libc:armv7a { ## Builds Linux Libc armv7-a eabihf
  local os_name="linux"
  local os_subtype="libc"
  local os_arch="armv7a"
  local build_args="CROSS_TRIPLE=armv7a-unknown-linux-gnueabihf"
  __exec:docker:assemble
}

function build:linux-libc:ppc64le { ## Builds Linux Libc powerpc64le
  local os_name="linux"
  local os_subtype="libc"
  local os_arch="ppc64le"
  local build_args="CROSS_TRIPLE=powerpc64le-unknown-linux-gnu"
  __exec:docker:assemble
}

function build:linux-libc:riscv64 { ## Builds Linux Libc riscv64
  local os_name="linux"
  local os_subtype="libc"
  local os_arch="riscv64"
  local build_args="CROSS_TRIPLE=riscv64-unknown-linux-gnu"
  __exec:docker:assemble
}

function build:linux-libc:x86 { ## Builds Linux Libc i686
  local os_name="linux"
  local os_subtype="libc"
  local os_arch="x86"
  local build_args="CROSS_TRIPLE=i686-unknown-linux-gnu"
  __exec:docker:assemble
}

function build:linux-libc:x86_64 { ## Builds Linux Libc x86_64
  local os_name="linux"
  local os_subtype="libc"
  local os_arch="x86_64"
  local build_args="CROSS_TRIPLE=x86_64-unknown-linux-gnu"
  __exec:docker:assemble
}

function build:linux-musl:aarch64 { ## Builds Linux Musl aarch64
  local os_name="linux"
  local os_subtype="musl"
  local os_arch="aarch64"
  local build_args="CROSS_TRIPLE=aarch64-unknown-linux-musl"
  __exec:docker:assemble
}

function build:linux-musl:x86 { ## Builds Linux Musl i686
  local os_name="linux"
  local os_subtype="musl"
  local os_arch="x86"
  local build_args="CROSS_TRIPLE=i686-unknown-linux-musl"
  __exec:docker:assemble
}

function build:linux-musl:x86_64 { ## Builds Linux Musl x86_64
  local os_name="linux"
  local os_subtype="musl"
  local os_arch="x86_64"
  local build_args="CROSS_TRIPLE=x86_64-unknown-linux-musl"
  __exec:docker:assemble
}

function build:macos-lts:aarch64 { ## Builds macOS (SDK 12.3) aarch64
  local os_subtype="lts"
  build:macos:aarch64
}

function build:macos-lts:x86_64 { ## Builds macOS (SDK 12.3) x86_64
  local os_subtype="lts"
  build:macos:x86_64
}

function build:macos:aarch64 { ## Builds macOS (SDK 15.4) aarch64
  local os_name="macos"
  local os_arch="aarch64"
  local build_args="CROSS_TARGET=aarch64-apple-darwin"
  __exec:docker:assemble
}

function build:macos:x86_64 { ## Builds macOS (SDK 15.4) x86_64
  local os_name="macos"
  local os_arch="x86_64"
  local build_args="CROSS_TARGET=x86_64-apple-darwin"
  __exec:docker:assemble
}

function build:mingw:x86 { ## Builds MinGW i686
  local os_name="mingw"
  local os_arch="x86"
  local build_args="ARCH=i686"
  __exec:docker:assemble
}

function build:mingw:x86_64 { ## Builds MinGW x86_64
  local os_name="mingw"
  local os_arch="x86_64"
  local build_args="ARCH=x86_64"
  __exec:docker:assemble
}

function publish { ## Builds and publishes all containers. ARG[ release TAG ]
  __require:var_set "$1" "ARG1 - release tag (e.g 0.4.0)"
  __require:cmd "$GIT" "git"
  __require:cmd "$DOCKER" "docker"

  ${DOCKER} login

  ${GIT} tag -s "$1" -m "Release v$1"

  purge:all "latest"
  build:all

  local images=
  local image=
  local repository=
  local image_id=

  images="$(${DOCKER} image ls | grep "$ORG" | grep 'latest' | grep -v "$ORG.staging." | tr -s ' ' | cut -d ' ' -f 1-3 | tr ' ' '|' | sort)"

  for image in $images; do
    repository="$(echo $image | cut -d '|' -f 1)"
    image_id="$(echo $image | cut -d '|' -f 3)"
    ${DOCKER} tag "$image_id" "$repository:$1"
    ${DOCKER} push "$repository:$1"
  done
}

function purge:all { ## Removes all docker images and purges docker builder. ARG[ TAG ]
  __require:cmd "$DOCKER" "docker"
  __require:var_set "$1" "ARG1 - TAG (e.g. latest)"

  local tag="$1"
  shift

  local images=
  local image=
  local image_id=

  images="$(${DOCKER} image ls | grep "$ORG" | grep "$tag" | tr -s ' ' | cut -d ' ' -f 1-3 | tr ' ' '|')"

  for image in $images; do
    image_id="$(echo $image | cut -d '|' -f 3)"
    ${DOCKER} image rm "$image_id" "$@"
  done

  ${DOCKER} builder prune --force
}

function help { ## THIS MENU
  echo "
    $0
    Copyright (C) 2023 Matthew Nelson

    Build docker containers

    Location: $DIR_TASK
    Syntax: $0 [task] [option]

    Tasks:
$(
    # function names + comments & colorization
    grep -E '^function .* {.*?## .*$$' "$0" |
    grep -v "^function __" |
    sed -e 's/function //' |
    sort |
    awk 'BEGIN {FS = "{.*?## "}; {printf "        \033[93m%-30s\033[92m %s\033[0m\n", $1, $2}'
)

    Example: $0 build:all:android
  "
}

function __exec:docker:assemble {
  __require:var_set "$os_name" "os_name"
  __require:var_set "$os_name" "os_arch"
  __require:var_set "$build_args" "build args"

  local dir_build="$os_name"
  local tag_suffix="$os_name"

  if [ -n "$os_subtype" ]; then
    dir_build+="/$os_subtype"
    tag_suffix+="-$os_subtype"
  fi

  __exec:docker:build "base" "base" "base"

  if [ "$os_name" = "android" ]; then
    #
    # https://github.com/android/ndk/wiki
    #
    local base_build_args="ANDROID_NDK_REVISION=28c"
    base_build_args+="|ANDROID_NDK_SHA256=dfb20d396df28ca02a8c708314b814a4d961dc9074f9a161932746f815aa552f"
    base_build_args+="|ANDROID_NDK_VERSION=28.2.13676358"
    __exec:docker:build "base/android" "base.android" "base/android" "$base_build_args"
    unset base_build_args

    if ! echo "$build_args" | grep -q "ANDROID_TARGET_API="; then
      build_args+="|ANDROID_TARGET_API=21"
    fi
    if ! echo "$build_args" | grep -q "ANDROID_TARGET_API_AVAILABLE="; then
      build_args+="|ANDROID_TARGET_API_AVAILABLE=21,22,23,24,25,26,27,28,29,30,31,32,33,34,35"
    fi
  fi

  if [ "$os_name" = "linux" ]; then
    #
    # https://github.com/crosstool-ng/crosstool-ng
    #
    local base_build_args="CROSSTOOL_NG_VERSION=1.27.0"
    __exec:docker:build "staging/crosstool" "staging.crosstool" "staging/crosstool" "$base_build_args"
    unset base_build_args
  fi

  if [ "$os_name" = "ios" ] || [ "$os_name" = "macos" ]; then
    local base_build_args="GIT_HASH_LDID=4bf8f4d60384a0693dbbe2084ce62a35bfeb87ab"
    base_build_args+="|GIT_HASH_LIBDISPATCH=fdf3fc85a9557635668c78801d79f10161d83f12"
    base_build_args+="|GIT_HASH_XAR=5fa4675419cfec60ac19a9c7f7c2d0e7c831a497"
    base_build_args+="|GIT_HASH_LIBTAPI=54c9044082ba35bdb2b0edf282ba1a340096154c"
    __exec:docker:build "base/darwin" "base.darwin" "base/darwin" "$base_build_args"
    unset base_build_args
  fi

  if [ "$os_name" = "ios" ]; then
    build_args+="|ARCH=$os_arch"

    local base_build_args="GIT_HASH_CCTOOLS=81f205e8ca6bbf2fdbcb6948132454fd1f97839e"
    base_build_args+="|VERSION_DARWIN=24.4"
    case "$os_name" in
      "ios")
        base_build_args+="|SDK_DIR=ios"
        base_build_args+="|SDK_PREFIX=iPhone"
        base_build_args+="|SDK_SHA256_OS=5f6b7647e319d610b9066fe75356395c18dc2edb64467b3c242bd8e7a0559daf"
        base_build_args+="|SDK_SHA256_SIMULATOR=85c85aa98455478f5c28cf3fe47405d1a3714c81f84c2944288b525738ca5219"
        base_build_args+="|VERSION_MIN=12.0"
        base_build_args+="|VERSION_SDK=18.4"
        ;;
      *)
        # TODO: tvos, watchos
        __error "Unknown os[$os_name]"
        ;;
    esac
    __exec:docker:build "/base/darwin/cctools" "base.${os_name}" "base/darwin/cctools" "$base_build_args"
    unset base_build_args
  fi

  if [ "$os_name" = "macos" ]; then
    #
    # Version info for various SDKs can be found via:
    #
    #   cat /path/to/SDKs/MacOSX{version}.sdk/SDKSettings.json | jq
    #
    # Alternatively see the table from osxcross:
    #
    #   https://github.com/tpoechtrager/osxcross/blob/f873f534c6cdb0776e457af8c7513da1e02abe59/build.sh#L30
    #
    local base_build_args="GIT_HASH_OSXCROSS=83daa9c65fbdcd7a9b867cd198f40b9564d06653"
    if [ "$os_subtype" = "lts" ]; then
      build_args+="|LTS=-lts"
      base_build_args+="|SDK_SHA256=5beee35d42f5bc4d1490b8856416ec5db63495cb31414f08caf63b63ce6e50c1"
      base_build_args+="|SDK_TAR_COMPRESSION=gz"
      base_build_args+="|VERSION_DARWIN=21.4"
      base_build_args+="|VERSION_MIN=10.9"
      base_build_args+="|VERSION_SDK=12.3"
    else
      base_build_args+="|SDK_SHA256=bc6edbf45c09772f4bbe2324975d1ff708c915df8ae2cfa97ef99bac6886fb0a"
      base_build_args+="|SDK_TAR_COMPRESSION=xz"
      base_build_args+="|VERSION_DARWIN=24.4"
      base_build_args+="|VERSION_MIN=10.13"
      base_build_args+="|VERSION_SDK=15.4"
    fi
    __exec:docker:build "base/darwin/macos" "base.${tag_suffix}" "base/darwin/macos" "$base_build_args"
    unset base_build_args
  fi

  if [ "$os_name" = "mingw" ]; then
    __exec:docker:build "base/mingw" "base.mingw" "base/mingw"
  fi

  tag_suffix+=".$os_arch"
  dir_build+="/$os_arch"

  __exec:docker:build "$os_name" "$tag_suffix" "$dir_build" "$build_args"
}

function __exec:docker:build {
  __require:cmd "$DOCKER" "docker"
  __require:var_set "$1" "ARG1 - Dockerfile directory location (from src/)"
  __require:var_set "$2" "ARG2 - image tag suffix"
  __require:var_set "$3" "ARG3 - build directory (from src/)"

  local _cmd="${DOCKER} build"
  _cmd+=" -f $DIR_TASK/src/$1/Dockerfile"

  local _build_arg=
  for _build_arg in $(echo "$4" | tr "|" " "); do
    _cmd+=" --build-arg $_build_arg"
  done

  _cmd+=" -t $ORG.$2"
  _cmd+=" $DIR_TASK/src/$3"

  echo "
    $_cmd
  "
  ${_cmd}
}

function __require:cmd {
  if [ -f "$1" ]; then return 0; fi
  __error "$2 is required to run this script"
}

function __require:var_set {
  __require:not_empty "$1" "$2 must be set"
}

function __require:not_empty {
  if [ -n "$1" ]; then return 0; fi
  __error "$2"
}

function __require:no_build_lock {
  if [ ! -f "$FILE_BUILD_LOCK" ]; then return 0; fi

  __error "Another task is in progress

    If this is not the case, delete the following file and re-run the task
    $FILE_BUILD_LOCK"
}

function __error {
  echo 1>&2 "
    ERROR: $1
  "
  exit 3
}

# Run
if [ -z "$1" ] || [ "$1" = "help" ] || echo "$1" | grep -q "^__"; then
  help
elif ! grep -qE "^function $1 {" "$0"; then
  echo 1>&2 "
    ERROR: Unknown task '$1'
  "
  help
else
  # Ensure always starting in the root directory
  cd "$DIR_TASK"

  # Setup a build lock to inhibit multiple shells
  __require:no_build_lock
  trap 'rm -rf "$FILE_BUILD_LOCK"' EXIT
  mkdir -p "$DIR_TASK/build"
  echo "$1" > "$FILE_BUILD_LOCK"

  TIMEFORMAT="
    Task '$1' completed in %3lR
  "
  time "$@"
fi
