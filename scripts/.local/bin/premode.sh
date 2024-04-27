#!/bin/zsh
#
INTERNAL_MONITOR="eDP-1"
PRESENT_MONITOR="HDMI-1"
# PRESENT_MONITOR="DP-3"

xrandr --output $INTERNAL_MONITOR --auto
xrandr --output $PRESENT_MONITOR --auto
xrandr --output $INTERNAL_MONITOR --left-of $PRESENT_MONITOR

bspc wm -O "$INTERNAL_MONITOR" "$PRESENT_MONITOR"

bspc desktop 10 --to-monitor "$PRESENT_MONITOR"
bspc desktop Desktop --remove
