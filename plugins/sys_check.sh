#!/bin/bash

system_check_mission() {
    echo -e "\e[1;34m--- System Environment Check ---\e[0m"
    # List of critical tools for your missions
    tools=("nmap" "subfinder" "amass" "theharvester" "masscan" "rustscan" "ffuf" "gobuster" "nuclei" "sqlmap" "msfconsole" "vol" "exiftool")

    for tool in "${tools[@]}"; do
        if command -v "$tool" &> /dev/null; then
            echo -e "[+] $tool: \e[1;32mFOUND\e[0m"
        else
            echo -e "[-] $tool: \e[1;31mNOT FOUND\e[0m"
        fi
    done
    read -p "Press ENTER to return..."
}
