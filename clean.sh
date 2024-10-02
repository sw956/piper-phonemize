#!/bin/bash

set -x

_DIR="$(dirname "${BASH_SOURCE[0]}")"

if [[ -n "$_DIR" ]]; then
    cd "$_DIR" || { echo "Error: Failed to change directory to $_DIR"; exit 1; }
    rm -rf "./build" "./download" "./install" "./dist" "./piper_phonemize.egg-info" "./piper_phonemize/bin" "./piper_phonemize/include" "./piper_phonemize/lib" "./piper_phonemize/share"
else
    echo "Error: _DIR is empty. Aborting."
    exit 1
fi