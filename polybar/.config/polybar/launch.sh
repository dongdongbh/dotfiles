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
LEFT_MONITOR="HDMI-1"
MAIN_MONITOR="DP-3"

LOG_PREFIX="[launch-polybar]"

# Launch bar
echo "---" | tee -a /tmp/mybar.log 

# polybar mybar 2>&1 | tee -a /tmp/mybar.log & disown

connected_monitors=$(polybar --list-monitors | cut -d":" -f1)

# Count the number of connected monitors
num_monitors=$(echo "$connected_monitors" | wc -l)

echo $num_monitors $connected_monitors
# Check if there's only one monitor (the internal monitor)
if [ "$num_monitors" -eq 1 ]; then
  MONITOR="$connected_monitors" polybar --reload mybar 2>&1 | tee -a /tmp/mybar.log & disown
  echo "$LOG_PREFIX Launching bar on $connected_monitors (Internal)" | tee -a /tmp/mybar.log
else
  while IFS= read -r m; do
    echo current monitor $m---
    if [ "$m" = "$MAIN_MONITOR" ]; then  
      echo "$LOG_PREFIX Launching main bar on $m" | tee -a /tmp/mybar-main.log 
      MONITOR=$m polybar --reload mybar-main 2>&1 | tee -a /tmp/mybar-main.log & disown 
    elif [ "$m" = "$LEFT_MONITOR" ]; then
      echo "$LOG_PREFIX Launching side bar on $m" | tee -a /tmp/mybar-side.log
      MONITOR=$m polybar --reload mybar-side 2>&1 | tee -a /tmp/mybar-side.log & disown 
    else 
      echo "$LOG_PREFIX Launching bar on $m" | tee -a /tmp/mybar.log
      MONITOR=$m polybar --reload mybar 2>&1 | tee -a /tmp/mybar.log & disown 
    fi 
  done <<< "$connected_monitors"
fi

echo "Bars launched..."
