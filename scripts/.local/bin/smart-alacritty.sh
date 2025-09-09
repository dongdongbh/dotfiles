#!/bin/bash

# Get the name of the currently focused monitor using niri's IPC and jq
# This command finds the output object where "focused" is true, and extracts its "name".
focused_monitor=$(niri msg --json focused-output | jq -r .name)

# Check if the focused monitor is your target HDMI monitor
if [ "$focused_monitor" = "HDMI-A-1" ]; then
  # If so, launch Alacritty with the special class to trigger our 'maximized' rule
  alacritty --class Alacritty-HDMI,Alacritty -e tmux
else
  # Otherwise, launch a normal Alacritty instance on the current monitor
  alacritty
fi
