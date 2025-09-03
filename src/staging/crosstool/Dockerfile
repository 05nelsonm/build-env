FROM 05nelsonm/build-env.base:latest

ARG CROSSTOOL_NG_VERSION

RUN apt-get install --no-install-recommends --yes \
      gperf \
      help2man \
      libncurses5-dev \
      libstdc++6 \
      libtool-bin \
      python3-dev \
      texinfo \
    && apt-get clean autoclean --yes \
    && apt-get autoremove --yes

ENV CT_ALLOW_BUILD_AS_ROOT_SURE=1

RUN mkdir -p /build \
    && cd /build \
    && git clone --branch crosstool-ng-${CROSSTOOL_NG_VERSION} --depth 1 https://github.com/crosstool-ng/crosstool-ng.git \
    && cd crosstool-ng \
    && git checkout crosstool-ng-${CROSSTOOL_NG_VERSION} \
    && ./bootstrap \
    && ./configure \
    && make -j"$(nproc)" \
    && make install \
    && cd / \
    && rm -rf /build
