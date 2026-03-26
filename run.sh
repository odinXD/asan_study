#!/usr/bin/env bash

set +e

CATEGORY="$1"
TEST_NAME="$2"

if [ -z "$CATEGORY" ] || [ -z "$TEST_NAME" ]; then
    echo "Usage: ./run.sh <category> <test_name>"
    echo "Example: ./run.sh basic heap_oob"
    exit 1
fi

BIN_FILE="bin/${CATEGORY}/${TEST_NAME}"
LOG_FILE="logs/${CATEGORY}/${TEST_NAME}.log"

if [ ! -f "$BIN_FILE" ]; then
    echo "[ERROR] Binary file not found: $BIN_FILE"
    echo "Build first with: ./build.sh $CATEGORY $TEST_NAME"
    exit 1
fi

mkdir -p "logs/${CATEGORY}"

ASAN_OPTIONS=detect_leaks=1 "$BIN_FILE" > "$LOG_FILE" 2>&1
EXIT_CODE=$?

echo "[OK] Executed: $BIN_FILE"
echo "[OK] Log saved: $LOG_FILE"
echo "[INFO] Exit code: $EXIT_CODE"
