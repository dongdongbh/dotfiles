#!/bin/bash

# --- CONFIGURATION ---
# The name of your primary external monitor
EXTERNAL_MONITOR="HDMI-A-2"

# The name of your laptop's internal monitor
INTERNAL_MONITOR="eDP-1"

# --- SCRIPT LOGIC ---
# Give Hyprland a moment to recognize the new monitor
sleep 1

# Check if the external monitor is connected
if hyprctl monitors | grep -q "$EXTERNAL_MONITOR"; then
    # --- DOCKED MODE ---
    # The external monitor is connected.

    # Use hyprctl and jq to find all workspaces on the internal monitor.
    # This command gets a list of workspace IDs (e.g., "9\n10")
    workspaces_on_internal=$(hyprctl -j workspaces | jq -r ".[] | select(.monitor == \"$INTERNAL_MONITOR\") | .id")

    # Loop through the found workspaces and move them to the external monitor.
    for ws in $workspaces_on_internal; do
        hyprctl dispatch moveworkspacetomonitor "$ws $EXTERNAL_MONITOR"
    done

    # After moving all workspaces, disable the internal monitor.
    hyprctl keyword monitor "$INTERNAL_MONITOR, disable"

else
    # --- UNDOCKED MODE ---
    # The external monitor is not connected.

    # Enable the internal monitor.
    # Hyprland will automatically move any remaining workspaces to it.
    hyprctl keyword monitor "$INTERNAL_MONITOR, 1920x1080,auto,1"
fi
