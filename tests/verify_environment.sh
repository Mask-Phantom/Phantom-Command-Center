#!/usr/bin/env bash

set -euo pipefail

echo "=== Environment Verification ==="

required_commands=(
    git
    bash
    shellcheck
)

missing=0

for cmd in "${required_commands[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        printf "[OK] %s\n" "$cmd"
    else
        printf "[MISSING] %s\n" "$cmd"
        missing=$((missing + 1))
    fi
done

echo

if [ "$missing" -eq 0 ]; then
    echo "Environment verification passed."
else
    echo "$missing required command(s) missing."
    exit 1
fi
