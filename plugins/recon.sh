#!/bin/bash

# --- Active Recon Functions ---
nmap_suite() {
    read -p "Enter Target IP/Domain: " target
    echo -e "\nSelect Scan Intensity:"
    echo "1) Fast Scan (Top 100 ports)"
    echo "2) Comprehensive Scan (All ports)"
    echo "3) Vulnerability Script Scan"
    read -p "Selection: " n_opt

    case $n_opt in
        1) nmap -F -Pn -sV "$target" ;;
        2) nmap -p- -Pn -sV -A -T4 "$target" ;;
        3) nmap -Pn -sV --script vuln "$target" ;;
        *) echo "Invalid option" ;;
    esac
    read -p "Press ENTER to return..."
}

# --- Passive Recon Functions ---
passive_recon_mission() {
    read -p "Enter Domain (e.g., example.com): " target_domain
    echo -e "\e[1;36m[*] Starting Passive Recon on $target_domain...\e[0m"
    
    subfinder -d "$target_domain" -o subdomains.txt
    amass enum -d "$target_domain" -o amass_results.txt
    theHarvester -d "$target_domain" -b all -f "${target_domain}_harvest.html"
    
    echo -e "\e[1;32m[+] Passive discovery complete.\e[0m"
    read -p "Press ENTER to return..."
}

# --- Active Recon Tools ---
masscan_suite() {
    read -p "Enter Target IP/Range (e.g., 192.168.1.0/24): " target
    read -p "Enter Ports (e.g., 80,443,22): " ports
    echo "[*] Running Masscan (Fast)..."
    masscan -p"$ports" "$target" --rate 1000 -oG masscan_results.txt
    echo "[+] Masscan complete. Saved to masscan_results.txt"
    read -p "Press ENTER to return..."
}

rustscan_suite() {
    read -p "Enter Target IP: " target
    echo "[*] Running RustScan (Smart)..."
    # RustScan automatically pipes to Nmap
    rustscan -a "$target" -- -A -T4
    read -p "Press ENTER to return..."
}
