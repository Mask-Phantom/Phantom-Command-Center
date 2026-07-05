function ssplt() {

# check if searchsploit exists
which searchsploit > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e "$green" "[ ✔ ] Searchsploit......................[ found ]"
echo "searchsploit" | tee -a "$config" "$log" > /dev/null 2>&1
echo "Searchsploit -> OK" >> "$inst"
sleep 1
else
echo -e "$red" "[ X ] searchsploit  -> not found"
echo ""
echo -e "$green" "Select one of the options bellow"
echo -e "$orange" "+-------------------------------------------------+"
echo -e "$orange" "|$white [$green 1$white ]$yellow Setup Searchsploit Path Manually$orange          |"
echo -e "$orange" "|$white [$green 2$white ]$yellow Install Searchsploit from Kali Repository$orange |"
echo -e "$orange" "+-------------------------------------------------+"
echo ""
echo -ne "$green" "Option : ";tput sgr0
read -r q1
case $q1 in
 
1)
echo ""
echo -e "$green" "Enter The Path of your Searchsploit instalation"
echo -e "$cyan" "ex : /opt/searchsploit/searchsploit"
echo ""
echo -ne "$green" "PATH : ";tput sgr0
read sspp
if [ ! -f "$sspp" ]
then
echo ""
echo -e "$red" "It was not possible to found searchsploit executable in : $sspp"
echo ""
echo -e "$green" "Make sure you write the right path of your instalation"
echo ""
echo -e "$green" "Press [ENTER] key to try again ."
read -r cont
ssplt
else
echo bash "$sspp" | tee -a "$config" "$log" > /dev/null 2>&1
echo "Searchsploit -> OK" >> "$inst"
fi
;;

#ok
2)
echo -e "$yellow" "[ ! ]  Installing Searchsploit "
xterm -T "☣ INSTALL SEARCHSPLOIT ☣" -geometry 100x30 -e "sudo apt-get install exploitdb -y"
which searchsploit > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e "$green" "[ ✔ ] Searchsploit"
echo "searchsploit" | tee -a "$config" "$log" > /dev/null 2>&1
echo "Searchsploit -> OK" >> "$inst"
else
echo "0" > "$stp"
echo "Searchsploit -> Not OK" >> "$inst"
fi
;;
*)
ssplt
;;
esac
fi
echo ""
#Go check the check file exists and read its value
chk="$path/logs/check"
if [ -f "$chk" ]
then
ct=`sed -n 1p "$chk"`
#if value of check is 0 theen some package was not installed sucefully 
if [ "$ct" == "0" ]; then
clear
echo -e "$red" "Fatrat was not able to install some packages"
echo ""
echo -e "$blue" "Reactivating your original repositories"
rm -f /etc/apt/sources.list
mv /etc/apt/sources.list.backup /etc/apt/sources.list
#now we can remove the emergency backup securely
rm -f /etc/apt/sources.list.fatrat
apt-get clean
xterm -T "☣ UPDATE YOUR REPO ☣" -geometry 100x30 -e "sudo apt-get update "
clear
rm -rf "$config" >/dev/null 2>&1

#Display to user the install.log file and inform him what to do
echo "Was not possible to install The Packages Labeled (Not Ok) in this list above" >> "$inst"
echo "Try : (apt-get remove --purge <packagename> && apt-get autoremove && apt-get install -f)" >> "$inst"
echo "before running fatrat setup script again" >> "$inst"
cat "$inst"
exit
elif [ "$ct" == "1" ]; then
echo ""
#value in check file is 1 , then everything is ok , delete install.log file and proceed to finish setup
rm -rf "$inst" >/dev/null 2>&1
fi
else
#in case value in check file is not 0 or 1 then something is wrong
echo -e "$green" "Something went very wrong , execute ./setup.sh again"
rm -rf "$config" >/dev/null 2>&1
echo ""
echo "Was not possible to install The Packages Labeled (Not Ok) in this list above" >> "$inst"
echo "Try : (apt-get remove --purge <packagename> && apt-get autoremove && apt-get install -f)" >> "$inst"
echo "before running fatrat setup script again" >> "$inst"
echo "" >> "$inst"
echo "***********Your current sources.list***************"
sclst=`cat /etc/apt/sources.list`
echo "$sclst" >> "$inst"
echo "***************Finish sources.list*****************" >> "$inst"
dist=`uname -a`
echo "" >> "$inst"
echo "Your linux distribution :" >> "$inst"
echo "$dist" >> "$inst"
cat "$inst"
echo -e "$lightgreen" "This log file can be found in : $inst "
exit
fi
}
function bkf() {
# Check if backdoor-factory exists

which backdoor-factory > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e "$green" "[ ✔ ] Backdoor-Factory..................[ found ]"
echo "backdoor-factory" | tee -a "$config" "$log" > /dev/null 2>&1
echo "Backdoor-Factory -> OK" >> "$inst"
sleep 1
ssplt
else
echo -e "$red" "[ X ] backdoor-factory  -> not found "
echo ""

echo ""
echo -e "$green" "Select one of the options bellow"
echo -e "$orange" "+-----------------------------------------------------+"
echo -e "$orange" "|$white [$okegreen 1$white ]$yellow Setup Backdoor-Factory Path Manually$orange          |"
echo -e "$orange" "|$white [$okegreen 2$white ]$yellow Install Backdoor-Factory from Kali Repository$orange |"
echo -e "$orange" "+-----------------------------------------------------+"
echo ""
echo -ne "$green" "Option : ";tput sgr0
read -r q2
case "$q2" in

1)
echo ""
echo -e "$green" "Enter The Path of your backdoor-factory instalation"
echo -e "$cyan" "ex : /opt/backdoor-factory/backdoor.py"
echo ""
echo -ne "$green" "PATH : ";tput sgr0
read -r msp
bkdf="$msp"
if [ ! -f "$bkdf" ]
then
echo ""
echo -e "$red" "It was not possible to found backdoor-factory executable in : $bkdf"
echo ""
echo -e "$green" "Make sure you write the right path of your instalation"
echo ""
echo -e "$green" "Press [ENTER] key to try again ."
read -r cont
bkf
fi
echo "python3 $bkdf" | tee -a "$config" "$log" > /dev/null 2>&1
echo "Backdoor-factory -> OK" >> "$inst"
ssplt
;;

