#!/bin/bash

###Customize Kali Linux to achieve a hacker-style.
#0x4r2 ®


# check if not root
if [ "$(id -u)" = "0" ]; then
    echo "Este script no debe ser ejecutado como root."
    exit 1
fi

USERNAME=$USER

function showhelp()
{
 echo -e "Usage:\n$0 options [-a] [-b] [-c] [-t] [-p] [-m] [-h|--help]

 
 -a|--all        	all custom (default)
 -c|--custom     	wallpapers, alias, functions
 -t|--tools 	 	update and install tools and pimpmykali
 -p|--panel		 	customize panel (workspaces,monitors,panelbar)
 -m|--monitors-bar 	download monitors for CTFs" 

    exit 0
}

function tools()
{
	#______Global Update________
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt install open-vm-tools

	#______Custom Software______
	sudo apt install -y tree locate
	sudo apt install -y jq
	sudo apt install -y mtr
	sudo apt install -y htop
	sudo apt install -y fcrackzip  
	sudo apt install -y html2text
	sudo apt install -y bat
	sudo apt install -y steghide
	sudo apt install -y smbclient
	sudo apt install -y enum4linux
	sudo apt install -y smbmap
	sudo apt install -y xsltproc
	sudo apt install -y moreutils
	sudo apt install -y docker.io
	sudo apt install -y figlet   
	sudo apt install -y xclip
	sudo apt install -y git
	sudo apt install -y gobuster ffuf dirbuster hydra dirb
	sudo apt install -y xmlstarlet
	#sudo apt install -y rofi caja gedit

	#______Enable services________
	sudo systemctl enable ssh
	sudo systemctl start ssh

	#______Hackfonts________
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip -N -O /tmp/hackfonts.zip
	sudo unzip -o -d /usr/local/share/fonts /tmp/hackfonts.zip

	#______PimpMyKali________
	sudo git clone https://github.com/Dewalt-arch/pimpmykali /opt/pimpmykali
	### Disable prompt root login, option N
	sudo sed -i 's/read -n1 -p "   Please type Y or N : " userinput/userinput="N"/g' /opt/pimpmykali/pimpmykali.sh
	sudo /opt/pimpmykali/pimpmykali.sh --all
}

