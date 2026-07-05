#!/usr/bin/env bash
#
# TheFatRat-Kali2026 Compatibility Report
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

print_header "TheFatRat-Kali2026 Compatibility Report"

echo "Project Version : $VERSION"
echo "Generated       : $(date)"
echo

print_header "Operating System"

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    echo "Name          : $PRETTY_NAME"
    echo "Version       : $VERSION_ID"
fi

echo "Kernel        : $(uname -r)"
echo "Architecture  : $(uname -m)"
echo

print_header "Dependencies"

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
    if command_exists "$tool"; then
        version="$("$tool" --version 2>/dev/null | head -n1)"
        printf "%-12s : OK  %s\n" "$tool" "$version"
    else
        printf "%-12s : MISSING\n" "$tool"
        ((missing++))
    fi
done

echo

print_header "Summary"

if [[ $missing -eq 0 ]]; then
    success "Environment is compatible."
else
    warn "$missing dependency(ies) missing."
fi