2)
echo -e "$yellow" "[ ! ] Installing backdoor-factory "
xterm -T "☣ INSTALL BACKDOOR-FACTORY ☣" -geometry 100x30 -e "sudo apt-get install backdoor-factory  -y"
which backdoor-factory > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e "$green" "[ ✔ ] Backdoor-Factory -> OK"
echo "backdoor-factory" | tee -a "$config" "$log" > /dev/null 2>&1
echo "Backdoor-factory -> OK" >> "$inst"
ssplt
else
echo -e "$red" "[ X ] backdoor-factory"
echo "0" > "$stp"
echo "Backdoor-factory -> Not OK" >> "$inst"
ssplt
fi
;;

*)
bkf
;;
esac
fi
}

function mtspl() {
# check if metasploit-framework its installed
which msfconsole > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e "$green" "[ ✔ ] Metasploit-Framework..............[ found ]"
echo "msfconsole" | tee -a "$config" "$log" >> /dev/null 2>&1
echo "msfvenom" | tee -a "$config" "$log" >> /dev/null 2>&1
echo "Metasploit -> OK" >> "$inst"
sleep 1
bkf
else
echo -e "$red" "[ X ] metasploit-framework -> not found "

# Providing manual input to user in case metasploit was installed from git and is not on system path

echo ""
echo -e "$green" "Select one of the options bellow"
echo -e "$orange" "+---------------------------------------------------------+"
echo -e "$orange" "|$white [$okegreen 1$white ]$yellow Setup Metasploit Framework Path Manually$orange          |"
echo -e "$orange" "|$white [$okegreen 2$white ]$yellow Install Metasploit Framework from Kali Repository$orange |"
echo -e "$orange" "+---------------------------------------------------------+"
echo ""
echo -ne "$green" "Option : ";tput sgr0
read -r q3
case "$q3" in
1)
echo ""
echo -e "$green" "Enter The Path of your metasploit instalation"
echo -e "$cyan" "ex : /opt/metasploit-framework"
echo ""
echo -ne "$green" "PATH : ";tput sgr0
read -r msp
msfc="$msp/msfconsole"
msfv="$msp/msfvenom"
if [ ! -f "$msfc" ]
then
echo ""
echo -e "$red" "It was not possible to found msfconsole in : $msfc"
echo ""
echo -e "$green" "Make sure you write the right path of your instalation"
echo ""
echo -e "$green" "Press [ENTER] key to try again ."
read -r cont
mtspl
fi
if [ ! -f "$msfv" ]
then
echo ""
echo -e "$red" "It was not possible to found msfvenom in : $msfv"
echo ""
echo -e "$green" "Make sure you write the right path of your instalation"
echo ""
echo -e "$green" "Press [ENTER] key to try again ."
read -r cont
mtspl
fi
#Creation of symlinks to metasploit manual path in /usr/local/sbin to avoid changes in fatrat scripts

unlink /usr/local/sbin/msfconsole > /dev/null 2>&1
unlink /usr/local/sbin/msfvenom > /dev/null 2>&1
ln -s "$msfc" /usr/local/sbin/msfconsole > /dev/null 2>&1
ln -s "$msfv" /usr/local/sbin/msfvenom > /dev/null 2>&1
echo "msfconsole" | tee -a "$config" "$log" > /dev/null 2>&1
echo "msfvenom" | tee -a "$config" "$log" > /dev/null 2>&1
echo "Metasploit -> OK" >> "$inst"
bkf
;;

2)
echo -e "$yellow" "[ ! ] Installing Metasploit-Framework  "
xterm -T "☣ INSTALL METASPLOIT-FRAMEWORK ☣" -geometry 100x30 -e "sudo apt-get install metasploit-framework  -y"
which msfconsole > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e "$green" "[ ✔ ] Metasploit - msfconsole -> OK"
echo "msfconsole" | tee -a "$config" "$log" > /dev/null 2>&1
echo "Metasploit - msfconsole -> OK" >> "$inst"
else
echo -e "$red" "[ x ] Metasploit - msfconsole"
echo "Metasploit - msfconsole -> Not OK" >> "$inst"
echo "0" > "$stp"
fi
which msfvenom > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e "$green" "[ ✔ ] Metasploit \(msfvenom\) -> OK"
echo "msfvenom" | tee -a "$config" "$log" > /dev/null 2>&1
echo "Metasploit - msfvenom -> OK" >> "$inst"
else
echo -e "$red" "[ x ] Metasploit - msfvenom"
echo "0" > "$stp"
echo "Metasploit - msfvenom -> Not OK" >> "$inst"
fi
bkf
;;
*)
mtspl
;;
esac
fi
}


