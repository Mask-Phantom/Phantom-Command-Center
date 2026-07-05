function crtdir() {
	echo ""
echo -e "$green""Write output directory for fatrat generated files or press enter to default."
echo -e "$orange""Default :$yellow $HOME/Fatrat_Generated"	
echo ""
echo -ne "$orange""Write: $green"
read -r pth	
if [[ -z "$pth" ]]
then
echo "$HOME/Fatrat_Generated" | tee -a "$config" "$log" > /dev/null 2>&1
mkdir $HOME/Fatrat_Generated > /dev/null 2>&1
else
mkdir -p "$pth" > /dev/null 2>&1
if [[ ! -d "$pth" ]] 
then
echo ""
echo -e "$red""There was an error creating $pth , default directory will be assigned"
echo -ne "$green""Press ENTER to continue"
echo "$HOME/Fatrat_Generated" | tee -a "$config" "$log" > /dev/null 2>&1
mkdir $HOME/Fatrat_Generated > /dev/null 2>&1
else
echo "$pth" | tee -a "$config" "$log" > /dev/null 2>&1
echo ""
echo -e "$orange""All fatrat generated files will be stored in :"
echo -e "$green""$pth"
echo ""
echo -ne "$green""Press ENTER to continue"
read rsp
clear
fi
fi	
}


