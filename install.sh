#!/bin/bash
set -euo pipefail

sudo pacman -Syu

sudo pacman -S --needed sudo
sudo pacman -S --needed vim
sudo pacman -S --needed mesa vulkan-intel libva-intel-driver
sudo pacman -S --needed pipewire pipewire-pulse wireplumber
# sudo pacman -S hyprland xorg-xwayland rofi waybar mako thunar hyprpaper hyprlock hypridle swaybg xdg-desktop-portal-hyprland hypridle  grim slurp
sudo pacman -S --needed zsh git stow zathura zathura-pdf-mupdf ripgrep feh rofi neovim
sudo pacman -S --needed openssh nebula udisks2 udiskie git-delta fd yazi duf dust dunst flameshot
sudo pacman -S --needed niri mako waybar swaybg swayidle hyprlock
sudo pacman -S --needed alacritty wl-clipboard cliphist

sudo pacman -S --needed sddm
sudo systemctl enable sddm
sudo pacman -S --needed noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd

sudo timedatectl set-timezone America/New_York
sudo systemctl enable --now systemd-timesyncd

sudo pacman -S --needed nodejs npm unzip wget tree fastfetch tldr git-delta man-db imv


sudo pacman -S --needed base-devel git

# Clone and build yay
if [ -d yay ]; then
    git -C yay pull --ff-only
else
    git clone https://aur.archlinux.org/yay.git
fi
pushd yay
makepkg -si
popd
rm -rf yay

yay -S google-chrome



chsh -s $(which zsh)
sudo chsh -s $(which zsh)
mkdir -p $HOME/Pictures/Screenshots/
if [ -e "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
fi
rm -f "$HOME/.zshrc"

for package in waybar niri hypr-common scripts tmux_cfg zsh fonts git rofi vim; do
    [ -d "$package" ] && stow "$package"
done

ln -s -f ~/.config/tmux_cfg/tmux.conf ~/.tmux.conf
ln -s ~/.config/tmux_cfg/tmux.conf.local ~/.tmux.conf.local

# We use Alacritty's default Linux config directory as our storage location here.
mkdir -p ~/.config/alacritty/themes
if [ -d ~/.config/alacritty/themes/.git ]; then
    git -C ~/.config/alacritty/themes pull --ff-only
else
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi

stow alacritty
