#!/bin/bash

IMAGE_NAME="piper-phonemize"
PLATFORMS=("linux/amd64" "linux/arm64")

declare -A ARCH_MAPPING=(
    ["amd64"]="x86_64"
    ["arm64"]="aarch64"
)

for PLATFORM in "${PLATFORMS[@]}"; do
    ARCH=$(echo $PLATFORM | cut -d'/' -f2)
    ARCH_SUFFIX=${ARCH_MAPPING[$ARCH]}

    if [ -z "$ARCH_SUFFIX" ]; then
        echo "No ARCH_SUFFIX mapping found for architecture: $ARCH"
        exit 1
    fi

    echo "Building for platform: $PLATFORM with ARCH_SUFFIX: $ARCH_SUFFIX"

    docker buildx build \
        --platform $PLATFORM \
        --build-arg ARCH_SUFFIX=$ARCH_SUFFIX \
        -t ${IMAGE_NAME}:${ARCH} \
        --output type=local,dest=dist \
        .
done