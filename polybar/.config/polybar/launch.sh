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

INTERNAL_MONITOR="eDP-1"
HDMI2_MONITOR="HDMI-2"
DP1_MONITOR="DP-1"
# Launch bar
echo "---" | tee -a /tmp/mybar.log 
# polybar mybar 2>&1 | tee -a /tmp/mybar.log & disown
for m in $(polybar --list-monitors | cut -d":" -f1); do
  if [ "$m" = "$HDMI2_MONITOR" ]; then  
    MONITOR=$m polybar --reload mybar-main 2>&1 | tee -a /tmp/mybar-main.log & disown 
  elif [ "$m" = "$DP1_MONITOR" ]; then
    MONITOR=$m polybar --reload mybar-side 2>&1 | tee -a /tmp/mybar-side.log & disown 
  elif [ "$m" = "$INTERNAL_MONITOR" ]; then
    MONITOR=$m polybar --reload mybar 2>&1 | tee -a /tmp/mybar.log & disown 
  else 
    MONITOR=$m polybar --reload mybar 2>&1 | tee -a /tmp/mybar.log & disown 
  fi 
done

echo "Bars launched..."
