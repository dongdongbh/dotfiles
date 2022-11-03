#! /bin/sh

# start network manager applet 
nm-applet --indicator --sm-disable &

# Bluetooth systray icon
blueman-applet &

# screen locker
betterlockscreen -w dim

# Run keybindings daemon.
sxhkdrcgen pgrep -x sxhkd > /dev/null || sxhkd -c $HOME/.config/sxhkd/bspwm.sxhkdrc \
$HOME/.config/sxhkd/system.sxhkdrc $HOME/.config/sxhkd/user.sxhkdrc  &

# Start X wallpaper.
feh --no-fehbg --bg-fill $HOME/dotfiles/bin/wallpapers/japan01.png &

# Start picom daemon
picom --config $HOME/.config/picom/picom.sample.conf -b

# Start ibus daemon
ibus-daemon -drx  &

# run polybar
~/.config/polybar/launch.sh &
