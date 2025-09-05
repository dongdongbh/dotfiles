#!/bin/bash

# The path to your layout script
LAYOUT_SCRIPT="$HOME/.config/hypr/scripts/monitor_layout.sh"

# Function to handle events
handle() {
  case $1 in
    monitoradded>>*)
      # Run the layout script when a monitor is added
      "$LAYOUT_SCRIPT"
      ;;
    monitorremoved>>*)
      # Run the layout script when a monitor is removed
      "$LAYOUT_SCRIPT"
      ;;
  esac
}

# Listen for events from Hyprland's socket
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock  | while read -r line; do
  handle "$line"
done
