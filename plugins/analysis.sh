#!/bin/bash

analysis_mission() {
    echo -e "\e[1;35m--- Analysis & Forensics Lab ---\e[0m"
    echo "1) Log Analysis (SSH/Wazuh Logs)"
    echo "2) Memory Forensics (Volatility)"
    echo "3) File Metadata & Hash Analysis"
    read -p "Selection: " a_opt

    case $a_opt in
        1) log_analysis_menu ;;
        2) volatility_menu ;;
        3) file_analysis_menu ;;
        *) echo "Invalid option" ;;
    esac
}

log_analysis_menu() {
    echo "[*] Accessing Security Logs..."
    # Placeholder: Pointing to your Wazuh logs
    tail -n 50 /var/ossec/logs/alerts/alerts.log | less
}

volatility_menu() {
    read -p "Enter path to memory dump: " memdump
    echo "[*] Analyzing memory profile..."
    volatility -f "$memdump" imageinfo
}

file_analysis_menu() {
    read -p "Enter file path: " filepath
    echo "[*] Hashing and Metadata..."
    md5sum "$filepath"
    exiftool "$filepath"
}
