ARG ARCH_SUFFIX=x86_64

# cmakelists specify cxx_std_17 so use manylinux_2_28 image
# quay.io/pypa/manylinux_2_28_x86_64
# quay.io/pypa/manylinux_2_28_aarch64
FROM quay.io/pypa/manylinux_2_28_${ARCH_SUFFIX} AS build

ARG TARGETARCH
ARG TARGETVARIANT

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN yum -y install \
    gcc gcc-c++ make cmake ca-certificates curl pkgconfig git

WORKDIR /build

COPY ./ ./

RUN cmake -Bbuild -DCMAKE_INSTALL_PREFIX=piper_phonemize
RUN cmake --build build --config Release
RUN cmake --install build

RUN python3.12 -m build

# -----------------------------------------------------------------------------
FROM scratch

COPY --from=build /build/dist/*.whl ./
