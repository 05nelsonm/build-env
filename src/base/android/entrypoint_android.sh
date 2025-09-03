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

# Can dynamically adjust envirioment variables for a given Android API by
# passing -e ANDROID_TARGET_API=24 to docker run.
#
# The default ANDROID_TARGET_API is the minimum supported API version for
# the NDK which is set at container build time.
if [ x"${ANDROID_TARGET_API+set}" != x ]; then
  if [ x"${CROSS_TARGET+set}" != x ]; then
    export CROSS_TRIPLE=${CROSS_TARGET}${ANDROID_TARGET_API}
    export AR=${CROSS_BIN}/${CROSS_TRIPLE}-ar \
    export AS=${CROSS_BIN}/${CROSS_TRIPLE}-as \
    export CC=${CROSS_BIN}/${CROSS_TRIPLE}-clang \
    export CXX=${CROSS_BIN}/${CROSS_TRIPLE}-clang++ \
    export LD=${CROSS_BIN}/${CROSS_TRIPLE}-ld \
    export RANLIB=${CROSS_BIN}/${CROSS_TRIPLE}-ranlib \
    export STRIP=${CROSS_BIN}/${CROSS_TRIPLE}-strip

    if [ ! -f "$CC" ]; then
      echo 1>&2 "
    ANDROID_TARGET_API=${ANDROID_TARGET_API} unsupported for CROSS_TARGET=${CROSS_TARGET}
    "
      exit 1
    fi
  fi
fi

/var/opt/entrypoint_base.sh "$@"
