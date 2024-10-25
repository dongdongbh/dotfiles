! /usr/bin/zsh

LOG_PREFIX="[autostart.sh]"

INTERNAL_MONITOR="eDP-1"
RIGHT_MONITOR="HDMI-1"
MAIN_MONITOR="DP-3"

echo $LOG_PREFIX "Starting auto launch..."
# start network manager applet 
nm-applet --indicator --sm-disable &

# Bluetooth systray icon
blueman-applet &

# start volumeicon
pgrep -x pa-applet > /dev/null || pa-applet &
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
udiskie &
# Run keybindings daemon.
pgrep -x sxhkd > /dev/null || sxhkd -m -1 -c $HOME/.config/sxhkd/bspwm.sxhkdrc \
$HOME/.config/sxhkd/system.sxhkdrc $HOME/.config/sxhkd/user.sxhkdrc  &

# for zoom screen sharing
xcompmgr -c -l0 -t0 -r0 -o.00 &

# Start picom daemon
# picom --config $HOME/.config/picom/picom.sample.conf -b

# Start X wallpaper.
# feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg &
if [[ $(xrandr -q | grep -E "^${RIGHT_MONITOR} connected") && $(xrandr -q | grep "^${MAIN_MONITOR} connected") ]]; then
  echo $LOG_PREFIX "Main and HDMI-1 connected"
  if [[ "$1" == 0 ]]; then
  # wait screen setup done 
  sleep 4
  fi

  betterlockscreen -u ~/dotfiles/wallpapers/dual --display 1 --fx dim,pixel &
  feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg --bg-fill $HOME/dotfiles/wallpapers/vertical-jet.jpg &

  # set screen blank time to 10 minutes for dual monitor setup
  xset dpms 600 900 1200

  # view list by `pactl list short sinks`
  pactl set-default-sink alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink

  bspc rule -a netease-cloud-music-gtk4 desktop='^6' -o state=tiled && flatpak run com.gitee.gmg137.NeteaseCloudMusicGtk4 &
  bspc desktop -f 'primary:^1'
else
  echo $LOG_PREFIX "HDMI-1 disconnected"
  betterlockscreen -u ~/dotfiles/wallpapers/japan01.png --fx dim,pixel &
  feh --no-fehbg --bg-fill $HOME/dotfiles/wallpapers/debian.jpg &
fi

# open programs
# bspc rule -a vifm desktop='^4' follow=off locked=on -o state=floating rectangle=1200x800+360+150 && alacritty --class vifm -e vifmrun &
# bspc rule -a pomotroid desktop='^3' follow=off locked=on -o state=floating rectangle=350x470+1500+100 && pomotroid &
# bspc rule -a Google-chrome desktop='^1' -o state=fullscreen && google-chrome &

bspc desktop -f 'primary:^1'

# Remove x cursor
xsetroot -cursor_name left_ptr &

# run polybar
~/.config/polybar/launch.sh &
