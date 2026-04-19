sudo pacman -S git xmonad xmonad-contrib rofi kitty xdotool sddm alasmixer pipewrite fastfetch xorg firefox ttf-ubuntu-font-family ttf-mononoki-nerd otf-font-awesome thunar feh okular vlc gimp screenkey xrandr qalculate-gtk flameshot thunderbird lxappearance qt5ct qt6ct breeze breeze-gtk
git clone https://github.com/shaun2006/My-Xmonad-config.git
cd My-Xmonad-config
mkdir -p ~/.config/xmonad ~/.config/xmobar ~/Pictures/
cp xmonad.hs ~/.config/xmonad/
cp xmobarrc ~/.config/xmobar/
cp winxp.jpeg ~/Pictures/
xmonad --recompile
sudo systemctl enable sddm
reboot
