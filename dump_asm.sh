#!/usr/bin/env bash

set -e

CATEGORY="$1"
TEST_NAME="$2"

if [ -z "$CATEGORY" ] || [ -z "$TEST_NAME" ]; then
    echo "Usage: ./scripts/dump_asm.sh <category> <test_name>"
    echo "Example: ./scripts/dump_asm.sh basic heap_oob"
    exit 1
fi

BIN_FILE="bin/${CATEGORY}/${TEST_NAME}"
ASM_FILE="asm/${CATEGORY}/${TEST_NAME}.txt"

if [ ! -f "$BIN_FILE" ]; then
    echo "[ERROR] Binary file not found: $BIN_FILE"
    echo "Build first with: ./build.sh $CATEGORY $TEST_NAME"
    exit 1
fi

mkdir -p "asm/${CATEGORY}"

objdump -d "$BIN_FILE" > "$ASM_FILE"

echo "[OK] ASM dumped: $ASM_FILE"