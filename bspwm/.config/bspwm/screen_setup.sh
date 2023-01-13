#!/bin/zsh
# refer https://miikanissi.com/blog/hotplug-dual-monitor-setup-bspwm/

# xrandr | grep -q 'HDMI-2 connected' && xrandr --output eDP-1 --off
# xrandr --output HDMI-2 --auto
# xrandr --output eDP-1 --primary --left-of HDMI-2

INTERNAL_MONITOR="eDP-1"
HDMI2_MONITOR="HDMI-2"
DP1_MONITOR="DP-1"


# init with only one monitor, first passed parameter is the reload time
if [[ "$1" == 0 ]]; then
  if [[ $(xrandr -q | grep "${HDMI2_MONITOR} connected") ]]; then
    # close internal by default
    xrandr --output $INTERNAL_MONITOR --off

    if [[ $(xrandr -q | grep "${DP1_MONITOR} connected") ]]; then
      bspc monitor "$HDMI2_MONITOR" -d 3 4 5 6 7 8 9 10
      bspc monitor "$DP1_MONITOR" -d 1 2
      xrandr --output $HDMI2_MONITOR --auto
      xrandr --output $DP1_MONITOR --mode 2560x1440 --rotate left
      xrandr --output $DP1_MONITOR --left-of $HDMI2_MONITOR
      bspc wm -O "$DP1_MONITOR" "$HDMI2_MONITOR"
    else 
      bspc monitor "$HDMI2_MONITOR" -d 1 2 3 4 5 6 7 8 9 10 
      xrandr --output $HDMI2_MONITOR --auto
    fi
  else
    xrandr --output $INTERNAL_MONITOR --auto
    bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
    # bspc monitor "$HDMI2_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
  fi
fi

monitor_add() {
  # Move all desktops to external monitor
  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | sed 2q); do
    bspc desktop "$desktop" --to-monitor "$DP1_MONITOR"
  done

  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | tail -n 8); do
    bspc desktop "$desktop" --to-monitor "$HDMI2_MONITOR"
  done

  # Remove default desktop created by bspwm
  bspc desktop Desktop --remove
  # close internal monitor
  # xrandr --output eDP-1 --off
  # reorder monitors
  # bspc wm -O "$HDMI2_MONITOR" "$INTERNAL_MONITOR"
}

monitor_remove() {
  # Add default temp desktop because a minimum of one desktop is required per monitor
  bspc monitor "$HDMI2_MONITOR" -a Desktop

  for desktop in $(bspc query -D -m "$DP1_MONITOR");	do
    bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
  done

  # Move all desktops except the last default desktop to internal monitor
  for desktop in $(bspc query -D -m "$HDMI2_MONITOR");	do
    bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
  done

  # delete default desktops
  bspc desktop Desktop --remove

  # reorder desktops
  bspc monitor "$INTERNAL_MONITOR" -o 1 2 3 4 5 6 7 8 9 10
}

# adjust in fly
if [[ $(xrandr -q | grep "${HDMI2_MONITOR} connected") ]]; then
  # set xrandr rules for docked setup
  xrandr --output "$DP1_MONITOR"  --pos 0x0 --rotate left --output "$HDMI2_MONITOR" --primary --rotate normal --right-of $DP1_MONITOR
  xrandr --output $HDMI2_MONITOR --auto
  xrandr --output $DP1_MONITOR --mode 2560x1440 --rotate left
  xrandr --output $DP1_MONITOR --left-of $HDMI2_MONITOR
  if [[ $(bspc query -D -m "${HDMI2_MONITOR}" | wc -l) -ne 8 ]]; then
    monitor_add
  fi
  bspc wm -O "$DP1_MONITOR" "$HDMI2_MONITOR"
  xrandr --output $INTERNAL_MONITOR --off
else
  # set xrandr rules for mobile setup
  xrandr --output "$INTERNAL_MONITOR" --primary --pos 0x0 --rotate normal --output "$HDMI2_MONITOR" --off --output "$DP1_MONITOR" --off
  xrandr --output $INTERNAL_MONITOR --auto
  if [[ $(bspc query -D -m "${INTERNAL_MONITOR}" | wc -l) -ne 10 ]]; then
    monitor_remove
  fi
fi

