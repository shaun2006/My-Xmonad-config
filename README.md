# My-Xmonad-config
This is my xmonad config. 

## Use 
1 Note :- change pacman with your distros package manager

copy the bellow code if you have alreday installed a base arch linux system configured with a desktop envirnoment eg(gnome,kde,xfce)
``` bash
sudo pacman -S xmonad xmobar xmonad-contrib rofi kitty xdotool
git clone https://github.com/shaun2006/My-Xmonad-config.git
cd My-Xmonad-config
mkdir -p ~/.config/xmonad ~/.config/xmobar ~/Pictures/
cp xmonad.hs ~/.config/xmonad/
cp xmobarrc ~/.config/xmobar/
cp winxp.jpeg ~/Pictures/
xmonad --recompile
```
logout of the current DE and then log back into xmoand

## Use the install script if you want have just installed archlinux and want everything configured automatically. 
```bash
suod pacman -S wget
wget https://raw.githubusercontent.com/shaun2006/My-Xmonad-config/refs/heads/main/install_script.sh
chmod +x install_script.sh
./install_script.sh
```
**After reboot use lxappearance & qt5ct or qt6ct to change themes of gtk and qt applications**

## ScreenShorts
![screenshort](https://github.com/shaun2006/My-Xmonad-config/blob/main/xmonad.png?raw=true)



![screenshort](https://github.com/shaun2006/My-Xmonad-config/blob/main/xmonad1.png?raw=true)
