! /usr/bin/zsh

LOG_PREFIX="[autostart.sh]"
echo $LOG_PREFIX "Starting auto launch..."
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
# pgrep -x xss-lock > /dev/null || xss-lock -n dim-screen.sh -- betterlockscreen -l &
# pgrep -x xss-lock > /dev/null || xss-lock -- betterlockscreen -l &
# xpgrep -x autolock > /dev/null || autolock -time 10 -locker 'systemctl suspend' -notify 480 -notifier 'betterlockscreen -l | xset dpms force off' &

# Set screen blank time based on battery status
# xset dpms 300 360 480 &
auto_set_dpms_time.sh &

# for clipmenud know X server $DISPLAY
systemctl --user import-environment DISPLAY &

# Start ibus daemon
# ibus-daemon -drx  &
# start fcitx daemon
# fcitx -d &
fcitx-autostart &
# Run keybindings daemon.
pgrep -x sxhkd > /dev/null || sxhkd -m -1 -c $HOME/.config/sxhkd/bspwm.sxhkdrc \
$HOME/.config/sxhkd/system.sxhkdrc $HOME/.config/sxhkd/user.sxhkdrc  &


# Start picom daemon
# picom --config $HOME/.config/picom/picom.sample.conf -b

# run polybar
~/.config/polybar/launch.sh &


# Start X wallpaper.
# feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg &
if [[ $(xrandr -q | grep -E "^HDMI-1 connected") ]]; then
  echo $LOG_PREFIX "HDMI-1 connected"
  if [[ "$1" == 0 ]]; then
  # wait screen setup done 
  sleep 4
  fi
  feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg --bg-fill $HOME/dotfiles/wallpapers/vertical-jet.jpg &
else
  echo $LOG_PREFIX "HDMI-1 disconnected"
  feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg &
fi

# open programs
# bspc rule -a vifm desktop='^4' follow=off locked=on -o state=floating rectangle=1200x800+360+150 && alacritty --class vifm -e vifmrun &
# bspc rule -a pomotroid desktop='^3' follow=off locked=on -o state=floating rectangle=350x470+1500+100 && pomotroid &
# bspc rule -a Google-chrome desktop='^1' -o state=fullscreen && google-chrome &

# Remove x cursor
xsetroot -cursor_name left_ptr &

