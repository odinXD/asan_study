#!/usr/bin/env bash

set -e

CATEGORY="$1"
TEST_NAME="$2"

if [ -z "$CATEGORY" ] || [ -z "$TEST_NAME" ]; then
    echo "Usage: ./scripts/emit_ir.sh <category> <test_name>"
    echo "Example: ./scripts/emit_ir.sh basic heap_oob"
    exit 1
fi

SRC_FILE="src/${CATEGORY}/${TEST_NAME}.c"
IR_FILE="ir/${CATEGORY}/${TEST_NAME}.ll"

if [ ! -f "$SRC_FILE" ]; then
    echo "[ERROR] Source file not found: $SRC_FILE"
    exit 1
fi

mkdir -p "ir/${CATEGORY}"

clang -fsanitize=address -g -O0 -S -emit-llvm "$SRC_FILE" -o "$IR_FILE"

echo "[OK] IR generated: $IR_FILE"