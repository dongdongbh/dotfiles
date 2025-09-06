#!/bin/bash
pacman -Syu
pacman -S sudo 
sudo pacman -S vim 
sudo pacman -S mesa vulkan-intel libva-intel-driver
sudo pacman -S pipewire pipewire-pulse wireplumber
sudo pacman -S hyprland xorg-xwayland alacritty rofi waybar mako thunar hyprpaper hyprlock hypridle swaybg xdg-desktop-portal-hyprland hypridle wl-clipboard cliphist grim slurp
sudo pacman -S zsh git stow zsthura ripgrep feh rofi neovim
sudo pacman -S openssh nebula udisks2 udiskie git-delta fd yazi duf dust dunst flameshot

sudo pacman -S sddm
sudo systemctl enable sddm
sudo pacman -S noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd



sudo pacman -S --needed base-devel git

# Clone and build yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

yay -S google-chrome



chsh -s $(which zsh)
sudo chsh -s $(which zsh)
stow hypr waybar
mkdir -p $HOME/Pictures/Screenshots/
rm ~/.zshrc
stow tmux_cfg zsh fonts git rofi vim scripts

ln -s -f ~/.config/tmux_cfg/tmux.conf ~/.tmux.conf
ln -s ~/.config/tmux_cfg/tmux.conf.local ~/.tmux.conf.local

# We use Alacritty's default Linux config directory as our storage location here.
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

stow alacritty
