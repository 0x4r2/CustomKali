#!/bin/bash

###Customize Kali

# Verificar si el usuario es root
if [ "$(id -u)" = "0" ]; then
    echo "Este script no debe ser ejecutado como root."
    exit 1
fi
 

USERNAME=$(cat /etc/passwd |grep 1000:1000 |awk '{print $1}' FS=:)


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


#______Hackfonts________
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip -O /tmp/hackfonts.zip
sudo unzip -o -d /usr/local/share/fonts /tmp/hackfonts.zip


#______PimpMyKali________
cd /opt
sudo git clone https://github.com/Dewalt-arch/pimpmykali
cd pimpmykali
### Disable prompt root login, option N
cat  pimpmykali.sh | sed 's/read -n1 -p "   Please type Y or N : " userinput/userinput="N"/g' |sudo sponge pimpmykali.sh
sudo ./pimpmykali.sh --all



#______Custom Images________
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/desktop.png -O /usr/share/backgrounds/desktop.png
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/profile.png -O /usr/share/backgrounds/profile.png
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/login.png -O /usr/share/backgrounds/login.png

xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorVirtual1/workspace0/last-image --set "/usr/share/backgrounds/desktop.png"

#sudo ln -sf /usr/share/backgrounds/login.png /usr/share/desktop-base/kali-theme/login/background

cat << 'EOF' > /tmp/lightdm-gtk-greeter.conf 
[greeter]
background = /usr/share/backgrounds/login.png
theme-name = Kali-Dark
xft-antialias = true
xft-hintstyle = slight
xft-rgba = rgb
font-name = Cantarell 11
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

#______Custom Monitors________

###
sudo mkdir /opt/custom
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/lan -O /opt/custom/lan
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/vpn -O /opt/custom/vpn
sudo wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/target -O /opt/custom/target
sudo chmod +x /opt/custom/*



#_______Custom Keyboard_________
xmlstarlet ed --inplace -s "/channel/property/custom" -t elem -n "property" -v "" -i "//property[@name='&lt;Super&gt;p']" -t attr -n "type" -v "string" -i "//property[@name='&lt;Super&gt;p']" -t attr -n "value" -v "qterminal"  /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/keyboard-layout.xml -O /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/keyboard-layout.xml

#________Set 2-4 Workspaces________

#xmlstarlet ed --inplace -u "//property[@name='workspace_count']/@value" -v "2"  /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
#xmlstarlet ed --inplace -d "//property[@name='workspace_names']/value"  /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml

#xmlstarlet ed --inplace -s "//property[@name='workspace_names']" -t elem -n "value" -v "" -i "//property[@name='workspace_names']/value[last()]" -t attr -n "type" -v "string" -i "//property[@name='workspace_names']/value[last()]" -t attr -n "value" -v "P"   /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
#xmlstarlet ed --inplace -s "//property[@name='workspace_names']" -t elem -n "value" -v "" -i "//property[@name='workspace_names']/value[last()]" -t attr -n "type" -v "string" -i "//property[@name='workspace_names']/value[last()]" -t attr -n "value" -v "S"   /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
#xmlstarlet ed --inplace -s "//property[@name='workspace_names']" -t elem -n "value" -v "" -i "//property[@name='workspace_names']/value[last()]" -t attr -n "type" -v "string" -i "//property[@name='workspace_names']/value[last()]" -t attr -n "value" -v "3"   /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
#xmlstarlet ed --inplace -s "//property[@name='workspace_names']" -t elem -n "value" -v "" -i "//property[@name='workspace_names']/value[last()]" -t attr -n "type" -v "string" -i "//property[@name='workspace_names']/value[last()]" -t attr -n "value" -v "4"   /home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml


#_______Custom Panel Bar________

#wget  https://github.com/0x4r2/CustomKali/raw/main/Recursos/panel.zip -O /tmp/panel.zip
#unzip -o -d /home/$USERNAME/.config/xfce4/ /tmp/panel.zip

wget  https://github.com/0x4r2/CustomKali/raw/main/Recursos/custom4r2.tar.bz2 -O /home/$USERNAME/.local/share/xfce4-panel-profiles/custom4r2.tar.bz2
xfce4-panel-profiles load /home/$USERNAME/.local/share/xfce4-panel-profiles/custom4r2.tar.bz2



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

#--------------------------------------
#	FUNCTIONS
#-------------------------------------
#  PT new folders
function  mkdir_HTB(){
	mkdir $1
	cd $1
	mkdir {files,scan,scripts}
	touch notas.txt
}

function set_target(){
	echo "$1" > /tmp/.target
}

function del_target(){
	rm -rf /tmp/.target
}

function go_HTB(){
	nmcli con up HTB 2>/dev/null
	sudo ip route delete default via 10.10.14.1 2>/dev/null
	if [ $? -eq 0 ]; then
		figlet Welcome to The Matrix -c
	else
		figlet "ERROR..\!"
	fi
}

function stop_HTB(){
	nmcli con down HTB
	figlet Go back to Real Life -c
}

filtrarpuertos () {
        ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | sort -u|xargs | tr ' ' ',')"
        ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 20)"
        echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
        echo -e "\t[*] IP Address: $ip_address" >> extractPorts.tmp
        echo -e "\t[*] Open ports: $ports\n" >> extractPorts.tmp
        echo $ports | tr -d '\n' | xclip -sel clip
        echo -e "[*] Ports copied to clipboard\n" >> extractPorts.tmp
        cat extractPorts.tmp
        rm extractPorts.tmp
}


EOF



#_________Enable services________
sudo systemctl enable ssh
sudo systemctl start ssh


#_________Custom zsh_________


git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$USERNAME/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>/home/$USERNAME/.zshrc
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' |sudo tee -a /root/.zshrc

echo "# To customize prompt, run p10k configure or edit ~/.p10k.zsh. " |sudo tee -a /root/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" |sudo tee -a /root/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" |tee -a /home/$USERNAME/.zshrc

sudo cp -r /home/$USERNAME/powerlevel10k /root


wget https://raw.githubusercontent.com/0x4r2/CustomKali/main/Recursos/p10k.zsh -O /home/$USERNAME/.p10k.zsh
sudo ln -s /home/$USERNAME/.p10k.zsh /root/.p10k.zsh

sed -i 's/fontFamily=.*/fontFamily=Hack Nerd Font Mono/'  /home/$USERNAME/.config/qterminal.org/qterminal.ini
sed -i 's/fontSize=.*/fontSize=11/'  /home/$USERNAME/.config/qterminal.org/qterminal.ini
sed -i 's/Rename%20Session=.*/Rename%20Session=F2/'    /home/$USERNAME/.config/qterminal.org/qterminal.ini

sudo cp -f /home/$USERNAME/.config/qterminal.org/qterminal.ini /etc/xdg/qterminal.org/qterminal.ini


sudo cp -f /home/$USERNAME/.zshrc /root/.zshrc

sudo rm -rf /tmp/*

echo -e "\n\n[+] Instalación Completa !!\n"
read -p "Presiona enter para reiniciar.... "

reboot