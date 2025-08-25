# build-env

This is the `sdk` branch for `build-env`.

Sdks are downloaded from this branch during the build process for `master`.

Creating the Sdk:

- Download Xcode (full, not CommandLineTools) to your current working directory
    - See [osxcross][osxcross-pkg] for how to do that

- Drop into a shell within the `non-linux.base` image with your 
  current working directory mounted as a volume (need root to install 
  software).
  ```shell
  docker run --rm \
    -e ID_U="$(id -u)" \
    -e ID_G="$(id -g)" \
    -v ./:/work \
    -it 05nelsonm/build-env.non-linux.base:0.3.0 \
    bash
  ```

- Update dependencies
  ```shell
  apt-get update && apt-get upgrade
  ```

- Install needed packages
  ```shell
  apt-get install \
    --no-install-recommends \
    --yes \
    clang \
    cpio \
    icu-devtools \
    libicu-dev \
    libxml2-dev
  ```

- Clone the `osxcross` project
  ```shell
  mkdir -p /build && \
    cd /build && \
    git clone https://github.com/tpoechtrager/osxcross.git && \
    cd osxcross && \
    git checkout f873f534c6cdb0776e457af8c7513da1e02abe59
  ```

- Generate the `MacOSX` sdk (replace `{xcode-download.xip}` with the actual file name)
  ```shell
  ./tools/gen_sdk_package_pbzx.sh /work/{xcode-download.xip}
  ```

- Modify the script to next look for `iPhoneOS` sdk
  ```shell
  sed -i 's+MacOSX.platform+iPhoneOS.platform+' tools/gen_sdk_package.sh
  sed -i 's+MacOS\[+iPhoneOS\[+' tools/gen_sdk_package.sh
  sed -i 's+MacOSX\[+iPhoneOS\[+' tools/gen_sdk_package.sh
  sed -i 's+MacOSX+iPhoneOS+' tools/gen_sdk_package.sh
  sed -i 's+MacOS.sdk+iPhoneOS.sdk+' tools/gen_sdk_package.sh
  ```

- Generate the `iPhoneOS` sdk (replace `{xcode-download.xip}` with the actual file name)
  ```shell
  ./tools/gen_sdk_package_pbzx.sh /work/{xcode-download.xip}
  ```

- Modify the script to next look for `iPhoneSimulator` sdk
  ```shell
  sed -i 's+iPhoneOS+iPhoneSimulator+g' tools/gen_sdk_package.sh
  ```

- Generate the `iPhoneSimulator` sdk (replace `{xcode-download.xip}` with the actual file name)
  ```shell
  ./tools/gen_sdk_package_pbzx.sh /work/{xcode-download.xip}
  ```

- Modify the script to next look for `AppleTVOS` sdk
  ```shell
  sed -i 's+iPhoneSimulator+AppleTVOS+g' tools/gen_sdk_package.sh
  ```

- Generate the `AppleTVOS` sdk (replace `{xcode-download.xip}` with the actual file name)
  ```shell
  ./tools/gen_sdk_package_pbzx.sh /work/{xcode-download.xip}
  ```

- Modify the script to next look for `AppleTVSimulator` sdk
  ```shell
  sed -i 's+AppleTVOS+AppleTVSimulator+g' tools/gen_sdk_package.sh
  ```

- Generate the `AppleTVSimulator` sdk (replace `{xcode-download.xip}` with the actual file name)
  ```shell
  ./tools/gen_sdk_package_pbzx.sh /work/{xcode-download.xip}
  ```

- Modify the script to next look for `WatchOS` sdk
  ```shell
  sed -i 's+AppleTVSimulator+WatchOS+' tools/gen_sdk_package.sh
  ```

- Generate the `WatchOS` sdk (replace `{xcode-download.xip}` with the actual file name)
  ```shell
  ./tools/gen_sdk_package_pbzx.sh /work/{xcode-download.xip}
  ```

- Modify the script to next look for `WatchSimulator` sdk
  ```shell
  sed -i 's+WatchOS+WatchSimulator+g' tools/gen_sdk_package.sh
  ```

- Generate the `WatchSimulator` sdk (replace `{xcode-download.xip}` with the actual file name)
  ```shell
  ./tools/gen_sdk_package_pbzx.sh /work/{xcode-download.xip}
  ```

- Have a look at the sdk(s) that were generated
  ```shell
  ll | grep "sdk.tar.xz"
  ```

- Fix ownership of the generated sdks
  ```shell
  chown "$ID_U:$ID_G" *.sdk.tar.xz
  ```

- Snag the sha256 values
  ```shell
  sha256sum *.sdk.tar.xz
  ```

- Move them to the `/work` directory
  ```shell
  mv *.sdk.tar.xz /work
  ```

- exit (`non-linux.base` container will be removed automatically upon exit)
  ```shell
  exit
  ```

[osxcross-pkg]: https://github.com/tpoechtrager/osxcross#packaging-the-sdk
