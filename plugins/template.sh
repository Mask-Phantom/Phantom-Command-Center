#!/bin/bash

# Guard clause: Prevent double-sourcing
if [[ "${PLUGIN_NAME_LOADED:-}" == "true" ]]; then return 0; fi
PLUGIN_NAME_LOADED="true"

# Define the function for your new tool
run_plugin_action() {
    echo -e "${okegreen}[*] Running Custom Plugin...${RESET}"
    # Your logic goes here
    # Use global variables like $yourip and $yourport
}
