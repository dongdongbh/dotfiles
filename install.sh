#!/bin/bash
sudo apt update
sudo apt-get install zsh stow ranger bspwm feh rofi fd-find ripgrep zathura maim gnome-session-canberra xclip thefuck suckless-tools dunst autorandr imagemagick
sudo chsh -s $(which zsh)
mkdir $HOME/Pictures/Screenshots/
rm ~/.zshrc
stow tmux_cfg zsh

ln -s -f ~/.config/tmux_cfg/tmux.conf ~/.tmux.conf
ln -s ~/.config/tmux_cfg/tmux.conf.local ~/.tmux.conf.local

# We use Alacritty's default Linux config directory as our storage location here.
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
