#!/usr/bin/env bash
# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

print_header "Environment Detection"

if [ -f /etc/os-release ]; then
    # shellcheck source=/dev/null
    source /etc/os-release
    log "OS: $ID $VERSION_ID"
else
    warn "Unable to detect OS"
fi

if command_exists uname; then
    log "Kernel: $(uname -r)"
fi
