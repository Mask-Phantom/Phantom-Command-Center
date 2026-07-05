#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

print_header "Dependency Report"

TOOLS=(
    git
    gcc
    java
    python3
    ruby
    openssl
    apktool
    aapt
    dx
    zipalign
)

missing=0

for tool in "${TOOLS[@]}"; do
    if ! check_command "$tool"; then
        missing=$((missing + 1))
    fi
done

echo

if [ "$missing" -eq 0 ]; then
    success "All required dependencies are installed."
else
    warn "$missing dependency(ies) missing."
fi
