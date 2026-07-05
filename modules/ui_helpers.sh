spinlong ()
{
    echo -e "\n"
    bar=" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
    barlength=${#bar}
    i=0
    while ((i < 100)); do
        n=$((i*barlength / 100))
        printf "\e[00;32m\r[%-${barlength}s]\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.02
    done
}


# Spinner For Random Seed Generator
spinlong2 ()
{
    echo -e "\n"
    bar=" 01100111001001001110111001101010101010110101001010111001010101010101010"
    barlength=${#bar}
    i=0
    while ((i < 100)); do
        n=$((i*barlength / 100))
        printf "\e[00;32m\r[%-${barlength}s]\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.02
    done
}

# Check if configuration file for grab script exists in /config folder
# Case grab config does not exist then create a default config with 60 seconds

if [[ ! -f "$grab" ]]; then
	echo "------------------------------------------------------------" > "$grab"
	echo "| Timeout configuration for Msfconsole file Grabber Script |" >> "$grab"
	echo "------------------------------------------------------------" >> "$grab"
	echo "60" >> "$grab"
fi

# Default Local Host & Port file creation function
function confdefault () {
clear
confd="$path/config/conf.def"
lh=$(sed -n 1p "$confd")
lp=$(sed -n 2p "$confd")

if [[ -f "$confd" ]]; then
clear
	echo -e "$okegreen"" "
	echo "Fatrat detected that exists a default config file
	with the following values :"
	echo ""
	echo "LHOST : $lh "
	echo "LPORT : $lp "
	echo ""
	read -rsp $'Press [ENTER] key go to options menu \n' -n 1 key
	echo ""
	echo -e "$okegreen" "Select one of the options bellow"
	echo ""
	echo -e "$orange" "+---------------------------------+"
	echo -e "$orange" "|$white [$okegreen 1$white ]$yellow Change current config$orange     |"
	echo -e "$orange" "|$white [$okegreen 2$white ]$yellow Delete configuration file$orange |"
	echo -e "$orange" "|$white [$okegreen 3$white ]$yellow Cancel$orange                    |"
	echo -e "$orange" "+---------------------------------+"
	echo ""
	echo -ne "$okegreen" "Option : ";tput sgr0
	read con
	echo ""
case "$con" in

1)
confd="$path/config/conf.def"
	rm -rf "$confd"
	touch "$confd"
	clear
	echo ""
	echo -e "$okegreen" "Write Lhost value$yellow (ex: 192.168.1.1 or mydomain.com)"
	echo -ne "$okegreen" "LHOST : ";tput sgr0
	read val
	if [[ -z "$val" ]]
		then
			confdefault
		else
			echo "$val" > "$confd"
	fi
			echo ""
			echo -e "$okegreen" "Write Lport value$yellow (Must be a port between 1 & 65535)"
			echo -ne "LPORT : ";tput sgr0
			read val
	if [[ -z "$val" ]]; then
			confdefault
		else
			echo "$val" >> "$confd"
	fi
	
	echo -e "$okegreen" ""
	read -rsp $'Configuration created , restart fatrat , Press [ENTER] key to exit fatrat \n' -n 1 key
	clear
	
exit 0
;;

2)
	clear
	echo -e "$okegreen" ""
	rm -rf "$confd"
	echo "Default configuration file was deleted , you will now have
	to input Lhost & Lport values manually in fatrat options ."
	echo ""
	read -rsp $'Press [ENTER] key to return to fatrat menu\n' -n 1 key
	clear
	menu

;;

3)
	clear
	menu

;;
   esac

else
	echo -e "$okegreen" ""
	echo "No default configuration file detected "
	read -rsp $'Press [ENTER] key to go to options \n' -n 1 key
	echo ""
	clear
	echo -e "$okegreen" "Select one of the options bellow"
	echo ""
	echo -e "$orange" "+---------------------+"
	echo -e "$orange" "|$white [$okegreen 1$white ]$yellow Create config$orange |"
	echo -e "$orange" "|$white [$okegreen 2$white ]$yellow Cancel$orange        |"
	echo -e "$orange" "+---------------------+"
	echo ""
	echo -ne "$okegreen" "Option : ";tput sgr0
	read -r con
	echo ""
case "$con" in
1)
confd="$path/config/conf.def"
	touch "$confd"
	echo ""
	echo -e "$okegreen" "Write Lhost value$yellow (ex: 192.168.1.1 or mydomain.com)"
	echo -ne "$okegreen" "LHOST : ";tput sgr0
	read -r val
	if [[ -z "$val" ]]; then
		confdefault
	else
		echo "$val" > "$confd"
	fi
		echo ""
		echo -e "$okegreen" "Write Lport value$yellow (Must be a port between 1 & 65535)"
		echo -ne "LPORT : ";tput sgr0
		read -r val
	if [[ -z "$val" ]]; then
		confdefault
	else
		echo "$val" >> "$confd"
	fi
		echo -e "$okegreen" ""
		read -rsp $'Configuration created , restart fatrat , Press [ENTER] key to exit fatrat \n' -n 1 key
		clear
