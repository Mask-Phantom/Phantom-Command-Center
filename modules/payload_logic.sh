function pldbkf(){
	echo ""
	echo -e $orange "  +--------------------------------------------+"
	echo -e $orange "  |$white [$okegreen 1$white ]$yellow cave_miner_inline$orange                    |"
	echo -e $orange "  |$white [$okegreen 2$white ]$yellow iat_reverse_tcp_inline$orange               |"
	echo -e $orange "  |$white [$okegreen 3$white ]$yellow iat_reverse_tcp_inline_threaded$orange      |"
	echo -e $orange "  |$white [$okegreen 4$white ]$yellow iat_reverse_tcp_stager_threaded$orange      |"
	echo -e $orange "  |$white [$okegreen 5$white ]$yellow iat_user_supplied_shellcode_threaded$orange |"
	echo -e $orange "  |$white [$okegreen 6$white ]$yellow meterpreter_reverse_https_threaded$orange   |"
	echo -e $orange "  |$white [$okegreen 7$white ]$yellow reverse_shell_tcp_inline$orange             |"
	echo -e $orange "  |$white [$okegreen 8$white ]$yellow reverse_tcp_stager_threaded$orange          |"
	echo -e $orange "  |$white [$okegreen 9$white ]$yellow user_supplied_shellcode_threaded$orange     |"
	echo -e $orange "  +--------------------------------------------+"
	echo ""
	echo -ne $okegreen "  Choose Payload : ";tput sgr0
	read pld
		case $pld in
			1)
				payload="cave_miner_inline"
			;;

			2)
				payload="iat_reverse_tcp_inline"
			;;

			3)
				payload="iat_reverse_tcp_inline_threaded"
			;;

			4)
				payload="iat_reverse_tcp_stager_threaded"
			;;
			
			5)
				payload="iat_user_supplied_shellcode_threaded"
			;;

			6)
				payload="meterpreter_reverse_https_threaded"
			;;
			
			7)
				payload="reverse_shell_tcp_inline"
			;;
			
			8)
				payload="reverse_tcp_stager_threaded"
			;;

			9)
				payload="user_supplied_shellcode_threaded"
			;;
			
			*)
				echo ""
				echo -ne $red "Wrong input , choose between 1 and 9 :"
				pldbkf
			;;
	esac
}

# Linux MSFVENOM Payload Selection
# Manual Generation : https://www.offensive-security.com/metasploit-unleashed/msfvenom/

function pldlnx(){
	echo ""
	echo -e $orange "  +-----------------------------------------+"
	echo -e $orange "  |$white [$okegreen 1$white ]$yellow linux/ppc/shell_reverse_tcp$orange       |"
	echo -e $orange "  |$white [$okegreen 2$white ]$yellow linux/x86/shell_reverse_tcp$orange       |"
	echo -e $orange "  |$white [$okegreen 3$white ]$yellow linux/x86/meterpreter/reverse_tcp$orange |"
	echo -e $orange "  |$white [$okegreen 4$white ]$yellow osx/armle/shell_reverse_tcp$orange       |"
	echo -e $orange "  |$white [$okegreen 5$white ]$yellow osx/ppc/shell_reverse_tcp$orange         |"
	echo -e $orange "  |$white [$okegreen 6$white ]$yellow bsd/x86/shell/reverse_tcp$orange         |"
	echo -e $orange "  |$white [$okegreen 7$white ]$yellow solaris/x86/shell_reverse_tcp$orange     |"
	echo -e $orange "  +-----------------------------------------+"
	echo ""
	echo -ne $okegreen "  Choose Payload : ";tput sgr0
	read pld
		case $pld in
			1)
				payload="linux/ppc/shell_reverse_tcp"
			;;

			2)
				payload="linux/x86/shell_reverse_tcp"
			;;

			3)
				payload="linux/x86/meterpreter/reverse_tcp"
			;;
			
			4)
				payload="osx/armle/shell_reverse_tcp"
			;;

			5)
				payload="osx/ppc/shell_reverse_tcp"
			;;
			
			6)
				payload="bsd/x86/shell/reverse_tcp"
			;;

			7)
				payload="solaris/x86/shell_reverse_tcp"
			;;
			
			*)
				echo ""
				echo -ne $red "Wrong input , choose between 1 and 7 :"
				pldlnx
			;;
	esac
}

# Windows MSFVENOM Payload Selection
# Manual Generation : https://www.offensive-security.com/metasploit-unleashed/msfvenom/

