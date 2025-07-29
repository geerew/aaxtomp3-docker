#!/bin/bash
set -e

if [[ -z "$AAX_ACTIVATION_CODE" ]]; then
    echo "❌ AAX_ACTIVATION_CODE environment variable is not set."
    exit 1
fi

if [[ $# -lt 1 ]]; then
    echo "Usage: run-aax /path/to/file.aax"
    exit 1
fi

FILE="$1"

if [[ ! -f "$FILE" ]]; then
    echo "❌ File not found: $FILE"
    exit 2
fi

echo "🎧 Converting: $FILE"
aax-to-mp3 -e:m4b -A "$AAX_ACTIVATION_CODE" -l 1 "$FILE"

# Detect UID of /working mount if TARGET_UID is not explicitly set
if [[ -z "$TARGET_UID" ]]; then
    TARGET_UID=$(stat -c '%u' /working)
    echo "🕵️  Detected target UID from /working: $TARGET_UID"
fi

# Fix ownership of output
if [[ -n "$TARGET_UID" ]]; then
    echo "🔧 Setting ownership of output to UID $TARGET_UID"
    chown -R "$TARGET_UID:$TARGET_UID" /working/Audiobook || true
fi
