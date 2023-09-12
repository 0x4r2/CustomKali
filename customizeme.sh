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


#sudo apt install -y rofi caja gedit


#______Hackfonts________
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip -O /tmp/hackfonts.zip
sudo unzip -o -d /usr/local/share/fonts /tmp/hackfonts.zip


#______PimpMyKali________
cd /opt
sudo git clone https://github.com/Dewalt-arch/pimpmykali
cd pimpmykali
### Disable prompt root login, option N
cat  pimpmykali.sh | sed 's/read -n1 -p "   Please type Y or N : " userinput/userinput="Y"/g' |sudo sponge pimpmykali.sh
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
cd /opt/custom
sudo touch target
sudo touch vpn
sudo touch lan
sudo chmod +x /opt/custom/*


#Custom Panel Bar

wget  https://github.com/0x4r2/CustomKali/raw/main/Recursos/panel.zip -O /tmp/panel.zip
unzip -o -d /home/$USERNAME/.config/xfce4/ /tmp/panel.zip

cat << EOF >/home/$USERNAME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml 
<?xml version="1.0" encoding="UTF-8"?>

<channel name="xfce4-panel" version="1.0">
  <property name="configver" type="int" value="2"/>
  <property name="panels" type="array">
    <value type="int" value="1"/>
    <property name="panel-1" type="empty">
      <property name="position" type="string" value="p=6;x=0;y=0"/>
      <property name="length" type="uint" value="100"/>
      <property name="position-locked" type="bool" value="true"/>
      <property name="size" type="uint" value="34"/>
      <property name="plugin-ids" type="array">
        <value type="int" value="1"/>
        <value type="int" value="2"/>
        <value type="int" value="3"/>
        <value type="int" value="4"/>
        <value type="int" value="5"/>
        <value type="int" value="6"/>
        <value type="int" value="7"/>
        <value type="int" value="8"/>
        <value type="int" value="9"/>
        <value type="int" value="10"/>
        <value type="int" value="11"/>
        <value type="int" value="12"/>
        <value type="int" value="24"/>
        <value type="int" value="25"/>
        <value type="int" value="23"/>
        <value type="int" value="26"/>
        <value type="int" value="18"/>
        <value type="int" value="14"/>
        <value type="int" value="15"/>
        <value type="int" value="16"/>
        <value type="int" value="17"/>
        <value type="int" value="19"/>
        <value type="int" value="20"/>
        <value type="int" value="21"/>
        <value type="int" value="22"/>
        <value type="int" value="13"/>
      </property>
    </property>
  </property>
  <property name="plugins" type="empty">
    <property name="plugin-1" type="string" value="whiskermenu"/>
    <property name="plugin-2" type="string" value="separator"/>
    <property name="plugin-3" type="string" value="showdesktop"/>
    <property name="plugin-4" type="string" value="directorymenu">
      <property name="icon-name" type="string" value="system-file-manager"/>
      <property name="base-directory" type="string" value="/home/$USERNAME"/>
    </property>
    <property name="plugin-5" type="string" value="launcher">
      <property name="items" type="array">
        <value type="string" value="16944410411.desktop"/>
      </property>
    </property>
    <property name="plugin-6" type="string" value="launcher">
      <property name="items" type="array">
        <value type="string" value="16944410412.desktop"/>
        <value type="string" value="16944539461.desktop"/>
      </property>
    </property>
    <property name="plugin-7" type="string" value="launcher">
      <property name="items" type="array">
        <value type="string" value="16944410413.desktop"/>
        <value type="string" value="16944410414.desktop"/>
      </property>
      <property name="move-first" type="bool" value="true"/>
    </property>
    <property name="plugin-8" type="string" value="separator"/>
    <property name="plugin-9" type="string" value="pager">
      <property name="miniature-view" type="bool" value="false"/>
      <property name="rows" type="uint" value="1"/>
    </property>
    <property name="plugin-900" type="string" value="pager">
      <property name="miniature-view" type="bool" value="true"/>
      <property name="rows" type="uint" value="2"/>
    </property>
    <property name="plugin-10" type="string" value="separator"/>
    <property name="plugin-11" type="string" value="tasklist">
      <property name="show-handle" type="bool" value="false"/>
      <property name="show-labels" type="bool" value="false"/>
      <property name="middle-click" type="uint" value="1"/>
      <property name="grouping" type="uint" value="1"/>
    </property>
    <property name="plugin-12" type="string" value="separator">
      <property name="expand" type="bool" value="true"/>
      <property name="style" type="uint" value="0"/>
    </property>
    <property name="plugin-14" type="string" value="systray">
      <property name="size-max" type="uint" value="22"/>
      <property name="square-icons" type="bool" value="true"/>
      <property name="symbolic-icons" type="bool" value="false"/>
      <property name="known-legacy-items" type="array">
        <value type="string" value="networkmanager applet"/>
        <value type="string" value="ethernet network connection “wired connection 1” active"/>
      </property>
    </property>
    <property name="plugin-15" type="string" value="genmon"/>
    <property name="plugin-16" type="string" value="pulseaudio">
      <property name="enable-keyboard-shortcuts" type="bool" value="true"/>
    </property>
    <property name="plugin-17" type="string" value="notification-plugin"/>
    <property name="plugin-19" type="string" value="clock">
      <property name="digital-layout" type="uint" value="3"/>
      <property name="digital-time-format" type="string" value="%_H:%M"/>
      <property name="digital-time-font" type="string" value="Cantarell 11"/>
    </property>
    <property name="plugin-20" type="string" value="separator">
      <property name="style" type="uint" value="0"/>
    </property>
    <property name="plugin-21" type="string" value="separator"/>
    <property name="plugin-22" type="string" value="actions">
      <property name="appearance" type="uint" value="0"/>
      <property name="items" type="array">
        <value type="string" value="+lock-screen"/>
        <value type="string" value="-switch-user"/>
        <value type="string" value="-separator"/>
        <value type="string" value="-suspend"/>
        <value type="string" value="-hibernate"/>
        <value type="string" value="-hybrid-sleep"/>
        <value type="string" value="-separator"/>
        <value type="string" value="-shutdown"/>
        <value type="string" value="-restart"/>
        <value type="string" value="-separator"/>
        <value type="string" value="+logout"/>
        <value type="string" value="-logout-dialog"/>
      </property>
    </property>
    <property name="plugin-2200" type="string" value="actions">
      <property name="appearance" type="uint" value="0"/>
      <property name="items" type="array">
        <value type="string" value="-lock-screen"/>
        <value type="string" value="-switch-user"/>
        <value type="string" value="-separator"/>
        <value type="string" value="-suspend"/>
        <value type="string" value="-hibernate"/>
        <value type="string" value="-hybrid-sleep"/>
        <value type="string" value="-separator"/>
        <value type="string" value="-shutdown"/>
        <value type="string" value="-restart"/>
        <value type="string" value="-separator"/>
        <value type="string" value="+logout"/>
        <value type="string" value="-logout-dialog"/>
      </property>
    </property>
    <property name="plugin-13" type="string" value="xkb">
      <property name="display-type" type="uint" value="2"/>
      <property name="display-name" type="uint" value="0"/>
      <property name="caps-lock-indicator" type="bool" value="true"/>
      <property name="show-notifications" type="bool" value="false"/>
      <property name="display-tooltip-icon" type="bool" value="true"/>
      <property name="group-policy" type="uint" value="0"/>
    </property>
    <property name="plugin-18" type="string" value="genmon"/>
    <property name="plugin-23" type="string" value="genmon"/>
    <property name="plugin-24" type="string" value="genmon"/>
    <property name="plugin-25" type="string" value="separator"/>
    <property name="plugin-26" type="string" value="separator"/>
  </property>
</channel>

EOF



#______Custom Functions________

cat <<'EOF' >> /home/$USERNAME/.zshrc

#-------------------------------------
#	ALIASES
#------------------------------------
alias pingg='ping -c 4 -w1 -i1 8.8.8.8'
alias cat='/usr/bin/bat --paging=never'
alias catn='/usr/bin/cat'
alias catl='/usr/bin/bat'
alias historial='/usr/bin/bat ~/.zsh_history'

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

sudo rm -rf /tmp/*
reboot
