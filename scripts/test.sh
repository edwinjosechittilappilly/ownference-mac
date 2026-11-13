#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
OUT="${OUT_DIR:-$PWD/build}"
mkdir -p "$OUT"
xcrun swiftc -sdk "$(xcrun --sdk macosx --show-sdk-path)" -target arm64-apple-macosx26.0 Sources/Core.swift Tests/CoreTests.swift -o "$OUT/core-tests"
"$OUT/core-tests"