function custom()
{
#______Custom Images________
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/desktop.png -N -O /usr/share/backgrounds/desktop.png
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/profile.png -N -O /usr/share/backgrounds/profile.png
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/login.png  -N -O /usr/share/backgrounds/login.png

xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorVirtual1/workspace0/last-image --set "/usr/share/backgrounds/desktop.png"


cat << 'EOF' > /tmp/lightdm-gtk-greeter.conf 
[greeter]
background = /usr/share/backgrounds/login.png
theme-name = Kali-Dark
xft-antialias = true
xft-hintstyle = slight
xft-rgba = rgb
font-name = Hack Nerd Font Mono 11
icon-theme-name = Flat-Remix-Blue-Light
xft-dpi = 96
indicators = ~host;~spacer;~session;~layout;~a11y;~clock;~power;
clock-format = %d %b, %H:%M
screensaver-timeout = 60
default-user-image = /usr/share/backgrounds/profile.png
keyboard = onboard
position = 85%,end -50%,center
EOF


sudo mv /tmp/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf 

echo -e "\n[+] Custom Images successfully \n \
for change images please replace:\n\n \
	\t-> Wallpaper: /usr/share/backgrounds/desktop.png \n \
	\t-> Login Screen: /usr/share/backgrounds/login.png \n \
	\t-> Profile: /usr/share/backgrounds/profile.png \n "



#_______Custom Keyboard_________
wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/xfce4-keyboard-shortcuts.xml -N -O /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/keyboard-layout.xml -N -O /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/keyboard-layout.xml


#______Custom Functions________

cat <<'EOF' >> /home/$USERNAME/.zshrc

#-------------------------------------
#	ALIASES
#------------------------------------
alias pingg='ping -c 4 -w1 -i1 8.8.8.8'
alias cat='/usr/bin/batcat --paging=never'
alias catn='/usr/bin/cat'
alias catl='/usr/bin/batcat'
alias historial='/usr/bin/batcat ~/.zsh_history'
alias imagen="kitty +kitten icat"

#--------------------------------------
#	FUNCTIONS
#-------------------------------------
#  PT new folders
function  mkdir_HTB(){
	mkdir $1
	cd $1
	mkdir {content,scan,exploit}
	touch "notas.txt"
	#touch $2
}

function set_target(){
	echo "$1" > /tmp/.target
}

function del_target(){
	rm -rf /tmp/.target
}


function go_HTB(){
	nmcli con up HTB 2>/dev/null
	clear
    	sudo ip route delete default via 10.10.16.1
	figlet Welcome to The Matrix -c
}

function stop_HTB(){
 #	pid=$(sudo ps -aux |grep openvpn |grep -v grep |awk '{print $2}')
#	sudo kill -9 $pid 
	nmcli con down HTB
	figlet Go back to Real Life -c
}

function go_THM(){
        nmcli con up THM 2>/dev/null
#        sudo ip route delete default via 10.9.0.1 2>/dev/null
#        if [ $? -eq 0 ]; then
        figlet Welcome to The Matrix -c
#        else
#                figlet "ERROR..\!"
#        fi
}

function stop_THM(){
        nmcli con down THM
        figlet Go back to Real Life -c
}

function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

function filtrarpuertos(){
        ports="$(cat $1 |grep tcp|grep open |awk '{print $1}' FS=/|xargs |tr ' ' ',')"
        echo $ports | tr -d '\n' | xclip -sel clip
        echo -e "[*] Ports copied to clipboard\n: $ports" 

}
EOF

#_________Custom zsh_________
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$USERNAME/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>/home/$USERNAME/.zshrc
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' |sudo tee -a /root/.zshrc

echo "# To customize prompt, run p10k configure or edit ~/.p10k.zsh. " |sudo tee -a /root/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" |sudo tee -a /root/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" |tee -a /home/$USERNAME/.zshrc

sudo cp -r /home/$USERNAME/powerlevel10k /root

wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/p10k.zsh -N -O /home/$USERNAME/.p10k.zsh
sudo ln -s /home/$USERNAME/.p10k.zsh /root/.p10k.zsh
sudo cp -f /home/$USERNAME/.zshrc /root/.zshrc

echo -e "[+] Custom Complete:
\t-> Wallpapers,login,fonts
\t-> ZSH alias and Functions
\t-> p10K Terminal Personalization"
}

function workspaces()
{
#_______Custom Workspaces_______
wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/xfwm4.xml -N -O  /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
}

function panelbar()
{
#_______Custom Panel Bar________
wget  https://github.com/0x4r2/CustomKali/raw/main/Recursos/custom4r2.tar.bz2 -N -O /home/$USERNAME/.local/share/xfce4-panel-profiles/custom4r2.tar.bz2
xfce4-panel-profiles load /home/$USERNAME/.local/share/xfce4-panel-profiles/custom4r2.tar.bz2
}

function cqterminal()
{
#_______Customize qterminal interface_______
wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/qtermminal.ini -N -O /home/$USERNAME/.config/qterminal.org/qterminal.ini
sudo cp -f /home/$USERNAME/.config/qterminal.org/qterminal.ini /etc/xdg/qterminal.org/qterminal.ini

}

function monitors()
{

#______Custom Monitors________

###
sudo mkdir /opt/custom
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/lan -N -O /opt/custom/lan
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/vpn -N -O /opt/custom/vpn
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/target -N -O /opt/custom/target
sudo chmod +x /opt/custom/*

echo -e "[+] Monitors was added in /opt/custom "
}

function all()
{
tools
custom
workspaces
monitors
panelbar
cqterminal

sudo rm -rf /tmp/*

echo -e "\n\n[+] Instalación Completa !!\n"
read -p "Presiona enter para reiniciar.... "

xfce4-session-logout -r
}


if [ "$1" == "" ]
      then showhelp
else

	case "$1" in
	    -h|--help)
	        showhelp
	        ;;
	    -a|--all)       # all custom (default)
	        all
	        #exit 0
	        ;;
	    -c|--custom)    # wallpapers, alias, functions
	    	custom
	    	exit 0
	        ;;
	    -t|--tools)
	        tools	# update and install tools and pimpmykali
	        exit 0
	        ;;
	    -p|--panel)		# customize panel 
	        workspaces
	        monitors
	        panelbar
	        xfce4-session-logout -l
	        exit 0
	        ;;
	    -m|--monitors-bar)  # download monitors for CTFs
	        monitors
	        exit 0
	        ;;
	    *)        
	        showhelp
	        ;;
	esac
fi   











