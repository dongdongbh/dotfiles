#!/bin/bash

# Check if any active external monitor (HDMI or DP) exists.
# We find active monitors by looking for "Current mode:", then check the line above (-B 1)
# for the output name containing HDMI or DP. The -E flag enables extended regex.
if niri msg outputs | grep -B 1 "Current mode:" | grep -qE '\((HDMI|DP)-'; then
    # If an external monitor is active, we are in a "docked" state
    CONFIG_FILE="$HOME/.config/waybar/config-docked.jsonc"
else
    # Otherwise, we are "undocked" (only eDP-1 is active)
    CONFIG_FILE="$HOME/.config/waybar/config-undocked.jsonc"
fi

# Launch Waybar using the selected configuration file
exec waybar -c "$CONFIG_FILE"
