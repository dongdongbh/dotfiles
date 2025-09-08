#!/bin/bash

# Check if the monitor name "(DP-3)" exists in the output from niri
if niri msg outputs | grep -q "(DP-3)"; then
    # If it does, launch Waybar with the "docked" configuration
    exec waybar -c "$HOME/.config/waybar/config-docked.jsonc"
else
    # Otherwise, launch Waybar with the "undocked" configuration
    exec waybar -c "$HOME/.config/waybar/config-undocked.jsonc"
fi

# Launch Waybar using the selected configuration file
# 'exec' replaces the script process with the waybar process, which is clean for systemd
exec waybar -c "$CONFIG_FILE"