exit 0
;;

2)
	clear
	menu
;;
*)
	echo -e "$red" ""
	read -rsp $ "Invalid Option"
	confdefault
;;
   esac
fi
}

# Verify user Input Values on Manual LHOST, LPORT & FILENAME
function invalid (){
err=0
echo ""

if [[ -z "$yourip" ]]; then
	echo -e "$red" ""
	echo "[ ! ] You must write an IP or Hostname ."
	echo -e "$okegreen" ""
	echo "IP Example : 192.168.1.34
	Domain Example : myhost.com"
	err=1
fi
	echo ""
if [[ -z "$yourport" ]]; then
	echo -e "$red" ""
	echo "[ ! ] You must write a port number between 1 & 65535 ."
	err=1
fi

if [[ -z "$fira" ]]; then
	echo -e "$red" ""
	echo "[ ! ] You must write a filename ."
	echo -e "$okegreen" ""
	echo "Filename Example : myfile"
	err=1
fi
echo -e "$okegreen" ""
}

#Selection of Executable and verify if exists for backdoor-factory
function selexe(){
echo ""
          echo -e $okegreen "Enter the path to your EXE file .(ex: /root/downloads/myfile.exe)"
          echo ""
          echo -ne $cyan "Path : ";tput sgr0
          read -r exef
		if [[ ! -f "$exef" ]]
			then
				echo ""
				echo -e "$red" "File does not exist , make sure you write the right path of it ."
				echo ""
				echo -e "$okegreen" "Press [ENTER] key to try again ."
				read -r preflight_check
				selexe
		fi
}

#Apk Embeded File Selection and Verify if User Path Is Correct
function selapk(){
echo ""
          echo -e $okegreen "Enter the path to your android app/game .(ex: /root/downloads/myapp.apk)"
          echo ""
          echo -ne $cyan "Path : ";tput sgr0
          read exef
		if [ ! -f $exef ]
			then
				echo ""
				echo -e $red "File does not exist , make sure you write the right path of it ."
				echo ""
				echo -e $okegreen "Press [ENTER] key to try again ."
				read preflight_check
				selapk
		fi
}

#Debian Embeded File Selection and Verify if User Path is Correct
function seldeb(){
echo ""
          echo -e $okegreen "Enter the path to your deb file .(ex: /root/downloads/dirbuster.deb)"
          echo ""
          echo -ne $cyan "Path : ";tput sgr0
          read exef
		if [ ! -f $exef ]
			then
				echo ""
				echo -e $red "File does not exist , make sure you write the right path of it ."
				echo ""
				echo -e $okegreen "Press [ENTER] key to try again ."
				read preflight_check
				seldeb
		fi
}

#Verification of User input for Lhost & Lport Only
function invalid1(){
err=0
echo ""
if [ -z "$yourip" ]; then
	echo -e $red ""
	echo "[ ! ] You must write an IP or Hostname ."
	echo -e $okegreen ""
	echo "IP Example : 192.168.1.34
	Domain Example : myhost.com"
	err=1
fi

	echo ""
if [ -z "$yourport" ]; then
	echo -e $red ""
	echo "[ ! ] You must write a port number between 1 & 65535 ."
	err=1
fi
	echo -e $okegreen ""
}


# This function is not active yet because user may input an hostame

valid_ip(){
# Verify if user ip input is valid
if [[ $yourip =~ ^[0-255]+\.[0-255]+\.[0-255]+\.[0-255]+$ ]]; then
  echo ""
  	err=1
else
  	err=0
fi
}

#Checking if your Command is correct
gboor(){
gboor(){
echo -e $yellow ""
cat << !
  Generate Backdoor
  +------------++-------------------------++-----------------------+
  | Name       ||  Descript   	          || Your Input
  +------------++-------------------------++-----------------------+
  | LHOST      ||  The Listen Addres      || $yourip
  | LPORT      ||  The Listen Ports       || $yourport
  | OUTPUTNAME ||  The Filename output    || $fira
  | PAYLOAD    ||  Payload To Be Used     || $payload
  +------------++-------------------------++-----------------------+


!
}

#Checking if your Command is Correct when embed backdoor
gboor2(){
echo -e $ ""
cat << !
  Generate Backdoor
  +------------++-------------------------++-----------------------+
  | Name       ||  Descript   	          || Your Input
  +------------++-------------------------++-----------------------+
  | LHOST      ||  The Listen Addres      || $yourip
!
