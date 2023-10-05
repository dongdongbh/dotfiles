#!/usr/bin/bash
# refer https://miikanissi.com/blog/hotplug-dual-monitor-setup-bspwm/

# xrandr | grep -q 'HDMI-2 connected' && xrandr --output eDP-1 --off
# xrandr --output HDMI-2 --auto
# xrandr --output eDP-1 --primary --left-of HDMI-2

INTERNAL_MONITOR="eDP-1"
LEFT_MONITOR="HDMI-1"
MAIN_MONITOR="DP-3"


# init with only one monitor, first passed parameter is the reload time
if [[ "$1" == 0 ]]; then
  if [[ $(xrandr -q | grep "^${MAIN_MONITOR} connected") ]]; then
    # close internal by default
    xrandr --output $INTERNAL_MONITOR --off

    if [[ $(xrandr -q | grep -E "^${LEFT_MONITOR} connected") ]]; then
      xrandr --output $LEFT_MONITOR --mode 3840x2160 --rotate left
      xrandr --output $LEFT_MONITOR --left-of $MAIN_MONITOR
      xrandr --output "$LEFT_MONITOR"  --pos 0x0 --rotate left --output "$MAIN_MONITOR" --primary --rotate normal --right-of $LEFT_MONITOR
      bspc monitor "$MAIN_MONITOR" -d 1 2 3 4 5 6 7 8
      bspc monitor "$LEFT_MONITOR" -d  9 10
      bspc wm -O "$MAIN_MONITOR" "$LEFT_MONITOR" 
    else 
      xrandr --output $MAIN_MONITOR --auto
      bspc monitor "$MAIN_MONITOR" -d 1 2 3 4 5 6 7 8 9 10 
    fi
    # xrandr --output $MAIN_MONITOR --auto
    # bspc monitor "$MAIN_MONITOR" -d 1 2 3 4 5 6 7 8 9 10 
  else
    xrandr --output $INTERNAL_MONITOR --auto
    bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
    # bspc monitor "$LEFT_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
  fi
  # switch desktop 1
  bspc desktop --focus 1
fi

monitor_add_2() {
  # Move all desktops to external monitor

  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | sed 8q); do
    bspc desktop "$desktop" --to-monitor "$MAIN_MONITOR"
  done

  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | tail -n 2); do
    bspc desktop "$desktop" --to-monitor "$LEFT_MONITOR"
  done
  # Remove default desktop created by bspwm
  bspc desktop Desktop --remove
  # reorder monitors
  # bspc wm -O "$MAIN_MONITOR" "$LEFT_MONITOR"
}
monitor_add_1() {
  # Move all desktops to external monitor

  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | sed 10q); do
    bspc desktop "$desktop" --to-monitor "$MAIN_MONITOR"
  done

  # Remove default desktop created by bspwm
  bspc desktop Desktop --remove
  # close internal monitor
  # xrandr --output eDP-1 --off
  bspc monitor "$MAIN_MONITOR" -o 1 2 3 4 5 6 7 8 9 10
}

monitor_remove() {
  # Add default temp desktop because a minimum of one desktop is required per monitor
  bspc monitor "$MAIN_MONITOR" -a Desktop

  if [[ $(xrandr -q | grep -E "^${MAIN_MONITOR} connected") ]]; then
    for desktop in $(bspc query -D -m "$MAIN_MONITOR");	do
      bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
    done
  fi

  # Move all desktops except the last default desktop to internal monitor
  if [[ $(xrandr -q | grep -E "^${LEFT_MONITOR} connected") ]]; then
    for desktop in $(bspc query -D -m "$LEFT_MONITOR");	do
      bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
    done
  fi

  xrandr --output "$INTERNAL_MONITOR" --primary --pos 0x0 --rotate normal --output "$LEFT_MONITOR" --off --output "$MAIN_MONITOR" --off
  # delete default desktops
  bspc desktop Desktop --remove

  # reorder desktops
  bspc monitor "$INTERNAL_MONITOR" -o 1 2 3 4 5 6 7 8 9 10
}

# adjust in fly
if [[ "$1" != 0 ]]; then
  if [[ $(xrandr -q | grep "^${MAIN_MONITOR} connected") ]]; then
    # set xrandr rules for docked setup
    if [[ $(xrandr -q | grep -E "^${LEFT_MONITOR} connected") ]]; then
      xrandr --output "$LEFT_MONITOR"  --pos 0x0 --rotate left --output "$MAIN_MONITOR" --primary --rotate normal --right-of $LEFT_MONITOR
      xrandr --output $MAIN_MONITOR --auto
      xrandr --output $LEFT_MONITOR --mode 3840x2160 --rotate left
      xrandr --output $LEFT_MONITOR --left-of $MAIN_MONITOR
      if [[ $(bspc query -D -m "${MAIN_MONITOR}" | wc -l) -ne 8 ]]; then
        monitor_add_2
      fi
      bspc wm -O "$MAIN_MONITOR" "$LEFT_MONITOR" 
      xrandr --output $INTERNAL_MONITOR --off
      echo Left_monitor_here
    else
      xrandr --output $MAIN_MONITOR --auto
      if [[ $(bspc query -D -m "${MAIN_MONITOR}" | wc -l) -ne 10 ]]; then
        monitor_add_1
        xrandr --output $INTERNAL_MONITOR --off
      fi
      echo Only_main_monitor
    fi
  else
    # set xrandr rules for mobile setup
    xrandr --output $INTERNAL_MONITOR --auto
    if [[ $(bspc query -D -m "${INTERNAL_MONITOR}" | wc -l) -ne 10 ]]; then
      monitor_remove
    fi
  fi
fi

