#!/usr/bin/env bash
#
# TheFatRat-Kali2026
# Common utility functions
#

set -euo pipefail

export PROJECT_NAME="TheFatRat-Kali2026"
export VERSION="0.2.0"

log() {
    printf "[*] %s\n" "$*"
}

success() {
    printf "[+] %s\n" "$*"
}

warn() {
    printf "[!] %s\n" "$*"
}

error() {
    printf "[-] %s\n" "$*" >&2
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

require_command() {
    local cmd="$1"

    if command_exists "$cmd"; then
        success "$cmd found"
        return 0
    fi

    error "$cmd missing"
    return 1
}

check_command() {
    local cmd="$1"

    if command_exists "$cmd"; then
        printf "%-20s OK\n" "$cmd"
        return 0
    else
        printf "%-20s MISSING\n" "$cmd"
        return 1
    fi
}

print_header() {
    echo
    echo "======================================"
    echo " $1"
    echo "======================================"
}     
