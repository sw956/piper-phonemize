#!/bin/bash

set -x

_DIR="$(dirname "${BASH_SOURCE[0]}")"

if [[ -n "$_DIR" ]]; then
    cd "$_DIR" || { echo "Error: Failed to change directory to $_DIR"; exit 1; }
else
    echo "Error: _DIR is empty. Aborting."
    exit 1
fi

if [[ -z "$VIRTUAL_ENV" ]]; then
    if [[ -z "$1" ]]; then
        VENV_PATH=".venv"  # default to .venv
    else
        VENV_PATH="$1"
    fi

    if [[ ! -d "$VENV_PATH" ]]; then
        echo "venv '$VENV_PATH' does not exist. Creating..."
        python3.12 -m venv $VENV_PATH
    fi

    echo "RUNNING 'source ./$VENV_PATH/bin/activate'"
    source "./$VENV_PATH/bin/activate"
fi

if [[ -n "$_DIR" ]]; then
    rm -rf "./build" "./download" "./install" "./dist" "./piper_phonemize.egg-info" "./piper_phonemize/bin" "./piper_phonemize/include" "./piper_phonemize/lib" "./piper_phonemize/share"
else
    echo "Error: _DIR is empty. Aborting"
    exit 1 
fi

pip install -r requirements.txt

cmake -Bbuild -DCMAKE_INSTALL_PREFIX=piper_phonemize
cmake --build build --config Release
cmake --install build

python -m build