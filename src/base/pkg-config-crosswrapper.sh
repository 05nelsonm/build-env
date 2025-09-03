#!/bin/sh
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

if [ x"${BUILD_ENV_SYSROOT+set}" != x ]; then
  export PKG_CONFIG_SYSROOT_DIR="${BUILD_ENV_SYSROOT}"

  if [ x"${PKG_CONFIG_LIBDIR+set}" = x ]; then
    export PKG_CONFIG_LIBDIR="${BUILD_ENV_SYSROOT}/usr/lib/pkgconfig:${BUILD_ENV_SYSROOT}/usr/share/pkgconfig"
  fi
fi

exec pkg-config "$@"
