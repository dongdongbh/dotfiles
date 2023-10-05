! /usr/bin/zsh

# start network manager applet 
nm-applet --indicator --sm-disable &

# Bluetooth systray icon
blueman-applet &

# syncthing tray
pgrep -x syncthingtray > /dev/null || syncthingtray --wait &

# lib gesture
libinput-gestures-setup start &

# screen locker
# use random wallpaper from the folder
# betterlockscreen -u ~/dotfiles/wallpapers/
# set wallpaper with dim effect
# betterlockscreen -w dim
# screen saver hook with betterlockscreen
# betterlockscreen -u ~/dotfiles/wallpapers/japan01.png --fx dim,pixel
pgrep -x xss-lock > /dev/null || xss-lock -n dim-screen.sh -- betterlockscreen -l &

# for clipmenud know X server $DISPLAY
systemctl --user import-environment DISPLAY &

# Start ibus daemon
ibus-daemon -drx  &
# Run keybindings daemon.
pgrep -x sxhkd > /dev/null || sxhkd -m -1 -c $HOME/.config/sxhkd/bspwm.sxhkdrc \
$HOME/.config/sxhkd/system.sxhkdrc $HOME/.config/sxhkd/user.sxhkdrc  &

# Start X wallpaper.
# feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg &
if [[ $(xrandr -q | grep -E "^HDMI-1 connected") ]]; then
  feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg --bg-fill $HOME/dotfiles/wallpapers/vertical-jet.jpg &
else
  feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg &
fi

# Set screen blank time based on battery status
auto_set_blank_time.sh &
# Start picom daemon
# picom --config $HOME/.config/picom/picom.sample.conf -b


# run polybar
~/.config/polybar/launch.sh &

# open programs
# bspc rule -a vifm desktop='^4' follow=off locked=on -o state=floating rectangle=1200x800+360+150 && alacritty --class vifm -e vifmrun &
# bspc rule -a pomotroid desktop='^3' follow=off locked=on -o state=floating rectangle=350x470+1500+100 && pomotroid &
# bspc rule -a Google-chrome desktop='^1' -o state=fullscreen && google-chrome &

# Remove x cursor
xsetroot -cursor_name left_ptr &

