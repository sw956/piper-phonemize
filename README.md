# Piper Phonemization Library

## Building

Use Docker:

``` sh
docker buildx build . -t piper-phonemize --output 'type=local,dest=dist'
```

Find whl file in `./dist`