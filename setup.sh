#!/bin/bash
#Instalation of searchsploit (exploitdb)
source "$(dirname "${BASH_SOURCE[0]}")/modules/pkg_helpers.sh"

source "$(dirname "${BASH_SOURCE[0]}")/modules/dep_helpers.sh"

source "$(dirname "${BASH_SOURCE[0]}")/modules/env_helpers.sh"
source "$(dirname "${BASH_SOURCE[0]}")/modules/sys_reqs.sh"
# setup.sh Original Author : Edo maland ( Screetsec )
# Script rebuilded by peterpt
# Install all dependencies nedded
# configuration all file for fixing all problems
# --------------------------------------------------------


#!/bin/bash
echo "Setting up Phantom Command Center..."

# Ensure entrypoint.sh is executable
chmod +x entrypoint.sh

# Check if necessary dependencies are installed
if ! command -v git &> /dev/null; then
    echo "Git not found, please install it."
    exit
fi

echo "Setup complete. Run ./entrypoint.sh to start."

#Fail safe for original user sources.list in case setup was interrupted in middle last time
file="/etc/apt/sources.list.fatrat"
if [ -f "$file" ]
then
echo "Setup Detected that your previous run was interrupted in middle , fixing your original repositories list ."
sleep 4s
rm -f /etc/apt/sources.list
mv /etc/apt/sources.list.fatrat /etc/apt/sources.list
echo "Your Original repository list was recovered. ;) ..... beginning setup"
echo ""
echo "Cleaning previous repositories cache & updating your repository ."
echo -e "$yellow" ""
sudo apt-get clean && apt-get update -y
sleep 2
else
echo -e "$green" ""
fi 
#variables for logs and others
path=`pwd`
arch=$(uname -m)
inst="$path/logs/install.log"
log="$path/logs/setup.log"
aptlog="$path/logs/apt.log"
config="$path/config/config.path"
mingw="$path/logs/aptdebug.log"
#Removing any previous setup log created
rm -rf "$log" > /dev/null 2>&1
rm -rf logs/check > /dev/null 2>&1
rm -rf "$aptlog" > /dev/null 2>&1
rm -rf "$mingw" > /dev/null 2>&1
#terminal text colours code
cyan='\033[0;36m'
green='\033[0;32m'
lightgreen='\e[0;32m'
white='\e[0;37m'
red='\e[0;31m'
yellow='\033[0;33m'
blue='\033[0;34m'
orange='\e[38;5;166m'

#Check root dulu
if [ $(id -u) != "0" ]; then
echo -e "$red" [x]::[not root]: You need to be [root] to run this script.;
      echo ""
   	  sleep 1
exit 0
fi
#Many fresh installed linux distros do not come with sudo installed
which sudo > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo ""
else
apt-get install sudo -y
fi
echo ""
# Fixing any possible problems with packages missed/corrupted dependencies on user OS before proceed
echo -ne "$green""[ * ] Fixing any possible broken packages in apt management..."
sleep 1
sudo apt-get install -f -y && sudo apt-get autoremove -y > /dev/null 2>&1
echo "Done"
sleep 1
echo ""
echo -ne "$green""Checking necessary packages with your current repositories ...."
chkpkg
echo ""
sleep 2
echo -ne "$green""* - Checking file permissions ..."
chmod +x powerfull.sh
chmod +x update
chmod +x backdoor_apk
chmod +x chk_tools
chmod +x tools/power.py
chmod +x tools/android-sdk/zipalign
chmod +x tools/baksmali233/baksmali
chmod +x tools/android-sdk/dx
chmod +x tools/android-sdk/aapt
chmod +x tools/apktool/apktool
chmod +x tools/android-string-obfuscator/lib/aso
chmod +x tools/pump.py
chmod +x tools/pw_exec.py
chmod +x tools/trusted_2_6.py
echo "Done"
sleep 0.5
clear
#Banner dong biar keren
echo -e "$green" ""
echo "___________         __  __________          __    "
echo "\_   _____/_____  _/  |_\______   \_____  _/  |_  "
echo " |    __)  \__  \ \   __\|       _/\__  \ \   __\ "
echo " |     \    / __ \_|  |  |    |   \ / __ \_|  |   "
echo " \___  /   (____  /|__|  |____|_  /(____  /|__|   "
echo "     \/         \/              \/      \/        "
echo "                 ____    ________                 "
echo "                /_   |  /   __   \                "
echo "                 |   |  \____    /                "
echo "                 |   |     /    /                 "
echo "                 |___| /\ /____/                  "
echo "                       \/                         "
echo ""
echo -e "$blue" "         Setup Script for FATRAT 1.9.7       "
echo "------------------------------------------------------" > "$log"
echo "| Tools paths configured in setup.sh for TheFatRat |" >> "$log"
echo "------------------------------------------------------" >> "$log"
echo "                                                      " >> "$log"
echo ""
#Detect if user OS is 32Bit or 64bit
case "$arch" in
x86_64|aarch64) 
echo -e "$yellow" "              64Bit OS detected"
echo ""
;;
i386|i486|i586|i686)
echo -e "$yellow" "              32Bit OS detected"
echo ""
;;
*)
echo -e "$red" "Setup will not proceed because none of these archs were detected"
echo ""
echo -e "$blue" "x86_64|i386|i486|i586|i686|aarch64"
echo ""
echo -e "$green" "Your linux arch: $blue $arch $green is not supported"
echo ""
echo -e "Press any key to continue"
read -r abor
exit 0
;;
esac
echo -e "$green" "Checking type of shell ...."
sleep 1

#Check if user is using a remote shell or a local terminal
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  echo "[remote]"
echo ""
    echo -e "$red" "Fatrat & Setup does not work over a remote secure shell ."
    echo ""
echo -e "$green" "If you want to Install Fatrat on a remote computer then "
echo -e "$green" "use a remote desktop connection like rdesktop or vnc) "
echo ""
echo -e "$green" "Press [ENTER] key to exit"
read -r abor
exit 1
else
echo "[local]"
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi
sleep 1
which nc > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo ""
else
sudo apt-get install netcat -y > /dev/null 2>&1
fi
sleep 1
#First check of setup for internet connection by connecting to google over http
echo -e "$green" "[ * ] Checking for internet connection"
sleep 1
echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
if [ $? -ne 0 ]; then
echo -e "$red" [ X ]::[Internet Connection]: OFFLINE!;
chknet
    sleep 1
else
echo -e "$green" [ ✔ ]::[Internet Connection]: CONNECTED!;
    sleep 1
    cont
fi

#ping -c 1 google.com > /dev/null 2>&1
#png="$?" 
# if [ $png == "0" ]
#then
#ping google hostname was succefully , then proceed with setup 
#    echo -e $green [ ✔ ]::[Internet Connection]: CONNECTED!;
#    sleep 1
#    cont
#elif [ $png == "1" ]
#then
#ping hostname failed , load chknet function
#    echo -e $yellow [ X ]::[Internet Connection]: LOCAL ONLY!;
#    chknet
#    sleep 1
#elif [ $png == "2" ]
#then
#ping hostname failed , load chknet function
#echo -e $red [ X ]::[Internet Connection]: OFFLINE!;
#chknet
#    sleep 1
#fi
