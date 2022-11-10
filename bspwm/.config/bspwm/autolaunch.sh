#! /bin/sh

# start network manager applet 
nm-applet --indicator --sm-disable &

# Bluetooth systray icon
blueman-applet &

# run polybar
~/.config/polybar/launch.sh &

# screen locker
# use random wallpaper from the folder
# betterlockscreen -u ~/dotfiles/wallpapers/
betterlockscreen -w dim

# Run keybindings daemon.
sxhkdrcgen pgrep -x sxhkd > /dev/null || sxhkd -c $HOME/.config/sxhkd/bspwm.sxhkdrc \
$HOME/.config/sxhkd/system.sxhkdrc $HOME/.config/sxhkd/user.sxhkdrc  &

# Start X wallpaper.
feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg &

# Start picom daemon
picom --config $HOME/.config/picom/picom.sample.conf -b

# Start ibus daemon
ibus-daemon -drx  &

# open programs
bspc rule -a vifm desktop='^4' follow=off locked=on -o state=floating rectangle=1200x800+360+150 && alacritty --class vifm -e vifmrun &
bspc rule -a Google-chrome desktop='^1' -o state=fullscreen && google-chrome &


# Remove x cursor
xsetroot -cursor_name left_ptr &
