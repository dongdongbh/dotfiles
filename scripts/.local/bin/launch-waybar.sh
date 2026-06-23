#!/bin/bash
# Check if any external monitor is connected and active.
# eDP-1 is the laptop's internal display; anything else is external.
if niri msg outputs | grep -B 1 "Current mode:" | grep -qvE '\(eDP-'; then
    CONFIG_FILE="$HOME/.config/waybar/config-docked.jsonc"
else
    CONFIG_FILE="$HOME/.config/waybar/config-undocked.jsonc"
fi
exec waybar -c "$CONFIG_FILE"