function pldwin(){
	echo ""
	echo -e $orange "  +-------------------------------------------+"
	echo -e $orange "  |$white [$okegreen 1$white ]$yellow windows/shell_bind_tcp$orange              |"
	echo -e $orange "  |$white [$okegreen 2$white ]$yellow windows/shell/reverse_tcp$orange           |"
	echo -e $orange "  |$white [$okegreen 3$white ]$yellow windows/meterpreter/reverse_tcp$orange     |"
	echo -e $orange "  |$white [$okegreen 4$white ]$yellow windows/meterpreter/reverse_tcp_dns$orange |"
	echo -e $orange "  |$white [$okegreen 5$white ]$yellow windows/meterpreter/reverse_http$orange    |"
	echo -e $orange "  |$white [$okegreen 6$white ]$yellow windows/meterpreter/reverse_https$orange   |"
	echo -e $orange "  +-------------------------------------------+"
	echo ""
	echo -ne $okegreen "  Choose Payload :";tput sgr0
	read pld
		case $pld in
			1)
				payload="windows/shell_bind_tcp"
			;;
			
			2)
				payload="windows/shell/reverse_tcp"
			;;

			3)
				payload="windows/meterpreter/reverse_tcp"
			;;

			4)
				payload="windows/meterpreter/reverse_tcp_dns"
			;;
			
			5)
				payload="windows/meterpreter/reverse_http"
			;;

			6)
				payload="windows/meterpreter/reverse_https"
			;;
			
			*)
				echo ""
				echo -e $red "Wrong input , choose between 1 and 6"
				pldwin
			;;
	esac
}

# Android msfvenom payload selection
function pldand () {
	echo ""
	echo -e $orange "  +-------------------------------------------+"
	echo -e $orange "  |$white [$okegreen 1$white ]$yellow android/meterpreter/reverse_http$orange    |"
	echo -e $orange "  |$white [$okegreen 2$white ]$yellow android/meterpreter/reverse_https$orange   |"
	echo -e $orange "  |$white [$okegreen 3$white ]$yellow android/meterpreter/reverse_tcp$orange     |"
	echo -e $orange "  |$white [$okegreen 4$white ]$yellow android/shell/reverse_http$orange          |"
	echo -e $orange "  |$white [$okegreen 5$white ]$yellow android/shell/reverse_https$orange         |"
	echo -e $orange "  |$white [$okegreen 6$white ]$yellow android/shell/reverse_tcp$orange           |"
	echo -e $orange "  +-------------------------------------------+"
	echo ""
	echo -ne $okegreen "  Choose Payload : ";tput sgr0
	read pld
		case $pld in
			1)
				payload="android/meterpreter/reverse_http"
			;;

			2)
				payload="android/meterpreter/reverse_https"
			;;

			3)
				payload="android/meterpreter/reverse_tcp"
			;;
			
			4)
				payload="android/shell/reverse_http"
			;;

			5)
				payload="android/shell/reverse_https"
			;;
			
			6)
				payload="android/shell/reverse_tcp"
			;;
			
			*)
				echo ""
				echo -e $red "Wrong input , choose between 1 and 6"
				pldand
			;;
	esac
}

# MAC MSFVENOM Payload Selection
function pldmac(){
	echo ""
	echo -e $orange "  +--------------------------------------+"
	echo -e $orange "  |$white [$okegreen 1$white ]$yellow python/meterpreter/reverse_tcp$orange |"
	echo -e $orange "  |$white [$okegreen 2$white ]$yellow generic/shell_reverse_tcp$orange      |"
	echo -e $orange "  +--------------------------------------+"
	echo ""
	echo -ne $okegreen "  Choose Payload : ";tput sgr0
	read pld
		case $pld in
			1)
				payload="python/meterpreter/reverse_tcp"
			;;
			
			2)
				payload="generic/shell_reverse_tcp"
			;;
			
			*)
				echo ""
				echo -e $red "Wrong input , choose between 1 and 2"
				pldmac
			;;
	esac
}

# Linux multi msfvenom payload selection
function pldmul() {
	echo ""
	echo -e $orange "  +------------------------------------------+"
	echo -e $orange "  |$white [$okegreen 1$white ]$yellow python/meterpreter/reverse_tcp$orange     |"
	echo -e $orange "  |$white [$okegreen 2$white ]$yellow python/meterpreter/reverse_http$orange    |"
	echo -e $orange "  |$white [$okegreen 3$white ]$yellow python/meterpreter/reverse_https$orange   |"
	echo -e $orange "  |$white [$okegreen 4$white ]$yellow python/meterpreter_reverse_http$orange    |"
	echo -e $orange "  |$white [$okegreen 5$white ]$yellow python/meterpreter_reverse_https$orange   |"
	echo -e $orange "  |$white [$okegreen 6$white ]$yellow python/shell_reverse_tcp$orange           |"
	echo -e $orange "  |$white [$okegreen 7$white ]$yellow python/meterpreter/reverse_tcp_ssl$orange |"
	echo -e $orange "  +------------------------------------------+"
	echo ""
	echo -ne $okegreen "  Choose Payload : ";tput sgr0
	read pld
		case $pld in
			1)
				payload="python/meterpreter/reverse_tcp"
			;;
			
			2)
				payload="python/meterpreter/reverse_http"
			;;
			
			3)
				payload="python/meterpreter/reverse_https"
			;;
			
			4)
				payload="python/meterpreter_reverse_http"
			;;

			5)
				payload="python/meterpreter_reverse_https"
			;;
			
			6)
				payload="python/shell_reverse_tcp"
			;;
			
			7)
				payload="python/meterpreter/reverse_tcp_ssl"
			;;
			
			*)
				echo ""
                                echo -e $red "Wrong input , choose between 1 and 7"
                                pldmul
                        ;;
esac
}
