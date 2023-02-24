#!/bin/zsh

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# INTERNAL_MONITOR="eDP-1"
# EXTERNAL_MONITOR="HDMI-2"
# if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
#   polybar --reload mybar -c ~/.config/polybar/config.ini </dev/null >/var/tmp/polybar-primary.log 2>&1 200>&- &
#   polybar --reload mybar-external -c ~/.config/polybar/config.ini </dev/null >/var/tmp/polybar-secondary.log 2>&1 200>&- &
# else
#   polybar --reload mybar  -c ~/.config/polybar/config.ini </dev/null >/var/tmp/polybar-primary.log 2>&1 200>&- &
# fi 

# Launch bar
echo "---" | tee -a /tmp/mybar.log 

polybar --reload mybar-main 2>&1 | tee -a /tmp/mybar-main.log & disown 
echo "Bars launched..."
