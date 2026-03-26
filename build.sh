#!/usr/bin/env bash

set -e

CATEGORY="$1"
TEST_NAME="$2"

if [ -z "$CATEGORY" ] || [ -z "$TEST_NAME" ]; then
    echo "Usage: ./build.sh <category> <test_name>"
    echo "Example: ./build.sh basic heap_oob"
    exit 1
fi

SRC_FILE="src/${CATEGORY}/${TEST_NAME}.c"
BIN_FILE="bin/${CATEGORY}/${TEST_NAME}"

if [ ! -f "$SRC_FILE" ]; then
    echo "[ERROR] Source file not found: $SRC_FILE"
    exit 1
fi

mkdir -p "bin/${CATEGORY}"

clang -fsanitize=address -g -O0 "$SRC_FILE" -o "$BIN_FILE"

echo "[OK] Built: $BIN_FILE"