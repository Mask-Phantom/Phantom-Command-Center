#!/bin/bash

# Auto-source plugins using relative path
for f in "$PWD/plugins/"*.sh; do
    source "$f"
done

run_plugin_menu() {
    echo -e "\e[1;32m--- Mission Profiles ---\e[0m"
    echo "1) Recon Mission"
    echo "2) Web Vulnerability Scan"
    echo "3) Post-Exploitation"
    echo "4) Analysis & Forensics"
    echo "5) System Environment Check"
    echo "Q) Return to Main Menu"
    read -p "Selection: " p_opt

    case $p_opt in
        1) 
           echo "1) Passive Recon"; echo "2) Active Recon"
           read -p "Selection: " s; [[ $s == 1 ]] && passive_recon_mission || active_recon_menu ;;
        2) web_vuln_mission ;;
        3) exploitation_mission ;;
        4) analysis_mission ;;
        5) system_check_mission ;;
        Q|q) ./entrypoint.sh ;;
        *) echo "Invalid option"; run_plugin_menu ;;
    esac
}
