#!/bin/zsh
# refer https://miikanissi.com/blog/hotplug-dual-monitor-setup-bspwm/

# xrandr | grep -q 'HDMI-2 connected' && xrandr --output eDP-1 --off
# xrandr --output HDMI-2 --auto
# xrandr --output eDP-1 --primary --left-of HDMI-2

INTERNAL_MONITOR="eDP-1"
EXTERNAL_MONITOR="HDMI-2"

# init with only one monitor
if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
  # bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5
  # bspc monitor "$EXTERNAL_MONITOR" -d 6 7 8 9 10
  # bspc wm -O "$EXTERNAL_MONITOR" "$INTERNAL_MONITOR"
  bspc monitor "$EXTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
  # close internal by default
  xrandr --output eDP-1 --off
else
  bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
  # bspc monitor "$EXTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
fi


monitor_add() {
  # Move all desktops to external monitor
  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" ); do
    bspc desktop "$desktop" --to-monitor "$EXTERNAL_MONITOR"
  done

  # Remove default desktop created by bspwm
  bspc desktop Desktop --remove
  # close internal monitor
  # xrandr --output eDP-1 --off
  # reorder monitors
  # bspc wm -O "$EXTERNAL_MONITOR" "$INTERNAL_MONITOR"
}

monitor_remove() {
  # Add default temp desktop because a minimum of one desktop is required per monitor
  bspc monitor "$EXTERNAL_MONITOR" -a Desktop

  # Move all desktops except the last default desktop to internal monitor
  for desktop in $(bspc query -D -m "$EXTERNAL_MONITOR");	do
    bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
  done

  # delete default desktops
  bspc desktop Desktop --remove

  # reorder desktops
  bspc monitor "$INTERNAL_MONITOR" -o 1 2 3 4 5 6 7 8 9 10
}

# adjust in fly
if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
  # set xrandr rules for docked setup
  # xrandr --output "$INTERNAL_MONITOR" --mode 1920x1080 --pos 0x0 --rotate normal --output "$EXTERNAL_MONITOR" --primary --mode 1920x1080 --pos 1920x0 --rotate normal
  if [[ $(bspc query -D -m "${EXTERNAL_MONITOR}" | wc -l) -ne 10 ]]; then
    monitor_add
  fi
  # xrandr --output eDP-1 --off
  # bspc wm -O "$INTERNAL_MONITOR" "$EXTERNAL_MONITOR"
else
  # set xrandr rules for mobile setup
  # xrandr --output "$INTERNAL_MONITOR" --primary --mode 1920x1080 --pos 0x0 --rotate normal --output "$EXTERNAL_MONITOR" --off
  if [[ $(bspc query -D -m "${INTERNAL_MONITOR}" | wc -l) -ne 10 ]]; then
    monitor_remove
  fi
fi

