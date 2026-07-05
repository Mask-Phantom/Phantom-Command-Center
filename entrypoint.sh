#!/bin/bash

# Main Entry Point
echo -e "\e[1;36m--- PHANTOM COMMAND CENTER ---\e[0m"
echo "1) Run TheFatRat"
echo "2) Run Custom Security Plugins"
echo "3) System Environment Check"
echo "Q) Quit"
read -p "Select an option: " opt

case $opt in
    1) ./TheFatRat/fatrat ;;
    2) source scripts/plugin_loader.sh; run_plugin_menu ;;
    3) echo "Checking environment..." ;;
    Q|q) exit 0 ;;
    *) echo "Invalid option"; ./entrypoint.sh ;;
esac
