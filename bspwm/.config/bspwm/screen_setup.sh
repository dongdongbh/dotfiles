#!/usr/bin/bash
# refer https://miikanissi.com/blog/hotplug-dual-monitor-setup-bspwm/

LOG_PREFIX="[screen_setup.sh:]"

INTERNAL_MONITOR="eDP-1"
RIGHT_MONITOR="HDMI-1"
MAIN_MONITOR="DP-3"

# Helper functions
present_mode() {
  echo $LOG_PREFIX "Present mode"
  xrandr --output $INTERNAL_MONITOR --auto --primary
  xrandr --output "$RIGHT_MONITOR" --auto
  bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9
  bspc monitor "$RIGHT_MONITOR" -d 10
  xrandr --output $INTERNAL_MONITOR --left-of $RIGHT_MONITOR
}

main_side_mode() {
  echo $LOG_PREFIX "Main-side mode"
  xrandr --output "$RIGHT_MONITOR" --rotate left --output "$MAIN_MONITOR" --pos 0x0 --primary --rotate normal --left-of "$RIGHT_MONITOR"
  xrandr --output $MAIN_MONITOR --auto
  xrandr --output $RIGHT_MONITOR --mode 3840x2160 --rotate left
  xrandr --output $MAIN_MONITOR --left-of $RIGHT_MONITOR
  bspc monitor "$MAIN_MONITOR" -d 1 2 3 4 5 6 7 8 9
  bspc monitor "$RIGHT_MONITOR" -d 10
  bspc wm -O "$MAIN_MONITOR" "$RIGHT_MONITOR"
}

main_mode() {
  echo $LOG_PREFIX "Main mode"
  xrandr --output $MAIN_MONITOR --auto
  bspc monitor "$MAIN_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
}

only_internal_mode() {
  echo $LOG_PREFIX "Only internal monitor"
  xrandr --output $INTERNAL_MONITOR --auto
  bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
}

monitor_add_2() {
  echo $LOG_PREFIX "Adding 2 monitors"
  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | sed 9q); do
    bspc desktop "$desktop" --to-monitor "$MAIN_MONITOR"
  done
  bspc desktop $(bspc query -D --names -m "$INTERNAL_MONITOR" | tail -n 1) --to-monitor "$RIGHT_MONITOR"
  bspc desktop Desktop --remove
}

monitor_add_1() {
  echo $LOG_PREFIX "Adding 1 monitor"
  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | sed 10q); do
    bspc desktop "$desktop" --to-monitor "$MAIN_MONITOR"
  done
  bspc desktop Desktop --remove
}

monitor_remove() {
  bspc monitor "$MAIN_MONITOR" -a Desktop
  echo $LOG_PREFIX "Removing monitor"

  for desktop in $(bspc query -D -m "$MAIN_MONITOR"); do
    bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
  done

  for desktop in $(bspc query -D -m "$RIGHT_MONITOR"); do
    bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
  done

  xrandr --output "$INTERNAL_MONITOR" --primary --pos 0x0 --rotate normal --output "$RIGHT_MONITOR" --off --output "$MAIN_MONITOR" --off
  bspc desktop Desktop --remove
  bspc monitor "$INTERNAL_MONITOR" -o 1 2 3 4 5 6 7 8 9 10
}

# First-time init
if [[ "$1" == 0 ]]; then
  echo $LOG_PREFIX "First time init bspwm"
  
  if [[ $(xrandr -q | grep -E "^${RIGHT_MONITOR} connected") && ! $(xrandr -q | grep "^${MAIN_MONITOR} connected") ]]; then
    present_mode
  elif [[ $(xrandr -q | grep "^${MAIN_MONITOR} connected") ]]; then
    # close internal by default
    xrandr --output $INTERNAL_MONITOR --off
    if [[ $(xrandr -q | grep -E "^${RIGHT_MONITOR} connected") ]]; then
      main_side_mode
    else
      main_mode
    fi
  else
    only_internal_mode
  fi

  bspc desktop --focus 1
fi

# On-the-fly adjustments
if [[ "$1" != 0 ]]; then
  echo $LOG_PREFIX "Refreshing bspwm"

  if [[ $(xrandr -q | grep -E "^${RIGHT_MONITOR} connected") && ! $(xrandr -q | grep "^${MAIN_MONITOR} connected") ]]; then
    present_mode
  elif [[ $(xrandr -q | grep "^${MAIN_MONITOR} connected") ]]; then
  # close internal by default
    xrandr --output $INTERNAL_MONITOR --off
    if [[ $(xrandr -q | grep -E "^${RIGHT_MONITOR} connected") ]]; then
      main_side_mode
      if [[ $(bspc query -D -m "${MAIN_MONITOR}" | wc -l) -ne 9 ]]; then
        monitor_add_2
      fi
    else
      main_mode
      if [[ $(bspc query -D -m "${MAIN_MONITOR}" | wc -l) -ne 10 ]]; then
        monitor_add_1
      fi
    fi
  else
    only_internal_mode
    if [[ $(bspc query -D -m "${INTERNAL_MONITOR}" | wc -l) -ne 10 ]]; then
      monitor_remove
    fi
  fi
fi

