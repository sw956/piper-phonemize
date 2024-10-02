FROM quay.io/pypa/manylinux_2_28_x86_64 as build
ARG TARGETARCH
ARG TARGETVARIANT

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN yum -y install \
    gcc gcc-c++ make cmake ca-certificates curl pkgconfig git

WORKDIR /build

COPY ./ ./

RUN python3.12 -m venv .venv
ENV PATH="/build/.venv/bin:$PATH"
RUN pip install -r requirements.txt

RUN cmake -Bbuild -DCMAKE_INSTALL_PREFIX=piper_phonemize
RUN cmake --build build --config Release
RUN cmake --install build

RUN python -m build

# -----------------------------------------------------------------------------
FROM scratch

COPY --from=build /build/dist/*.whl ./
