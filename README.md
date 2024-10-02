# Piper Phonemization Library

## Building

Use Docker:

AMD64:
``` sh
docker buildx build --platform linux/amd64 --build-arg ARCH_SUFFIX=x86_64 --tag piper-phonemize:amd64 --output type=local,dest=dist .
```

ARM64:
``` sh
docker buildx build --platform linux/arm64 --build-arg ARCH_SUFFIX=aarch64 --tag piper-phonemize:arm64 --output type=local,dest=dist .
```

BOTH:
``` sh
./build_docker.sh
```

Find whl file in `./dist`