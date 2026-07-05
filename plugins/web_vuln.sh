#!/bin/bash

web_vuln_mission() {
    read -p "Enter Target URL (e.g., http://target.com): " target
    echo -e "\e[1;33m--- Web Discovery Suite ---\e[0m"
    echo "1) ffuf (Fast fuzzing)"
    echo "2) Gobuster (Dir/DNS)"
    echo "3) Feroxbuster (Recursive/Fast)"
    echo "4) Nuclei (Templates/CVEs)"
    echo "5) sqlmap (Database injection)"
    read -p "Selection: " w_opt

    case $w_opt in
        1) ffuf -u "$target/FUZZ" -w /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt ;;
        2) gobuster dir -u "$target" -w /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt ;;
        3) feroxbuster -u "$target" --wordlist /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt ;;
        4) nuclei -u "$target" ;;
        5) sqlmap -u "$target" --batch --level 2 --risk 2 ;;
        *) echo "Invalid option" ;;
    esac
    read -p "Press ENTER to return..."
}
