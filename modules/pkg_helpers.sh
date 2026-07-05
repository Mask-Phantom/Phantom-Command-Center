function optmingw () {
case $sel in
y|Y|yes|YES|Yes)
echo -n "Removing mingw as requested..."	
xterm -T "☣ REMOVING MINGW ☣" -geometry 100x30 -e "apt remove --purge *mingw* -y && apt autoremove -y"
which x86_64-w64-mingw32-gcc >> /dev/null 2>&1
if [ "$?" != "0" ]; then
echo "Done"
else
echo "Error"
echo ""
echo "Setup was unable to remove mingw Installation"
fi
;;
n|N|No|NO)
echo "Setup will not remove current mingw installation"
echo "However you will encounter issues running Fudwin"
echo -n "in fatrat menu , press ENTER to resume setup"
read -rsp var	
;;
esac	
}	
rchk () {
apt-get update &> /tmp/aptkey.log 
awk '{print $1}' RS='NO_PUBKEY' /tmp/aptkey.log | sed '1d' > /tmp/expkeys.log
awk '{print $1}' RS='EXPKEYSIG' /tmp/aptkey.log | sed '1d' >> /tmp/expkeys.log
sort /tmp/expkeys.log | uniq > /tmp/expkeystmp.log
rm /tmp/expkeys.log && mv /tmp/expkeystmp.log /tmp/expkeys.log
cntk=$(wc -l /tmp/expkeys.log | awk '{print$1}' | sed 's/ //g')
if [[ "$cntk" == "0" ]]
then
echo "[ Done ]"
else
echo "[ Error ]"
echo "Unable to process key for $dist"
echo ""
fi
}	

function repokey () {
echo -ne "$green" "[ ? ] Update Jessie/Kali Repo Public Key"
apt-get update &> /tmp/aptkey.log 
awk '{print $1}' RS='NO_PUBKEY' /tmp/aptkey.log | sed '1d' > /tmp/expkeys.log
awk '{print $1}' RS='EXPKEYSIG' /tmp/aptkey.log | sed '1d' >> /tmp/expkeys.log
cat /tmp/expkeys.log | sort | uniq > /tmp/expkeystmp.log
rm /tmp/expkeys.log && mv /tmp/expkeystmp.log /tmp/expkeys.log
cntk=$(wc -l /tmp/expkeys.log | awk '{print$1}' | sed 's/ //g')
if [[ "$cntk" == "0" ]]
then
echo "[ Done ]"
fi
for i in $(seq $cntk)
do
gtkey=$(sed -n ${i}p /tmp/expkeys.log)
xterm -T "☣ CHECK PUBKEY ☣" -geometry 100x30 -e "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $gtkey &> /tmp/gtkey.log" 
kout=$(grep -w "Total number processed:" /tmp/gtkey.log  | awk -F'Total number processed:' '{print $2}' | sed 's/ //g')
dist=$(grep -o '".*"' /tmp/gtkey.log | sed 's/"//g')
if [[ "$kout" == "1" ]]
then
echo "[ Done ]"
echo "Succefull Key processed for $dist" 
else
rchk
fi
done

}
function mingwchk () {
echo -ne "$green" "[ ? ] Checking Mingw Version............"	
which x86_64-w64-mingw32-gcc >> /dev/null 2>&1
if [ "$?" -eq "0" ]; then
chkvs=$(x86_64-w64-mingw32-gcc --version | sed -n 1p | awk '{print$3}')
echo "[✔]"
else
echo "Not Installed"
fi
}	
