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

# Programs
readonly DOCKER=$(which docker)
readonly GIT=$(which git)

function build:all { ## Builds all images
  build:all:android
#  build:all:freebsd
  build:all:linux-libc
#  build:all:linux-musl
  build:all:mingw
  build:all:macos
}

function build:all:android { ## Builds all Android images
  build:android:aarch64
  build:android:armv7a
  build:android:x86
  build:android:x86_64
}

#function build:all:freebsd { ## Builds all FreeBSD images
#  build:freebsd:aarch64
#  build:freebsd:x86
#  build:freebsd:x86_64
#}

function build:all:linux-libc { ## Builds all Linux Libc images
  build:linux-libc:aarch64
  build:linux-libc:armv7a
  build:linux-libc:ppc64le
  build:linux-libc:x86
  build:linux-libc:x86_64
}

#function build:all:linux-musl { ## Builds all Linux Musl images
#  build:linux-musl:aarch64
#  build:linux-musl:x86
#  build:linux-musl:x86_64
#}

function build:all:macos { ## Builds all macOS images
  build:macos-lts:aarch64
  build:macos-lts:x86_64
  build:macos:aarch64
  build:macos:x86_64
}

function build:all:mingw { ## Builds all Mingw images
  build:mingw:x86
  build:mingw:x86_64
}

function build:android:aarch64 { ## Builds Android arm64-v8a
  local os_name="android"
  local os_arch="aarch64"
  __exec:docker:assemble
}

function build:android:armv7a { ## Builds Android armeabi-v7a
  local os_name="android"
  local os_arch="armv7a"
  __exec:docker:assemble
}

function build:android:x86 { ## Builds Android x86
  local os_name="android"
  local os_arch="x86"
  __exec:docker:assemble
}

function build:android:x86_64 { ## Builds Android x86_64
  local os_name="android"
  local os_arch="x86_64"
  __exec:docker:assemble
}

#function build:freebsd:aarch64 { ## Builds FreeBSD aarch64
#  local os_name="freebsd"
#  local os_arch="aarch64"
#  # TODO __exec:docker:assemble
#}

#function build:freebsd:x86 { ## Builds FreeBSD x86
#  local os_name="freebsd"
#  local os_arch="x86"
#  # TODO __exec:docker:assemble
#}

#function build:freebsd:x86_64 { ## Builds FreeBSD x86_64
#  local os_name="freebsd"
#  local os_arch="x86_64"
#  # TODO __exec:docker:assemble
#}

function build:linux-libc:aarch64 { ## Builds Linux Libc aarch64
  local os_name="linux"
  local os_subtype="-libc"
  local os_arch="aarch64"
  __exec:docker:assemble
}

function build:linux-libc:armv7a { ## Builds Linux Libc armv7a
  local os_name="linux"
  local os_subtype="-libc"
  local os_arch="armv7a"
  __exec:docker:assemble
}

function build:linux-libc:ppc64le { ## Builds Linux Libc ppc64le
  local os_name="linux"
  local os_subtype="-libc"
  local os_arch="ppc64le"
  __exec:docker:assemble
}

function build:linux-libc:x86 { ## Builds Linux Libc x86
  local os_name="linux"
  local os_subtype="-libc"
  local os_arch="x86"
  __exec:docker:assemble
}

function build:linux-libc:x86_64 { ## Builds Linux Libc x86_64
  local os_name="linux"
  local os_subtype="-libc"
  local os_arch="x86_64"
  __exec:docker:assemble
}

#function build:linux-musl:aarch64 { ## Builds Linux Musl aarch64
#  local os_name="linux"
#  local os_subtype="-musl"
#  local os_arch="aarch64"
#  # TODO __exec:docker:assemble
#}

#function build:linux-musl:x86 { ## Builds Linux Musl x86
#  local os_name="linux"
#  local os_subtype="-musl"
#  local os_arch="x86"
#  # TODO __exec:docker:assemble
#}

#function build:linux-musl:x86_64 { ## Builds Linux Musl x86_64
#  local os_name="linux"
#  local os_subtype="-musl"
#  local os_arch="x86_64"
#  # TODO __exec:docker:assemble
#}

function build:macos-lts:aarch64 { ## Builds macOS LTS aarch64
  local os_subtype="-lts"
  build:macos:aarch64
}

function build:macos-lts:x86_64 { ## Builds macOS LTS x86_64
  local os_subtype="-lts"
  build:macos:x86_64
}

function build:macos:aarch64 { ## Builds macOS aarch64
  local os_name="macos"
  local os_arch="aarch64"
  __exec:docker:assemble
}

function build:macos:x86_64 { ## Builds macOS x86_64
  local os_name="macos"
  local os_arch="x86_64"
  __exec:docker:assemble
}

function build:mingw:x86 { ## Builds Windows x86
  local os_name="mingw"
  local os_arch="x86"
  __exec:docker:assemble
}

function build:mingw:x86_64 { ## Builds Windows x86_64
  local os_name="mingw"
  local os_arch="x86_64"
  __exec:docker:assemble
}

function publish { ## Builds and publishes all containers
  __require:var_set "$1" "tag must be specified in first argument"
  __require:cmd "$GIT" "git"
  __require:cmd "$DOCKER" "docker"

  ${DOCKER} login

  ${GIT} tag -s "$1" -m "Release v$1"

  purge:all
  build:all

  local images=
  local image=
  local repository=
  local image_id=

  images="$(${DOCKER} image ls | grep '05nelsonm/build-env' | grep 'latest' | tr -s ' ' | cut -d ' ' -f 1-3 | tr ' ' '|')"

  for image in $images; do
    repository="$(echo $image | cut -d '|' -f 1)"
    image_id="$(echo $image | cut -d '|' -f 3)"
    ${DOCKER} tag "$image_id" "$repository:$1"
    ${DOCKER} push "$repository:$1"
  done
}

function purge:all { ## Purges all latest builds from docker images
  __require:cmd "$DOCKER" "docker"

  local tag="$1"
  shift
  if [ -z "$tag" ]; then
    tag="latest"
  fi

  local images=
  local image=
  local image_id=

  images="$(${DOCKER} image ls | grep '05nelsonm/build-env' | grep "$tag" | tr -s ' ' | cut -d ' ' -f 1-3 | tr ' ' '|')"

  for image in $images; do
    image_id="$(echo $image | cut -d '|' -f 3)"
    ${DOCKER} image rm "$image_id" "$@"
  done

  ${DOCKER} builder prune --force
}

function help { ## THIS MENU
  # shellcheck disable=SC2154
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

  if [ "$os_name" = "linux" ]; then
    __exec:docker:build "linux$os_subtype.base"
  fi

  # Build android base image if needed
  if [ "$os_name" = "android" ]; then
    __exec:docker:build "linux-libc.base"
    __exec:docker:build "android.base"
  fi

  # Build macos base image if needed
  if [ "$os_name" = "macos" ]; then
    __exec:docker:build "linux-libc.base"
    __exec:docker:build "darwin.base"
    __exec:docker:build "macos$os_subtype.base"
  fi

  # Build linux-libc base images if needed
  if [ "$os_name" = "mingw" ]; then
    __exec:docker:build "linux-libc.base"
  fi

  # Build final container
  __exec:docker:build "$os_name$os_subtype.$os_arch"
}

function __exec:docker:build {
  __require:cmd "$DOCKER" "docker"

  ${DOCKER} build \
    -f "$DIR_TASK/Dockerfile.$1" \
    -t "05nelsonm/build-env.$1" \
    "$DIR_TASK"
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
